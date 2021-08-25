Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3EAC4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 13:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21F1610F8
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 13:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbhHYNjL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 09:39:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58280 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbhHYNjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 09:39:11 -0400
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17PDcETJ095807;
        Wed, 25 Aug 2021 22:38:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Wed, 25 Aug 2021 22:38:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17PDc456095540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Aug 2021 22:38:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] nbd: Fix races introduced by nbd_index_mutex scope
 reduction
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <40c3ff83-3fce-5408-9579-7df5f9999450@i-love.sakura.ne.jp>
 <20210825131519.GA19907@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <16109a71-c366-b27e-8501-51e7fe950729@i-love.sakura.ne.jp>
Date:   Wed, 25 Aug 2021 22:38:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825131519.GA19907@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/25 22:15, Christoph Hellwig wrote:
> On Sun, Aug 22, 2021 at 12:46:29AM +0900, Tetsuo Handa wrote:
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>> Only compile tested. This patch is a hint for Christoph Hellwig
>> who needs to know what the global mutex was serializing...
> 
> Thanks a lot for your feedback.  Most of this looks good, except
> for a few bits that could be done cleaner, and the fact that
> we really should be using a global waitqueue instead of a completion.
> 
> Based on the recent syzbot report I'v reshuffled this and will send
> a series in a bit.
> 

Thank you for responding.

I guess you might want below diff, for reinit_completion() immediately after
complete_all() likely resets completion count before all threads sleeping at
wait_for_completion_timeout() check the completion count.
Use of simple sequence count will be robuster.

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -51,7 +51,8 @@ static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
 static int nbd_total_devices = 0;
-static DECLARE_COMPLETION(nbd_destroy_complete);
+static atomic_t nbd_destroy_sequence = ATOMIC_INIT(0);
+static DECLARE_WAIT_QUEUE_HEAD(nbd_destroy_wait);
 
 struct nbd_sock {
 	struct socket *sock;
@@ -244,8 +245,8 @@ static const struct device_attribute backend_attr = {
 static void nbd_notify_destroy_completion(struct nbd_device *nbd)
 {
 	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags)) {
-		complete_all(&nbd_destroy_complete);
-		reinit_completion(&nbd_destroy_complete);
+		atomic_inc(&nbd_destroy_sequence);
+		wake_up_all(&nbd_destroy_wait);
 	}
 }
 
@@ -1871,10 +1872,12 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nbd) {
 		if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
 		    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
+			const int seq = atomic_read(&nbd_destroy_sequence);
+
 			mutex_unlock(&nbd_index_mutex);
 
 			/* wait until the nbd device is completely destroyed */
-			wait_for_completion_timeout(&nbd_destroy_complete, HZ / 10);
+			wait_event(nbd_destroy_wait, atomic_read(&nbd_destroy_sequence) != seq);
 			goto again;
 		}
 

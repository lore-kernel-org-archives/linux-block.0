Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52735C432BE
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 02:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F2A60F44
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 02:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhH1CYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 22:24:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60562 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhH1CYK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 22:24:10 -0400
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17S2N3ns024887;
        Sat, 28 Aug 2021 11:23:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sat, 28 Aug 2021 11:23:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17S2N3OS024884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 28 Aug 2021 11:23:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp>
 <20210827184302.GA29967@lst.de>
 <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
Message-ID: <b9d7b6b1-236a-438b-bee7-6d65b7b58905@i-love.sakura.ne.jp>
Date:   Sat, 28 Aug 2021 11:22:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/28 10:10, Tetsuo Handa wrote:
> If we don't ignore forced module unload, we could update my patch to keep only
> mutex_destroy() and kfree() deferred by a refcount, for only lo->lo_state,
> lo->lo_refcnt and lo->lo_encryption would be accessed under lo->lo_mutex
> serialization. There is no need to defer "del_gendisk() + idr_remove()"
> sequence for concurrent callers.
> 

OK, here is a delta patch to make it no longer best effort.
We can consider removal of cryptoloop module after this patch,
starting from a printk() for deprecated message.

 drivers/block/loop.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2113,7 +2113,11 @@ int loop_register_transfer(struct loop_func_table *funcs)
 	return 0;
 }
 
-static void loop_remove(struct loop_device *lo);
+static void loop_destroy(struct loop_device *lo)
+{
+	mutex_destroy(&lo->lo_mutex);
+	kfree(lo);
+}
 
 int loop_unregister_transfer(int number)
 {
@@ -2137,7 +2141,7 @@ int loop_unregister_transfer(int number)
 			loop_release_xfer(lo);
 		mutex_unlock(&lo->lo_mutex);
 		if (refcount_dec_and_test(&lo->idr_visible))
-			loop_remove(lo);
+			loop_destroy(lo);
 		spin_lock(&loop_idr_spinlock);
 	}
 	spin_unlock(&loop_idr_spinlock);
@@ -2426,9 +2430,6 @@ static void loop_remove(struct loop_device *lo)
 	spin_lock(&loop_idr_spinlock);
 	idr_remove(&loop_index_idr, lo->lo_number);
 	spin_unlock(&loop_idr_spinlock);
-	/* There is no route which can find this loop device. */
-	mutex_destroy(&lo->lo_mutex);
-	kfree(lo);
 }
 
 static void loop_probe(dev_t dev)
@@ -2452,7 +2453,7 @@ static int loop_control_remove(int idx)
 
 	/*
 	 * Identify the loop device to remove. Skip the device if it is owned by
-	 * loop_remove()/loop_add() where it is not safe to access lo_mutex.
+	 * loop_add() where it is not safe to access lo_mutex.
 	 */
 	spin_lock(&loop_idr_spinlock);
 	lo = idr_find(&loop_index_idr, idx);
@@ -2479,19 +2480,11 @@ static int loop_control_remove(int idx)
 	mutex_unlock(&lo->lo_mutex);
 	/* Hide this loop device. */
 	refcount_dec(&lo->idr_visible);
-	/*
-	 * Try to wait for concurrent callers (they should complete shortly due to
-	 * lo->lo_state == Lo_deleting) operating on this loop device, in order to
-	 * help that subsequent loop_add() will not to fail with -EEXIST.
-	 * Note that this is best effort.
-	 */
-	for (ret = 0; refcount_read(&lo->idr_visible) != 1 && ret < HZ; ret++)
-		schedule_timeout_killable(1);
-	ret = 0;
+	/* Remove this loop device, but wait concurrent callers before destroy. */
+	loop_remove(lo);
 out:
-	/* Remove this loop device. */
 	if (refcount_dec_and_test(&lo->idr_visible))
-		loop_remove(lo);
+		loop_destroy(lo);
 	return ret;
 }
 
@@ -2623,8 +2616,10 @@ static void __exit loop_exit(void)
 	 * There is no need to use loop_idr_spinlock here, for nobody else can
 	 * access loop_index_idr when this module is unloading.
 	 */
-	idr_for_each_entry(&loop_index_idr, lo, id)
+	idr_for_each_entry(&loop_index_idr, lo, id) {
 		loop_remove(lo);
+		loop_destroy(lo);
+	}
 
 	idr_destroy(&loop_index_idr);
 }
-- 
2.25.1


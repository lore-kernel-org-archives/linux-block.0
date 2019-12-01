Return-Path: <SRS0=5p5X=ZX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A5DC432C3
	for <linux-block@archiver.kernel.org>; Sun,  1 Dec 2019 17:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B862073C
	for <linux-block@archiver.kernel.org>; Sun,  1 Dec 2019 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV7II9jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLARLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Dec 2019 12:11:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbfLARLl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Dec 2019 12:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575220299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIboseq0fDMMwBbrkH9pSvbsR619q2chHbtWr6BrOkg=;
        b=bV7II9jfTAGHiImmE6jtVBiUFyxz7j/1+9FUFliW+0r8fjVIxYkgG7X0WcXhTzq1VdtKp/
        OulvvilX91tQafVb+BV+daXENp91GJ2vPcBI65boLDZ2KmhV3QENPPN0LlpEqib7fJuZ08
        iV59eRoZHJtOTdr6+cg2e2FMZgc7jRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-oE2aqEnnP_mRPMcbYHMNXA-1; Sun, 01 Dec 2019 12:11:36 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DD7110054E3;
        Sun,  1 Dec 2019 17:11:33 +0000 (UTC)
Received: from [10.10.121.37] (ovpn-121-37.rdu2.redhat.com [10.10.121.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7130B5D9E5;
        Sun,  1 Dec 2019 17:11:32 +0000 (UTC)
Subject: Re: [PATCH] nbd: fix potential deadlock in nbd_config_put()
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com
References: <1574937951-92828-1-git-send-email-sunke32@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DE3F444.9080706@redhat.com>
Date:   Sun, 1 Dec 2019 11:11:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1574937951-92828-1-git-send-email-sunke32@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: oE2aqEnnP_mRPMcbYHMNXA-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/mixed;
 boundary="------------080507070007010002020405"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------080507070007010002020405
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 11/28/2019 04:45 AM, Sun Ke wrote:
> I got a deadlock report from syzkaller:
> 
> [  234.427696] ============================================
> [  234.428327] WARNING: possible recursive locking detected
> [  234.429011] 5.4.0-rc4+ #1 Not tainted
> [  234.429528] --------------------------------------------
> [  234.430162] kworker/u9:0/894 is trying to acquire lock:
> [  234.430911] ffff0000d3aca128 ((wq_completion)knbd0-recv){+.+.}, at: flush_workqueue+0xbc/0xfe8
> [  234.432330]
> [  234.432330] but task is already holding lock:
> [  234.432927] ffff0000d3aca128 ((wq_completion)knbd0-recv){+.+.}, at: process_one_work+0x6a0/0x17e8
> [  234.433983]
> [  234.433983] other info that might help us debug this:
> [  234.434615]  Possible unsafe locking scenario:
> [  234.434615]
> [  234.435263]        CPU0
> [  234.435613]        ----
> [  234.436019]   lock((wq_completion)knbd0-recv);
> [  234.436521]   lock((wq_completion)knbd0-recv);
> [  234.437166]
> [  234.437166]  *** DEADLOCK ***
> [  234.437166]
> [  234.437763]  May be due to missing lock nesting notation
> [  234.437763]
> [  234.438559] 3 locks held by kworker/u9:0/894:
> [  234.439040]  #0: ffff0000d3aca128 ((wq_completion)knbd0-recv){+.+.}, at: process_one_work+0x6a0/0x17e8
> [  234.440185]  #1: ffff0000d344fd50 ((work_completion)(&args->work)){+.+.}, at: process_one_work+0x6a0/0x17e8
> [  234.442209]  #2: ffff0000d723cd78 (&nbd->config_lock){+.+.}, at: refcount_dec_and_mutex_lock+0x5c/0x128
> [  234.443380]
> [  234.443380] stack backtrace:
> [  234.444271] CPU: 3 PID: 894 Comm: kworker/u9:0 Not tainted 5.4.0-rc4+ #1
> [  234.444989] Hardware name: linux,dummy-virt (DT)
> [  234.446077] Workqueue: knbd0-recv recv_work
> [  234.446909] Call trace:
> [  234.447372]  dump_backtrace+0x0/0x358
> [  234.447877]  show_stack+0x28/0x38
> [  234.448347]  dump_stack+0x15c/0x1ec
> [  234.448838]  __lock_acquire+0x12ec/0x2f78
> [  234.449474]  lock_acquire+0x180/0x590
> [  234.450075]  flush_workqueue+0x104/0xfe8
> [  234.450587]  drain_workqueue+0x164/0x390
> [  234.451090]  destroy_workqueue+0x30/0x560
> [  234.451598]  nbd_config_put+0x308/0x700
> [  234.452093]  recv_work+0x198/0x1f0
> [  234.452556]  process_one_work+0x7ac/0x17e8
> [  234.453189]  worker_thread+0x36c/0xb70
> [  234.453788]  kthread+0x2f4/0x378
> [  234.454257]  ret_from_fork+0x10/0x18
> 
> The root cause is recv_work() is the last one to drop the config
> ref and try to destroy the workqueue from inside the work queue.
> 
> There are two ways to fix the bug. The first way is flushing the
> workqueue before dropping the initial refcount and making sure
> recv_work() will not be the last owner of nbd_config. However it
> is hard for ioctl interface. Because nbd_clear_sock_ioctl() may
> not be invoked, so we need to flush the workqueue in nbd_release()
> and that will lead to another deadlock because recv_work can not
> exit from nbd_read_stat() loop.
> 
> The second way is using another work to put nbd_config asynchronously
> for recv_work().
> 

Can we also increment the refcount before we do wait_event_interruptible
in nbd_start_device_ioctl, always flush the workqueue then drop the
refcount after the flush? See compile tested only patch.

We will then also know the recv side has stopped after
nbd_start_device_ioctl has returned, so new NBD_DO_IT calls for the same
device do not race with shutdowns of previous uses.



--------------080507070007010002020405
Content-Type: text/x-patch;
 name="nbd-move-flush.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nbd-move-flush.patch"

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 57532465fb83..f8597d2fb365 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1293,13 +1293,15 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 
 	if (max_part)
 		bdev->bd_invalidated = 1;
+
+	refcount_inc(&nbd->config_refs);
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
-	if (ret) {
+	if (ret)
 		sock_shutdown(nbd);
-		flush_workqueue(nbd->recv_workq);
-	}
+	flush_workqueue(nbd->recv_workq);
+
 	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(bdev);
 	/* user requested, ignore socket errors */
@@ -1307,6 +1309,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 		ret = 0;
 	if (test_bit(NBD_RT_TIMEDOUT, &config->runtime_flags))
 		ret = -ETIMEDOUT;
+	nbd_config_put(nbd);
 	return ret;
 }
 

--------------080507070007010002020405--


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D9DC4320A
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596376113B
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 15:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhHUPrZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Aug 2021 11:47:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60694 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhHUPrY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Aug 2021 11:47:24 -0400
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17LFkYfU017903;
        Sun, 22 Aug 2021 00:46:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sun, 22 Aug 2021 00:46:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17LFkY2F017898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Aug 2021 00:46:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] nbd: Fix races introduced by nbd_index_mutex scope reduction
Message-ID: <40c3ff83-3fce-5408-9579-7df5f9999450@i-love.sakura.ne.jp>
Date:   Sun, 22 Aug 2021 00:46:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes oversights in "nbd: refactor device search and allocation
in nbd_genl_connect" and "nbd: reduce the nbd_index_mutex scope".

Previously nbd_index_mutex was held during whole add/remove/lookup
operations in order to guarantee that partially initialized devices are
not reachable via idr_find() or idr_for_each(). But now that partially
initialized devices become reachable as soon as idr_alloc() succeeds,
we need to skip partially initialized devices. Since it seems that
all functions use refcount_inc_not_zero(&nbd->refs) in order to skip
destroying devices, update nbd->refs from zero to non-zero as the last
step of device initialization in order to also skip partially initialized
devices. Also, update nbd->index before releasing nbd_index_mutex, for
populate_nbd_status() might access nbd->index as soon as nbd_index_mutex
is released. Error messages which assume that nbd->refs == 0 as "going
down" might be no longer accurate, but this patch does not update them.

Use of per "struct nbd_device" completion is not thread-safe.
Since nbd_index_mutex is released before calling wait_for_completion(),
when multiple threads concurrently reached wait_for_completion(), only
one thread which set nbd->destroy_complete for the last time is woken up
by complete() and all other threads will hang with uninterruptible state.
Use global completion with short timeout, for extra wake up results in
harmless retries. But nbd must be reset to NULL after "goto again;", or
use-after-free access will happen if idr_for_each_entry() did not find
any initialized free device.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Only compile tested. This patch is a hint for Christoph Hellwig
who needs to know what the global mutex was serializing...

 drivers/block/nbd.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c5e2b4cd697f..4580016eca44 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -51,6 +51,7 @@ static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
 static int nbd_total_devices = 0;
+static DECLARE_COMPLETION(nbd_destroy_complete);
 
 struct nbd_sock {
 	struct socket *sock;
@@ -120,7 +121,6 @@ struct nbd_device {
 	struct task_struct *task_recv;
 	struct task_struct *task_setup;
 
-	struct completion *destroy_complete;
 	unsigned long flags;
 
 	char *backend;
@@ -243,9 +243,10 @@ static const struct device_attribute backend_attr = {
  */
 static void nbd_notify_destroy_completion(struct nbd_device *nbd)
 {
-	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
-	    nbd->destroy_complete)
-		complete(nbd->destroy_complete);
+	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags)) {
+		complete_all(&nbd_destroy_complete);
+		reinit_completion(&nbd_destroy_complete);
+	}
 }
 
 static void nbd_dev_remove(struct nbd_device *nbd)
@@ -1706,7 +1707,6 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
 	INIT_WORK(&nbd->remove_work, nbd_dev_remove_work);
-	nbd->destroy_complete = NULL;
 	nbd->backend = NULL;
 
 	err = blk_mq_alloc_tag_set(&nbd->tag_set);
@@ -1724,10 +1724,10 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		if (err >= 0)
 			index = err;
 	}
+	nbd->index = index;
 	mutex_unlock(&nbd_index_mutex);
 	if (err < 0)
 		goto out_free_tags;
-	nbd->index = index;
 
 	disk = blk_mq_alloc_disk(&nbd->tag_set, NULL);
 	if (IS_ERR(disk)) {
@@ -1751,7 +1751,6 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 
 	mutex_init(&nbd->config_lock);
 	refcount_set(&nbd->config_refs, 0);
-	refcount_set(&nbd->refs, refs);
 	INIT_LIST_HEAD(&nbd->list);
 	disk->major = NBD_MAJOR;
 
@@ -1770,11 +1769,14 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	disk->private_data = nbd;
 	sprintf(disk->disk_name, "nbd%d", index);
 	add_disk(disk);
+	refcount_set(&nbd->refs, refs);
 	nbd_total_devices++;
 	return nbd;
 
 out_free_idr:
+	mutex_lock(&nbd_index_mutex);
 	idr_remove(&nbd_index_idr, index);
+	mutex_unlock(&nbd_index_mutex);
 out_free_tags:
 	blk_mq_free_tag_set(&nbd->tag_set);
 out_free_nbd:
@@ -1829,8 +1831,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 
 static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 {
-	DECLARE_COMPLETION_ONSTACK(destroy_complete);
-	struct nbd_device *nbd = NULL;
+	struct nbd_device *nbd;
 	struct nbd_config *config;
 	int index = -1;
 	int ret;
@@ -1855,8 +1856,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		struct nbd_device *tmp;
 		int id;
 
+		nbd = NULL;
 		idr_for_each_entry(&nbd_index_idr, tmp, id) {
-			if (!refcount_read(&tmp->config_refs)) {
+			if (!refcount_read(&tmp->config_refs) &&
+			    refcount_read(&tmp->refs)) {
 				nbd = tmp;
 				break;
 			}
@@ -1868,11 +1871,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nbd) {
 		if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
 		    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
-			nbd->destroy_complete = &destroy_complete;
 			mutex_unlock(&nbd_index_mutex);
 
 			/* wait until the nbd device is completely destroyed */
-			wait_for_completion(&destroy_complete);
+			wait_for_completion_timeout(&nbd_destroy_complete, HZ / 10);
 			goto again;
 		}
 
-- 
2.18.4



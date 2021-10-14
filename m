Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDD8C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5DC61053
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhJNSg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhJNSg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 14:36:28 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D31AC061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:34:23 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id f15so4516482ilu.7
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LD7Pd0GwdqlENbrJ30WPjrKJessl9znW+jqyAVfwtpY=;
        b=YYmW+XltfVALONrK2O1bEedMf0w8FgFdKD97iknB4BtaKlnM4yUpctKe2SXziJZ+w7
         FuiifNCiOk3OFI6DAK7SCmy8VRb540mcem2vqS9QNdWUfh/Qne2DrBGO+XI66GH0Y3yt
         VbMJSCTPULkORIdnZzUArL0pw2qEYUZDORWCAKlKTvGBUe5Lqhj0/2SHWv2GvTbUP0kk
         Fzw5evn9Db3UqSCmpfXn6TSnEmGqZp6FtaADUaRrWqfqadAGfHGGkSSNB4gtBLOF4MqG
         u/hOUBVE92ojD3wiS6+8ghFH+wgDHHMRxbkWB2amLZ0JmiRG/GMhHaRJ40SLlCWGtBs3
         EQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LD7Pd0GwdqlENbrJ30WPjrKJessl9znW+jqyAVfwtpY=;
        b=vcyb3IjsLhWGY6QJtvUGPKS3qc6OqYoXuTsfTZuOzxaf6qVEiSE+j7LP54ISNssczH
         q7tEHHnBHfws3dwzA4uFqpRmFxhPLET2aA+peH3Uu+Q/MifN7dxIzjUAwa7rdGIOwlyo
         IY5J9noPutimypm9H11AxHkPAuu0rrpk+bSywgFD1rN/hv7bg4n39AR9kdcvfnR902jH
         gm0hkKuL2eqV3Rk0ydOWjNn3Oak4UqXZSOnkdW5InDGmdLJqQH9Rdk1TKKrFNmn9whOa
         u7M1/Lawhtm1USRTKPllJ3wu2GC5qnZc5iGdXTvvWdy2jZieaq3xjprjXlS+I6EMJ9gi
         NECQ==
X-Gm-Message-State: AOAM530wouGhvwPDFE6V4/RDpKVkpAC1OgkLPGIVbqJnE+BuXlFpqvHU
        IHzAfEyrtdKPT9QBHZxkLkf49DmKLXkdkQ==
X-Google-Smtp-Source: ABdhPJxsXB3mk6inB+R7FaTngJMX6dm5fBHgmF8Tpn1DdoiTzye8NxwhKKlXXie4fSZZIox30Jd11Q==
X-Received: by 2002:a05:6e02:12c3:: with SMTP id i3mr434989ilm.145.1634236462618;
        Thu, 14 Oct 2021 11:34:22 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l12sm1490765ilh.19.2021.10.14.11.34.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 11:34:22 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3] block: only check previous entry for plug merge attempt
Message-ID: <9222613d-d4d3-7cfb-2e96-1bfa3b5f2d7f@kernel.dk>
Date:   Thu, 14 Oct 2021 12:34:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we scan the entire plug list, which is potentially very
expensive. In an IOPS bound workload, we can drive about 5.6M IOPS with
merging enabled, and profiling shows that the plug merge check is the
(by far) most expensive thing we're doing:

  Overhead  Command   Shared Object     Symbol
  +   20.89%  io_uring  [kernel.vmlinux]  [k] blk_attempt_plug_merge
  +    4.98%  io_uring  [kernel.vmlinux]  [k] io_submit_sqes
  +    4.78%  io_uring  [kernel.vmlinux]  [k] blkdev_direct_IO
  +    4.61%  io_uring  [kernel.vmlinux]  [k] blk_mq_submit_bio

Instead of browsing the whole list, just check the previously inserted
entry. That is enough for a naive merge check and will catch most cases,
and for devices that need full merging, the IO scheduler attached to
such devices will do that anyway. The plug merge is meant to be an
inexpensive check to avoid getting a request, but if we repeatedly
scan the list for every single insert, it is very much not a cheap
check.

With this patch, the workload instead runs at ~7.0M IOPS, providing
a 25% improvement. Disabling merging entirely yields another 5%
improvement.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

v3: retain merge list, but only check last addition.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f390a8753268..575080ad0617 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1089,32 +1089,22 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 {
 	struct blk_plug *plug;
 	struct request *rq;
-	struct list_head *plug_list;
 
 	plug = blk_mq_plug(q, bio);
-	if (!plug)
+	if (!plug || list_empty(&plug->mq_list))
 		return false;
 
-	plug_list = &plug->mq_list;
-
-	list_for_each_entry_reverse(rq, plug_list, queuelist) {
-		if (rq->q == q && same_queue_rq) {
-			/*
-			 * Only blk-mq multiple hardware queues case checks the
-			 * rq in the same queue, there should be only one such
-			 * rq in a queue
-			 **/
-			*same_queue_rq = rq;
-		}
-
-		if (rq->q != q)
-			continue;
-
-		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
-		    BIO_MERGE_OK)
-			return true;
+	/* check the previously added entry for a quick merge attempt */
+	rq = list_last_entry(&plug->mq_list, struct request, queuelist);
+	if (rq->q == q && same_queue_rq) {
+		/*
+		 * Only blk-mq multiple hardware queues case checks the rq in
+		 * the same queue, there should be only one such rq in a queue
+		 */
+		*same_queue_rq = rq;
 	}
-
+	if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK)
+		return true;
 	return false;
 }
 
-- 
Jens Axboe


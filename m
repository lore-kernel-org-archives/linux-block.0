Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A05C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FF9218C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wwtQO51f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfCOJG4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:06:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfCOJGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8xHXe020839;
        Fri, 15 Mar 2019 09:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=gFXOPmEFeouNmRWga/lmVGO0Wj+K/sZgIY+UwDko9R4=;
 b=wwtQO51fc+o8NST/Txo2SuZsHkhkbfJgF398I0nvDqt8nduGiO/n64vp7NFDEy5ptrLJ
 2YEa5kooySXMuXo86MAR27QDPIxUksK5jEX6wwhY6TeBIhnCAUuNwkkhDTp9ywVxL3K0
 faqOX6NCFWLSuiekdlDNWGw/hFKlE6A5FoDsBZIdbnYZbeekhnooOQWxKrtpqBX+52fi
 GxoQM1YY9QtzY6ObkE8XBVbHzRSMmfNQUyWvjt7jIhqCQClZTfWDP1Vfac35yXL+lO0A
 +gjClHAkMJXPMM4JdA3eVe6E5UZeJkl8NUtJCweyz2yo3jflcFmXeJcaQnbxtquSXZQl FQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r44wunjts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96Yfq009241
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:35 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96YTR021509;
        Fri, 15 Mar 2019 09:06:34 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 09:06:33 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] blk-mq: remove blk_mq_tagset_busy_iter
Date:   Fri, 15 Mar 2019 16:57:44 +0800
Message-Id: <1552640264-26101-9-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As nobody uses blk_mq_tagset_busy_iter, remove it.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-tag.c     | 95 --------------------------------------------------
 include/linux/blk-mq.h |  2 --
 2 files changed, 97 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cdec2cd..b5a14ce 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -279,101 +279,6 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
 }
 
-struct bt_tags_iter_data {
-	struct blk_mq_tags *tags;
-	busy_tag_iter_fn *fn;
-	void *data;
-	bool reserved;
-};
-
-static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
-{
-	struct bt_tags_iter_data *iter_data = data;
-	struct blk_mq_tags *tags = iter_data->tags;
-	bool reserved = iter_data->reserved;
-	struct request *rq;
-
-	if (!reserved)
-		bitnr += tags->nr_reserved_tags;
-
-	/*
-	 * We can hit rq == NULL here, because the tagging functions
-	 * test and set the bit before assining ->rqs[].
-	 */
-	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
-		return iter_data->fn(rq, iter_data->data, reserved);
-
-	return true;
-}
-
-/**
- * bt_tags_for_each - iterate over the requests in a tag map
- * @tags:	Tag map to iterate over.
- * @bt:		sbitmap to examine. This is either the breserved_tags member
- *		or the bitmap_tags member of struct blk_mq_tags.
- * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @data,
- *		@reserved) where rq is a pointer to a request. Return true
- *		to continue iterating tags, false to stop.
- * @data:	Will be passed as second argument to @fn.
- * @reserved:	Indicates whether @bt is the breserved_tags member or the
- *		bitmap_tags member of struct blk_mq_tags.
- */
-static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, bool reserved)
-{
-	struct bt_tags_iter_data iter_data = {
-		.tags = tags,
-		.fn = fn,
-		.data = data,
-		.reserved = reserved,
-	};
-
-	if (tags->rqs)
-		sbitmap_for_each_set(&bt->sb, bt_tags_iter, &iter_data);
-}
-
-/**
- * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
- * @tags:	Tag map to iterate over.
- * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
- * @priv:	Will be passed as second argument to @fn.
- */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
-		busy_tag_iter_fn *fn, void *priv)
-{
-	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
-}
-
-/**
- * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
- * @tagset:	Tag set to iterate over.
- * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
- * @priv:	Will be passed as second argument to @fn.
- */
-void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
-		busy_tag_iter_fn *fn, void *priv)
-{
-	int i;
-
-	for (i = 0; i < tagset->nr_hw_queues; i++) {
-		if (tagset->tags && tagset->tags[i])
-			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
-	}
-}
-EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
-
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all busy tags
  * @q:		Request queue to examine.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d6beeb5..3a048db 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -319,8 +319,6 @@ void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
-void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
-		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv, bool inflight);
 void blk_mq_freeze_queue(struct request_queue *q);
-- 
2.7.4


Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57440C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C9720879
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DwoOYWuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfCYFr1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:47:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfCYFr1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:47:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P5iuMK012660;
        Mon, 25 Mar 2019 05:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=Qtay4iMoGsdiOZtE6Fg9tCYzdXhmd4l5eiDsppfvGLg=;
 b=DwoOYWuAGvZieVLC744oEGebJLhkUxBpCeJKJCSVd3KelZ/Ogj0LOJvg8GYa3be0OsUj
 oDnrjgy10DUGcccFXAH6IyJE95xG/D2VoYH6bDKvWsXrLfgXXdWw15ZL18KVWW4ZE+kc
 IrgunGoL00I7NOThs+Bgs7VYJn7ytkPm3eBgvkY4sWno9QfbZcP/i73ySDOVhYHhcFl3
 XqY79gzctbrpJJgkv1taVzUh4gveLMuYJOP3F5/lHVhtvzXoHlhtbpe/t1i0itM3qaNp
 YWRufKVHZMxGgeLW2vTeRmnic8kngPJJ6p24fFFxnpSsczGvEYU6KWZs7SdMPo/2CSsQ pA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2re6dj1uef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5l1RH013182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:01 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5l02M031637;
        Mon, 25 Mar 2019 05:47:00 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 22:46:59 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/8]: blk-mq: use static_rqs to iterate busy tags
Date:   Mon, 25 Mar 2019 13:38:30 +0800
Message-Id: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250044
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As we know, there is a risk of accesing stale requests when iterate
in-flight requests with tags->rqs[] and this has been talked in following
thread,
[1] https://marc.info/?l=linux-scsi&m=154511693912752&w=2
[2] https://marc.info/?l=linux-block&m=154526189023236&w=2

A typical sence could be
blk_mq_get_request         blk_mq_queue_tag_busy_iter
  -> blk_mq_get_tag
                             -> bt_for_each
                               -> bt_iter
                                 -> rq = taags->rqs[]
                                 -> rq->q
  -> blk_mq_rq_ctx_init
    -> data->hctx->tags->rqs[rq->tag] = rq;

The root cause is that there is a window between set bit on tag sbitmap
and set tags->rqs[].

This patch would fix this issue by iterating requests with tags->static_rqs[]
instead of tags->rqs[] which would be changed dynamically. Moreover,
we will try to get a non-zero q_usage_counter before access hctxs and tags and
thus could avoid the race with updating nr_hw_queues, switching io scheduler
and even queue clean up which are all under a frozen and drained queue.

The 1st patch get rid of the useless of synchronize_rcu in __blk_mq_update_nr_hw_queues

The 2nd patch modify the blk_mq_queue_tag_busy_iter to use tags->static_rqs[]
instead of tags->rqs[] to iterate the busy tags.

The 3rd ~ 7th patch change the blk_mq_tagset_busy_iter to blk_mq_queue_tag_busy_iter
which is safer

The 8th patch get rid of the blk_mq_tagset_busy_iter.

Change log

V1 -> V2:
  - Add wrapper to hide "inflight" parameter to user based on Sagi's suggestion.
  - Other misc changes on comment.

Jianchao Wang (8)
blk-mq: get rid of the synchronize_rcu in
 blk-mq: use static_rqs instead of rqs to iterate tags
 blk-mq: use blk_mq_queue_tag_inflight_iter in debugfs
 mtip32xx: use blk_mq_queue_tag_inflight_iter
 nbd: use blk_mq_queue_tag_inflight_iter
 skd: use blk_mq_queue_tag_inflight_iter
 nvme: use blk_mq_queue_tag_inflight_iter
 blk-mq: remove blk_mq_tagset_busy_iter

diff stat

 block/blk-mq-debugfs.c            |   2 +-
 block/blk-mq-tag.c                | 193 ++++++++++++++------------------------
 block/blk-mq-tag.h                |   4 +-
 block/blk-mq.c                    |  31 ++----
 drivers/block/mtip32xx/mtip32xx.c |   6 +-
 drivers/block/nbd.c               |   2 +-
 drivers/block/skd_main.c          |   4 +-
 drivers/nvme/host/core.c          |  12 +++
 drivers/nvme/host/fc.c            |  10 +-
 drivers/nvme/host/nvme.h          |   2 +
 drivers/nvme/host/pci.c           |   5 +-
 drivers/nvme/host/rdma.c          |   4 +-
 drivers/nvme/host/tcp.c           |   5 +-
 drivers/nvme/target/loop.c        |   4 +-
 include/linux/blk-mq.h            |   7 +-
 15 files changed, 119 insertions(+), 172 deletions(-)

Thanks
Jianchao

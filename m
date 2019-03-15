Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8AEC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497EB2184C
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afodna/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfCOJGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:06:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40494 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfCOJGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8xHq8027924;
        Fri, 15 Mar 2019 09:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ooKzMHXjxB1hW4mS22uZ/3/Gq8wyTQbRb/0fnDdxmdE=;
 b=afodna/opPv022Ix7KYXTzEzAm00+2z1BrogluY1JNaUEaEt0/RWrcDCD8omkfmLna1X
 P2VC9FKonyna4rKupgiy4aLSlA/UP5UQcJjyy13AEnDj2PrEkQsbOrazBS4JykfymguQ
 JY5B9ptt9z1z2mNSgsp6kBhetadJheDvfFtFylfFlAaqox4aM9AL3lpbhcKUQz8fxskd
 4HXmIMc7t1JjMW9BIhG7b07hpZ8IqZQafBzEBn/cXQs3S+uPO2H2OdOmqCO13/+fbBDh
 ufPIOfOz8ZdyqjcciwdCBzcsqWjxRdYgkKcGEdYH769Wuz4+cXGTfZgVyY8IXBDoX7DH gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r464rwhsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:19 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96DmS007350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:13 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2F968CE005175;
        Fri, 15 Mar 2019 09:06:09 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 09:06:08 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
Date:   Fri, 15 Mar 2019 16:57:36 +0800
Message-Id: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=868 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

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

Jianchao Wang(8)
	blk-mq: get rid of the synchronize_rcu in
	blk-mq: change the method of iterating busy tags of a
	blk-mq: use blk_mq_queue_tag_busy_iter in debugfs
	mtip32xx: use blk_mq_queue_tag_busy_iter
	nbd: use blk_mq_queue_tag_busy_iter
	skd: use blk_mq_queue_tag_busy_iter
	nvme: use blk_mq_queue_tag_busy_iter
	blk-mq: remove blk_mq_tagset_busy_iter

diff stat
 block/blk-mq-debugfs.c            |   4 +-
 block/blk-mq-tag.c                | 173 +++++++++++++++++++++++++-------------------------------------------------------------
 block/blk-mq-tag.h                |   2 -
 block/blk-mq.c                    |  35 ++++++------------
 drivers/block/mtip32xx/mtip32xx.c |   8 ++--
 drivers/block/nbd.c               |   2 +-
 drivers/block/skd_main.c          |   4 +-
 drivers/nvme/host/core.c          |  12 ++++++
 drivers/nvme/host/fc.c            |  12 +++---
 drivers/nvme/host/nvme.h          |   2 +
 drivers/nvme/host/pci.c           |   5 ++-
 drivers/nvme/host/rdma.c          |   6 +--
 drivers/nvme/host/tcp.c           |   5 ++-
 drivers/nvme/target/loop.c        |   6 +--
 include/linux/blk-mq.h            |   7 ++--
 15 files changed, 105 insertions(+), 178 deletions(-

Thanks
Jianchao


Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C5C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 02:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F185D21741
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 02:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUmQTo/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeL0CBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:01:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36250 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeL0CBg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Dec 2018 21:01:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBR1tvvF122776;
        Thu, 27 Dec 2018 02:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=fXn3Oto089QTnnQEcK+DF10o1EUTdFRTMobcbtRb6RU=;
 b=cUmQTo/Ou0BPm/XZg3tPOcjDPpHgA9aQb6rMW4HUldODVm0Hc9OgLoQ58lSDYjpbKzC9
 rYx+dlZaRe3ORrILYBFlfaWmY3WakDIus7UvTiTgQVuhhXGKpCH8Sq4xfDod+Jrpgxli
 qWRJKEoxVkLrryZkRarSJPLIesPYos10IeNl9ijYY3AlQj9ccuSLfZudq3zphzmwIkvU
 tvMp2zQQw0eq/FirS3UgLwgfFf+C8+YxemJJR83P0Av2UNqU0zIDzoguGKfjwnLTmN5f
 IIRvwhn6u73y4fAO53IB/ChlebB+aUGy92n4kaIKl1bH0va3lVY6Sw4o2iuKW2Sk9W4C AA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2phasdu93j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Dec 2018 02:01:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBR21VAu001911
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Dec 2018 02:01:31 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBR21UVh016640;
        Thu, 27 Dec 2018 02:01:30 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Dec 2018 18:01:29 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] blk-mq: small optimization for accessing of queue map
Date:   Thu, 27 Dec 2018 10:00:39 +0800
Message-Id: <1545876041-16076-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9118 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=947
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812270015
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

These two patches are small optimization for accessing the queue mapping
in hot path. It saves the queue mapping results into blk_mq_ctx directly,
then we needn't do the complicated bounce on queue_hw_ctx[] map[] and
mq_map[].

Jianchao Wang(2)
  blk-mq: save queue mapping result into ctx directly
  blk-mq: save default hctx into ctx->hctxs for not-supported type

block/blk-mq-sched.c |  2 +-
block/blk-mq-tag.c   |  2 +-
block/blk-mq.c       | 13 ++++++++++---
block/blk-mq.h       | 20 +++++++++-----------
block/blk.h          |  2 +-
5 files changed, 22 insertions(+), 17 deletions(-)

Thanks
Jianchao
 

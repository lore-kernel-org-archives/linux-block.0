Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F393C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 10:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649D621872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 10:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tHr1GgUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfAXK2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:28:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44698 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfAXK2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 05:28:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0OANvFS003599;
        Thu, 24 Jan 2019 10:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=aDl+ytAS7V7RyMu2EPFO/emYddLI+KhMS1596c8Wtu8=;
 b=tHr1GgUn2h4foTueONXFusaoEZBO+HGfp6SLMfpvySz9t9Dedjtc7BMXKtMzdsj7it6P
 aIoLpvevfpAXGpx4uiG6etmkkE9TPUoBYwfKZPj+BFB+E97/gOz4R9rq2ggz6tZpUcSB
 vDnUERR36gBg4iJcLeMl84tE6O6AsnYAxsJTMtjRmQPW4keHJI8bPpCtYCo6eYrieaeX
 +FzDm8Uj97jXFxSJ0Ac4tNjMnMTxRjnZ5Tq8YJ/9ULOhRA1HcDiTBcJydcFH0/usXp9z
 IryKTHobMkVOECZFzHB9v48IG0ZU6RwhtYTWoDQH901oH6mqIQNRIRqqYw0zIa2O/DAL +A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2q3sdeq781-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 10:28:06 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0OAS5N0008234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 10:28:05 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0OAS5kv018676;
        Thu, 24 Jan 2019 10:28:05 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jan 2019 02:28:05 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] small optimization for accessing queue map
Date:   Thu, 24 Jan 2019 18:25:31 +0800
Message-Id: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=836
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901240076
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

These two patches are small optimization for accessing the queue mapping
in hot path. It saves the queue mapping results into blk_mq_ctx directly,
then we needn't do the complicated bounce on queue_hw_ctx[] map[] and
mq_map[].

Jianchao Wang (2)
blk-mq: save queue mapping result into ctx directly
blk-mq: save default hctx into ctx->hctxs

 block/blk-mq-sched.c |  2 +-
 block/blk-mq-tag.c   |  2 +-
 block/blk-mq.c       | 13 ++++++++++---
 block/blk-mq.h       | 20 +++++++++-----------
 block/blk.h          |  2 +-
 5 files changed, 22 insertions(+), 17 deletions(-)

Thanks
Jianchao

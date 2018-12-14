Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6DEC67872
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 01:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BE02075B
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 01:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j0glL3we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BE02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeLNB3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:29:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeLNB3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 20:29:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBE1Ofu6158695;
        Fri, 14 Dec 2018 01:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=JPT9cM6aCRThbzpbJrmOUw+5N4eXdYrAZJTlOqeaoEg=;
 b=j0glL3werKZRY3tCu1OnIMivG+OWeuPwl2qwuN3hsjVQvkWV0knYE3OaMThAMgmAxCSq
 YjC0pXeHazOQQpAYpIbPvSxvurUnWe+HKkYHoZ2VQi62NAEL6v9StxhRpvJFX1nwZ03m
 UrBnLxKa/xoJ5IctrCxUHfxdsZ3TbGd9C0X8KJUsa1V9bzqD+S3VAlAiAUKZMp0uhdld
 WZDXYYWdfX13C8edX4DF83QZr7cmwXpxnhj79t8vBSowedzldfpBBmJkeZwbv8Qb0BYn
 MK+t81xJpYcUy9F7sSokK9KdthSX4j+2SROfWkk0WnP1mwF/JECbJ7jN0xBJ6HXfhEc9 5Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pb7tf77kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 01:29:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBE1TFW3012813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 01:29:15 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBE1TEQd012304;
        Fri, 14 Dec 2018 01:29:15 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 17:29:14 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V14 0/3] blk-mq: refactor and fix the code of issue directly
Date:   Fri, 14 Dec 2018 09:28:17 +0800
Message-Id: <1544750900-1549-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9106 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812140011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

After commit c616cbee ( blk-mq: punt failed direct issue to dispatch
list ), we always insert request to hctx dispatch list whenever get a
BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, this is overkill and will
harm the merging. We just need to do that for the requests that has
been through .queue_rq.

This patch set fixes the issue above and refactors the code of issue
request directly to unify the interface and make the code clearer and
more readable.

Please consider this patchset for 4.21.

The 1st patch refactors the code of issue request directly to unify the
helper interface which could handle all the cases. And also it does more
reasonable decision about how to insert the requests.

The 2nd patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass' false, then it needn't to handle the non-issued requests
any more.

The 3rd patch replace and kill the blk_mq_request_issue_directly.

V14:
 - change some comment

V13:
 - remove the unused tag 'out' (1/3)

V12:
 - remove the original 1st patch/
 - rebase other 3 patches on newest for-4.21/block
 - add some comment

V11:
 - insert request to dispatch list when .queue_rq return
   BLK_STS_RESOURCE/BLK_STS_DEV_RESOURCE. (2/4)
 - stop to attempt direct-issue and insert the reset when meet
   non-ok case (3/4).

V10:
 - address Jen's comment.
 - let blk_mq_try_issue_directly return actual result for case
   'bypass == false'. (2/4)
 - use return value of blk_mq_try_issue_directly to identify
   whether the request is direct-issued successfully. (3/4)

V9:
 - rebase on recent for-4.21/block
 - add 1st patch

V8:
 - drop the original 2nd patch which try to insert requests into hctx->dispatch
   if quiesced or stopped.
 - remove two wrong 'unlikely'

V7:
 - drop the original 3rd patch which try to ensure hctx to be ran on
   its mapped cpu in issueing directly path.

V6:
 - drop original 1st patch to address Jen's comment
 - discard the enum mq_issue_decision and blk_mq_make_decision and use
   BLK_STS_* return values directly to address Jen's comment. (1/5)
 - add 'unlikely' in blk_mq_try_issue_directly (1/5)
 - refactor the 2nd and 3rd patch based on the new 1st patch.
 - reserve the unused_cookie in 4th and 5th patch

V5:
 - rebase against Jens' for-4.21/block branch
 - adjust the order of patch04 and patch05
 - add patch06 to replace and kill the one line blk_mq_request_bypass_insert
 - comment changes

V4:
 - split the original patch 1 into two patches, 1st and 2nd patch currently
 - rename the mq_decision to mq_issue_decision
 - comment changes

V3:
 - Correct the code about the case bypass_insert is true and io scheduler
   attached. The request still need to be issued in case above. (1/4)
 - Refactor the code to make code clearer. blk_mq_make_request is introduced
   to decide insert, end or just return based on the return value of .queue_rq
   and bypass_insert (1/4) 
 - Add the 2nd patch. It introduce a new decision result which indicates to
   insert request with blk_mq_request_bypass_insert.
 - Modify the code to adapt the new patch 1.

V2:
 - Add 1st and 2nd patch to refactor the code.


Jianchao Wang (3)
blk-mq: refactor the code of issue request directly
blk-mq: issue directly with bypass 'false' in
blk-mq: replace and kill blk_mq_request_issue_directly

 block/blk-core.c     |   4 +++-
 block/blk-mq-sched.c |   8 +++----
 block/blk-mq.c       | 122 ++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
 block/blk-mq.h       |   6 +++--
 4 files changed, 69 insertions(+), 71 deletions(-)


Thanks
Jianchao

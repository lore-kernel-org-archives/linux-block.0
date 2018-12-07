Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE2EC04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FFD20868
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EKecywX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FFD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGDK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:10:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGDK2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:10:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB72xAc8018755;
        Fri, 7 Dec 2018 03:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=yOHBPsXQCBE/NjffdAWLmXFaco4wLibrWvlZg2RpHb4=;
 b=EKecywX2jRrH3q3A3ttxpPe7TagNj+l4aSP/ZGB/eRGclze3niICgEOLoJWOV+MnPmnh
 Ceil8YQQOuMw3SsiLzVFuCSRmTl9W1HQObQeLz4rxg3RmHqzFoPSLeHTPiyfsECpGw9I
 +xo/uz/BbNkv4LjKy8ft7+9TjNmcxg4Q76b/XhRFKHivBda88ZNJ1A4kmloUAdSyacZk
 pyBgTAD97UifsK2MS9YPJ9S190+E9E95uI6Pn6FIwutQW8DK62lHDLgsSbZdUEFllqls
 J4s6q6CjKrRKlS2YWNsQvs+O7GNTDMMCX8eWcECKD8nHkWMJjWAOYOI6gLhPypgYslSu Mw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2p3hqubkbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 03:10:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB73AOmY019501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 03:10:24 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB73ANuB010216;
        Fri, 7 Dec 2018 03:10:23 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 19:10:23 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V11 0/4] blk-mq: refactor code of issue directly
Date:   Fri,  7 Dec 2018 11:09:41 +0800
Message-Id: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=914
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070024
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

Please consider this patchset for 4.21.

It refactors the code of issue request directly to unify the interface
and make the code clearer and more readable.

This patch set is rebased on the recent for-4.21/block and add the 1st
patch which inserts the non-read-write request to hctx dispatch
list to avoid to involve merge and io scheduler when bypass_insert
is true, otherwise, inserting is ignored, BLK_STS_RESOURCE is returned
and the caller will fail forever.

The 2nd patch refactors the code of issue request directly to unify the
helper interface which could handle all the cases.

The 3rd patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass' false, then it needn't to handle the non-issued requests
any more.

The 4th patch replace and kill the blk_mq_request_issue_directly.

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


Jianchao Wang (4)
blk-mq: insert to hctx dispatch list when
blk-mq: refactor the code of issue request directly
blk-mq: issue directly with bypass 'false' in
blk-mq: replace and kill blk_mq_request_issue_directly

block/blk-core.c     |   4 +-
block/blk-mq-sched.c |   8 ++-
block/blk-mq.c       | 137 +++++++++++++++++++++++++--------------------------
block/blk-mq.h       |   6 ++-
4 files changed, 76 insertions(+), 79 deletions(-)

Thanks
Jianchao



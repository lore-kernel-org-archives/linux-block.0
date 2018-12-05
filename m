Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB4EC04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 07:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9459820850
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 07:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4OqbIt/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9459820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeLEHou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:44:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39736 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeLEHou (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 02:44:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB57i6kb166791;
        Wed, 5 Dec 2018 07:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=aWc4ssTqK3+0Va0XF3SwYiR03i3PrRf+R9WvbryzeBM=;
 b=4OqbIt/Z0vJHEqoC7GD6DJJHAz8RmA354cNul3aVFLmjZ4j0pHkZyTM017XVL8cQtPFQ
 KI/HzhRU4GTCah4hpX8yAc2cndwQ850CcskC/zVVinz11FuGym9/hB2ZJCiyT8lZyHeR
 OKG41IsBgScnJjFGc7PCC7mU3ablGVqXayI9bGShwfsWa0H351aVfaBgVMRCYCViMguM
 vO+/k6dzR4QP7+ewMfRH7tP4dc8txgAsv48mcnqLhFdompmtFntPv5BYjd/tz5gLYalO
 gjqtmqrBp2+5iqGajEO3HiGjnDDpwxw5j0Qpn1G/h3i4hEKX0+I4xgs8j5q6rWDT/bq2 UA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqu0t71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 07:44:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB57ifCQ020725
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 07:44:41 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB57id4V021853;
        Wed, 5 Dec 2018 07:44:41 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 23:44:39 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 0/4] blk-mq: refactor code of issue directly
Date:   Wed,  5 Dec 2018 15:43:58 +0800
Message-Id: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=984
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050072
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

block/blk-core.c          |   4 +-
block/blk-mq-sched.c      |   8 ++-
block/blk-mq.c            | 129 +++++++++++++++++++++-------------------------
block/blk-mq.h            |   6 ++-
include/linux/blk_types.h |   1 +
5 files changed, 71 insertions(+), 77 deletions(-)

Thanks
Jianchao

Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E7CC43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A616C20866
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j/wYYSLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A616C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeKMTyz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:54:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32952 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbeKMTyy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 14:54:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAD9t7sK181187;
        Tue, 13 Nov 2018 09:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=qx4fgGSAg1M48uR1L/5l7qWwCw8uF7+4KzUXFAi4PtU=;
 b=j/wYYSLwC2CUDWs1RvBBItOTHAr4mEYOGAjBjN3FEobjZ+5YcqA2Gzg6QyKVjqAXIqP8
 FTat1gYbbHUSJDoLvPkElBwqQu4iMavWdn0hykqNvcBhpgenKbkkAqRJwtosWCrktCVU
 bDplEnRBNThgWGYfkKis51+7ceNB8135E3mq1s5QTQ6l2TY2nZJ5kfALh6hsM+EAr+VG
 mivUQGo8MyouRnoFyIKztYzQmONBrUfKBSHMXjaei4TaOixOFJD4ydPffIIbWTfAN55F
 n6om/VbtXJT7ISVJd7KpajtkJuPw4nX+J9FOtAaEEt6SeFfAvMHN2XEVTy3s8/HIn2wo OA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nnw6ehjgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 09:57:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAD9vUT2013682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 09:57:30 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAD9vUgo032349;
        Tue, 13 Nov 2018 09:57:30 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Nov 2018 01:57:29 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 0/5] blk-mq: refactor and fix on issue request directly
Date:   Tue, 13 Nov 2018 17:56:51 +0800
Message-Id: <1542103016-21037-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9075 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

Please consider this patchset for 4.21.
It refactors the code of issue request directly to unify the interface
and make the code clearer and more readable, and also fixes two defects
there.

The 1st patch refactors the code of issue request directly to unify the
helper interface which could handle all the cases.

The 2nd patch fix the issue that when queue is stopped or quiesced request
may pass through bottom device's potential io scheduler.

The 3rd patch fix the issue that hctx maybe ran on a cpu where it is not
mapped in issue directly path.

The 4th patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass' false, then it needn't to handle the non-issued requests
any more.

The 5th patch replace and kill the blk_mq_request_issue_directly.

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

Jianchao Wang(6)
  blk-mq: refactor the code of issue request directly
  blk-mq: fix issue directly case when q is stopped or quiesced
  blk-mq: ensure hctx to be ran on mapped cpu when issue directly
  blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
  blk-mq: replace and kill blk_mq_request_issue_directly

block/blk-core.c     |   4 +-
block/blk-mq-sched.c |   8 ++--
block/blk-mq.c       | 126 +++++++++++++++++++++++++--------------------------
block/blk-mq.h       |   7 +--
4 files changed, 72 insertions(+), 73 deletions(-)

Thanks
Jianchao



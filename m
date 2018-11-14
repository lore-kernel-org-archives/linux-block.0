Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C5CC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 08:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D6F223DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 08:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K4+MSlfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D6F223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeKNSsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:48:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35618 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNSsX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 13:48:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE8hokb080831;
        Wed, 14 Nov 2018 08:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=1hPCKuWyc+fz9Xt7CgfOPDF76Vg7XC8cIbRG0mMOups=;
 b=K4+MSlfN0dBI1oCz/9W6H5EbbN182cvMKqsakUapGGTZgB9eLuK0aNkKeOOM+gACtjF2
 w+61B6SKaaD66qE6kWeRYIHQakHl0Zw5r3pm/RFpVjEoDC7MmSh2cj48fsK/kVlWkvKo
 inGcc+WsZ/YnSv16PEtdaurOaOLyBZlGeWAgF6YR4x8zX8V/9npCsGCGviRWGWExRjLU
 mrJIU4e2YQO374BHE+T7SjyBf8OxXX5RfTTia4gMFBwyMq3J48kWNP8ca5RwtbJoAXZh
 f7OW1UlGUbIpd/QdGz+8fqeDTFvvam3m1uHMBZk/pljt1IGpC9rbYQPpRPQb9DYgxI8T 8A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nr7cs1w1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 08:46:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAE8k2Qi018449
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 08:46:02 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAE8k26h011582;
        Wed, 14 Nov 2018 08:46:02 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 00:46:01 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 0/4] blk-mq: refactor and fix on issue request directly
Date:   Wed, 14 Nov 2018 16:45:27 +0800
Message-Id: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140080
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Jens

Please consider this patchset for 4.21.
It refactors the code of issue request directly to unify the interface
and make the code clearer and more readable, and also fixes a defects
there.

The 1st patch refactors the code of issue request directly to unify the
helper interface which could handle all the cases.

The 2nd patch fix the issue that when queue is stopped or quiesced request
may pass through bottom device's potential io scheduler.

The 3rd patch make blk_mq_sched_insert_requests issue requests directly
with 'bypass' false, then it needn't to handle the non-issued requests
any more.

The 4th patch replace and kill the blk_mq_request_issue_directly.

V7:
 - drop the original 3rd patch which try to ensure hctx to be ran on mapped
   cpu. As it add get/put_cpu and cpumask test in hot path and it is not
   necessary for drivers to do the guarantee.

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

Jianchao Wang(4)
  blk-mq: refactor the code of issue request directly
  blk-mq: fix issue directly case when q is stopped or quiesced
  blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
  blk-mq: replace and kill blk_mq_request_issue_directly

block/blk-core.c     |   4 +-
block/blk-mq-sched.c |   8 ++--
block/blk-mq.c       | 112 ++++++++++++++++++++++-----------------------------
block/blk-mq.h       |   7 ++--
4 files changed, 59 insertions(+), 72 deletions(-)

Thanks
Jianchao





Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA31C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 01:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567F920672
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 01:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="03E470CH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567F920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeLKBld (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:41:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54348 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbeLKBld (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 20:41:33 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBB1YPt2010319;
        Tue, 11 Dec 2018 01:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+BqcrYpxy5FhbcXFuoeBDdEk/8cWqUDOO4+BAyActtY=;
 b=03E470CHJ6TnfEhVEOx9se16Vc3fTDz9HchegaM/Vx3xAirRQ1qLybBY9UGetW5/Or10
 wOC5SXc2Z2SjT48qKlHt9pv9eUaRUbY5usSKyLj7jC6plBb0de7rvJDuqwB1+GqVI1vQ
 ZmvEwV4PLnOcHf6cz7Ao3R2lCae7zS9VhimErgnhUkcP0hktRjBVPyH8/sxaxFqqCT/X
 vTYWJjqmEwo9kqnFv/C1MGAOecU5VOEhNMc6GsAsvf3UxW6PKFjqexvJcMOVQY2TqatK
 nkEqmOTY1Z2YF1vJlBOfny793OYEA9q4Oi8yjYth7ClLKQ6InblxS5NE5sJW/EHK/qNx Nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2p83fe1d56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 01:41:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBB1fQC1026840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 01:41:27 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBB1fQQX000878;
        Tue, 11 Dec 2018 01:41:26 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 17:41:26 -0800
Subject: Re: [PATCH V13 0/3] blk-mq: refactor code of issue directly
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544410892-2905-1-git-send-email-jianchao.w.wang@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e0048af3-6ba5-f397-9837-41fede63ce07@oracle.com>
Date:   Tue, 11 Dec 2018 09:42:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544410892-2905-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110014
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping ?

Thanks
Jianchao

On 12/10/18 11:01 AM, Jianchao Wang wrote:
> Hi Jens
> 
> Please consider this patchset for 4.21.
> 
> It refactors the code of issue request directly to unify the interface
> and make the code clearer and more readable.
> 
> The 1st patch refactors the code of issue request directly to unify the
> helper interface which could handle all the cases.
> 
> The 2nd patch make blk_mq_sched_insert_requests issue requests directly
> with 'bypass' false, then it needn't to handle the non-issued requests
> any more.
> 
> The 3rd patch replace and kill the blk_mq_request_issue_directly.
> 
> V13:
>  - remove the unused tag 'out' (1/3)
> 
> V12:
>  - remove the original 1st patch/
>  - rebase other 3 patches on newest for-4.21/block
>  - add some comment
> 
> V11:
>  - insert request to dispatch list when .queue_rq return
>    BLK_STS_RESOURCE/BLK_STS_DEV_RESOURCE. (2/4)
>  - stop to attempt direct-issue and insert the reset when meet
>    non-ok case (3/4).
> 
> V10:
>  - address Jen's comment.
>  - let blk_mq_try_issue_directly return actual result for case
>    'bypass == false'. (2/4)
>  - use return value of blk_mq_try_issue_directly to identify
>    whether the request is direct-issued successfully. (3/4)
> 
> V9:
>  - rebase on recent for-4.21/block
>  - add 1st patch
> 
> V8:
>  - drop the original 2nd patch which try to insert requests into hctx->dispatch
>    if quiesced or stopped.
>  - remove two wrong 'unlikely'
> 
> V7:
>  - drop the original 3rd patch which try to ensure hctx to be ran on
>    its mapped cpu in issueing directly path.
> 
> V6:
>  - drop original 1st patch to address Jen's comment
>  - discard the enum mq_issue_decision and blk_mq_make_decision and use
>    BLK_STS_* return values directly to address Jen's comment. (1/5)
>  - add 'unlikely' in blk_mq_try_issue_directly (1/5)
>  - refactor the 2nd and 3rd patch based on the new 1st patch.
>  - reserve the unused_cookie in 4th and 5th patch
> 
> V5:
>  - rebase against Jens' for-4.21/block branch
>  - adjust the order of patch04 and patch05
>  - add patch06 to replace and kill the one line blk_mq_request_bypass_insert
>  - comment changes
> 
> V4:
>  - split the original patch 1 into two patches, 1st and 2nd patch currently
>  - rename the mq_decision to mq_issue_decision
>  - comment changes
> 
> V3:
>  - Correct the code about the case bypass_insert is true and io scheduler
>    attached. The request still need to be issued in case above. (1/4)
>  - Refactor the code to make code clearer. blk_mq_make_request is introduced
>    to decide insert, end or just return based on the return value of .queue_rq
>    and bypass_insert (1/4) 
>  - Add the 2nd patch. It introduce a new decision result which indicates to
>    insert request with blk_mq_request_bypass_insert.
>  - Modify the code to adapt the new patch 1.
> 
> V2:
>  - Add 1st and 2nd patch to refactor the code.
> 
> 
> Jianchao Wang (3)
> blk-mq: refactor the code of issue request directly
> blk-mq: issue directly with bypass 'false' in
> blk-mq: replace and kill blk_mq_request_issue_directly
> 
> block/blk-core.c     |   4 +-
> block/blk-mq-sched.c |   8 ++--
> block/blk-mq.c       | 123 +++++++++++++++++++++++++--------------------------
> block/blk-mq.h       |   6 ++-
> 4 files changed, 70 insertions(+), 71 deletions(-)
> 
> Thanks
> Jianchao
> 
> 

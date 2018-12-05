Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB66C04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FDD2081C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CP5baTPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FDD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbeLEDBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:01:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37590 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEDBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 22:01:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB52xIAQ164993;
        Wed, 5 Dec 2018 03:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=T3XEqKyqB/8LE7iZPiELQPs+ckmt9K0/WHT9jmsxIiY=;
 b=CP5baTPb1dFG6AaPw4LKr35l3AmCcZIIdrvG1b29mvvt8BXNGhLjJ1xhfgkx00yciKLS
 uk0oaVE77LcPdUJG8HLWZ81/4TlcSMlOKO+kYDNG054IGFnjY9oKeuJ1nBSIgrxqIlVN
 60cGjTHTK4NGCCNy38YShH7UF67aUUKeCX2wVJ5gEWrjKCZCgygMa17BcpUc4fMnbxq0
 RFy7ExUleEKpHaPqSahdiPPnXlgte1P18ZGKmbeTj3IYzyvMIyyIZIBrioln4AdGHyYx
 AkUhBvJnXruFdp1cB9CUKNy4kZ6ZVQ6Hk7XQl/is5aK6I8OMUN2BU+2HSS/+5x3l+fKK 2A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqtyy5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 03:01:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB531CVr019165
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 03:01:13 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB531Caf008230;
        Wed, 5 Dec 2018 03:01:12 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 19:01:12 -0800
Subject: Re: [PATCH V8 0/3] blk-mq: refactor code of issue request directly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542251558-10517-1-git-send-email-jianchao.w.wang@oracle.com>
 <88fe68c6-886c-1328-009a-9c7c5fa4ebc9@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <154edba0-f4dc-716f-df64-50b23db39138@oracle.com>
Date:   Wed, 5 Dec 2018 11:01:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <88fe68c6-886c-1328-009a-9c7c5fa4ebc9@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/5/18 10:58 AM, Jens Axboe wrote:
> On 11/14/18 8:12 PM, Jianchao Wang wrote:
>> Hi Jens
>>
>> Please consider this patchset for 4.21.
>> It refactors the code of issue request directly to unify the interface
>> and make the code clearer and more readable.
>>
>> The 1st patch refactors the code of issue request directly to unify the
>> helper interface which could handle all the cases.
>>
>> The 2nd patch make blk_mq_sched_insert_requests issue requests directly
>> with 'bypass' false, then it needn't to handle the non-issued requests
>> any more.
>>
>> The 3rd patch replace and kill the blk_mq_request_issue_directly.
> 
> I'd love to get this queued up, the direct dispatch path is a mess and
> it's even now been known to cause corruptions... I'm going to queue
> up the direct dispatch fix shortly, and apply it to for-4.21/block
> as well. Any chance you can respin this on top after that?
> 

OK, I will do now.

Thanks
Jianchao

Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57382C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB6022360
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wbmVNsen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB6022360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeKOLlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:41:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOLlO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 06:41:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAF1U0Le128824;
        Thu, 15 Nov 2018 01:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hKQkzgbLsQ66WXB6sPHOTALk0ojr6tOPyXzTnJyBbXE=;
 b=wbmVNsenHVT3Yb6/vNz998leHf45BMQMLQPaDWFBgRtZ4ns0+hiArz4icjKOI0I8DZV0
 ikpmBl3mieXAVZMFNK0FJNH5iUyMp3b+ynzaHd32wBVs2Ubu33aGb+HVsap+omYm7/cJ
 eOk75h/GtZdT6nAtX6XO6ltX2Zqq3FV7P+XIn9G0kJE1qkhpU0xWG8ECclfadAN8DkQd
 yU75WKEHvEvgi/Z7Slx2KuAIUGLe63iHMHs4/9gYwa/vQad4Kmj2IwB8cdyGr2YLzL9/
 Hl6HfjOEhwzCAEx2dJcJGAEEK+9gWfyUBv1/m98ndyBQvbDwVCOkCEmc+n44IpAi/bxp 4g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nr7cs6udx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 01:35:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAF1ZQ3t028728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Nov 2018 01:35:26 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAF1ZQ6o028571;
        Thu, 15 Nov 2018 01:35:26 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 17:35:26 -0800
Subject: Re: [PATCH V7 1/4] blk-mq: refactor the code of issue request
 directly
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542185131-15029-2-git-send-email-jianchao.w.wang@oracle.com>
 <20181114091153.GB20550@ming.t460p>
 <17b51550-d45b-9861-b172-74ee0e256d98@oracle.com>
 <20181114094343.GA13193@ming.t460p>
 <42861ece-5519-bb59-e3a7-8fea1c731f19@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d7c48fb9-9294-49ff-bb18-67a5db3ea021@oracle.com>
Date:   Thu, 15 Nov 2018 09:35:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <42861ece-5519-bb59-e3a7-8fea1c731f19@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9077 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811150011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/14/18 11:22 PM, Jens Axboe wrote:
> On 11/14/18 2:43 AM, Ming Lei wrote:
>> On Wed, Nov 14, 2018 at 05:23:48PM +0800, jianchao.wang wrote:
>>> Hi Ming
>>>
>>> On 11/14/18 5:11 PM, Ming Lei wrote:
>>>>>  
>>>>> -	if (!blk_mq_get_dispatch_budget(hctx))
>>>>> -		goto insert;
>>>>> +	if (unlikely(!blk_mq_get_dispatch_budget(hctx)))
>>>>> +		goto out_unlock;
>>>> The unlikely annotation is a bit misleading, since out-of-budget can
>>>> happen frequently in case of low queue depth, and there are lots of
>>>> such examples.
>>>>
>>>
>>> This could be good for the case for no .get_budget and getting budget success.
>>> In case of out-of-budget, we insert the request which is slow path.
>>
>> In case of low queue depth, it is hard to say that 'insert request' is
>> done in slow path, cause it happens quite frequently.
>>
>> I suggest to remove these two unlikely() since modern CPU's branch prediction
>> should work well enough.
>>
>> Especially the annotation of unlikely() often means that this branch is
>> missed in most of times for all settings, and it is obviously not true
>> in this case.
> 
> Agree, unlikely() should only be used for the error handling case or
> similar that does indeed almost never trigger. It should not be used
> for cases that don't trigger a lot in "most" circumstances.
> 

That's really appreciated for all of your kindly response.
Fair enough with 'unlikely'.
I will remove these two wrong 'unlikely' in next version.

Thanks
Jianchao


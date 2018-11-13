Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC8C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 04:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DDF2245E
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 04:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yfOH5G3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DDF2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeKMOIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:08:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59452 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeKMOIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 09:08:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAD48smj145078;
        Tue, 13 Nov 2018 04:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5WPxsdu0yw/8Qm8Yv1F0P9m2Gq8yq2lWiRtXmDAnn9w=;
 b=yfOH5G3aF06dxB4Aq3D5BoS/uRCa4907po+PUwYZqUSr5Qe684/JSaKcnkrcEHMs93x4
 WI+jjvzxLbnpl/nAR21Q2+2l3N8HeSBLrFvwZH3LLj6N7c9lQtkRiVpHI+chsIwE6ZOH
 o7N2zef1VE4llTvaFK1lqHY09KEx0WU236bIcfXFmsPhCCp463Ogqdq39GGTLAPuEjbQ
 XKN3gUjilZoKSivbye+PqVqQwL3lwoc84OoR/ldHy7/9Qtbzp+16Qomq6OprybBoqHKS
 RWa0HqVqmqB7V4g5VDLA3dWO0ndipZZwXk6rVwHXjSysRgt5TVNk/NNMtNx1UdhzVPyr lA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nnwg181dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 04:12:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAD4CWkR005370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 04:12:33 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAD4CV9e024724;
        Tue, 13 Nov 2018 04:12:32 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 20:12:30 -0800
Subject: Re: [PATCH V5 2/6] blk-mq: refactor the code of issue request
 directly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542014609-1769-3-git-send-email-jianchao.w.wang@oracle.com>
 <77b68772-4daa-cffc-079a-7ad1bfae2fec@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a7fe7cf3-528b-06bd-135f-c12a08ee9657@oracle.com>
Date:   Tue, 13 Nov 2018 12:12:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <77b68772-4daa-cffc-079a-7ad1bfae2fec@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9075 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130038
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

On 11/13/18 11:22 AM, Jens Axboe wrote:
> On 11/12/18 2:23 AM, Jianchao Wang wrote:
>> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
>> into one interface to unify the interfaces to issue requests
>> directly. The merged interface takes over the requests totally,
>> it could insert, end or do nothing based on the return value of
>> .queue_rq and 'bypass' parameter. Then caller needn't any other
>> handling any more.
>>
>> To make code clearer, introduce new helpers enum mq_issue_decision
>> and blk_mq_make_decision to decide how to handle the non-issued
>> requests.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq.c | 108 +++++++++++++++++++++++++++++++++------------------------
>>  1 file changed, 63 insertions(+), 45 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 364a53f..48b7a7c 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1766,77 +1766,95 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>>  	return ret;
>>  }
>>  
>> -static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>> +enum mq_issue_decision {
>> +	MQ_ISSUE_INSERT_QUEUE,
>> +	MQ_ISSUE_END_REQUEST,
>> +	MQ_ISSUE_DO_NOTHING,
>> +};
>> +
>> +static inline enum mq_issue_decision
>> +	blk_mq_make_dicision(blk_status_t ret, bool bypass)
>> +{
>> +	enum mq_issue_decision dec;
>> +
>> +	switch(ret) {
>> +	case BLK_STS_OK:
>> +		dec = MQ_ISSUE_DO_NOTHING;
>> +		break;
>> +	case BLK_STS_DEV_RESOURCE:
>> +	case BLK_STS_RESOURCE:
>> +		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_INSERT_QUEUE;
>> +		break;
>> +	default:
>> +		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_END_REQUEST;
>> +		break;
>> +	}
>> +
>> +	return dec;
>> +}
> 
> You seem to mix and match decision and dicision, the former is the
> right spelling.
> 

Oops, it's my bad that not find this even in V5 respin.

> But more importantly, not sure I like where this is going, wrapping
> the return value in some other status code. That also makes it a bit
> fragile in terms of adding other status codes, another spot to update.
> Like the decent distinction between RESOURCE and DEV_RESOURCE.
> 
> Maybe it is cleaner to just handle this in the caller still?
> 
Actually enum mq_issue_decision is introduced to reduce the depth of
'if' branch. And it is indeed not good to introduce another status value.

I will discard enum mq_issue_decision and blk_mq_make_decision in next version.

Thanks
Jianchao

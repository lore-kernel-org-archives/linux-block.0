Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0691C04EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 01:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72C72146D
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 01:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SHdrCm3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72C72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeLFBLb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:11:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46994 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFBLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 20:11:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB619idc001560;
        Thu, 6 Dec 2018 01:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BpHNERcP+usiB6ijW7Vv6qJrTws/14F5ApTXtGpapeo=;
 b=SHdrCm3LZgYtqOOjHSBm/0pPxuV6jwPuifnTPMd9n1rN+qJRt3b9EqL8d72tgcbVrXmF
 3z9YvRQcIYlqEACOmHH8edFXPqmf2cpamCiQu6gIgWE4r1glSpbn/8SORz0g9cE++v4j
 LvTzAXJyJ7sBC1ICp/jfaxfRICejKjBIXT3aQr6Qz1aQi7iQArOA7MjO/W0+QogtMjVH
 jjKbGi/PV6rK3AofgdZi6tuS3nyWaLo01b0K6B6kVBYU5Co+2AHQhOEt6/mGV00PyDxh
 fhPYYoS9sFzwhw6DjQfrLcbt8o1wpJNUdQpn1yQ6JjHJv1vKK4Gzbpyv3GDETg9/3Njn hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftf9keb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 01:11:27 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB61BLB9006459
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 01:11:21 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB61BL70011296;
        Thu, 6 Dec 2018 01:11:21 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 01:11:21 +0000
Subject: Re: [PATCH V9 1/4] blk-mq: insert to hctx dispatch list when
 bypass_insert is true
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
 <1543995842-20704-2-git-send-email-jianchao.w.wang@oracle.com>
 <54c7377f-e8e6-92cf-eced-6c76297afd52@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <99339021-4d05-8dff-bee4-a6af2eaf3e21@oracle.com>
Date:   Thu, 6 Dec 2018 09:12:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <54c7377f-e8e6-92cf-eced-6c76297afd52@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060007
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/6/18 12:25 AM, Jens Axboe wrote:
> On 12/5/18 12:43 AM, Jianchao Wang wrote:
>> We don't allow direct dispatch of anything but regular reads/writes
>> and insert all of non-read-write requests. However, this is not
>> correct for 'bypass_insert == true' case where inserting is ignored
>> and BLK_STS_RESOURCE is returned. The caller will fail forever.
>>
>> Fix it with inserting the non-read-write request to hctx dispatch
>> list to avoid to involve merge and io scheduler when bypass_insert
>> is true.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq.c | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 9005505..153af90 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1822,6 +1822,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>  {
>>  	struct request_queue *q = rq->q;
>>  	bool run_queue = true;
>> +	bool force = false;
>>  
>>  	/*
>>  	 * RCU or SRCU read lock is needed before checking quiesced flag.
>> @@ -1836,9 +1837,19 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>  		goto insert;
>>  	}
>>  
>> -	if (!blk_rq_can_direct_dispatch(rq) || (q->elevator && !bypass_insert))
>> +	if (q->elevator && !bypass_insert)
>>  		goto insert;
>>  
>> +	if (!blk_rq_can_direct_dispatch(rq)) {
>> +		/*
>> +		 * For 'bypass_insert == true' case, insert request into hctx
>> +		 * dispatch list.
>> +		 */
>> +		if (bypass_insert)
>> +			force = true;
>> +		goto insert;
>> +	}
> 
> Just do force = bypass_insert, no need for the if.
> 

Yes, I will do it.

Thanks
Jianchao

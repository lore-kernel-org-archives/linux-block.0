Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB55C04EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 01:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227FB2146D
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 01:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C31YpJ5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227FB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeLFBL6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:11:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47256 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFBL6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 20:11:58 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB619Pur001212;
        Thu, 6 Dec 2018 01:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VZkgXeIEZ3W6cCdhF/Is7OQcrhENZCkkmF7DPwBBxMA=;
 b=C31YpJ5Zpepp+vNFioW4Xc4BS+hZvsK7l7N94B1rfjRM9XAH5XfhQMfm7LdUMDyZ6xMQ
 R1/jMgTL3bh9eu1Cegq263dAWyZPr7zOmW20DLn28vstpIy9/JG9uX0xQk3bFaINkC5r
 t41NU71fFhtHc/Nhh1DtDmeZ4+zVu6cCqF4NEijwE0WwGXG36P/mTCsVrpiNXBVj7GNT
 MyTX2El4B6Y/0ODmAxkIdZa/TagG9Z/knVM8ncHqiJcsmEAy3ZLawRMytnoDooFjUOHJ
 FD6CvTBYeFNpwy4XYjlM6Ps7VBImh3qLCLDX/yMBUsz7dLJi37Q9ngr/nUjTWL9Szra7 Kw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftf9kgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 01:11:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB61BrxD007589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 01:11:53 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB61Bq2l021192;
        Thu, 6 Dec 2018 01:11:53 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 17:11:52 -0800
Subject: Re: [PATCH V9 2/4] blk-mq: refactor the code of issue request
 directly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
 <1543995842-20704-3-git-send-email-jianchao.w.wang@oracle.com>
 <d46af0a7-62f3-4988-2b1c-857378282356@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f1f368b7-fb2f-5ef4-4179-6086a0d91c35@oracle.com>
Date:   Thu, 6 Dec 2018 09:12:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d46af0a7-62f3-4988-2b1c-857378282356@kernel.dk>
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



On 12/6/18 12:27 AM, Jens Axboe wrote:
> On 12/5/18 12:44 AM, Jianchao Wang wrote:
>> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
>> into one interface to unify the interfaces to issue requests
>> directly. The merged interface takes over the requests totally,
>> it could insert, end or do nothing based on the return value of
>> .queue_rq and 'bypass' parameter. Then caller needn't any other
>> handling any more and then code could be cleaned up.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq.c | 116 +++++++++++++++++++++++++++------------------------------
>>  1 file changed, 54 insertions(+), 62 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 153af90..fe92e52 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1815,93 +1815,85 @@ static bool blk_rq_can_direct_dispatch(struct request *rq)
>>  	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
>>  }
>>  
>> -static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>> +static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>  						struct request *rq,
>>  						blk_qc_t *cookie,
>> -						bool bypass_insert, bool last)
>> +						bool bypass, bool last)
>>  {
>>  	struct request_queue *q = rq->q;
>>  	bool run_queue = true;
>> +	blk_status_t ret = BLK_STS_RESOURCE;
>> +	int srcu_idx;
>>  	bool force = false;
>>  
>> +	if (!blk_rq_can_direct_dispatch(rq)) {
>> +		/*
>> +		 * Insert request to hctx dispatch list for 'bypass == true'
>> +		 * case, otherwise, the caller will fail forever.
>> +		 */
>> +		if (bypass)
>> +			force = true;
>> +		goto out;
>> +	}
> 
> Same here, of course.

Yes, I will change it next version.

> 
> Otherwise looks fine.
> 

Thanks
Jianchao

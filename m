Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0723CC04EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 01:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9D120892
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 01:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PS3GR5TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9D120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeLFBKs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:10:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41264 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFBKr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 20:10:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB619T31034130;
        Thu, 6 Dec 2018 01:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vkfPimCXJ60akZSzATpjseD0xbz2X0hZ5XHuYLhIpdA=;
 b=PS3GR5TQdRzepDNb3wCL14cqjAAlPfVEyjNIc8iTQvV6yCiovIjWJvW/pskA7lzAvSkf
 mj3DW+IMf7hyTkVP6SuHiwNZTVmhHVsta88akECO0LZD6/DjDPhPjPk2WEZRcYE4axhF
 D77uJ8j91SFvHtzTDi3Z+PyQkm/zowI2PcGRbr5Vv35w6uuQ8/Kf/9NomrVXL1EyHdGm
 AFnLutoYgZ7vJlO3p1asZg98wyy1LwFF0+I2i7OtpPxcvtP+c/ymfpUKHEKw7YcDKaW7
 SclorHL4AvHFmMf78tUDmK4SAVWzMpdXNl3iFwkNs9KHXAe5YBRoMq2zP6krhGR3eOpF fA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hqu5pbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 01:10:43 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB61AfRW002107
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 01:10:42 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB61Afnl020735;
        Thu, 6 Dec 2018 01:10:41 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 17:10:41 -0800
Subject: Re: [PATCH V9 3/4] blk-mq: issue directly with bypass 'false' in
 blk_mq_sched_insert_requests
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
 <1543995842-20704-4-git-send-email-jianchao.w.wang@oracle.com>
 <6cb12913-3575-d3aa-ff08-f89bcb38b3d6@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b57bbedf-bc7e-7b8d-2217-3e8628ab657c@oracle.com>
Date:   Thu, 6 Dec 2018 09:11:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6cb12913-3575-d3aa-ff08-f89bcb38b3d6@kernel.dk>
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

Hi Jens

On 12/6/18 12:30 AM, Jens Axboe wrote:
> On 12/5/18 12:44 AM, Jianchao Wang wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index fe92e52..0dfa269 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1899,32 +1899,23 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>>  void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>>  		struct list_head *list)
>>  {
>> +	blk_qc_t cookie = BLK_QC_T_INVALID;
>> +
> 
> I'm fine with adding this, but I think we need some sort of check for
> that not being a valid cookie. That isn't new, we really should have
> already.
> 
>>  	while (!list_empty(list)) {
>> -		blk_status_t ret;
>>  		struct request *rq = list_first_entry(list, struct request,
>>  				queuelist);
>>  
>> -		if (!blk_rq_can_direct_dispatch(rq))
>> -			break;
>> -
>>  		list_del_init(&rq->queuelist);
>> -		ret = blk_mq_request_issue_directly(rq, list_empty(list));
>> -		if (ret != BLK_STS_OK) {
>> -			if (ret == BLK_STS_RESOURCE ||
>> -					ret == BLK_STS_DEV_RESOURCE) {
>> -				list_add(&rq->queuelist, list);
>> -				break;
>> -			}
>> -			blk_mq_end_request(rq, ret);
>> -		}
>> +		blk_mq_try_issue_directly(hctx, rq, &cookie, false,
>> +				list_empty(list));
> 
> Indent the list_empty() one more tab, should be after the ( if possible.

Yes, I will do it

> 
>> -	 * If we didn't flush the entire list, we could have told
>> -	 * the driver there was more coming, but that turned out to
>> -	 * be a lie.
>> +	 * cookie is set to a valid value only when reqeust is issued successfully.
>> +	 * We only need to care about the last request's result, if it is inserted,
>> +	 * kick the hardware with commit_rqs hook.
> 
> reqeust -> request
> 
> Also lines are too long, limit to 80 chars please.

Yes, I will do it.

> 
> And why aren't we just using the list_empty() check like before, and not
> having to add the inval cookie value?

Because we use 'bypass == false' here, so blk_mq_try_issue_directly will take
over the request totally, so the request will always be removed from the list
and finally, the list must be empty.

There is another way to identify the result of blk_mq_try_issue_directly.
Currently,
for the 'bypass == true' case,
    it always return BLK_STS_OK,
for the 'bypass == false' case,
    it return the actual result, except for 'force == true' case
    where the request has to be inserted into hctx dispatch list
    and return a BLK_STS_OK.

We could let the 'bypass == true' case also return the actual result to
show what has been done in the blk_mq_try_issue_directly and thus we could
get the actual result of the last request.

Would you mind we handle it like this ?

>> -	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
>> +	if ((cookie == BLK_QC_T_INVALID) && hctx->queue->mq_ops->commit_rqs)
>>  		hctx->queue->mq_ops->commit_rqs(hctx);
> 
> Redundant parens around the cookie check.
> 

Yes.

Thanks
Jianchao

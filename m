Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE611C56202
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 03:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5521F20872
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 03:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKYDK4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:10:56 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36739 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbgKYDK4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 22:10:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGSxlA._1606273852;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UGSxlA._1606273852)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 11:10:53 +0800
Subject: Re: [PATCH v5] block: disable iopoll for split bio
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com
References: <20201123080020.64667-1-jefflexu@linux.alibaba.com>
 <20201124112100.GA25573@infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <91536149-afaf-88ed-85be-0e7a95621434@linux.alibaba.com>
Date:   Wed, 25 Nov 2020 11:10:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201124112100.GA25573@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/24/20 7:21 PM, Christoph Hellwig wrote:
> This looks generally food:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Some cosmetic nitpicks below:
> 
>> +	/*
>> +	 * Bio splitting may cause subtle trouble such as hang
>> +	 * when doing sync iopoll in direct IO routine. Given
>> +	 * performance gain of iopoll for big IO can be trival,
>> +	 * disable iopoll when split needed.
>> +	 */
> 
> You can use up all 80 characters for comments, and doing so generally
> helps readability.
> 
Thanks. I will be more careful about this. I'm gonna set related 
constraint in my vim, checkpatch etc. ;)

>> -	return cookie;
>> +	return bio_flagged(bio, BIO_NONE_COOKIE) ? BLK_QC_T_NONE : cookie;
> 
> I'd write this a little more easily flowing as:
> 
> 	if (bio_flagged(bio, BIO_NONE_COOKIE))
> 		return BLK_QC_T_NONE;
> 	return cookie;
> 
Regards.

>>   queue_exit:
>>   	blk_queue_exit(q);
>>   	return BLK_QC_T_NONE;
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index d9b69bbde5cc..938fd25d2c68 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -284,6 +284,7 @@ enum {
>>   				 * of this bio. */
>>   	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
>>   	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
>> +	BIO_NONE_COOKIE,	/* disable iopoll for split bio */
> 
> I'd rename this to BIO_SPLIT and update the comment.  The rationale
> is BIO_SPLIT is what happened to the bio.  The fact that
> blk_mq_submit_bio doesn't return the cookie is just one good use of
> such information.
> 
Actually why I didn't choose 'BIO_SPLIT' at the very beginning is that, 
currently only normal IO in mq routine gets marked when they gets split, 
neither abnormal IO nor normal IO in dm/md routine, though this is 
reasonable since currently only normal IO in mq routine is capable of 
polling and gets stuck in this issue.

But BIO_SPLIT may be more clear? I could explain the above constraint in 
the comment instead.


Thanks for reviewing.
-- 
Thanks,
Jeffle

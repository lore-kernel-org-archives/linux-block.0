Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B40C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 02:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EB52243E
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 02:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="APbsb8af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EB52243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeKML6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:58:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKML6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 06:58:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAD1rsK2026547;
        Tue, 13 Nov 2018 02:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HNf7CgfWd7puxc4OHacKKS3Svugp/2Np/zvxnmS616w=;
 b=APbsb8af2uzYiIOssHHRFJpKeB31eoi/7ZFIqK+QKLbiBxkOgfQrWQ2my+Q7en+96P32
 S+GMSk5+L8+nMBIDLjACsylnX+NSniiGyYIVbgoTN5O9z/5zLk7of7zE3692evCrhRiU
 LafxiPBRiXGrn8jTekHQsGDgdk3zdoDFxJhvhrJNabf5mi1kX4T/oOnUOec3y/vjOYbV
 MStGLY9gR07e9ZetEWLsV02+8/EcdOgG7MoC8R85U2C0usaG3JUkSJz8OjBO76Re/+uk
 xTMn4AuaA7ihb51+x1b9WpF8LYLihMyCXF0EBLm5iUAzqlJbxmkIRoOjUodQjF7nCcK2 dg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nnw6eftcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 02:02:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAD22kJR006485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 02:02:47 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAD22kUQ012427;
        Tue, 13 Nov 2018 02:02:46 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 18:02:46 -0800
Subject: Re: [PATCH 4/6] block: avoid ordered task state change for polled IO
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-5-axboe@kernel.dk>
 <653c9f83-157c-dca9-aa3b-02903dc81f5b@oracle.com>
 <e213ca38-19c0-70ca-e4d0-096c48d5b4b8@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8d87e7a2-aa63-0178-23e5-efb906bbc0b9@oracle.com>
Date:   Tue, 13 Nov 2018 10:02:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e213ca38-19c0-70ca-e4d0-096c48d5b4b8@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9075 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=935
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130016
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

On 11/13/18 12:26 AM, Jens Axboe wrote:
> On 11/12/18 2:35 AM, jianchao.wang wrote:
>> Hi Jens
>>
>> On 11/10/18 11:13 PM, Jens Axboe wrote:
>>> We only really need the barrier if we're going to be sleeping,
>>> if we're just polling we're fine with the __set_current_state()
>>> variant.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  fs/block_dev.c | 25 +++++++++++++++++++++----
>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>>> index c039abfb2052..e7550b1f9670 100644
>>> --- a/fs/block_dev.c
>>> +++ b/fs/block_dev.c
>>> @@ -237,12 +237,23 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>>  
>>>  	qc = submit_bio(&bio);
>>>  	for (;;) {
>>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>>> +		/*
>>> +		 * Using non-atomic task state for polling
>>> +		 */
>>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>>> +
>>>  		if (!READ_ONCE(bio.bi_private))
>>>  			break;
>>
>> When we don't use polling, the blkdev_bio_end_io_simple may come on a different cpu before
>> submit_bio returns 
>> For example,
>> __blkdev_direct_IO_simple
>>   qc = submit_bio(&bio) 
>>                                           blkdev_bio_end_io_simple
>>                                             WRITE_ONCE(bio.bi_private, NULL)
>>                                             wake_up_process(waiter)
>>   __set_current_state(TASK_UNINTERRUPTIBLE)                              
>>   READ_ONCE(bio.bi_private)
> 
> While I agree that you are right, that's an existing issue. The store
> barrier implied by set_current_state() doesn't fix that.
> 
> How about this variant:
> 
> https://urldefense.proofpoint.com/v2/url?u=http-3A__git.kernel.dk_cgit_linux-2Dblock_commit_-3Fh-3Dmq-2Dperf-26id-3D036ba7a8d1334889c0fe55d4858d78f4e8022f12&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=pjbk_9rxuy7OS1pCkQ9MAHzFf4eT27Yt4RL8jASDJCA&s=AnmYMIcGpIILUrjDFsabj61pcTyMCRHB1Pu8XXi47t0&e=
> 
> which then changes the later wake up helper patch to be:
>  
> https://urldefense.proofpoint.com/v2/url?u=http-3A__git.kernel.dk_cgit_linux-2Dblock_commit_-3Fh-3Dmq-2Dperf-26id-3Df8c3f188425967adb040cfefb799b0a5a1df769d&d=DwICaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=pjbk_9rxuy7OS1pCkQ9MAHzFf4eT27Yt4RL8jASDJCA&s=PdajuUul55e6p0FED_AzzWt5Gip0ekLi1eGYBMLiZPo&e=
> 

The wake up path has contained a full memory barrier with the raw_spin_lock and following smp_mb__after_spinlock

wake_up_process
  -> try_to_wake_up

	raw_spin_lock_irqsave(&p->pi_lock, flags);
	smp_mb__after_spinlock();

So a smp_rmb() could be enough. :)

Thanks
Jianchao

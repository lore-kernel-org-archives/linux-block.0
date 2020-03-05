Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF65C3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 11:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6B2208C3
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 11:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCELEc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:04:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:60320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgCELEc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 06:04:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5EF60AFA0;
        Thu,  5 Mar 2020 11:04:29 +0000 (UTC)
Subject: Re: [PATCH] xen/blkfront: fix ring info addressing
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20200305100331.16790-1-jgross@suse.com>
 <20200305104935.GU24458@Air-de-Roger.citrite.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <20915d12-665e-bd23-2685-d2ec7e015679@suse.com>
Date:   Thu, 5 Mar 2020 12:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305104935.GU24458@Air-de-Roger.citrite.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05.03.20 11:49, Roger Pau Monné wrote:
> On Thu, Mar 05, 2020 at 11:03:31AM +0100, Juergen Gross wrote:
>> Commit 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to
>> actual use case") made struct blkfront_ring_info size dynamic. This is
>> fine when running with only one queue, but with multiple queues the
>> addressing of the single queues has to be adapted as the structs are
>> allocated in an array.
> 
> Thanks, and sorry for not catching this during review.
> 
>>
>> Fixes: 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to actual use case")
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   drivers/block/xen-blkfront.c | 82 ++++++++++++++++++++++++--------------------
>>   1 file changed, 45 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index e2ad6bba2281..a8d4a3838e5d 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -213,6 +213,7 @@ struct blkfront_info
>>   	struct blk_mq_tag_set tag_set;
>>   	struct blkfront_ring_info *rinfo;
>>   	unsigned int nr_rings;
>> +	unsigned int rinfo_size;
>>   	/* Save uncomplete reqs and bios for migration. */
>>   	struct list_head requests;
>>   	struct bio_list bio_list;
>> @@ -259,6 +260,21 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
>>   static void blkfront_gather_backend_features(struct blkfront_info *info);
>>   static int negotiate_mq(struct blkfront_info *info);
>>   
>> +#define rinfo_ptr(rinfo, off) \
>> +	(struct blkfront_ring_info *)((unsigned long)(rinfo) + (off))
>                                        ^ void * would seem more natural IMO.
> 
> Also if you use void * you don't need the extra (struct
> blkfront_ring_info *) cast I think?

Yes, can change that.

> I however think this macro is kind of weird, since it's just doing an
> addition. I would rather have that calculation in get_rinfo and code
> for_each_rinfo on top of that.

I wanted to avoid the multiplication in the rather common
for_each_rinfo() usage.

> 
> I agree this might be a question of taste, so I'm not going to insist
> but that would reduce the number of helpers from 3 to 2.
> 
>> +
>> +#define for_each_rinfo(info, rinfo, idx)				\
>> +	for (rinfo = info->rinfo, idx = 0;				\
>> +	     idx < info->nr_rings;					\
>> +	     idx++, rinfo = rinfo_ptr(rinfo, info->rinfo_size))
> 
> I think the above is missing proper parentheses around macro
> parameters.

rinfo and idx are simple variables, so I don't think they need
parentheses. info maybe. But just seeing it now: naming the
parameter "rinfo" and trying to access info->rinfo isn't a good
idea. It is working only as I always use "rinfo" as the pointer.

> 
>> +
>> +static struct blkfront_ring_info *get_rinfo(struct blkfront_info *info,
>> +					    unsigned int i)
> 
> inline attribute might be appropriate here.

See "the inline disease" in the kernel's coding style.


Juergen


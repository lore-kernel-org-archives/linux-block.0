Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCAFC10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 10:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DF320818
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 10:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfDKKVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:21:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbfDKKVG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 06:21:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7A52632F08D0D580D5DD;
        Thu, 11 Apr 2019 18:21:01 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 11 Apr
 2019 18:20:55 +0800
Subject: Re: Some new bio merging behaviors in __bio_try_merge_page
To:     Ming Lei <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        Jens Axboe <axboe@kernel.dk>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <85c5fa1a-a506-e26f-c354-1554d47d8b2b@huawei.com>
 <20190411070807.GA421@ming.t460p>
 <cb392476-a00e-09ce-fa6b-9e088242ecc6@huawei.com>
 <20190411080953.GE421@ming.t460p>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <d7618cdc-b0a2-35bd-ef2d-a549907b0ef2@huawei.com>
Date:   Thu, 11 Apr 2019 18:20:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190411080953.GE421@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/4/11 16:09, Ming Lei wrote:
> On Thu, Apr 11, 2019 at 03:43:02PM +0800, Gao Xiang wrote:
>>
>>
>> On 2019/4/11 15:08, Ming Lei wrote:
>>> Hi Gao Xiang,
>>>
>>> On Thu, Apr 11, 2019 at 01:47:49PM +0800, Gao Xiang wrote:
>>>> Hi Ming,
>>>>
>>>> I found a erofs issue after commit 07173c3ec276
>>>> ("block: enable multipage bvecs") is merged. It seems that
>>>> it tries to merge more physical continuous pages in one iovec.
>>>>
>>>> However it breaks the current erofs_read_raw_page logic since it uses
>>>> nr_iovecs of bio_alloc to limit the maximum number of physical
>>>
>>> I believe you can do the limit outside easily, such as by checking
>>> how many pages have been added to the bio.
>>
>> Yes, I agree that. However, I noticed that bio_add_page is exported as
>> EXPORT_SYMBOL. I have no idea how many out-of-tree drivers break as well.
> 
> I don't think it is a good behaviour to use bio->bi_max_vecs to limit
> max allowed page, you may see the idea from the naming simply...

I hoped to simplify all these page limits to one number which is
the minimum number among them all then...

> 
> If there were other such drivers, we may fix it easily, and the following
> patch should fix your issue:
> 
> diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
> index 526e0dbea5b5..8878f2f2593e 100644
> --- a/drivers/staging/erofs/data.c
> +++ b/drivers/staging/erofs/data.c
> @@ -298,7 +298,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  	*last_block = current_block;
>  
>  	/* shift in advance in case of it followed by too many gaps */
> -	if (unlikely(bio->bi_vcnt >= bio->bi_max_vecs)) {
> +	if (unlikely(bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE)) {
>  		/* err should reassign to 0 after submitting */
>  		err = 0;
>  		goto submit_bio_out;

Yeah, it is fine, thanks for your suggestion :)

Thanks,
Gao Xiang

>>
>> Is there no way to take old behavior into consideration in the block layer as well?
> 
> One new interface, such as bio_add_page_limit(), may be helpful for
> addressing this issue, but not sure if it is necessary, since it is
> more reasonable to put the logic in user side.
> 
>>
>>>
>>>> continuous blocks as well. It was practicable since the old
>>>> __bio_try_merge_page only tries to merge in the same page.
>>>> it is a kAPI behavior change which also affects bio_alloc...
>>>>
>>>> ...
>>>> 231                 err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>>>> 232                 if (unlikely(err))
>>>> 233                         goto err_out;
>>>> ...
>>>> 284                 /* max # of continuous pages */
>>>> 285                 if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
>>>> 286                         nblocks = DIV_ROUND_UP(map.m_plen, PAGE_SIZE);
>>>> 287                 if (nblocks > BIO_MAX_PAGES)
>>>> 288                         nblocks = BIO_MAX_PAGES;
>>>> 289
>>>> 290                 bio = erofs_grab_bio(sb, blknr, nblocks, sb,
>>>> 291                                      read_endio, false);
>>>
>>> Previously this bio is allowed to add at most 'nblocks' pages, however,
>>> now we are allowed to add at most 'nblocks' io vecs, instead of pages.
>>>
>>>> 292                 if (IS_ERR(bio)) {
>>>> 293                         err = PTR_ERR(bio);
>>>> 294                         bio = NULL;
>>>> 295                         goto err_out;
>>>> 296                 }
>>>> 297         }
>>>> 298
>>>> 299         err = bio_add_page(bio, page, PAGE_SIZE, 0);
>>>> 300         /* out of the extent or bio is full */
>>>> 301         if (err < PAGE_SIZE)
>>>> 302                 goto submit_bio_retry;
>>>> ...
>>>>
>>>> After commit 07173c3ec276 ("block: enable multipage bvecs"), erofs could
>>>> read more beyond what erofs_map_blocks assigns, and out-of-bound data could
>>>> be read and it breaks tail-end inline determination.
>>>
>>> I don't understand why, could you explain a bit why erofs reads more?
>>
>> In current erofs, file could be break in two parts (non tail-end and tail-end blocks).
>> Considering this on-disk layout,
>>  ________________________________________________________________
>> |     non tail-end data              |   meta data               |
>> |____________________________________|_(inode) + non-inline data_|
>>                           ^          ^
>>                           |          |        
>>                           bio start  \-- what nr_iovecs indicates as well:
>>                                          the end of the non tail-end data.
>>
>> Before this commit, it will stop just before the next meta data. However,
>> if the new bio merging behavior is introduced, it could add pages more than
>> nr_iovecs, thus meta data will be read as the normal data...
> 
> I'd suggest you to not re-use bio->bi_max_vecs for this purpose.
> 
>>
>>
>>>
>>> The amount depends on how many pages you added to the bio.
>>>
>>>>
>>>> I can change the logic in erofs. However, out of curiosity, I have no idea
>>>> if some other places also are designed like this.
>>>>
>>>> IMO, it's better to provide a total count which indicates how many real
>>>> pages have been added in this bio. some thoughts?
>>>
>>> As I mentioned, you may count how many pages added to bio, or you still
>>> can get the number via bio_segments(bio).
>>
>> It is unsuitable to introduce bio_segments for each bio_add_page...
> 
> It isn't necessary, see the above patch.
> 
> 
> Thanks,
> Ming
> 

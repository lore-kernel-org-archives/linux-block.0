Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485DCC4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKSBVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiKSBVK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:21:10 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96121B70CD
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 16:19:45 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 8CC512B07345;
        Fri, 18 Nov 2022 19:19:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 18 Nov 2022 19:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1668817184; x=1668820784; bh=prtbcy8N/1
        rKugKj2vTvtItnBTqItgZYEcm/uusO8QU=; b=P9Qv0KCTBPHhYqGwupp0v55Ifi
        y+GwsnG8/2pzdM3tUjL2gWntdDHzJm3+hpwcBHIXwJMsNAoqDEuxtZ4cN0axfGw8
        FugfI0cjnL8E5FB1j1+GZ6SlsUnoXsLMKBiVCI3/t/m8uetRdA//6BSua8ytbEMc
        J/WWq/OX3oWI28qlSKc0ocxwamDt+pbOSrNTIXzc4WxIUwHwNkFPPE+PZxJfFLYY
        kIFWZ1Der12RrVeRJZAudey7Beqd1IJLcoqfgagVPGqAEvxs07ZGCwByk16OnDFX
        /mA6/N4NVjzztJFBx9mYSngxmfyVeTDqjonlWPbeHhTa9BeUzmHB0zgUtBCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668817184; x=1668820784; bh=prtbcy8N/1rKugKj2vTvtItnBTqI
        tgZYEcm/uusO8QU=; b=Wk5fp6KInm9ucluIm6eeyp9aCLMQEqlWNrF4/DZsbrOc
        PRpELuid6oDx+Z1+MlTQCscIsB8BUGbAN5uRcrd0d/1joQT0geLVMWZ/fL17YeBy
        ptcGTs6mNNF7eHd9LzoizcUWuVgzC4DOfllWXgtHh4DOjFXSkUYHqDoa0qkmHMkD
        da5IhobLDn0oayISGJ5L+6nio2RPTPb16r2KWP50xuEl+sZjQhPP//dDneJn1QzJ
        Dcf1cUNWM9uowvTkAY6rEl93WSpRvyuyy4Vg239DUKN4YfI2AK6morCmXpz9YF8G
        iodE569rxAZrskQphFM1YXjuIiw8EvM3xG0lRCF03A==
X-ME-Sender: <xms:HyF4Y3r5Y5ueWr5k6gd-126sItUzGYGdGznXCjLQJMzTufhIycR-_g>
    <xme:HyF4YxrxIgzOyvxnmgOjlXQ0mTvWNKclJRZHuEpNjnGMpup-7TXtUrRz8w0JOlNnS
    uWvjDtYmY3JizKAGus>
X-ME-Received: <xmr:HyF4Y0Nc1lZ77I1plmkuPpdQrHgdP0NQmKYtZhW_4eMxFKx3hlxMLVlnvvOLwbDi4n54d3s_ks8-TT0nJD1r8oPtZGVL7QdTUORTAOzwJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedugddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesthdtre
    dttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgv
    rhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhedthf
    etvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:HyF4Y67m0Px2i9eoDvke-3Ees1fCdxIK4RG6I-2yIqttjdVo2ARwxw>
    <xmx:HyF4Y25Q3hzptPlFu1ZtZEE9EPqsxRu_RYtiJTWhBjm7soDCMHEyTg>
    <xmx:HyF4YyivORHi4NnmxARnC9vM5gipZs6chOyDyeEUjm_OewWYS8Us5A>
    <xmx:ICF4YzuxCrNOb9BNIEYnFX4vSOdQhALZ4zWpdU3VJtUPgWRf8WgwwYeboNA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 19:19:43 -0500 (EST)
References: <20221024190603.3987969-1-shr@devkernel.io>
 <20221024190603.3987969-8-shr@devkernel.io>
 <20221116132916.564a26142c1f15c8553edb9f@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 07/14] mm: add bdi_set_max_bytes() function.
Date:   Fri, 18 Nov 2022 16:16:27 -0800
In-reply-to: <20221116132916.564a26142c1f15c8553edb9f@linux-foundation.org>
Message-ID: <qvqwfsef94o1.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 24 Oct 2022 12:05:56 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> This introduces the bdi_set_max_bytes() function. The max_bytes function
>> does not store the max_bytes value. Instead it converts the max_bytes
>> value into the corresponding ratio value.
>>
>> ...
>>
>> --- a/include/linux/backing-dev.h
>> +++ b/include/linux/backing-dev.h
>> @@ -108,6 +108,7 @@ static inline unsigned long wb_stat_error(void)
>>  unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);
>>  int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ratio);
>>  int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>> +int bdi_set_max_bytes(struct backing_dev_info *bdi, unsigned long long max_bytes);
>>  int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int strict_limit);
>>
>>  /*
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index 8b8936603783..21d7c1880ea8 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -13,6 +13,7 @@
>>   */
>>
>>  #include <linux/kernel.h>
>> +#include <linux/math64.h>
>>  #include <linux/export.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/fs.h>
>> @@ -650,6 +651,28 @@ void wb_domain_exit(struct wb_domain *dom)
>>   */
>>  static unsigned int bdi_min_ratio;
>>
>> +static int bdi_check_pages_limit(unsigned long pages)
>> +{
>> +	unsigned long max_dirty_pages = global_dirtyable_memory();
>> +
>> +	if (pages > max_dirty_pages / 2)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>
> Some code comments are needed here.  Explain what it does and why it
> does it.  The "/ 2" seems utterly arbitray - explain why this value was
> chosen?  Why is it better than "/ 3"?
>
>

I changed the check to
   (pages > max_dirty_pages)

>
>> +static unsigned long bdi_ratio_from_pages(unsigned long pages)
>> +{
>> +	unsigned long background_thresh;
>> +	unsigned long dirty_thresh;
>> +	unsigned long ratio;
>> +
>> +	global_dirty_limits(&background_thresh, &dirty_thresh);
>> +	ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
>
> `unsigned long' is 32-bit on 32-bit machines, which makes this code a
> bit odd.  Should everything here be u64?

The function global_dirty_limits() uses unsigned long pointers for its
arguments. unsigned long looks like a better fit. Any thoughts?

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D03C48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 06:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C2D613CC
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 06:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhFXGxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 02:53:11 -0400
Received: from mail.synology.com ([211.23.38.101]:38814 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231132AbhFXGxK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 02:53:10 -0400
Subject: Re: [PATCH v3] block: fix trace completion for chained bio
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1624517448; bh=S9PH3gMYVY8Uk41vBYmoqe9s+YbYcC3OEOnxZ09adSk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V2DuV9LO1rjX81uFaJ16urzZgfeoMD+BXuyqrtX/vm9hl5BUKCQxBnZmFmxek23tU
         QIqtGHW8vL7x9AV8cqBdUeqhCybjE6a9aFVJN43v6E1lP1dHacUHvaJ1HWsjI+cJY+
         h86ZflLo1JPFt5M7lpvoULjKWhjx7wRSV9x8nWhM=
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, neilb@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, s3t@synology.com,
        bingjingc@synology.com, cccheng@synology.com,
        Wade Liang <wadel@synology.com>
References: <20210616030810.4901-1-edwardh@synology.com>
 <YMmDxl9abff+wulm@infradead.org>
From:   Edward Hsieh <edwardh@synology.com>
Message-ID: <1204c32a-e3b3-95dd-b2b5-b9f6eef4f022@synology.com>
Date:   Thu, 24 Jun 2021 14:50:30 +0800
MIME-Version: 1.0
In-Reply-To: <YMmDxl9abff+wulm@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/16/2021 12:53 PM, Christoph Hellwig wrote:
> On Wed, Jun 16, 2021 at 11:08:10AM +0800, edwardh wrote:
>> @@ -1400,18 +1404,13 @@ void bio_endio(struct bio *bio)
>>   	if (bio->bi_end_io == bio_chain_endio) {
>>   		bio = __bio_chain_endio(bio);
>>   		goto again;
>> +	} else {
>> +		blk_throtl_bio_endio(bio);
>> +		/* release cgroup info */
>> +		bio_uninit(bio);
>> +		if (bio->bi_end_io)
>> +			bio->bi_end_io(bio);
> 
> No need for an else after a goto.
> 

We are suggested by Neil Brown in the last version that from the
comment, the bio_chain_endio handling is used *only* to avoid
deep recursion so it should be at the end of the function.
Therefore, the position of blk_throtl_bio_endio() and bio_uninit()
are a bit odd.

We believe that blk_throtl_bio_endio() and bio_uninit() is in
the correct position now. And adding an else closure is our
attempt to make it more clear.

If it's not necessary then V2 patch should work to fix the
missing completion traces. Should we resend PATCH V2?

Thank you,
Edward

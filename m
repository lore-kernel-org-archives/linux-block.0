Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741D5CA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 20:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472A020869
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 20:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OxlihDAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfKDUN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:13:57 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41800 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKDUN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 15:13:57 -0500
Received: by mail-il1-f195.google.com with SMTP id z10so16030386ilo.8
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 12:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lw+R+0ZkkC3ubW2Y8pybIZLDkTWWeoge8SEC3g7u1no=;
        b=OxlihDAkh9adkEARDQ34BCoCP05PvvRYCrvgUKtCgaBudPJ1zJQjpqz7qvWlsVYD48
         +Zc3boDwf8WmuuWRUhxsQoYiyFJlDAzDXF7uwZCzpnTmsJtkf1ab62c9IwnLHV/pXL/P
         6avSL3zFVR44EVfCKsfhaURYDwJ9LmAcQKd2KMveChKsxb4aHx5E4X/p+5C7gK/j++lO
         LvIIA7GkNey/fdgR0q+7mvkdUeCYoMk9TvMj9RSchwChhFkHeqQa6B2JEdrJ4XUMlKc2
         xe4Oq4tPjzXqY885xBCam9p9UAPbNryCBTseYhnWIJDMRntn7tapQL75lGq7IzFUjmXf
         032w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lw+R+0ZkkC3ubW2Y8pybIZLDkTWWeoge8SEC3g7u1no=;
        b=ScheuHS7BbUfk3u9TO4VhBcHPaUW3kaaEVZY1pmbgdYW1SgSpAKV6QKpZ6Vu4o6cNN
         /J009VlMdwcna8Jcn846NKBeF0nnlQN8iZIIVdcnHq3XbgWyhrnP4aaOGOoLWOkw+q36
         Bq4nkZGPvN1hE8OjVcNfpVf1dtINA49AsgGyoJ4Y7y9xQptIWK0utAiJKWb/4rl+6dLa
         yO82lNYgOwiYK0JIou5r0mBmLyb5RPq9kjLk6mHJ994nAk2t4RjhPT+oCJg7L2ggnZFs
         iW+SD89j7f0RPBvpsFiyruNXAScjzv1wbnWE6ZGNIRtAkLqrYUB/P5k/Jk9iq9VzwBrV
         oUzw==
X-Gm-Message-State: APjAAAW0JKQUDiwyyMar/+xZfoNwqgTpyv/LKMT00bjQtB6urPuoME6g
        utSSNXZMM/TiY9BIS7BYT6vOI05qaxK1uQ==
X-Google-Smtp-Source: APXvYqzp9VvSqt1cfxwsi4rgscemiULAV0CV+AnJGQ9cW8AkvTf4HefvoJ3Fkanp4BIzq04SZSFnDQ==
X-Received: by 2002:a92:4555:: with SMTP id s82mr31419163ila.228.1572898436208;
        Mon, 04 Nov 2019 12:13:56 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j68sm383114ilf.10.2019.11.04.12.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 12:13:55 -0800 (PST)
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20191104180543.23123-1-hch@lst.de>
 <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
Date:   Mon, 4 Nov 2019 13:13:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 12:30 PM, Keith Busch wrote:
> On Mon, Nov 04, 2019 at 10:05:43AM -0800, Christoph Hellwig wrote:
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 48e6725b32ee..06eb38357b41 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -293,7 +293,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>>   void __blk_queue_split(struct request_queue *q, struct bio **bio,
>>   		unsigned int *nr_segs)
>>   {
>> -	struct bio *split;
>> +	struct bio *split = NULL;
>>   
>>   	switch (bio_op(*bio)) {
>>   	case REQ_OP_DISCARD:
>> @@ -309,6 +309,19 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>>   				nr_segs);
>>   		break;
>>   	default:
>> +		/*
>> +		 * All drivers must accept single-segments bios that are <=
>> +		 * PAGE_SIZE.  This is a quick and dirty check that relies on
>> +		 * the fact that bi_io_vec[0] is always valid if a bio has data.
>> +		 * The check might lead to occasional false negatives when bios
>> +		 * are cloned, but compared to the performance impact of cloned
>> +		 * bios themselves the loop below doesn't matter anyway.
>> +		 */
>> +		if ((*bio)->bi_vcnt == 1 &&
>> +		    (*bio)->bi_io_vec[0].bv_len <= PAGE_SIZE) {
>> +			*nr_segs = 1;
>> +			break;
>> +		}
>>   		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
>>   		break;
>>   	}
> 
> If the device advertises a chunk boundary and this small IO happens to
> cross it, skipping the split is going to harm performance.

Does anyone do that, that isn't the first gen intel weirdness? Honest question,
but always seemed to me that this spec addition was driven entirely by that
one device.

And if they do, do they align on non-4k?

-- 
Jens Axboe


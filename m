Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94FFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DD760EDF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhJYLOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhJYLOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 07:14:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF1C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 04:11:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y22-20020a1c7d16000000b003231ea3d705so12677374wmc.4
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cep0oUZuEKxpQmkHA5E8nLfCNHI1LiTiOo2Ma1D4ZsU=;
        b=lnExz9SbdXXnGsBuSsBp5psdJURvEurNW4wjegm5pMn6D5ACNj8OatX4VS24vTaLzP
         jZ94popDin2puJB72i6SAVs2m8kpTXrtfskiQyVOJQA/06+0HBmVngBgQf5MlqtcBmsZ
         yZSWhPPIfGqk4jlDG6+gyvsOI5FagLuaUKTPo9QD3B4urZyykIUSsMNxvj9Sm9HoZuof
         lqhNHMMwcOwuy9Zg+iMYALBW2RG0Bn27HIx4FK6RsAciBHQRoM9HwYDNrdhc0U4sADre
         SK5nd9DQSp+/BipRjhAkManRZ2zsgYo323R5oRbCE0FFLqBUFFwxnOJ51FqmodyXtJ8Q
         TF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cep0oUZuEKxpQmkHA5E8nLfCNHI1LiTiOo2Ma1D4ZsU=;
        b=g1BlJx2nGKIz1vQ9S8apWAkEbh3u4vuk9MSNyTsWS5Y/dv4xqhebp1D3r7iBruYXg9
         LVw0bEMPi62MkzrDodeewQqv5kN4H7zHcU7NgAG0vemp9a3Xi5UO2ScB2zOdLOR72O09
         LL9RcA4lbQQDybu/FQ0NlK35xwKY4WSr0F05uX0pDXrYjJAA8/h9C4Yr1SQaLGYljr3X
         Cup24w1fh54FvJoZaAUDkL7YehWZsJnpF0X98DfoaIO9mjkFyiPmgloNemT6iH5I5YpW
         +el1Ru/n3QTqukx+/lI8K+Vekq4qtiFhz9WhaZAriu9NiVcppxJXT+33GnwQBHDbTKw4
         0nvA==
X-Gm-Message-State: AOAM530fuNwlfRpLSG9RPoTTYpgmUKms0DLxXAYAiNm0yvFtuIKoWRmz
        smdCgpWwPJArzDuyaIWQRDI=
X-Google-Smtp-Source: ABdhPJyYaiwNHCFAUD3sCxCKBaSONq19k1pf8M41PKVn/2+P7hiYaHSpSVOanmadebTZlHlvyJyEpQ==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr15833055wmh.38.1635160315674;
        Mon, 25 Oct 2021 04:11:55 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.144.165])
        by smtp.gmail.com with ESMTPSA id w7sm9892023wrm.64.2021.10.25.04.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 04:11:55 -0700 (PDT)
Message-ID: <87d9f109-c00e-7e79-36c3-61f153db3561@gmail.com>
Date:   Mon, 25 Oct 2021 12:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/5] block: avoid extra iter advance with async iocb
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <aee615ac9cd6804c10c14938d011e0913f751960.1635006010.git.asml.silence@gmail.com>
 <YXZd3ETk4P+OBWXD@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YXZd3ETk4P+OBWXD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/21 08:33, Christoph Hellwig wrote:
> On Sat, Oct 23, 2021 at 05:21:34PM +0100, Pavel Begunkov wrote:
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -352,11 +352,21 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>>   	bio->bi_end_io = blkdev_bio_end_io_async;
>>   	bio->bi_ioprio = iocb->ki_ioprio;
>>   
>> -	ret = bio_iov_iter_get_pages(bio, iter);
>> -	if (unlikely(ret)) {
>> -		bio->bi_status = BLK_STS_IOERR;
>> -		bio_endio(bio);
>> -		return ret;
>> +	if (!iov_iter_is_bvec(iter)) {
>> +		ret = bio_iov_iter_get_pages(bio, iter);
>> +		if (unlikely(ret)) {
>> +			bio->bi_status = BLK_STS_IOERR;
>> +			bio_endio(bio);
>> +			return ret;
>> +		}
> 
> Nit: I generally find it much nicer to read if simple if statements
> don't use pointless negations.
> 
>> +	} else {
>> +		/*
>> +		 * Users don't rely on the iterator being in any particular
>> +		 * state for async I/O returning -EIOCBQUEUED, hence we can
>> +		 * avoid expensive iov_iter_advance(). Bypass
>> +		 * bio_iov_iter_get_pages() and set the bvec directly.
>> +		 */
>> +		bio_iov_bvec_set(bio, iter);
> 
> So if this optimization is so useful, please also do it for
> non-bvec iov_iters, which is what 99% of the applications actually
> use.

It's an async path, so mainly io_uring or aio, I don't think there
is much profit in doing that for iov, especially behind iov -> bvec
translation with page referencing.

Could've been done nonetheless, but what I think about looks too
ugly because of the loop inside of bio_iov_iter_get_pages(). Don't
think the sketch below is viable, any better ideas?


ssize_t __bio_iov_iter_get_pages() {
	...
	/* not advancing */
	return size;
}

do {
	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
		ret = __bio_iov_append_get_pages(bio, iter);
	else
		ret = __bio_iov_iter_get_pages(bio, iter);
	if (ret < 0)
		break;
	iov_iter_advance(ret);
} while (iov_iter_count(iter) && !bio_full(bio, 0));

and copy paste into fops.c

do {
	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
		ret = __bio_iov_append_get_pages(bio, iter);
	else
		ret = __bio_iov_iter_get_pages(bio, iter);

	if (ret < 0 || iov_iter_count(iter) == ret || bio_full(bio, 0))
		break;
	iov_iter_advance(ret);
} while (1);



-- 
Pavel Begunkov

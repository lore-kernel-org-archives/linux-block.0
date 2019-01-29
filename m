Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D524C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C99214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FchD8yEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfA2BUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:20:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37391 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfA2BUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 20:20:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so8573802plr.4
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 17:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U5Plj+bsMHwWNSfjhoJKpuSWkRPDj7Dv8RAwNakUeBA=;
        b=FchD8yEmv2yu1poCyAB7Otuxq7WKmvd+hPjy2HLUPXJY4MuxK0e8lmQ9iS1NGiF2TZ
         iMuaLZHJQFZQXttPO8u67lU19gcOPAIbdhl/bhppKo7RNUVwaWkBvIzJwN7yyzubII6d
         L5lBLYvyHzlaRI7DtaTMb+0ufTFNw8AdSYGiVj011oSnyhfZuuPRuBh0bx+dwPDl8OyU
         k/XfuzwfEIlBosjmy1srNleJZ8WTnyzTcNTt2ENM4B1y22FbUfVVu4kmiFLPQfZKVSW2
         phfZCyUGjHz+69JL3EFEg9emCUDf3RN286nCtA3bjEVwB9PzQUlL0CODqmG90rX0GDHe
         lJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U5Plj+bsMHwWNSfjhoJKpuSWkRPDj7Dv8RAwNakUeBA=;
        b=ugzkgrP/NAegWTzaxv3Ys149bo/iMr14J9wSIVGkPNE8nznoWkeImpfUYVIB776IYr
         XZZ+8EN7eOuXwJuz8Mwb+4AceXVN5b0/UOqYo1TxcCEzZTLQQsnnz2Thwz72rcBckZKG
         UC9VeyoOP6kXoXsr6t1nYjVXt5ZZ3AVqp+OvHGcZC5m9pHKn3/kBKymcZcvupLlHjIwm
         IFFeI6OuL5M14WBfqbkCFjYyLgkFlNcIJ2o1QL9JX4xGOGNhFZXezGfva/9hreFgB+cR
         LZSM0tkbrInJULftlOJPkoWH1ds5Z4DMqU7nEXn5tRi9T1goWYsrxZK2ZE56xa5vBp37
         tVlA==
X-Gm-Message-State: AJcUukdFmqbc2KQ69F906Zb22xqsrbKGJtanJDxBUu3I48ctVEAJ5mpV
        c+Ur8frt+o50bC4r4TPzIDBNzg==
X-Google-Smtp-Source: ALg8bN4pBZzslZHOgVWT8fgCiw80+2dRC8iBuIRciP9v4VBCHdP0GmPYPeB5o/kss6MRPmyHtQeCqw==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr24059375plb.150.1548724811515;
        Mon, 28 Jan 2019 17:20:11 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u69sm68506534pfj.116.2019.01.28.17.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:20:10 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de>
 <CALCETrV30uN2qOUEf+kNGWdphBtps7K3rEk8_8+VAwdtPomRkQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dab3fa32-3887-3264-9fe1-bc3b7abc58b3@kernel.dk>
Date:   Mon, 28 Jan 2019 18:20:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALCETrV30uN2qOUEf+kNGWdphBtps7K3rEk8_8+VAwdtPomRkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 5:47 PM, Andy Lutomirski wrote:
> On Mon, Jan 28, 2019 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> [please make sure linux-api and linux-man are CCed on new syscalls
>> so that we get API experts to review them]
> 
>>> +static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>>> +                        const struct io_uring_sqe *sqe,
>>> +                        struct iovec **iovec, struct iov_iter *iter)
>>> +{
>>> +     void __user *buf = u64_to_user_ptr(sqe->addr);
>>> +
>>> +#ifdef CONFIG_COMPAT
>>> +     if (ctx->compat)
>>> +             return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
>>> +                                             iovec, iter);
>>> +#endif
>>
>> I think we can just check in_compat_syscall() here, which means we
>> can kill the ->compat member, and the separate compat version of the
>> setup syscall.
>>
> 
> Since this whole API is new, I don't suppose you could introduce a
> struct iovec64 or similar and just make the ABI be identical for
> 64-bit and 32-bit code?

Sure, that would be straight forward. Is there a strong reason to do
so outside of "that would be nice"? It's not like it's a huge amount
of code.

-- 
Jens Axboe


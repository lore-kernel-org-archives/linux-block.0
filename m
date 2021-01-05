Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC7CC433E0
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 20:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E516822D6E
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 20:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbhAEUkq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 15:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbhAEUkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 15:40:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9018DC061574
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 12:40:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i9so481284wrc.4
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 12:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NrdtUVCWdPer7at9+mmYXBnne6UVIhO9QSGP/oycW2E=;
        b=s645+hyVgcGDzTY1Pe/dK5aZpf2bgiRxaV9LfRZexf9mRfEi9SZrDE1xh4Kou11tUt
         xz883SUQwuG44u+vUssLVkZDkcqKmo1pDgIlW8vpDCiUaZp1aTLdGHbWAo4bFPoZk/WB
         uLZCDn6wbYsUhqppIwyQ61IzAwgGeOuV6kz/A9c1HZU4FoLdv2MM8HscK3052jyg+zXj
         SIRsQI/1iaPJrclDqIAMNC0g9YWmvvG7Knd4gnohg2a0d+6h6sfPK5080E3C4YsKcZwK
         mkbHkvTSiJIkCl8TS5Mdq9zl6xNgXuoTDbar0Xoz1FE41YnsfMndN73LZzR2khkBVh/7
         ABDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NrdtUVCWdPer7at9+mmYXBnne6UVIhO9QSGP/oycW2E=;
        b=CFC/M5kgRJ65pCCSH+M1KzlZ9cyXP2yyx2Qom1Rj2nvwAKq/6bJAhA1aOC1N/TjWJW
         tvATdERsJn4ZzlS0r53OodkBtgga2/MFlyho8R/s749RJgu0dE4L69iylDsIwrAcWurV
         23RbqtVP+4owYPveYmjByD7hK/TJAarwlDONWpmu72nv3TDucri1sAiINDwsn7GD3Yt1
         U83JOFM9xZn5XI34F4CNU3u8VmSCZaboVyCfrlfugb+BpJ9U3re7wNLQ0SadVqjwMs2K
         LVP9SGBITWfvmosmaeKP/UyaxTzPd93BBPe2DUlnb9pTA+I77IohD90EsenxL7mV/ahk
         LJiA==
X-Gm-Message-State: AOAM532iC9e1h/IfXrHLwb3/YmpP97l7GQck/lJ2kLeCI3ALnY5mgLqB
        JOnb7K+3FPz6whIwwbguZ60=
X-Google-Smtp-Source: ABdhPJxJohUXxViYQZOJrYhIRRSwaXzxsB7hyel5E8v11UuGvSyFW5ky7Wwfmw0NlfMB7yh/qbXS1g==
X-Received: by 2002:a5d:508f:: with SMTP id a15mr1287258wrt.2.1609879204399;
        Tue, 05 Jan 2021 12:40:04 -0800 (PST)
Received: from [192.168.8.198] ([185.69.144.125])
        by smtp.gmail.com with ESMTPSA id h184sm400216wmh.23.2021.01.05.12.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 12:40:03 -0800 (PST)
Subject: Re: [RFC 2/2] block: add a fast path for seg split of large bio
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <cover.1609875589.git.asml.silence@gmail.com>
 <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <32e083c2-2bd8-aafd-c5ed-5b41fd59eaca@gmail.com>
Date:   Tue, 5 Jan 2021 20:36:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/01/2021 19:43, Pavel Begunkov wrote:
> blk_bio_segment_split() is very heavy, but the current fast path covers
> only one-segment under PAGE_SIZE bios. Add another one by estimating an
> upper bound of sectors a bio can contain.
> 
> One restricting factor here is queue_max_segment_size(), which it
> compare against full iter size to not dig into bvecs. By default it's
> 64KB, and so for requests under 64KB, but for those falling under the
> conditions it's much faster.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk-merge.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
[...]
>  
> -	return __blk_bio_segment_split(q, bio, bs, nr_segs);
> +	q_max_sectors = get_max_io_size(q, bio);
> +	if (!queue_virt_boundary(q) && bio_segs < queue_max_segments(q) &&
> +	    bio->bi_iter.bi_size <= queue_max_segment_size(q)) {

I think I miss a seg_boundary_mask check here. Any insights how to skip it?
Or why it's 2^31-1 by default, but not say ((unsigned long)-1)?


-- 
Pavel Begunkov

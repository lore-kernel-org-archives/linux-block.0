Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DB0C64E7B
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 13:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D672B21D7A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 13:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgLBNyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgLBNyP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 08:54:15 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08197C0613D4
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 05:53:35 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so8187726wmb.5
        for <linux-block@vger.kernel.org>; Wed, 02 Dec 2020 05:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8amRbSLEK07eBFPJ+bfAAHYTpk08fkuCAFnTAgu16AM=;
        b=nFf5H4h161DrciTk+m1NAcbgLpZGmMEF0K1MwG4vHnguFj7l6ly6gRkj05MqrZIw8Q
         u2QwRKxVjTIsvJtuFpNPEx0nv0Z5nVzfU06Lv0Gg3+YBLqvNdJuN7o0fv4iUWigyTq8c
         ivmpWSfekKghqVC09FoDaXb9CnOy+LpYpdnYyVUgaXHmHdwU1jqXeONR16KMiXJTvtnk
         mYLO2v7TXVTu/VRR8VBx34Og5xSfUFi60/kLrDz5T7T+ediX2ugwm38tF1vCXmYpNk0P
         nFtQKURNT4aUo94eW4lLln0R6yT1XE0X/HJzvZJ2inVMkA3tRypKo4josa97wIsOwIL9
         7C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8amRbSLEK07eBFPJ+bfAAHYTpk08fkuCAFnTAgu16AM=;
        b=SHbSKY+qBZn/ctuMISXMEMMH1f5uHRfhREKgPiD2FNG0tthHhQQZjJWG00v8TKgC1Q
         ykpMlT29xWHVSvnPERgC938llkIGS0jH7P5dNKmiXaPYBxXRUTa0K/GFNbEtWfduFHQu
         o5Pv0iVuKgl8o/889dT0qJRLYYLE8TAqzBu84XuJruh3AvLZOedmaZ+wD5nKWSpiMmpD
         yoA7wQd6YI9z9A6zpjUJpqOl/JrdgFZxUMVr5b/iB6pw95Un0+an1+OZ/WVBusGnh5fq
         oayweNXz1iBMGuLH9beWptxIGhK+nCRYH4TvbjVGpKpU0xKyTIsgdljNtjdtwk/SlFGZ
         g0/w==
X-Gm-Message-State: AOAM530n/eXGjsamcTRFxL3105cu4wIMgKQi5ef8uLV5mhlSW8yizSse
        9uKhuKKR1Zvs6qRMbXGiCM0=
X-Google-Smtp-Source: ABdhPJwj6zhHQcwT7yZEPmJXqSDIK7RmpT0sl4uq/D1+w7nqEYH6cTxBNR/rx1ltkAZOPmTLqf9D8A==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr3311448wml.64.1606917213795;
        Wed, 02 Dec 2020 05:53:33 -0800 (PST)
Received: from [192.168.1.144] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id 90sm2342513wrl.60.2020.12.02.05.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 05:53:33 -0800 (PST)
Subject: Re: [PATCH 2/2] bio: optimise bvec iteration
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <cover.1606240077.git.asml.silence@gmail.com>
 <e1acd31d91a1e9501a5420d6ac1488a4412a0353.1606240077.git.asml.silence@gmail.com>
 <20201126100227.GB949@infradead.org>
 <fac832fe-45a2-5630-55a2-3684e434f998@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <521781a4-fb18-e9bd-76ae-8cd3a46680ec@gmail.com>
Date:   Wed, 2 Dec 2020 13:50:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fac832fe-45a2-5630-55a2-3684e434f998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/11/2020 12:32, Pavel Begunkov wrote:
> On 26/11/2020 10:02, Christoph Hellwig wrote:
>> On Tue, Nov 24, 2020 at 05:58:13PM +0000, Pavel Begunkov wrote:
>>> __bio_for_each_bvec(), __bio_for_each_segment() and bio_copy_data_iter()
>>> fall under conditions of bvec_iter_advance_single(), which is a faster
>>> and slimmer version of bvec_iter_advance(). Add
>>> bio_advance_iter_single() and convert them.
>>
>> Are you sure about bio_advance_iter()?  That API looks like it might
> 
> Both those listed bio_for_each*() pass bvl.bv_len, which is truncated to
> current segment by bio_iter_iovec() (i.e. bvec_iter_bvec) or
> mp_bvec_iter_bvec().
> 
> And just to note that I didn't change bio_advance_iter() but added a
> new function.

> There is always space for stupid mistakes, but I'm sure. What makes you
> to think opposite? I may have missed it.

Christoph, any doubts left?

>> not always be limited to a single segment, and might at least need a
>> WARN_ON_ONCE to make sure it is not abused.
> 
> I thought twice about converting other places as you commented before,
> and it looks saner to not do that exactly for that reason. I prefer
> to leave *_single() versions for rare but high impact cases like
> for_each()s.
> And as it's contained I decided to not add overhead on WARN_ONCE(),
> e.g. with inlining and w/o string dedup it grows .data section much.
> 

-- 
Pavel Begunkov

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F61C2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 13:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEE72076E
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 13:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9VLdJ2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbgKXNDO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387826AbgKXNDO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 08:03:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FABC0613D6;
        Tue, 24 Nov 2020 05:03:14 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so22304918wrt.0;
        Tue, 24 Nov 2020 05:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zdz5fBa4T11k+5bH3jFX0pTSXtn07jqB+Bz4r2/EDsM=;
        b=F9VLdJ2wPN4CiqPCtxPPpl2heewrzVMYOxZey7FLAFIBchB174YjrVhg+4d+0n5Dl5
         l/YjNZZ1cr2Wd/rddAPYAioPog4s22e8TLKWrmVa3XnpPAE/ici7EoCrJagnSs0dvvme
         ydeYyKHORzbz3j3uOuf60hJVcCn8V+fWd+y84naTp06RCdWTM5KQM8IOJ6YE//xsdnev
         g0fY49z/x6HxEhoMQ3Ac/dTUAegCWBFcn9skkMN81BuhJydh4y/gyJIVUX+ofnI6/35+
         1McKAmS2hI9xoGjUw9oio1L/We3+b+ip49LB7XT/VpLOXO58SaDDDn6386459t6DLF8r
         f3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Zdz5fBa4T11k+5bH3jFX0pTSXtn07jqB+Bz4r2/EDsM=;
        b=GXsp6prt0ZxXdEkvL01bQUCeBZs3RawqUdxHQJIYeqhHyh2/nlvPyWFl7PKVd93S/K
         FQpeaVkCTghXsgUjBI7TerHFfEhzp5Qn1+tl8aNlduz/1udwnYnXnGvmuK1xgK0t8qVV
         Nl6rmsAdJpvU4iuZ+m4jzM9XUTme1Ihl0SYurye+5UWzm3TDr6XysKcT91xu/wcEr3WE
         fmD5dFY72CVS/hPyBoDEMq3ExKd8cEuj21d1pJ9oSNxdpUrDdLYM0vcJb6S7Kjk/+v30
         81rybE1qIWK6aTfwktrkRnpzcjn39BKS6Ms+Flz0PmKLC57TytYK8F+ZwKjkxRE584ss
         EPPA==
X-Gm-Message-State: AOAM531DeAPyn06fcrHn0IprkI4tNS/RAIxTYUFS6aJoW0kvO+1udrhT
        jqmDO8AKK6GMHn7lyFqU7B6Oam1ZEzoJiRgW
X-Google-Smtp-Source: ABdhPJymsY0sUUEYIPQx0qgzKoQg/iI3TLy3ZkYEivMpquP3qTetLSrpNHh5gfyso/eOrxV6cstSvw==
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr5391087wrn.392.1606222992046;
        Tue, 24 Nov 2020 05:03:12 -0800 (PST)
Received: from [192.168.1.216] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id f4sm5115072wmb.47.2020.11.24.05.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 05:03:11 -0800 (PST)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com, linux-kernel@vger.kernel.org
References: <60aaa6caab3d061cf7194716c27a10920b5bd7ad.1606212786.git.asml.silence@gmail.com>
 <20201124112249.GB25573@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 5.11] block: optimise for_each_bvec() advance
Message-ID: <0b40b474-1aaa-cdaf-567d-572bcb285aa7@gmail.com>
Date:   Tue, 24 Nov 2020 13:00:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201124112249.GB25573@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/11/2020 11:22, Christoph Hellwig wrote:
> On Tue, Nov 24, 2020 at 10:21:23AM +0000, Pavel Begunkov wrote:
>> Because of how for_each_bvec() works it never advances across multiple
>> entries at a time, so bvec_iter_advance() is an overkill. Add
>> specialised bvec_iter_advance_single() that is faster. It also handles
>> zero-len bvecs, so can kill bvec_iter_skip_zero_bvec().
> 
> bvec_iter_advance_single needs a comment describing how it can be

agree

> used.  Also can you take a look at the other callers and see who
> can be switched over?  If you are not sure ask the relevant maintainers. 

There are bio_advanced*(), that are used all across block layer.
Considering that all that is inlined it's going to be a good win.

I'll resend it as a part of a series converting some users.
For others like net, I'd rather wait until it lands.

-- 
Pavel Begunkov

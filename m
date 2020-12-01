Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6046C64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C7820639
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2FCgp9FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbgLARyH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 12:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLARyH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 12:54:07 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B22C0613CF
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 09:53:26 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e23so1599934pgk.12
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GGvr/361QsS/rtGakPueyLl+Ud9hPyc2KZoLpr4f4aA=;
        b=2FCgp9FKOvoOah2d5uYQS0TGzgv6Tc5W8ysrE/d0W8GtZ3vAUrVN1BJXn5lt/ssMFX
         YMcEnyOVuR832vYdKFy52tm68DzJGAcKLnbxhvZzek0aFh6HZZ9PlDXzaTTG3bwCi8up
         SvZuXt6MsIeqkqZTd4+gO/Cptb1Q6mOgl0Ml16Y9H/7JbjVMVHwNLXZRwZIgf+pndKRz
         1D+dHbjGKyi5w25I4nY7vBcO5fGs1LTxE6g1DunQ11cCsm+t6NDtMEF7Eu0csiFHjDqq
         p46sE96JMk0KrBsIXAlAy69IqPBWI2rKWUVreM5/niftiaYhzxympHfo/7nE0X5NrNP4
         Z1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GGvr/361QsS/rtGakPueyLl+Ud9hPyc2KZoLpr4f4aA=;
        b=mGR/46S4NK1fuZO/dDjgReh36AIEUOjXuKFx/uEPFdRnnPom3YwwFtZN6uz71lNmSR
         j+Nwq6GBD7CMXeXpL91MchrBNw57pcBU2+eAt4fKF1CCpjFlrP4YC6S4tNxMbZUMhbyQ
         n3GCk3kGGwW6GTFWdT2AAUn+sB6KlAXAdLmszcSu/G5wQM9IZtzWQhiQOI7kgiyXN1tW
         gZt2lJcVrd7vA2ni9XJ6RPzFQ0RQNuaU8bXNW+PiP0Nm62t/1fY+3yq+m9aZJfVtUPR7
         bmpR7lOJlHvulMiqGEaaY3gstmLp7E/95SsGrypbxYq5UkAPOfGzsyWSpU5bEI4xT+Kn
         T0cQ==
X-Gm-Message-State: AOAM533bNHNI5p9q6ILhJ1JpG3erP9Qp9kFlUxMLqElnConLHJmp9DA/
        Pr4joSHLgOJICrHHOUO/egYpDw==
X-Google-Smtp-Source: ABdhPJxh5z2v04fO7TlUW/jBlS4B25SihFMf4nMDomCGzRTrIUqxQxpNuCmqXImwL2paKnurwV9pKQ==
X-Received: by 2002:aa7:97a2:0:b029:19a:e055:1d53 with SMTP id d2-20020aa797a20000b029019ae0551d53mr3756146pfq.12.1606845206386;
        Tue, 01 Dec 2020 09:53:26 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21d6::12f3? ([2620:10d:c090:400::5:b3dd])
        by smtp.gmail.com with ESMTPSA id v196sm431732pfc.34.2020.12.01.09.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 09:53:25 -0800 (PST)
Subject: Re: [PATCH v2] block: use gcd() to fix chunk_sectors limit stacking
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     martin.petersen@oracle.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jdorminy@redhat.com, bjohnsto@redhat.com
References: <20201130171805.77712-1-snitzer@redhat.com>
 <20201201160709.31748-1-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c878c13-2112-32cd-6ff0-bb54fd6b8382@kernel.dk>
Date:   Tue, 1 Dec 2020 10:53:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201160709.31748-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/20 9:07 AM, Mike Snitzer wrote:
> commit 22ada802ede8 ("block: use lcm_not_zero() when stacking
> chunk_sectors") broke chunk_sectors limit stacking. chunk_sectors must
> reflect the most limited of all devices in the IO stack.
> 
> Otherwise malformed IO may result. E.g.: prior to this fix,
> ->chunk_sectors = lcm_not_zero(8, 128) would result in
> blk_max_size_offset() splitting IO at 128 sectors rather than the
> required more restrictive 8 sectors.
> 
> And since commit 07d098e6bbad ("block: allow 'chunk_sectors' to be
> non-power-of-2") care must be taken to properly stack chunk_sectors to
> be compatible with the possibility that a non-power-of-2 chunk_sectors
> may be stacked. This is why gcd() is used instead of reverting back
> to using min_not_zero().

Applied for 5.10, thanks.

-- 
Jens Axboe


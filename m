Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD4C433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbiFAGJD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbiFAGJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:09:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21A4EA28
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:09:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k16so822490wrg.7
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UfmsxzQ5cyXaYfffY/KNNowgw/oLxrr30Q8aXfBM24o=;
        b=Kmm82cyVIqmw6LFpKjDGr7ZE7/50oDGhP+Q5AtXjmSOKdBZajPho8D0Ls6DDqG13qS
         Eh0Tz07Hl1X3G8ZPELMsYBnz7VzmkgVjbxqE+UUeTBGRPmpdiz1R46ntcH8VK8/RlVC6
         4EB70CBiJrAZSsWsX20Lw+U4cqCpWAmzIj6g5xmDI5ADLUx1TdLFUXMrZHRKYo4BBuOJ
         5J1xUBmtcOvLpiIwlunHp3FaSqh0+8qyQUesbYuQBSKNjQ6Nlk6ln8vXi2fBzJea6rY3
         6NNK9l8RqmNGHDpM9XQkk309fQh+XLkga1eoD1NuNm5DeWfJve41O0PFwAPt4+SRy2Nx
         C9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UfmsxzQ5cyXaYfffY/KNNowgw/oLxrr30Q8aXfBM24o=;
        b=NzFx/ILOpRevZliFn9sDZaVTaORqi0gLfDL2jE359/H0A22WAws28uEeFU6Mbt4rBr
         fms7gwhnrvFd9OUm6GbfC7r4EnHqIcMfqPsiG9itgQGAPBrgaEi5FXHeypHXlPMzXray
         0ysSOZIkmn5wfvQ7gZ8Z4BEMQ6yGC+ZEQRUrlgJxpsVNa/F+EWjOiHnsO8gLQm+44k/O
         fDe89pgSisWwNnuUpdTfHkTAGyVwKYsftcoYiiVRwCb04tzavfbCt/rB4UI1tAALiHMi
         juO9qTHwIcMoBMPF7UvuKppFLUqfEpfYZDAo2i7znnDTzBoISrNjJyyJToZf/ezK1xNa
         AlQw==
X-Gm-Message-State: AOAM530Rg8/ixBigcoP9WzXIWYhSfPjtV5zioY1KGXJ5b2g3mpkRTqAs
        Kc7nd7RUUD6+QGqptatSx6ugFA==
X-Google-Smtp-Source: ABdhPJz8fxd4n51jtphXpda+Rpfo2uctjwLEcLzjniBxLo41YM+g4w8Q1MBi9Nt9VXMKx2hwkOekJQ==
X-Received: by 2002:a5d:6e85:0:b0:210:3ded:60ac with SMTP id k5-20020a5d6e85000000b002103ded60acmr1544487wrz.143.1654063738961;
        Tue, 31 May 2022 23:08:58 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm590754wrb.79.2022.05.31.23.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 23:08:58 -0700 (PDT)
Message-ID: <08625f5f-4781-52c5-46fc-d1250f70626c@kernel.dk>
Date:   Wed, 1 Jun 2022 00:08:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: bioset_exit poison from dm_destroy
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com> <YpcBgY9MMgumEjTL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YpcBgY9MMgumEjTL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/1/22 12:04 AM, Christoph Hellwig wrote:
> On Tue, May 31, 2022 at 02:58:00PM -0400, Mike Snitzer wrote:
>> Yes, we need the above to fix the crash.  Does it also make sense to
>> add this?
> 
> Can we just stop treating bio_sets so sloppily and make the callers
> handle their lifetime properly?  No one should have to use
> bioset_initialized (or double free bio_sets).

Yes, that was my point in the previous email - get rid of
bioset_initialized() and just fixup dm, which is the only user of it.
There really should be no need to have this kind of conditional checking
and initialization.

-- 
Jens Axboe


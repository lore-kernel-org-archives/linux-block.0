Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54472C4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F58A60F23
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhG1Bbg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 21:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhG1Bbg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 21:31:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A4C061757
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:31:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q2so707315plr.11
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHc64D7GeFGFvPKcL3/klEXdsXGAyEbOGkW4X7dqYZk=;
        b=fhSYS231qJ3sqkIYNi8KPw8MsfS0+ziEaNeUJJgkWRoGnsw+X6Zela3vLGucwxsOnQ
         T/2eQecJMaDAtj1/fJv4pRgNYPjG5MBwhmQRzKVK7XHucRr9VlsyFnemk7Az0cFRvaoj
         SXA55eSG8LWFjpI5M4/vVkrChJvWZRFUIvXxtX/YyI6Hetmvo8xUU0IsYqW0uPaYORh+
         7fbNsmk6bU1nDAoUQ8bBanH/4Fg5DnH45lOS4h8rnJCcsSof3DVR671BuFi4Ezu9qGFc
         pniezhy1QlK6TDYbbPRo+6/gzTozJcEPXqbmDtUTOLhYVoF+8NtbsE0cFeksRw7VSH/K
         7dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHc64D7GeFGFvPKcL3/klEXdsXGAyEbOGkW4X7dqYZk=;
        b=ozAUuYzwagxlcIIqeSsroB3axI/aEmIO1zRiP3X++Zp8SUXKBraiDJHtZJnqzbTf1o
         9cDTVhQOTcJS1Q384u7QrTO0g3BO9FvXhneJdE1Yr+8WC+yA6/FtMk2etcGTtaTy35hJ
         1UHyeoVfbegBWau6m8xiiiC2wVYhWspwi0QHtSBP4QLJ3QsO9AHL+U06JKZjUDKr86fS
         u2zDo+Pv4xezQ8MGRagotCvuyr9uutOJgtNBZY+p5+UoNbWoi5Kgnk1rEsCw+PNqfFna
         co0aFE9UYxuhG5fbA3JzkmJDIdiEXsePxuA1Lg5z3HP4m3ut4cTjN4Kj0iTWLAKhJBHD
         hRoQ==
X-Gm-Message-State: AOAM532exgcneEMfBb5EFGibF84RrHyOnJ6bOKFjsvo8F2NDhNQw75Lw
        aU36V0NJCKjtKoeOP/oX1YsDVw==
X-Google-Smtp-Source: ABdhPJzWMYJQkYrSLemCw68WHvxxx2yrrdVHcAiwavOx0x2TeSqkNy6ZylLwTbIdJTyjO+rAuqNUqw==
X-Received: by 2002:a62:b414:0:b029:317:52d:7fd5 with SMTP id h20-20020a62b4140000b0290317052d7fd5mr25840599pfn.30.1627435895354;
        Tue, 27 Jul 2021 18:31:35 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id a16sm5054336pfo.66.2021.07.27.18.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 18:31:34 -0700 (PDT)
Subject: Re: switch the block layer to use kmap_local_page v3
To:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20210727055646.118787-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eba0b98f-5b0e-32c4-3b09-fa1946192517@kernel.dk>
Date:   Tue, 27 Jul 2021 19:31:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727055646.118787-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/21 11:56 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series switches the core block layer code and all users of the
> existing bvec kmap helpers to use kmap_local_page.  Drivers that
> currently use open coded kmap_atomic calls will converted in a follow
> on series.
> 
> To do so a new kunmap variant is added that calls
> flush_kernel_dcache_page.  I'm not entirely sure where to call
> flush_dcache_page vs flush_kernel_dcache_page, so I've tried to follow
> the documentation here, but additional feedback would be welcome.
> 
> Note that the ps3disk has a minir conflict with the
> flush_kernel_dcache_page removal in linux-next through the -mm tree.
> I had hoped that change would go into 5.14, but it seems like it is
> being held for 5.15.

Applied for 5.15, thanks.

-- 
Jens Axboe


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B304CC6FA86
	for <linux-block@archiver.kernel.org>; Sat, 10 Sep 2022 11:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIJLcc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Sep 2022 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIJLcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Sep 2022 07:32:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71C153033
        for <linux-block@vger.kernel.org>; Sat, 10 Sep 2022 04:32:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 29so6165683edv.2
        for <linux-block@vger.kernel.org>; Sat, 10 Sep 2022 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oO2f6puxNv2WM0203jHJ9dATLxOnB/EAhNK0gKh1Fco=;
        b=ZH5YuCofNtiX91aOQ8okF8wGG31vLQnBuGTbsJIxq6skqZDH7RvK+S6Wg/jL8kGMG0
         wxALhNndMloVN1pmlZYgbSnkA4WugVPm6xPyUnDyPXtNQrabmBlb3doY3JHFHpEwdDOn
         UCMlcq27n8LGY/fiI8rrezsaIzsFdm7yeal6QiEIrx2i6u5RSvNr3NejNRbuoylCf6VT
         1NmPWSzvA4lzXHfElWpQVZrWn1GOb5l1rdycwSX1lGO4Q9iha+7RREdHfUFuABmzTqNy
         MS6wyNdM+htzk0aYqzebY8yDNHwmUT2SYl/24SW+F1b30ss1/TkgEA7qVOS7cSXPX2Wb
         gdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oO2f6puxNv2WM0203jHJ9dATLxOnB/EAhNK0gKh1Fco=;
        b=520N/dFZ+Fx0qkDpjvnSbDr1y6tB9ItB6cgrNxbgKj8Z18Zg7ZTP/wGNwwTl7PSK3v
         WH9WkkgcounXpNsU6Wp5LSd0+BtHC3/QmdcmnITprXqvKLsDLebQenL8w5Bu/u8YjJY4
         yc3XxXvK2H4fwm0bQPS2icQEwd2BhmuiMswH3TPiixh+3GIdu8mMMwfbiPq9ymGdGPZe
         tHR/iMHrmuuVsGCcfmy7rVsA+1uY9olIf3+dmfhU2MAkpkrbBMz7IMAEWxgzIjiufB/7
         ZZXdiZfXnsriAJonM76u0H6IbhCngtCBGX8jq6CxXgR6seH1qNrxtVVfzDHfIOIQ1GaQ
         sTWA==
X-Gm-Message-State: ACgBeo3awXOiJMce+H5FrymFZ01kJbvMZwsC+wKOk3Gzd5LKwF6dxDAd
        kHSMr2vPOgOsJAVs7XSky4H3qA==
X-Google-Smtp-Source: AA6agR7ABzhvw0hLX7UM5YEGmj7ooKpj1BWh9U8hMic6ls9gEZTIgOqBBSoD7neml/f66zDsZ4trLA==
X-Received: by 2002:a05:6402:280f:b0:44e:ee5c:da6b with SMTP id h15-20020a056402280f00b0044eee5cda6bmr15219418ede.256.1662809547250;
        Sat, 10 Sep 2022 04:32:27 -0700 (PDT)
Received: from [10.41.110.194] ([77.241.232.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b00731582babcasm1625186eja.71.2022.09.10.04.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 04:32:26 -0700 (PDT)
Message-ID: <c76b45ad-c4ef-5166-fec3-a05e2febcce3@kernel.dk>
Date:   Sat, 10 Sep 2022 05:32:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: improve pagecache PSI annotations
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
References: <20220910065058.3303831-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220910065058.3303831-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/10/22 12:50 AM, Christoph Hellwig wrote:
> Hi all,
> 
> currently the VM tries to abuse the block layer submission path for
> the page cache PSI annotations.  This series instead annotates the
> ->read_folio and ->readahead calls in the core VM code, and then
> only deals with the odd direct add_to_page_cache_lru calls manually.
> 
> Diffstat:
>  block/bio.c               |    8 --------
>  block/blk-core.c          |   17 -----------------
>  fs/btrfs/compression.c    |   14 ++++++++++++--
>  fs/direct-io.c            |    2 --
>  fs/erofs/zdata.c          |   13 ++++++++++++-
>  include/linux/blk_types.h |    1 -
>  include/linux/pagemap.h   |    2 ++
>  kernel/sched/psi.c        |    2 ++
>  mm/filemap.c              |    7 +++++++
>  mm/readahead.c            |   22 ++++++++++++++++++----
>  10 files changed, 53 insertions(+), 35 deletions(-)

Nice! It's always bothered me that we have this weird layering
here.

-- 
Jens Axboe



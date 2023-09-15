Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA6EED60B
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 15:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbjIOPap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 11:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjIOPao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 11:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA5E7E6A
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694791799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJpaxC+7Y+75rYPpbOd56ZO18Rl2VH2cz+UAa2NMxbE=;
        b=UWZrnLiZunK7iSpgOAz9LzJzKseGKbMPvtiBz+1V2NIOOBEksizF3O7aUr0FrTwVvCMDTq
        W8lsjoLDqTLDffHq+g7vfuH5gWdGlhC6ffopqnttdebauMuIPhF2vHxde0LEkZwsVzwgxS
        c4nC5Iew79PuzqtA1J9LHvz0VOznBWw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-6mOOLMi4P7mZpf2QZkNUzw-1; Fri, 15 Sep 2023 11:29:57 -0400
X-MC-Unique: 6mOOLMi4P7mZpf2QZkNUzw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-403ca0e2112so17901275e9.0
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 08:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791796; x=1695396596;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJpaxC+7Y+75rYPpbOd56ZO18Rl2VH2cz+UAa2NMxbE=;
        b=pVZ2Tes8anyxDHx58gm9iC7L6gErWf+VvCg+zOGgZd4YsBJHvyWOZs0+LAYuzFfqqs
         SxO4Vpo/ICaWtVKJtKi6Qw5khFJM4ViUni+Viav/DymMKrtuHtzfKU9Fg4Ib+yzZM2z5
         Zhgt4awqCdk+UsIFxNCbQI5OKPekBGPAYHd/WmOsA9dJWPJyxg0GkNQPwODwlpnw2NhE
         ziGwY9gnMBPWxjbtCN/phM0J5FIxzAHx0SLljDZV6CMTG7y2iAWQsCUSNZ2N4Mjryi6n
         ukBH755AclwS9eDnNAdOCYoFLPro+5ngaHrsTl51PMc2E9NsTzmBtzUuUDzXiuChipE3
         rimw==
X-Gm-Message-State: AOJu0YyFw1Y30IQ9q7CH+Z+ICprQgm/fkB5Cm9LPGeliYYWwyFytrzlP
        JGwfP7R5r335qoBf4DtDRVl4tP3kQsIOEjtLtMdjcKVVnbJ9N8MycrkHeVNSQepHpzf16+lYSbB
        /46X1xC3nuhioakmE1Z12FIY=
X-Received: by 2002:a05:600c:2293:b0:3fe:5501:d293 with SMTP id 19-20020a05600c229300b003fe5501d293mr1986146wmf.30.1694791796359;
        Fri, 15 Sep 2023 08:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIrjtSY3mCEdjzBASUXOKYz2giyEwV+Sal1jqwjEXeA8+EAYhUpoZN7WSinZRhK3GWPQUqaw==
X-Received: by 2002:a05:600c:2293:b0:3fe:5501:d293 with SMTP id 19-20020a05600c229300b003fe5501d293mr1986111wmf.30.1694791795956;
        Fri, 15 Sep 2023 08:29:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:e000:a4bd:1c35:a64e:5c70? (p200300cbc728e000a4bd1c35a64e5c70.dip0.t-ipconnect.de. [2003:cb:c728:e000:a4bd:1c35:a64e:5c70])
        by smtp.gmail.com with ESMTPSA id l26-20020a056000023a00b0031ff1ef7dc0sm1867385wrz.66.2023.09.15.08.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:29:55 -0700 (PDT)
Message-ID: <b8f75b8e-77f5-4aa1-ce73-6c90f7d87d43@redhat.com>
Date:   Fri, 15 Sep 2023 17:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] shmem: high order folios support in write path
Content-Language: en-US
To:     Daniel Gomez <da.gomez@samsung.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
References: <CGME20230915095123eucas1p2c23d8a8d910f5a8e9fd077dd9579ad0a@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230915095042.1320180-1-da.gomez@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.09.23 11:51, Daniel Gomez wrote:
> This series add support for high order folios in shmem write
> path.
> 
> This is a continuation of the shmem work from Luis here [1]
> following Matthew Wilcox's suggestion [2] regarding the path to take
> for the folio allocation order calculation.
> 
> [1] RFC v2 add support for blocksize > PAGE_SIZE
> https://lore.kernel.org/all/ZHBowMEDfyrAAOWH@bombadil.infradead.org/T/#md3e93ab46ce2ad9254e1eb54ffe71211988b5632
> [2] https://lore.kernel.org/all/ZHD9zmIeNXICDaRJ@casper.infradead.org/
> 
> Patches have been tested and sent from next-230911. They do apply
> cleanly to the latest next-230914.
> 
> fsx and fstests has been performed on tmpfs with noswap with the
> following results:
> - fsx: 2d test, 21,5B
> - fstests: Same result as baseline for next-230911 [3][4][5]
> 
> [3] Baseline next-230911 failures are: generic/080 generic/126
> generic/193 generic/633 generic/689
> [4] fstests logs baseline: https://gitlab.com/-/snippets/3598621
> [5] fstests logs patches: https://gitlab.com/-/snippets/3598628
> 
> There are at least 2 cases/topics to handle that I'd appreciate
> feedback.
> 1. With the new strategy, you might end up with a folio order matching
> HPAGE_PMD_ORDER. However, we won't respect the 'huge' flag anymore if
> THP is enabled.
> 2. When the above (1.) occurs, the code skips the huge path, so
> xa_find with hindex is skipped.

Similar to large anon folios (but different to large non-shmem folios in 
the pagecache), this can result in memory waste.

We discussed that topic in the last bi-weekly mm meeting, and also how 
to eventually configure that for shmem.

Refer to of a summary. [1]

[1] https://lkml.kernel.org/r/4966f496-9f71-460c-b2ab-8661384ce626@arm.com

-- 
Cheers,

David / dhildenb


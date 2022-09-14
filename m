Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01329C6FA82
	for <linux-block@archiver.kernel.org>; Wed, 14 Sep 2022 11:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiINLlq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Sep 2022 07:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiINLlp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 07:41:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC47AC05
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 04:41:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so15299379wma.2
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UQ6ki4yX5kQtVY1QftaIadGFPpTJFOi0It8Nz6sT1sA=;
        b=q/oyayVc8gtEqunNB1xJ3/FfxrAeboEzVVJSS32eCQHH7YkWiqGgc4DvqOkB0BmKB4
         EGBb59YfleXrHU3uhnARoWo1nkO+5gVkRg434+fP58rkbQ+KyzSzFEdZMFr+gIQUNJxq
         vNaGHKI6gzmX6l03osdo1ByMaXvFnCpGisqVbAa62a/tMQq7SKC2J88arzMPMDjYF36K
         5xDreZXRw+mz8OAlu6KXnu1yjwXtnaapCWAG0NQxDQmrAHbEmFBM9EVDoD7eLf/StPtW
         PVPtrMfMkfxUHkfJjD5j7HiSoRmkXQ3yJjff0qqwea5vgyNr/Dz+Fg3Y5dDOdpUikG5Q
         wIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UQ6ki4yX5kQtVY1QftaIadGFPpTJFOi0It8Nz6sT1sA=;
        b=6LK6NlJDq6ssKBX6foWYv9HbhxuRF1AYon/81v548W+M3RVbifRHEWX+sK4fbgzKuX
         0yf35KpcmESWAjpjziGa1pHp/yDYNQdvMwS1CTYZXV6yYNa4upSojZ4+g0yukEoEbIMH
         DKkMokgvj9LyvG5sfIjoleaBJX0xKaWvXkqK6cJsyM/1z1BiF3bcA0Nux0uAus1U3OE9
         QwKpCUmIypSr99uT9+mUQ7JkI/rTA8F/WAetoRAvanvliZgwG5mGl8fw5WkNuaTkMAkQ
         wx2P65HZMxJI9CAb0vM0KM+FzI92hbvLDkMANDX9Za43a3Sy03EzSHf8yxJcD9gZvvM1
         vIsQ==
X-Gm-Message-State: ACgBeo2JUqTn7QOsAGTSh3B2r2tWyS/sNflMlkrtjDI/cM6ysS9NDWUu
        qKWDEqDMDZ4kyWMYcSeNAN0V5g==
X-Google-Smtp-Source: AA6agR5iucBxgT+lWuCgOcqjgv1Qz0MJiMgw6JKNQ8nsLCUf51/5QiLnwph6LP3BZLcxpH7lhwgthg==
X-Received: by 2002:a7b:c457:0:b0:3b4:689d:b408 with SMTP id l23-20020a7bc457000000b003b4689db408mr2835029wmi.22.1663155702145;
        Wed, 14 Sep 2022 04:41:42 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5951000000b00228dc37ce2asm13229870wri.57.2022.09.14.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:41:41 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:41:40 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: add PSI accounting around ->read_folio and
 ->readahead calls
Message-ID: <YyG99D196Hj0/GgZ@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:54AM +0200, Christoph Hellwig wrote:
> PSI tries to account for the cost of bringing back in pages discarded by
> the MM LRU management.  Currently the prime place for that is hooked into
> the bio submission path, which is a rather bad place:
> 
>  - it does not actually account I/O for non-block file systems, of which
>    we have many
>  - it adds overhead and a layering violation to the block layer
> 
> Add the accounting into the two places in the core MM code that read
> pages into an address space by calling into ->read_folio and ->readahead
> so that the entire file system operations are covered, to broaden
> the coverage and allow removing the accounting in the block layer going
> forward.
> 
> As psi_memstall_enter can deal with nested calls this will not lead to
> double accounting even while the bio annotations are still present.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is much cleaner. With the fixlet Willy pointed out:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

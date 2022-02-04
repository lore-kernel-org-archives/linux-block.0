Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF00BC433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 19:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiBDTAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 14:00:09 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59638
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbiBDTAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Feb 2022 14:00:08 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 788894003B
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644001207;
        bh=dsp7mzZUkzpXvj/wXApzigKpljtQL8jF7c8eXlwLYTU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qcQrgh22xMzksVMYubdWZqe6T2zM1+gytfsrukqeFKqWU53Mewvc/8Lq4uuReAH59
         abTlkGflWA0cVFkICk2RSLZltjpbngtJfq6dUJFPxaeuYEh2xj7wIF+9zoEcfuWDXV
         ubLeFTGEhBZ3UgiqbwtPQAMlEeUmKxLrUHJaYsygZDecIgMSBPSpPmPjQGVLlvqpbv
         Q6h27Ciqu9OMB+CjpB/aOf/BvyM5aP9OMs5X2G4/qwrrce5czcmvEfJQ2mltWbP0JN
         /cUkJ3jxc4kFgA+81pvpQkAe59uwnHB0XDy6cyr6EWqTQOzZOaf0GejzT2VkRTSBY3
         GEr0AWiB5xyvg==
Received: by mail-pl1-f200.google.com with SMTP id v14-20020a170902e8ce00b0014b48e8e498so3542890plg.2
        for <linux-block@vger.kernel.org>; Fri, 04 Feb 2022 11:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsp7mzZUkzpXvj/wXApzigKpljtQL8jF7c8eXlwLYTU=;
        b=1S/nLXoDkkWMlZWCR83ABRf1VhYm4a9SLxfcFt9FzKQHLU2an1zeG/fUwwKR9zbLl7
         caWRmFkj3gTT/UpTC8+3CdIEUoVY2txaMcQb9/3lUxAUH6tt10Q1hSWMPA3qaSu7QuVR
         xR0Sxi36Nq9cW981KieT/cT+oUKoOL5Dyg+nvipCGlSs1AnFFwxF0AqdnhrXIEAuh5IP
         luHKxNbOBuMcDodgyLlATjoIhC1jwr7nkEIe+93+ssSpvdhWbE0qxgsM9+0ooGe4EmWq
         Zw6IemQCjbRMXGrM5iWwI6OznUmH8gUx0IRDQ+LAJFyzz4CI7zAvsF6TYjCpqQstAtFK
         4z7A==
X-Gm-Message-State: AOAM532h//vICg0GOZPaC4ti9xQZX0iCLkAn7NezYee5QmMpTSYLhMOs
        qe+g/9s009P1U9a9W+vgT/g1j65wmqsQe+hfxXzcnUoyN12b/ej3qdUny2Hjk2PdbkgInFb7NOc
        y7Sqs6q+KHvpv17MR+2g+ewQgrIyKpUK5S9pJg9x884M04YRxLarrFx5B
X-Received: by 2002:a17:902:c412:: with SMTP id k18mr4696647plk.142.1644001205605;
        Fri, 04 Feb 2022 11:00:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqwOfSwjLOPcO4DzI5QBtfMm3Dn7PcJAUBIXJ7TooDBhnF02yOVT4Kes+je9/DUQ+FVCPviR8n/QpUd1NPJgk=
X-Received: by 2002:a17:902:c412:: with SMTP id k18mr4696591plk.142.1644001204980;
 Fri, 04 Feb 2022 11:00:04 -0800 (PST)
MIME-Version: 1.0
References: <20220131230255.789059-1-mfo@canonical.com> <Yfrh9F67ligMDUB7@google.com>
 <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
 <Yfr9UkEtLSHL2qhZ@google.com> <CAO9xwp0U4u_XST3WARND0eQ5nyHFrKx+sLWVJLQpjYrkZJOBaw@mail.gmail.com>
 <CAOUHufbrQZQ=ZCmVFRGOFk6+Snuy4Z6YSDUb3qMsHwROXatz_w@mail.gmail.com> <aed15ae0-24f9-d733-a3a2-3f803a82b6c7@nvidia.com>
In-Reply-To: <aed15ae0-24f9-d733-a3a2-3f803a82b6c7@nvidia.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Fri, 4 Feb 2022 15:59:53 -0300
Message-ID: <CAO9xwp2mTH7vBy9m-_63hAEwe3UgDShL1e2hCovf0RkrR+y90g@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux-MM <linux-mm@kvack.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 4, 2022 at 4:03 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/3/22 21:56, Yu Zhao wrote:
> ...
> >>> Got it. IIRC, get_user_pages() doesn't imply a write barrier. If so,
> >>> there should be a smp_wmb() on the other side:
> >>
> >> If I understand it correctly, it actually implies a full memory
> >> barrier, doesn't it?
> >>
> >> Because... gup_pte_range() (fast path) calls try_grab_compound_head(),
> >> which eventually calls* atomic_add_unless(), an atomic conditional RMW
> >> operation with return value, thus fully ordered on success (atomic_t.rst);
> >> (on failure gup_pte_range() falls back to the slow path, below.)
> >>
> >> And follow_page_pte() (slow path) calls try_grab_page(), which also calls
> >> into try_grab_compound_head(), as the above.
>
> Well, doing so was a mistake, actually. I've recently reverted it, via:
> commit c36c04c2e132 ("Revert "mm/gup: small refactoring: simplify
> try_grab_page()""). Details are in the commit log.
>
> Apologies for the confusion that this may have created.

No worries; thanks for the pointers / commit log.

>
> thanks,
> --
> John Hubbard
> NVIDIA
> [...]


-- 
Mauricio Faria de Oliveira

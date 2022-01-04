Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4782CC433FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 11:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiADLqi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:46:38 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58184
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbiADLqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jan 2022 06:46:38 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7C36F3F1AF
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641296790;
        bh=JY7Ra2cchiTcCQg+DROtjoU0ny4nqnEUeEw1mO9P5Dc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nnVjdUZBDa3jJ5rlpt4oyTizF+akpiMJjgEsTDr+lZxhZhGae9BhsfTAVvYQhzCGM
         YnEUoSsk5yqXvIWT04fkgDkaZS9GM/MwVfSYmDj8ZUY5D9aX42V/2hKY9CNniN8v2f
         eV4k8AinkHbizoVnoWGZZBW0dzsK793ssVzUiFcTLP2W2+UcpjFKDfax+lMTcdxQry
         PpuGlDvbaOjw78kawOQncfZ+cSf5gMVM2Y+ADguVNfe5vCgTIpOMMJB3pp8ZwhvZ3t
         cJ0r/N1Ew4+pqvC4U77jq2kSBogBjmM3OQNPGx/UKEBzm1tPo/hUOmRw/v06vxPsSw
         k66N8fgXd3a2Q==
Received: by mail-pj1-f70.google.com with SMTP id y2-20020a17090a1f4200b001b103d6b6d0so29116862pjy.1
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 03:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JY7Ra2cchiTcCQg+DROtjoU0ny4nqnEUeEw1mO9P5Dc=;
        b=qmh7J96Yzz7lME9KE0znZQ6xfcyqRCuchAdeSN5jX4MAlG0jz+fGgpP7dRo5ScnkkJ
         GspBTNuPSMNYrkbf6yCBOoS2nkCyElnLL9MXk5kEU1s0r/3Ns0jRCqR+C80yKc/wEDrS
         6+ut0wQ1PKDfOUOhOjsEWqjysTrhGZ/zRVBs/5LYWtdUhGsAsYCen9PkB/vbABL72cVY
         +d9im6/PdY8yX+LsDgL2EAlNclaQxQuHIKWDEwoT5Kr4k9nPw/X4DFKmKElvc+d0UlZP
         bMGaqPutVn+IE2x3vA+R30uzxb0lsinR3xJeRybrDCJPPwtZTJyTrve7cQosDpjZoQez
         +q4Q==
X-Gm-Message-State: AOAM532+ay0tLG3du3GvkZipE5IAEvPtO1SyX3cMnmbNMsyoUCtErMqg
        VAD6ZV5v9Tzoeh70wyC5Q+yYtehunfGE1goNDRu1KrXAJQhG5YX2fgkl9EZXxtPWH99yUn8IfGM
        fLbX2Bj8PGGWipmf+mFwocemVDM/B1nz1PZV5rjbHmM/O4EVDv7CRVdSo
X-Received: by 2002:a17:902:dac7:b0:148:ea85:af4d with SMTP id q7-20020a170902dac700b00148ea85af4dmr48734215plx.131.1641296789042;
        Tue, 04 Jan 2022 03:46:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMafOx3J2N+vnirg/RUlbh9VxvnjrvO/7mYaSFQHtIuDWATbA8Hi1oXl+pthEwcCKllJGQrdkzLfD/NlRm1gg=
X-Received: by 2002:a17:902:dac7:b0:148:ea85:af4d with SMTP id
 q7-20020a170902dac700b00148ea85af4dmr48734197plx.131.1641296788754; Tue, 04
 Jan 2022 03:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20211211022115.1547617-1-mfo@canonical.com> <YbuCvo12yVHiZgRE@google.com>
In-Reply-To: <YbuCvo12yVHiZgRE@google.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Tue, 4 Jan 2022 08:46:17 -0300
Message-ID: <CAO9xwp32+izoL54iCWRMGttL_T9yJKcyDyqwqxoDBx8Z7d_ZKg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix race between MADV_FREE reclaim and blkdev direct
 IO read
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 16, 2021 at 3:17 PM Minchan Kim <minchan@kernel.org> wrote:
...
> Hi Mauricio,
>
> Thanks for catching the bug. There is some comment before I would
> look the problem in more detail. Please see below.
>

Hey! Thanks for looking into this. Sorry for the delay; I've been out
a few weeks.

> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 163ac4e6bcee..f04151aae03b 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1570,7 +1570,18 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >
> >                       /* MADV_FREE page check */
> >                       if (!PageSwapBacked(page)) {
> > -                             if (!PageDirty(page)) {
> > +                             int refcount = page_ref_count(page);
> > +
> > +                             /*
> > +                              * The only page refs must be from the isolation
> > +                              * (checked by the caller shrink_page_list() too)
> > +                              * and the (single) rmap (dropped by discard:).
> > +                              *
> > +                              * Check the reference count before dirty flag
> > +                              * with memory barrier; see __remove_mapping().
> > +                              */
> > +                             smp_rmb();
> > +                             if (refcount == 2 && !PageDirty(page)) {
>
> A madv_free marked page could be mapped at several processes so
> it wouldn't be refcount two all the time, I think.
> Shouldn't we check it with page_mapcount with page_refcount?
>
>     page_ref_count(page) - 1  > page_mapcount(page)
>

It's the other way around, isn't it? The madvise(MADV_FREE) call only clears
the page dirty flag if page_mapcount() == 1 (ie not mapped by more processes).

@ madvise_free_pte_range()

                        /*
                         * If page is shared with others, we couldn't clear
                         * PG_dirty of the page.
                         */
                        if (page_mapcount(page) != 1) {
                                unlock_page(page);
                                continue;
                        }
...
                        ClearPageDirty(page);
                        unlock_page(page);


If that's right, the refcount of 2 should be OK (one from the isolation,
another one from the single map/one process.)

Does that make sense?  I might be missing something.

Thanks!

-- 
Mauricio Faria de Oliveira

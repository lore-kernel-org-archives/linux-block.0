Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB31AC433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 11:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiADLtr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:49:47 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33744
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231659AbiADLtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jan 2022 06:49:46 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2741E3F175
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 11:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641296985;
        bh=vguJt1qBunnTzzYbonX6ium+NdHf9qExcNc7nkL9r5E=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LZ8iaik6Pt5sah160yZ5UtIiXDZaxjwStLmFjgetXA3OFyJsRvs6cqN44/+Tgscps
         Al6xwuimMxadZ0k2VLj4u105C0iII1ZUUvZx0qldtZ+Qs5T8Z0ySdTPxO3VCxCDyrA
         1Y0zpbwSEicJZSiNhccOqhm6Xjo/HC2nESx4z952sSQcIUTgGZm74Q8HAnF8AWuZQV
         IEyw1+G3dypxpe2e7/vdYyBEye/STr0L1no7kKB9I+s33mj8cSPSZylQ3Q/JX6xO0D
         bDjOS3feCr5zJvRfFvCEjF/eKivbFU16fRqTYGip7d4Dt1zswr51YeJt632F5gT5J6
         K2jrfvCT3ntaA==
Received: by mail-pg1-f200.google.com with SMTP id k1-20020a63d841000000b003417384b156so13414648pgj.13
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 03:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vguJt1qBunnTzzYbonX6ium+NdHf9qExcNc7nkL9r5E=;
        b=0m7j3nGQ32M9ffCYsj/0UEZziV88S2DNP7/OCKrru91afzYObcV3+60s4DKEKXeJtl
         UHhDp70YRt7PlQFjgLZX0NjZ2hNuARp0Z9hDuM/x1qPJhyJR4Mmd9rYslpxyOLi84s+g
         R/4/z8Ej4z3txCI2Tx38UCaMsd8rWPW8YJF3S42gmHgA3Qncw4CtekYu0rhbbzQXp9Fc
         vKjmP8H11fNUkNKvZg35k6rdZnwpOykXQFMUGW1w5IjEvkzGUTK3Lx8dGd+nYdC8kbxS
         rBhM1y1VwEyPJfQQqLGftkd/JCgM6xTPEW+GfSnagmqBQT+4YOlY7rCJ/VV2IxRbXmJd
         +Veg==
X-Gm-Message-State: AOAM532D5qDPAZVUj4uu7uMsn6jaXHuG02FFer37US6vXgss+7X8/e+B
        Rbq6qks6KCqE8brmdTlxw12JkE+6dQYjPLjsdOVJD28cjWPDDkNJI++wL4jHDVILNv9+mNR+poW
        PpZ/MEo1NPQPu6+ea6nvSORSu+a5/lZn30EhxsKeadecVcO1cfwBpn+jw
X-Received: by 2002:a05:6a00:2189:b0:4bc:3def:b662 with SMTP id h9-20020a056a00218900b004bc3defb662mr25965576pfi.5.1641296983724;
        Tue, 04 Jan 2022 03:49:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHUG523/8tbQoU+FdbL4mua7c1pE+3BKOgbfFl3NT4qiEjvq8tQ1RLFRaslHzAFK3UvUGlAtwKxmumPCxbgVk=
X-Received: by 2002:a05:6a00:2189:b0:4bc:3def:b662 with SMTP id
 h9-20020a056a00218900b004bc3defb662mr25965561pfi.5.1641296983477; Tue, 04 Jan
 2022 03:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20211211022115.1547617-1-mfo@canonical.com> <YbuCvo12yVHiZgRE@google.com>
 <871r2ct207.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871r2ct207.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Tue, 4 Jan 2022 08:49:32 -0300
Message-ID: <CAO9xwp0buKKqEU=CLe0tjDhSM_NWx6aafXiNX3zPghNdtcPQyA@mail.gmail.com>
Subject: Re: [PATCH] mm: fix race between MADV_FREE reclaim and blkdev direct
 IO read
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 16, 2021 at 11:10 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Minchan Kim <minchan@kernel.org> writes:
...
> >
> > A madv_free marked page could be mapped at several processes so
> > it wouldn't be refcount two all the time, I think.
> > Shouldn't we check it with page_mapcount with page_refcount?
> >
> >     page_ref_count(page) - 1  > page_mapcount(page)
> >
>
> And should we consider page_count() too in madvise_free_pte_range()?
> That is, if the page has been used by GUP, we needn't to make its PTE
> clean?

Hey, thanks for reviewing!

That might not be sufficient time-wise, I guess, because the page can
be used by GUP after the madvise() call (e.g., this case), thus
checking for it during the call wouldn't catch it -- this may apply to
other cases too, where there's no guarantee/ordering between both
operations.

cheers,

-- 
Mauricio Faria de Oliveira

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37471CE79A9
	for <linux-block@archiver.kernel.org>; Tue, 19 Sep 2023 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjISQBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Sep 2023 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjISQBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2023 12:01:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6C93
        for <linux-block@vger.kernel.org>; Tue, 19 Sep 2023 09:00:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adb9fa7200so1198735266b.0
        for <linux-block@vger.kernel.org>; Tue, 19 Sep 2023 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695139256; x=1695744056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0R/NEqhp8mvFMCcaKYM+AhiLyAZfM1uN2ggUzMalzw=;
        b=FtzaXOi+hA01MIr7cO5FS90YmVBkOJC+dhjrOCsAurhpXemDPx3XRkVlRCGe4b7pJw
         6U/kdVPpxlqn2gwcJDjZPRQLwI4RmkJMzfx9trA2VCezlmebJXQgsSNLym3ebCfLT25w
         okscFh+rEzMEo0ehRInD2SRCDHY1pysIb5wIqpPSTmM694YHvvWvenMC4SZ8SGPPaORC
         217TBfMvGnQDB9E1rMRFEue4SzC693KM4PwYZ9A+IDbhNJlOGNbENZchwwPxPhXvHdwN
         sGqixBVFn91zfNXBliBvHcE4g9jZoNC891pEred5zqUgAHBN7bQNnE8e1gvtcir6znqi
         4ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695139256; x=1695744056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0R/NEqhp8mvFMCcaKYM+AhiLyAZfM1uN2ggUzMalzw=;
        b=g3qeFw9Kz/urUK8i3zZjAUJBZ+liO27UU5DbYid2f6k0RCIVY+h/IRPFUCu/wRvISA
         ScRUBQZ3flfsEEsm38GiXZedtp+y4wjfCH61aeK7IFmEBbH51l5gpa4UiI1oU/Kpc6bW
         roVQEReyjGCreIpzOsxgnyW6s/VIfK2EC4g4yWkgSRN0r5T1cB4IdIkRAJHWT3VYXO6j
         5Mp2SOLP5GfDuj3/aviM7MME6TjYtKwWuj2KVWDEWYGZMlES9QW21KznwwqP3Mp0y0oG
         b40TLRjps6UUpcd/k3o/Z/6UwSz9955YmBE+SVegCMWCcYDbaEKKVYb4xtasPYg9iSE9
         uwWA==
X-Gm-Message-State: AOJu0YzRM18AiJ+s+C3CnaFIkvZJRAASnM2DBzwi6B4tD27f/iRJmVlj
        X5mfI6KxF6K1KtN7CqntRrwFKpiw7LH8PvEaT+6d8w==
X-Google-Smtp-Source: AGHT+IGwZwS2c6qiWZ9zWVkmGdcNaP8g1k2FnfUTXQz40ZbXZpXm7Nn5A9VeM/7x9bLj2HVuo2cxxg+CmzsH7772dVQ=
X-Received: by 2002:a17:906:51d2:b0:9a5:9305:83fb with SMTP id
 v18-20020a17090651d200b009a5930583fbmr128884ejk.34.1695139255976; Tue, 19 Sep
 2023 09:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com> <20230915095042.1320180-7-da.gomez@samsung.com>
 <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com>
 <20230918075758.vlufrhq22es2dhuu@sarkhan> <CAJD7tkZSST8Kc6duUWt6a9igrsn=ucUPSVPWWGDWEUxBs3b4bg@mail.gmail.com>
 <20230919132633.v2mvuaxp2w76zoed@sarkhan>
In-Reply-To: <20230919132633.v2mvuaxp2w76zoed@sarkhan>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 19 Sep 2023 09:00:16 -0700
Message-ID: <CAJD7tkaELyZXsUP+c=DKg9k-FeFTTRS+_9diK5fyTNdfDAykmQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] shmem: add large folios support to the write path
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 19, 2023 at 6:27=E2=80=AFAM Daniel Gomez <da.gomez@samsung.com>=
 wrote:
>
> On Mon, Sep 18, 2023 at 11:55:34AM -0700, Yosry Ahmed wrote:
> > On Mon, Sep 18, 2023 at 1:00=E2=80=AFAM Daniel Gomez <da.gomez@samsung.=
com> wrote:
> > >
> > > On Fri, Sep 15, 2023 at 11:26:37AM -0700, Yosry Ahmed wrote:
> > > > On Fri, Sep 15, 2023 at 2:51=E2=80=AFAM Daniel Gomez <da.gomez@sams=
ung.com> wrote:
> > > > >
> > > > > Add large folio support for shmem write path matching the same hi=
gh
> > > > > order preference mechanism used for iomap buffered IO path as use=
d in
> > > > > __filemap_get_folio().
> > > > >
> > > > > Use the __folio_get_max_order to get a hint for the order of the =
folio
> > > > > based on file size which takes care of the mapping requirements.
> > > > >
> > > > > Swap does not support high order folios for now, so make it order=
 0 in
> > > > > case swap is enabled.
> > > >
> > > > I didn't take a close look at the series, but I am not sure I
> > > > understand the rationale here. Reclaim will split high order shmem
> > > > folios anyway, right?
> > >
> > > For context, this is part of the enablement of large block sizes (LBS=
)
> > > effort [1][2][3], so the assumption here is that the kernel will
> > > reclaim memory with the same (large) block sizes that were written to
> > > the device.
> > >
> > > I'll add more context in the V2.
> > >
> > > [1] https://protect2.fireeye.com/v1/url?k=3Da80aab33-c981be05-a80b207=
c-000babff9b5d-b656d8860b04562f&q=3D1&e=3D46666acf-d70d-4e8d-8d00-b027808ae=
400&u=3Dhttps%3A%2F%2Fkernelnewbies.org%2FKernelProjects%2Flarge-block-size
> > > [2] https://protect2.fireeye.com/v1/url?k=3D3f753ca2-5efe2994-3f74b7e=
d-000babff9b5d-e678f885471555e3&q=3D1&e=3D46666acf-d70d-4e8d-8d00-b027808ae=
400&u=3Dhttps%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vS7sQ=
fw90S00l2rfOKm83Jlg0px8KxMQE4HHp_DKRGbAGcAV-xu6LITHBEc4xzVh9wLH6WM2lR0cZS8%=
2Fpubhtml%23
> > > [3] https://lore.kernel.org/all/ZQfbHloBUpDh+zCg@dread.disaster.area/
> > > >
> > > > It seems like we only enable high order folios if the "noswap" moun=
t
> > > > option is used, which is fairly recent. I doubt it is widely used.
> > >
> > > For now, I skipped the swap path as it currently lacks support for
> > > high order folios. But I'm currently looking into it as part of the L=
BS
> > > effort (please check spreadsheet at [2] for that).
> >
> > Thanks for the context, but I am not sure I understand.
> >
> > IIUC we are skipping allocating large folios in shmem if swap is
> > enabled in this patch. Swap does not support swapping out large folios
> > as a whole (except THPs), but page reclaim will split those large
> > folios and swap them out as order-0 pages anyway. So I am not sure I
> > understand why we need to skip allocating large folios if swap is
> > enabled.
>
> I lifted noswap condition and retested it again on top of 230918 and
> there is some regression. So, based on the results I guess the initial
> requirement may be the way to go. But what do you think?
>
> Here the logs:
> * shmem-large-folios-swap: https://gitlab.com/-/snippets/3600360
> * shmem-baseline-swap : https://gitlab.com/-/snippets/3600362
>
> -Failures: generic/080 generic/126 generic/193 generic/633 generic/689
> -Failed 5 of 730 tests
> \ No newline at end of file
> +Failures: generic/080 generic/103 generic/126 generic/193 generic/285 ge=
neric/436 generic/619 generic/633 generic/689
> +Failed 9 of 730 tests
> \ No newline at end of file
> >

I am not really familiar with these tests so I cannot really tell
what's going on. I can see "swapfiles are not supported" in the logs
though, so it seems like we are seeing extra failures by just lifting
"noswap" even without actually swapping. I am curious if this is just
hiding a different issue, I would at least try to understand what's
happening.

Anyway, I don't have enough context here to be useful. I was just
making an observation about reclaim splitting shmem folios to swap
them out as order-0 pages, and asking why this is needed based on
that. I will leave it up to you and the reviewers to decide if there's
anything interesting here.

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63168C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 00:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbiFWAVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 20:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiFWAVX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 20:21:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94F41617
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 17:21:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k127so12334901pfd.10
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sEu+ZemtOoW/S//8vKKuvbhZURlfcFDsCuSI86ItaKU=;
        b=BWizh8cmQiUQBzMgOHK5VuVrre4BR/nwDUoYRqTMaOfc/oxtjiWPD8sZuMr5blJkPi
         6t6ZyXd8SNUgAozlhCz503wgCxum6fyWWxQNEWwnbJpjzpcgK0QJ69yXi0R/AE0LPHOy
         8B5fFCLmTjNZHADgdrEmrjNALlBxYJLnnvrQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sEu+ZemtOoW/S//8vKKuvbhZURlfcFDsCuSI86ItaKU=;
        b=zaDYR7zvWteC4py/BOFt2u3JKgSC/cGRWPFmj1R9R63qRJtdXmViasaicRRwDVANd5
         hx4T7VnCQF3B9fJfQC/qtn1pNobxKakN27NL7nbWi0rJ79C9e1YQ0NPwarh3nFouPA5G
         SjGIc97Kvp1kUPYXPOa79hz6k0+9kE7e40WjGKDFVte8dICC25B0m8VA8/Z4Q4swWpl8
         CKOjcYuZZwbScGDZCdoMKPvkvNsFuTsOF98BcHNf2i9coZYhkZ2RRHz1bNdEITNJ0Evq
         52g27/nh5XyPPBJAiZC9FzFDsWLcgXAo7q5oUfONSAwxxqCPrYmWqNRalhCOOaLD51Wb
         KXOA==
X-Gm-Message-State: AJIora/z+HV5Cj6mPaPEzUWrYe1oragSJoKGRsneM1kmaeBbOrH5/W3u
        GoB+Xk0N5FRB1HQUimvCeIQl8Q==
X-Google-Smtp-Source: AGRyM1stBjUVDHEr/5KTYtcgg9N7JATjDQ5ZjXL6QFIb3spqjUM1WFCLiuemHKjZliAelwPxWikd7w==
X-Received: by 2002:a63:6bca:0:b0:408:897c:3fb8 with SMTP id g193-20020a636bca000000b00408897c3fb8mr5080621pgc.576.1655943682009;
        Wed, 22 Jun 2022 17:21:22 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e2f3:d85c:2a24:ec47])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a348f00b001ecc616c9f3sm379098pjb.21.2022.06.22.17.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 17:21:21 -0700 (PDT)
Date:   Thu, 23 Jun 2022 09:21:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: do not lookup algorithm in backends table
Message-ID: <YrOx/eG/JZpRv22m@google.com>
References: <20220622023501.517125-1-senozhatsky@chromium.org>
 <YrMzJSNb4b+tODqR@google.com>
 <20220622121930.4f8d3f882bb2b0520fd6917c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622121930.4f8d3f882bb2b0520fd6917c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/06/22 12:19), Andrew Morton wrote:
> > On (22/06/22 11:35), Sergey Senozhatsky wrote:
> > > Always use crypto_has_comp() so that crypto can lookup module,
> > > call usermodhelper to load the modules, wait for usermodhelper
> > > to finish and so on. Otherwise crypto will do all of these steps
> > > under CPU hot-plug lock and this looks like too much stuff to
> > > handle under the CPU hot-plug lock. Besides this can end up in
> > > a deadlock when usermodhelper triggers a code path that attempts
> > > to lock the CPU hot-plug lock, that zram already holds.
> > 
> > And we think that we (not exactly "we", our partners) actually
> > see a deadlock. It goes something like this:
> > 
> > - path A. zram grabs CPU hot-plug lock, execs /sbin/modprobe from crypto
> >   and waits for modprobe to finish
> 
> Nope, can't do that.
> 
> > disksize_store
> >  zcomp_create
> >   __cpuhp_state_add_instance
> >    __cpuhp_state_add_instance_cpuslocked
> >     zcomp_cpu_up_prepare
> >      crypto_alloc_base
> >       crypto_alg_mod_lookup
> >        call_usermodehelper_exec
> >         wait_for_completion_killable
> >          do_wait_for_common
> >           schedule
> 
> The usermode helper is free to do anything it wants, including
> operations that take the CPU hotplug lock.  Or operations which might
> in the future be changed to take that lock.

Agreed.

> > - path B. async work kthread that brings in scsi device. It wants to
> >   register CPUHP states at some point, and it needs the CPU hot-plug
> >   lock for that, which is owned by zram.
> > 
> > async_run_entry_fn
> >  scsi_probe_and_add_lun
> >   scsi_mq_alloc_queue
> >    blk_mq_init_queue
> >     blk_mq_init_allocated_queue
> >      blk_mq_realloc_hw_ctxs
> >       __cpuhp_state_add_instance
> >        __cpuhp_state_add_instance_cpuslocked
> >         mutex_lock
> >          schedule
> > 
> > - path C. modprobe sleeps, waiting for all aync works to finish.
> > 
> > load_module
> >  do_init_module
> >   async_synchronize_full
> >    async_synchronize_cookie_domain
> >     schedule
> > 
> > And none can make any progress.
> > 
> > So I think we need to move crypto_alg_mod_lookup()->call_usermodehelper_exec()
> > out of CPU hot-plug lock and pre-load modules in advance, before we grab the
> > hot-plug lock.
> 
> If the locking is fixed, why is there still a need to preload modules?

We "fix" locking by doing initial crypto compression algorithm lookup
outside of hot-plug lock (pre-load).

Crypto API handles a list of preloaded modules internally. What we do
currently, we call crypto_alloc_base() under hot-plug lock, which calls
crypto_alg_mod_lookup(), which figures out that crypto modules list does
not contain that module yet so then it modprobes it.

With this patch we do the first crypto_alg_mod_lookup() outside of
hot-plug lock, so that it safely modprobes compression module. Then
when we grab the hot-plug lock and setup per-CPU streams,
crypto_alloc_base()->crypto_alg_mod_lookup() figures that module is
already on the list so no modprobe is needed.

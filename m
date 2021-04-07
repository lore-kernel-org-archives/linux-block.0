Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB80C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E205661394
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 14:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbhDGOxD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 10:53:03 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45638 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhDGOxC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 10:53:02 -0400
Received: by mail-pg1-f173.google.com with SMTP id d10so8398682pgf.12;
        Wed, 07 Apr 2021 07:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x11JedQ758JkCFaOFtBqoObk8A4GggupZY+sy4Vsx4U=;
        b=We6nXCyf2ThfIHiPj+hVS4vBiZUxMaOh96gV0XeUcSuuOyMXQxHLx1enXPs+TmcBbA
         OkzQx9C2gYdlh2H2XSygfMvVIastHYEpgCJ0xWr/cg4ZoWd8q5+pFn3jWvjybbdcg9H+
         H8YX4LLCgcC+R/FVi0ffhISyLc6YHt4hTg4uB12xhSM92pW5n/BALOA0UO55w9N/gD1X
         +2+9CFXGpU2pM+u4Yv5Pj88xpVZoqd7f3uYgphvcr0XeNNgrD87B07p4oACZX4VPoIIk
         Xms9HTgXNeoTuPC+kEABa8KKyzJefTjbeibMJITuAY/NbFecu8SXcCsIX3zH4/EoQJFV
         g93A==
X-Gm-Message-State: AOAM533ZHqqbO64rHSMRiw+RIxKs2mC91r/t6t2JPMVVvssC33+nsg9S
        pphy0QzBKkg7HXQSPhdJgxU=
X-Google-Smtp-Source: ABdhPJw+Obi6cmgWa245v+vfQ1ayLJmpONEwFsqx+XnbdVDKj1LvWJlkSOhHu1/VUmuPUn5epZYWdQ==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr3634340pgo.365.1617807172997;
        Wed, 07 Apr 2021 07:52:52 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f2sm20793876pfe.177.2021.04.07.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:52:52 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6804E402D7; Wed,  7 Apr 2021 14:52:51 +0000 (UTC)
Date:   Wed, 7 Apr 2021 14:52:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     keescook@chromium.org, dhowells@redhat.com, hch@infradead.org,
        mbenes@suse.com, gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210407145251.GD4332@42.do-not-panic.com>
References: <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGtDzH0dEfEngCij@google.com>
 <20210405190023.GX4332@42.do-not-panic.com>
 <YGtrzXYDiO3Gf9Aa@google.com>
 <20210406002909.GY4332@42.do-not-panic.com>
 <YG0JouWqrJPHbpqz@google.com>
 <YG0NEIUfJ5lmS4DL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG0NEIUfJ5lmS4DL@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 06, 2021 at 06:38:24PM -0700, Minchan Kim wrote:
> To clarify what I understood form the discussion until now:
> 
> 1. zram shouldn't allow creating more zram instance during
> rmmod(It causes CPU multistate splat)

Right!

> 2. the private data of gendisk shouldn't destroyed while zram
> sysfs knob is working(it makes system goes crash)

Yup, this is resolved with the bdgrab / bdput on each sysfs knob.

And the last issue is:

3) which patch 2/2 addresed. If a mutex is shared on sysfs
knobs and module removal, you must do try_module_get() to prevent
the deadlock.

  Luis

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687D0C04A94
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 06:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjHDGiu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 02:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjHDGiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 02:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF246BB
        for <linux-block@vger.kernel.org>; Thu,  3 Aug 2023 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691131042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRbNEV/g+3SWffCtpqnTW+44zOe74EJ4R0UlzfLRMdg=;
        b=aA/lC50pfMCZ4ZXM4HdzDcHeECa/8q6129iXzS2g1XkDAb9EFQNQnGHeuWiXJBz1t8jzSi
        GmLNR4jojzARAshS2/FF+vMvFH25+DuoI0px/PQI0qBI7Nv916X+Rr/MaAkKttKHLRAOI9
        PQWmh1emsXeBc8ZwpdBFqGUKel9IEsY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-dNwAkdJdOziL2bJs1qcMcw-1; Fri, 04 Aug 2023 02:37:19 -0400
X-MC-Unique: dNwAkdJdOziL2bJs1qcMcw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40c10c73650so23224661cf.0
        for <linux-block@vger.kernel.org>; Thu, 03 Aug 2023 23:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691131039; x=1691735839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRbNEV/g+3SWffCtpqnTW+44zOe74EJ4R0UlzfLRMdg=;
        b=cnxO2A/120E1NpLb3b1XkQu45Qy7Ae6MYy5miZNYxGNb7DiKCB7xvgI9DfWUyMwkR6
         z4CaYGJVNsvVmxcs9pzQTG2Jz8eHwxlby0z0sZBxyTXln78EAFAAhqFibfL+YEMeoecP
         b0ysPc6tkGyZeA6kpmGAEI3BzGW9xea24HdR0VTZrTd8LRPGH2xdNumu4SI9AKi53twG
         tPQT6JYjEh0o6l9qrjAPG6eezs2yaLT+62rlIwbIyQxqhsimT0SWMWJuOOaZtjS4m42j
         JyrhfROykh7A06RMH+0dM0sogQ6qaw4ulgw70Mx3ln2XTE9eg23zbnWmg3vlJ4LLks3l
         goaA==
X-Gm-Message-State: AOJu0YxceY671bHcwnzue4+dTG6L1K2LQhV2weAXkbj2jwNRTH/Wv2RR
        AyN+KRO01Jm+1mcq5ptUoOUPjI14176rVlxFlX3aTPCig1wE5d8JssIEkG20Bdt1Vagge0sKSho
        Df8BcZOGNuppaTb7u9bUfUtU=
X-Received: by 2002:a05:622a:44f:b0:404:a649:879c with SMTP id o15-20020a05622a044f00b00404a649879cmr1022821qtx.49.1691131038970;
        Thu, 03 Aug 2023 23:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQAEaqfcC9XZlm+xYVaRBqSvtLqOU49iCHOkXeJwSJ4Vq7u3O4eD+BrXMQHkYycIHuMGVRvA==
X-Received: by 2002:a05:622a:44f:b0:404:a649:879c with SMTP id o15-20020a05622a044f00b00404a649879cmr1022804qtx.49.1691131038689;
        Thu, 03 Aug 2023 23:37:18 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a034700b002681bda127esm920379pjf.35.2023.08.03.23.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 23:37:18 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:37:11 +1000
From:   Ian Wienand <iwienand@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <ZMycl7xKyJoQNpcu@fedora19.localdomain>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2l3vJb1y2Jynf50@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 07, 2022 at 01:25:16PM -0800, Minchan Kim wrote:
> > following bug is trying to workaround an error on ppc64le, where
> > zram01.sh LTP test (there is also kernel selftest
> > tools/testing/selftests/zram/zram01.sh, but LTP test got further
> > updates) has often mem_used_total 0 although zram is already filled.

> Is it happening on only ppc64le?

I have managed to replicate this on an arm64 system.  I frankly don't
know what is so special about it -- it's a qemu guest and I'm not sure
what exactly it's running ontop of.

> Is it a new regression? What kernel version did you use?

I've replicated this on 4.18.0; obviously something more recent would
be useful but I'm hesitant to destroy too much state in case it is
something ...

> Actually, mem_used_total indicates how many *physical memory* were
> currently used to keep original data size.
> 
> However, if the test data is repeated pattern of unsigned long
> (https://github.com/torvalds/linux/blob/master/drivers/block/zram/zram_drv.c#L210)
> zram doesn't allocate the physical memory but just mark the unsigned long's value
> in meta area for decompression later.

To recap; this test [1] creates a zram device, makes a filesystem on
it, and fills it with sequential 1k writes from /dev/zero via dd.  The
problem is that it sees the mem_used_total for the zram device as zero
in the sysfs stats after the writes; this causes a divide by zero
error in the script calculation.

An annoted extract:

 zram01 3 TINFO: /sys/block/zram1/disksize = '26214400'
 zram01 3 TPASS: test succeeded
 zram01 4 TINFO: set memory limit to zram device(s)
 zram01 4 TINFO: /sys/block/zram1/mem_limit = '25M'
 zram01 4 TPASS: test succeeded
 zram01 5 TINFO: make vfat filesystem on /dev/zram1

 >> at this point a cat of /sys/block/zram1/mm_stat shows
 >>   65536      527    65536 26214400    65536        0        0        0

 zram01 5 TPASS: zram_makefs succeeded
 zram01 6 TINFO: mount /dev/zram1
 zram01 6 TPASS: mount of zram device(s) succeeded
 zram01 7 TINFO: filling zram1 (it can take long time)
 zram01 7 TPASS: zram1 was filled with '25568' KB

 >> at this point "ls -lh" shows the file
 >> total 25M
 >> -rwxr-xr-x. 1 root root 25M Aug  4 01:06 file

 >> however, /sys/block/zram1/mm_stat shows
 >>   9502720        0        0 26214400   196608      145        0        0
 >> the script reads this zero value and tries to calculate the
 >> compression ratio

 ./zram01.sh: line 145: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")

 >> If we do a "sync" then redisply the mm_stat after, we get
 >>   26214400     2842    65536 26214400   196608      399        0        0

I have managed to instrument this, and in the following

 static ssize_t mm_stat_show(struct device *dev,
                struct device_attribute *attr, char *buf)
 {
  ...
        if (init_done(zram)) {
		mem_used = zs_get_total_pages(zram->mem_pool);
                pr_info("mm_stat_show: init done %p %lld\n", zram->mem_pool, mem_used);
                zs_pool_stats(zram->mem_pool, &pool_stats);

zs_get_total_pages(zram->mem_pool) is definitely zero, which is why
the mm_stat is returning zero.  i.e. zsmalloc really doesn't seem to
have any pages recorded for that mem_pool ...

This doesn't seem to make sense; how can a device that has a file
system on it not even have one page assigned to it in zram->mem_pool?

I *think* this has something to do with the de-deuplication as noted.
If I stub out page_same_filled() to return false always, we see instead

 zram01 7 TPASS: zram1 was filled with '25568' KB
 >>  < immediately after >
 >> 10223616    48516   131072 26214400   196608        0        0        0
 >>  < after sync >
 >> 26214400   126933   327680 26214400   327680        0        0        0

So I think this test still needs a sync to be sure that it's seeing
the right values?  It's probably expected that this takes some time to
write everything out?

But is it possible that mem_used_total being zero is a bug -- possibly
triggered by the de-dup path and the test writing the same thing in
every block?  Something like the first de-duped page also being thrown
out?

-i

[1] https://github.com/linux-test-project/ltp/blob/8c201e55f684965df2ae5a13ff439b28278dec0d/testcases/kernel/device-drivers/zram/zram01.sh


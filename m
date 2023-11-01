Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E97C4167B
	for <linux-block@archiver.kernel.org>; Wed,  1 Nov 2023 03:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjKADYf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Oct 2023 23:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjKADYe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2023 23:24:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16334A4;
        Tue, 31 Oct 2023 20:24:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3bc5df96so25718265ad.2;
        Tue, 31 Oct 2023 20:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698809071; x=1699413871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+2C1iXZcOTrTqGCV4PTQYVBg6Rkhk9UufGCighF5v2k=;
        b=AImHUx8p0E623U3NyO12zbEksrkLgIApuepQzIzq5cCqTvVq6RmtAKEpGL4JWBGWj9
         Jgo8cNgfbCI5ikqrlsWlopKex0liaHPB7AaE6QswAUmUZUGD8GoHtdqZ7RPbvevclrOS
         36pRDF9xsy2e5TTExayYE/VWcMyTVMtD+tQXOfsKcjMu4uZi3j9SIYrLnPIWanAxPxtx
         mGeBd6yMJSoFa9JfJ1BuRkSkJQLvaDVCDB96hNDq8OHnMS4fvk6cN0wKqIZjC/F5073t
         JfXjV6/AfF+d43J/mtmPl5RHM4W7sD7ZrdJ8hYV6CV6HB4ajEE9oKsG3NqUa+kFFkur0
         pn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698809071; x=1699413871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2C1iXZcOTrTqGCV4PTQYVBg6Rkhk9UufGCighF5v2k=;
        b=L5U4losfQbdeB5WGeFsf/xu+NWq8p+Z+FX+gJ8foqZArYlNJFNWrUCf3HfV/XOD3jO
         bsqQOWydhSbrDiGAJuW5Yt7upro4LkhUreiv5GJjm7Sa17WoKsj/aXTGVp71HgGXeM6+
         Q5ejeBqfJfmK8ylalEBtLiwLUAbvX8OtsVC0kShvfA3xkPh7ovxqOl2Ox7cCa1gnL+Vj
         HR5O1SfGoF6kUM+/D1hSB7+RRWgFtMqAeYizZ/hAtK6i74gUwUqKI2Ouchbg47Gtnal/
         9ZPc91PTuREXIpJSSngTDm9J+se3dsbmB6Jd7RizNLpHfkMyy5aMOz+ICETPXJyRrQNR
         MkWw==
X-Gm-Message-State: AOJu0YwRiwx0I2sj6DOCB5xBWxTDe0WFcq9NmCAY+UfgehhWrjPGaZOm
        Aj7sNwEMihm/01f6catZygM=
X-Google-Smtp-Source: AGHT+IEiqzbxuH1oyyz4CFB5xcpfQcMLCwLmTN0qfwugw7Xk6L/aWx4ZRSK3TgVkGOAedxuqcdqOIQ==
X-Received: by 2002:a17:902:9688:b0:1c9:d90b:c3e4 with SMTP id n8-20020a170902968800b001c9d90bc3e4mr11705042plp.10.1698809071306;
        Tue, 31 Oct 2023 20:24:31 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b001c60d0a6d84sm279375plx.127.2023.10.31.20.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 20:24:30 -0700 (PDT)
Date:   Wed, 1 Nov 2023 11:24:23 +0800
From:   Ming Lei <tom.leiming@gmail.com>
To:     Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, ming.lei@redhat.com
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZUHE52SznRaZQxnG@fedora>
References: <ZT+wDLwCBRB1O+vB@mail-itl>
 <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com>
 <20231030155603.k3kejytq2e4vnp7z@quack3>
 <ZT/e/EaBIkJEgevQ@mail-itl>
 <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com>
 <ZUB5HFeK3eHeI8UH@mail-itl>
 <20231031140136.25bio5wajc5pmdtl@quack3>
 <ZUEgWA5P8MFbyeBN@mail-itl>
 <CACVXFVOEWDyzasS7DWDvLOhC3Hr6qOn5ks3HLX+fbRYCxYv26w@mail.gmail.com>
 <ZUG0gcRhUlFm57qN@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUG0gcRhUlFm57qN@mail-itl>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 01, 2023 at 03:14:22AM +0100, Marek Marczykowski-Górecki wrote:
> On Wed, Nov 01, 2023 at 09:27:24AM +0800, Ming Lei wrote:
> > On Tue, Oct 31, 2023 at 11:42 PM Marek Marczykowski-Górecki
> > <marmarek@invisiblethingslab.com> wrote:
> > >
> > > On Tue, Oct 31, 2023 at 03:01:36PM +0100, Jan Kara wrote:
> > > > On Tue 31-10-23 04:48:44, Marek Marczykowski-Górecki wrote:
> > > > > Then tried:
> > > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=4 - cannot reproduce,
> > > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=5 - cannot reproduce,
> > > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=6 - freeze rather quickly
> > > > >
> > > > > I've retried the PAGE_ALLOC_COSTLY_ORDER=4,order=5 case several times
> > > > > and I can't reproduce the issue there. I'm confused...
> > > >
> > > > And this kind of confirms that allocations > PAGE_ALLOC_COSTLY_ORDER
> > > > causing hangs is most likely just a coincidence. Rather something either in
> > > > the block layer or in the storage driver has problems with handling bios
> > > > with sufficiently high order pages attached. This is going to be a bit
> > > > painful to debug I'm afraid. How long does it take for you trigger the
> > > > hang? I'm asking to get rough estimate how heavy tracing we can afford so
> > > > that we don't overwhelm the system...
> > >
> > > Sometimes it freezes just after logging in, but in worst case it takes
> > > me about 10min of more or less `tar xz` + `dd`.
> > 
> > blk-mq debugfs is usually helpful for hang issue in block layer or
> > underlying drivers:
> > 
> > (cd /sys/kernel/debug/block && find . -type f -exec grep -aH . {} \;)
> > 
> > BTW,  you can just collect logs of the exact disks if you know what
> > are behind dm-crypt,
> > which can be figured out by `lsblk`, and it has to be collected after
> > the hang is triggered.
> 
> dm-crypt lives on the nvme disk, this is what I collected when it
> hanged:
> 
...
> nvme0n1/hctx4/cpu4/default_rq_list:000000000d41998f {.op=READ, .cmd_flags=, .rq_flags=IO_STAT, .state=idle, .tag=65, .internal_tag=-1}
> nvme0n1/hctx4/cpu4/default_rq_list:00000000d0d04ed2 {.op=READ, .cmd_flags=, .rq_flags=IO_STAT, .state=idle, .tag=70, .internal_tag=-1}

Two requests stays in sw queue, but not related with this issue.

> nvme0n1/hctx4/type:default
> nvme0n1/hctx4/dispatch_busy:9

non-zero dispatch_busy means BLK_STS_RESOURCE is returned from
nvme_queue_rq() recently and mostly.

> nvme0n1/hctx4/active:0
> nvme0n1/hctx4/run:20290468

...

> nvme0n1/hctx4/tags:nr_tags=1023
> nvme0n1/hctx4/tags:nr_reserved_tags=0
> nvme0n1/hctx4/tags:active_queues=0
> nvme0n1/hctx4/tags:bitmap_tags:
> nvme0n1/hctx4/tags:depth=1023
> nvme0n1/hctx4/tags:busy=3

Just three requests in-flight, two are in sw queue, another is in hctx->dispatch.

...

> nvme0n1/hctx4/dispatch:00000000b335fa89 {.op=WRITE, .cmd_flags=NOMERGE, .rq_flags=DONTPREP|IO_STAT, .state=idle, .tag=78, .internal_tag=-1}
> nvme0n1/hctx4/flags:alloc_policy=FIFO SHOULD_MERGE
> nvme0n1/hctx4/state:SCHED_RESTART

The request staying in hctx->dispatch can't move on, and nvme_queue_rq()
returns -BLK_STS_RESOURCE constantly, and you can verify with
the following bpftrace when the hang is triggered:

	bpftrace -e 'kretfunc:nvme_queue_rq  { @[retval, kstack]=count() }'

It is very likely that memory allocation inside nvme_queue_rq()
can't be done successfully, then blk-mq just have to retry by calling
nvme_queue_rq() on the above request.


Thanks,
Ming

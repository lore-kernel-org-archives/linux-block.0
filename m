Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5ABC43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 04:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA1020718
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 04:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyiWPE16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLKEI0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:08:26 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43190 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLKEI0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 23:08:26 -0500
Received: by mail-pj1-f65.google.com with SMTP id g4so8369811pjs.10;
        Tue, 10 Dec 2019 20:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=In54ids+z+a8rh2f7nWjNXjlFLpZrv06UVBdfJ8YyXQ=;
        b=cyiWPE16t+2QsQSOHoDcALaMF5/7WXGgsF9gFpL97bF9sdDl5tL0/z1jPsPw7B3nt9
         bcgwk2DsE03HwMyDryrjwcr9T15E1j7Bkijius0a4dkeG/4Po91hLDGVMi8kY/9M1K4c
         id0a6PSeF10wWe+a3p2Qo72eE/UyKkws4km7kcQZXiadxikyN9mU45ra0JFeoOvaEpYf
         KtyTQjmft/tqfW/TV4CB6e2rfFFQGFUux09CuIKNsRVVUzVWoBhOnbWyH/UNwCCrr0Ym
         UbNGMPoJMgiYKjQyd4TWbJPuMTrlb/m3gFB7/eSsc7o2QCyaDLJn6cGgLtp+yX/R55B9
         aXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=In54ids+z+a8rh2f7nWjNXjlFLpZrv06UVBdfJ8YyXQ=;
        b=OE/7s+ldcUpLM1BMD2FC8zOA9mjpe4t8JSDc+xcYHYdpf1MorO1waN+o8P9me1WfoS
         jaaEjtZAMly75ED9vq2kP49AiJAxVNKXoi9KKaP1ez27Vmz2iQZWKK2eg72UygIhh/ja
         HjVs+mW8DDJgJ89A3r/hpyihtfH2Vo6ShHE8uFRYYqjFAPYJOyJW6UIzl6aeNia/EgGC
         iULCneoBNMN99/6WSC2rLpaZVVFCI8TdMVy3PomimeeqKQpVA8ImpHFtzhZYvLZlBkju
         QPlWzIiX60aCy7nlGnePM/V7peuBIPz01Va5/ls3NLKWJqlKa54Cm8siGPRSwRTYHlzo
         6NfQ==
X-Gm-Message-State: APjAAAWXShth/6YNoidlZAYsTSLsIK4onSh7cTHF93TbljuZVRM7Ic5E
        29TexXyz7odNFV5oCcytyYk=
X-Google-Smtp-Source: APXvYqxCQ1gO0RFQCm3LYhHssEc/WWTT739kqm7H0+y907AL2LyMliOBNVegRIfkjkERSiHsBmW5DA==
X-Received: by 2002:a17:902:ba0c:: with SMTP id j12mr1008012pls.203.1576037305037;
        Tue, 10 Dec 2019 20:08:25 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id m127sm596533pfm.167.2019.12.10.20.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 20:08:24 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     sjpark@amazon.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, xen-devel@lists.xenproject.org,
        SeongJae Park <sjpark@amazon.de>, sj38.park@gmail.com
Subject: Re: Re: [PATCH v5 2/2] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Wed, 11 Dec 2019 05:08:12 +0100
Message-Id: <20191211040812.12354-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <20191210110432.GG980@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 10 Dec 2019 12:04:32 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> > Each `blkif` has a free pages pool for the grant mapping.  The size of
> > the pool starts from zero and be increased on demand while processing
> > the I/O requests.  If current I/O requests handling is finished or 100
> > milliseconds has passed since last I/O requests handling, it checks and
> > shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> > 
> > Therefore, `blkfront` running guests can cause a memory pressure in the
> > `blkback` running guest by attaching a large number of block devices and
> > inducing I/O.
> 
> Hm, I don't think this is actually true. blkfront cannot attach an
> arbitrary number of devices, blkfront is just a frontend for a device
> that's instantiated by the Xen toolstack, so it's the toolstack the one
> that controls the amount of PV block devices.

Right, the problem can occur only if it is mis-configured so that the frontend
running guests can attach a large number of devices which is enough to cause
the memory pressure.  I tried to explain it in below paragraph, but seems above
paragraph is a little bit confusing.  I will wordsmith the sentence in the next
version.

> 
> > System administrators can avoid such problematic
> > situations by limiting the maximum number of devices each guest can
> > attach.  However, finding the optimal limit is not so easy.  Improper
> > set of the limit can results in the memory pressure or a resource
> > underutilization.  This commit avoids such problematic situations by
> > squeezing the pools (returns every free page in the pool to the system)
> > for a while (users can set this duration via a module parameter) if a
> > memory pressure is detected.
> > 
> > Discussions
> > ===========
> > 
> > The `blkback`'s original shrinking mechanism returns only pages in the
> > pool, which are not currently be used by `blkback`, to the system.  In
> > other words, the pages are not mapped with foreign pages.  Because this
>                         ^ that               ^ granted
> > commit is changing only the shrink limit but uses the mechanism as is,
> > this commit does not introduce improper mappings related security
> > issues.
> 
> That last sentence is hard to parse. I think something like:
> 
> "Because this commit is changing only the shrink limit but still uses the
> same freeing mechanism it does not touch pages which are currently
> mapping grants."
> 
> > 
> > Once a memory pressure is detected, this commit keeps the squeezing
> > limit for a user-specified time duration.  The duration should be
> > neither too long nor too short.  If it is too long, the squeezing
> > incurring overhead can reduce the I/O performance.  If it is too short,
> > `blkback` will not free enough pages to reduce the memory pressure.
> > This commit sets the value as `10 milliseconds` by default because it is
> > a short time in terms of I/O while it is a long time in terms of memory
> > operations.  Also, as the original shrinking mechanism works for at
> > least every 100 milliseconds, this could be a somewhat reasonable
> > choice.  I also tested other durations (refer to the below section for
> > more details) and confirmed that 10 milliseconds is the one that works
> > best with the test.  That said, the proper duration depends on actual
> > configurations and workloads.  That's why this commit is allowing users
>                                                         ^ allows
> > to set it as their optimal value via the module parameter.
> 
> ... to set the duration as a module parameter.

Thank you for great suggestions, I will apply those.

> 
> > 
> > Memory Pressure Test
> > ====================
> > 
> > To show how this commit fixes the memory pressure situation well, I
> > configured a test environment on a xen-running virtualization system.
> > On the `blkfront` running guest instances, I attach a large number of
> > network-backed volume devices and induce I/O to those.  Meanwhile, I
> > measure the number of pages that swapped in and out on the `blkback`
> > running guest.  The test ran twice, once for the `blkback` before this
> > commit and once for that after this commit.  As shown below, this commit
> > has dramatically reduced the memory pressure:
> > 
> >                 pswpin  pswpout
> 
> I assume pswpin means 'pages swapped in' and pswpout 'pages swapped
> out'. Might be good to add a note to that effect.

Good point!  I will add the note.

> 
> >     before      76,672  185,799
> >     after          212    3,325
> > 
> > Optimal Aggressive Shrinking Duration
> > -------------------------------------
> > 
> > To find a best squeezing duration, I repeated the test with three
> > different durations (1ms, 10ms, and 100ms).  The results are as below:
> > 
> >     duration    pswpin  pswpout
> >     1           852     6,424
> >     10          212     3,325
> >     100         203     3,340
> > 
> > As expected, the memory pressure has decreased as the duration is
> > increased, but the reduction stopped from the `10ms`.  Based on this
> > results, I chose the default duration as 10ms.
> > 
> > Performance Overhead Test
> > =========================
> > 
> > This commit could incur I/O performance degradation under severe memory
> > pressure because the squeezing will require more page allocations per
> > I/O.  To show the overhead, I artificially made a worst-case squeezing
> > situation and measured the I/O performance of a `blkfront` running
> > guest.
> > 
> > For the artificial squeezing, I set the `blkback.max_buffer_pages` using
> > the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
> > the value to `1024` and `0`.  The `1024` is the default value.  Setting
> > the value as `0` is same to a situation doing the squeezing always
> > (worst-case).
> > 
> > For the I/O performance measurement, I use a simple `dd` command.
> > 
> > Default Performance
> > -------------------
> > 
> >     [dom0]# echo 1024 > /sys/module/xen_blkback/parameters/max_buffer_pages
> >     [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 13.8827 s, 38.7 MB/s
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 13.8781 s, 38.7 MB/s
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 13.8737 s, 38.7 MB/s
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 13.8702 s, 38.7 MB/s
> > 
> > Worst-case Performance
> > ----------------------
> > 
> >     [dom0]# echo 0 > /sys/module/xen_blkback/parameters/max_buffer_pages
> >     [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 13.878 s, 38.7 MB/s
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 13.8746 s, 38.7 MB/s
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 13.8786 s, 38.7 MB/s
> >     131072+0 records in
> >     131072+0 records out
> >     536870912 bytes (537 MB) copied, 13.8749 s, 38.7 MB/s
> > 
> > In short, even worst case squeezing makes no visible performance
> > degradation.
> 
> I would argue that with a ~40MB/s throughput you won't see any
> performance difference at all regardless of the size of the pool of
> free pages or the amount of persistent grants because the bottleneck is
> on the storage performance itself.
> 
> You need to test this using nullblk or some kind of fast storage, or
> else the above figures are not going to reflect any changes you make
> because they are hidden by the poor performance of the underlying
> storage.

Yes, agree that.  My test is just a minimal check for my environment.  I will
note the points and concerns in the commit message.

> 
> > I think this is due to the slow speed of the I/O.  In
> > other words, the additional page allocation overhead is hidden under the
> > much slower I/O latency.
> > 
> > Nevertheless, pleaset note that this is just a very simple and minimal
> > test.
> 
> I would like to add that IMO this is papering over an existing issue,
> which is how pages to be used to map grants are allocated. Grant
> mappings _shouldn't_ consume RAM pages in the first place, and IIRC
> the fact that they do is because Linux balloons out memory in order to
> re-use those pages to map grants and have a valid page struct.
> 
> A way to solve this would be to hotplug a fake memory region and use
> it in order to map grant pages, without having to balloon out RAM
> regions. At the end of day on a PV domain mapping a grant should just
> require virtual address space.
> 
> This is going to get even worse for PVH that requires a physical memory
> address in order to map a grant, but that's another story.

Yes, as Paul also pointed out and suggested, we should consider a structural
solution in a big picture.  Until the big change is ready, this simple solution
would work as a point fix.

> 
> > 
> > Reviewed-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  drivers/block/xen-blkback/blkback.c | 23 +++++++++++++++++++++--
> >  drivers/block/xen-blkback/common.h  |  1 +
> >  drivers/block/xen-blkback/xenbus.c  |  3 ++-
> >  3 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> > index fd1e19f1a49f..4d4dba7ea721 100644
> > --- a/drivers/block/xen-blkback/blkback.c
> > +++ b/drivers/block/xen-blkback/blkback.c
> > @@ -142,6 +142,22 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
> >  		HZ * xen_blkif_pgrant_timeout);
> >  }
> >  
> > +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> > +static int xen_blkif_buffer_squeeze_duration_ms = 10;
> 
> unsigned?

Good eye!

> 
> You can likely drop the xen_blkif prefix since this is a static
> variable.

You're right!  I will also remove the prefix for other static variables, too.

> 
> > +module_param_named(buffer_squeeze_duration_ms,
> > +		xen_blkif_buffer_squeeze_duration_ms, int, 0644);
> > +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> > +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> > +
> > +static unsigned long xen_blk_buffer_squeeze_end;
> > +
> > +unsigned xen_blkbk_reclaim(struct xenbus_device *dev)
> > +{
> > +	xen_blk_buffer_squeeze_end = jiffies +
> > +		msecs_to_jiffies(xen_blkif_buffer_squeeze_duration_ms);
> > +	return 0;
> > +}
> > +
> >  static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
> >  {
> >  	unsigned long flags;
> > @@ -656,8 +672,11 @@ int xen_blkif_schedule(void *arg)
> >  			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
> >  		}
> >  
> > -		/* Shrink if we have more than xen_blkif_max_buffer_pages */
> > -		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
> > +		/* Shrink the free pages pool if it is too large. */
> > +		if (time_before(jiffies, xen_blk_buffer_squeeze_end))
> > +			shrink_free_pagepool(ring, 0);
> > +		else
> > +			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
> >  
> >  		if (log_stats && time_after(jiffies, ring->st_print))
> >  			print_stats(ring);
> > diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
> > index 1d3002d773f7..c0334cda79fe 100644
> > --- a/drivers/block/xen-blkback/common.h
> > +++ b/drivers/block/xen-blkback/common.h
> > @@ -383,6 +383,7 @@ irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
> >  int xen_blkif_schedule(void *arg);
> >  int xen_blkif_purge_persistent(void *arg);
> >  void xen_blkbk_free_caches(struct xen_blkif_ring *ring);
> > +unsigned xen_blkbk_reclaim(struct xenbus_device *dev);
> >  
> >  int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
> >  			      struct backend_info *be, int state);
> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > index b90dbcd99c03..de49a09e6933 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -1115,7 +1115,8 @@ static struct xenbus_driver xen_blkbk_driver = {
> >  	.ids  = xen_blkbk_ids,
> >  	.probe = xen_blkbk_probe,
> >  	.remove = xen_blkbk_remove,
> > -	.otherend_changed = frontend_changed
> > +	.otherend_changed = frontend_changed,
> > +	.reclaim = xen_blkbk_reclaim
> 
> While at it please add the ending comma so that new addition don't
> have to modify the previous line.

Yes, I will add the comma!


Thanks,
SeongJae Park

> 
> Thanks, Roger.
> 
> 

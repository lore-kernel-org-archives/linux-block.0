Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99C1C433E0
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 02:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7780964F8E
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 02:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhCLCJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLCIj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 21:08:39 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2CC061574;
        Thu, 11 Mar 2021 18:08:39 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t26so14862803pgv.3;
        Thu, 11 Mar 2021 18:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79YGAxuRyjMyQxyWZDF0TDTD3u6wj5U3ba9TjFbFALE=;
        b=oh8MxH0rBZ4t/PYi7xql3NLChmO2awCHSlfRylSHYGzVEWArBCmCnPnwCRZuGcxWex
         +AM+/cg/AUJYzzsuGeOUlH2xz/oX7XIWnOht02gJm0Si1bwltVznkBJ5q0guii/cxyPh
         xxQNJTQ5W+nj6WYgyTJWDnZpEZRPwOvV4s0Ji2VbMXBqAP07WalbkMxUzt4HMX1izwO5
         EgO1jx8XafdOgjAEp5jKPAVcyioI33P3HEaorhUVt0u1jkFl6ylai062QYqSLAtmShcI
         OH6hseSjVBBvgeuMAminZ42nYpKG2aYxog1Wr2sRkSVxDJXdX7Ypz8MCvjFpzsWx1xiS
         NfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=79YGAxuRyjMyQxyWZDF0TDTD3u6wj5U3ba9TjFbFALE=;
        b=SGO2C/yYzKVhQOe4Q8NwRe592LSE6tGuzCe9ElDCWsS7rn816I+j6y36wd+EBaLafB
         /kJNJBBvagfAKrPNxD2q+VOfY5DbjLPxb/+uX/Vea7Q4N5tQ/u+AbAbfkMLzHqf9jq6R
         zvWFU0VNgkM5eB00qBVLkORA4rjKQmz7AOBGyZc/cLvj8muEUOA0vdlpFJN9kZ41b9+X
         tcBgvtCHOgBjN7Emifmri+D54HyFA8CZt4f0JMlHz0RSI7Hafi1eq1TSwbk6rOBixVIT
         ncfwDiO2w1phjamV501cjSNglBrMvz6N+fI8kUB0Y5GSC3ZL7kH+NGV+43CdvCgxDGPi
         fmag==
X-Gm-Message-State: AOAM531Ge40mkmi6X2c5UAkEHK+diY1yULUBZbemONNhTjiyQIMJekw6
        XrCmgoM7hNqejhzowMqty4k=
X-Google-Smtp-Source: ABdhPJxgy3Ue2AQjrurX88QF43Fcud7eYoA3UjVdBZNQ21tCuDSfd9kIR8NZ4IvnRczgvew0YZVxzQ==
X-Received: by 2002:a62:43:0:b029:1cd:2de2:5a24 with SMTP id 64-20020a6200430000b02901cd2de25a24mr9972822pfa.27.1615514918709;
        Thu, 11 Mar 2021 18:08:38 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id r16sm3646887pfq.211.2021.03.11.18.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:08:37 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 11 Mar 2021 18:08:35 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YErNI4mv5sK613ed@google.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310131115.GQ4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310131115.GQ4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 10, 2021 at 01:11:15PM +0000, Luis Chamberlain wrote:
> On Mon, Mar 08, 2021 at 06:55:30PM -0800, Minchan Kim wrote:
> > On Sat, Mar 06, 2021 at 02:20:34AM +0000, Luis Chamberlain wrote:
> > > The zram driver makes use of cpu hotplug multistate support,
> > > whereby it associates a zram compression stream per CPU. To
> > > support CPU hotplug multistate a callback enabled to allow
> > > the driver to do what it needs when a CPU hotplugs.
> > > 
> > > It is however currently possible to end up removing the
> > > zram driver callback prior to removing the zram compression
> > > streams per CPU. This would leave these compression streams
> > > hanging.
> > > 
> > > We need to fix ordering for driver load / removal, zram
> > > device additions, in light of the driver's use of cpu
> > > hotplug multistate. Since the zram driver exposes many
> > > sysfs attribute which can also muck with the comrpession
> > > streams this also means we can hit page faults today easily.
> > 
> > Hi Luis,
> > 
> > First of all, thanks for reporting the ancient bugs.
> > 
> > Looks like you found several bugs and I am trying to digest them
> > from your description to understand more clear. I need to ask
> > stupid questions, first.
> > 
> > If I understand correctly, bugs you found were related to module
> > unloading race while the zram are still working.
> > If so, couldn't we fix the bug like this(it's not a perfect
> > patch but just wanted to show close module unloading race)?
> > (I might miss other pieces here. Let me know. Thanks!)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index a711a2e2a794..646ae9e0b710 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1696,6 +1696,8 @@ static void zram_reset_device(struct zram *zram)
> >                 return;
> >         }
> > 
> > +       module_put(THIS_MODULE);
> > +
> >         comp = zram->comp;
> >         disksize = zram->disksize;
> >         zram->disksize = 0;
> > @@ -1744,13 +1746,19 @@ static ssize_t disksize_store(struct device *dev,
> >                 goto out_free_meta;
> >         }
> > 
> > +       if (!try_module_get(THIS_MODULE))
> > +               goto out_free_zcomp;
> > +
> >         zram->comp = comp;
> >         zram->disksize = disksize;
> > +
> >         set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
> >         up_write(&zram->init_lock);
> > 
> >         return len;
> > 
> > +out_free_zcomp:
> > +       zcomp_destroy(comp);
> >  out_free_meta:
> >         zram_meta_free(zram, disksize);
> >  out_unlock:
> 
> This still allows for a crash on the driver by running the zram02.sh script twice.
> 
> Mar 09 14:52:19 kdevops-blktests-block-dev kernel: zram0: detected capacity change from 209715200 to 0
> Mar 09 14:52:19 kdevops-blktests-block-dev kernel: BUG: unable to handle page fault for address: ffffba7db7904008
> Mar 09 14:52:19 kdevops-blktests-block-dev kernel: #PF: supervisor read access in kernel mode
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: #PF: error_code(0x0000) - not-present page
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: PGD 100000067 P4D 100000067 PUD 100311067 PMD 14cd2f067 PTE 0
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Oops: 0000 [#1] SMP NOPTI
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: CPU: 0 PID: 2137 Comm: zram02.sh Tainted: G            E     5.12.0-rc1-next-20210304+ #4
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RIP: 0010:zram_free_page+0x1b/0xf0 [zram]
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Code: 1f 44 00 00 48 89 c8 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 54 49 89 f4 55 89 f5 53 48 8b 17 48 c1 e5 04 48 89 f>
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RSP:0018:ffffba7d808f3d88 EFLAGS: 00010286
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RAX: 0000000000000000 RBX: ffff9eee5317d200 RCX: 0000000000000000
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RDX: ffffba7db7904000 RSI: 0000000000000000 RDI: ffff9eee5317d200
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RBP: 0000000000000000 R08: 00000008f78bb1d3 R09: 0000000000000000
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000000
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: R13: ffff9eee53d4cb00 R14: ffff9eee5317d220 R15: ffff9eee70508b80
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: FS: 00007f4bb1482580(0000) GS:ffff9eef77c00000(0000) knlGS:0000000000000000
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: CR2: ffffba7db7904008 CR3: 0000000107e9c000 CR4: 0000000000350ef0
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Call Trace:
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: zram_reset_device+0xe9/0x150 [zram]
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: reset_store+0x9a/0x100 [zram]
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: kernfs_fop_write_iter+0x124/0x1b0
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: new_sync_write+0x11c/0x1b0
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: vfs_write+0x1c2/0x260
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel:  ksys_write+0x5f/0xe0
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: do_syscall_64+0x33/0x80
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RIP: 0033:0x7f4bb13aaf33
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00
> 00 00 85 c0 75 14 b8 01 00 0>
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RSP: 002b:00007ffce0090d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RAX: ffffffffffffffda RBX: 000055a17c4a14b0 RCX: 00007f4bb13aaf33
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RDX: 0000000000000002 RSI: 000055a17c4a14b0 RDI: 0000000000000001
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: RBP: 0000000000000002 R08: 000055a17c48a1d0 R09: 0000000000000000
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: R10: 000055a17c48a1d1 R11: 0000000000000246 R12: 0000000000000001
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: R13: 0000000000000002 R14: 7fffffffffffffff R15: 0000000000000000
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: Modules linked in: zram(E) zsmalloc(E) xfs(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) joydev(E) evdev(>
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: zram0: detected capacity change from 0 to 209715200
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: CR2: ffffba7db7904008
> Mar 09 14:52:20 kdevops-blktests-block-dev kernel: ---[ end trace 534ee1d0b880dd90 ]---
> 
> I can try to modify it to include second patch first, as that is
> required. There are two separate bugs here. Or was your goalt to
> try to address both with only one patch?

I am trying to understand problem first.

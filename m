Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B8CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbiEaTtq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 15:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiEaTtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 15:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEF89DF93
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654026584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0EN/5SY1qJWxsPIwoglrC1Ernms6akAtpsVUl0LZS4=;
        b=b9R7aZyucdVcDo77ZINKzunbIH4EaM4NM1u2CmXN4648QaUjkInRT7ws2H50Z7qzxVfMVR
        2yqx7Dl49YDRJr2FKhetUYyuw3qRYXzzWmlQqglEEfZdeuOqt+TyRlgSGC6DD+wSg0ORHV
        sfzkHXaERigV9/7ygizEgiHbTXi9EWU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-1pxvdqsIN96bcIxDzfU9gA-1; Tue, 31 May 2022 15:49:42 -0400
X-MC-Unique: 1pxvdqsIN96bcIxDzfU9gA-1
Received: by mail-qk1-f199.google.com with SMTP id x9-20020a05620a14a900b006a32ca95a72so11240465qkj.22
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 12:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0EN/5SY1qJWxsPIwoglrC1Ernms6akAtpsVUl0LZS4=;
        b=p3mph8tMICsy2fCBuYmsDSJM+3WByPKLYBk2lNcRAi82LeByIS5yq3F4cooZkeulkj
         FfEfRwTiuPRijMH0J2N3yEtIVmUjtQ0t74YOqw8ftfjZF1EWrd87wuDHzWojvasJuj/b
         ZYlkKcC/YDnn2eK0NkQsjaC7T0iZ1YakKTihoU2bA1E8lRuNl0RBUaLDByY+7Ev/wvmL
         x43tT5oZoks+Qs9tMz1N7/UoT0uT2vcVFa94P1/W/Etsar0wtkj0YcpEilJ0SVyicvus
         F6vQIPJMjGMWxzlT3CzQSwWjSWlkX8BK77ycafY6fl7khikvmo+6HB2NgQwrvLkU0Ize
         xmAw==
X-Gm-Message-State: AOAM531REkMgNJ7LIxddivNFhtWJ/1ftzPYyYQSLrZKhE8QdVzIMgEFe
        MbtNVF0iFK0vmmqvuh9Q/AAEyppcRsniNmdeG5MhDSwN/t2uI8CY1fjmtUaMyuvunbTAVZVsr4Q
        vGOVvvWedzX0OO7LXSq38Lw==
X-Received: by 2002:a05:620a:298a:b0:6a3:973c:47f with SMTP id r10-20020a05620a298a00b006a3973c047fmr31560999qkp.487.1654026581803;
        Tue, 31 May 2022 12:49:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyufhk9YpAkvU+1m4iZ798e9O97lv/f8IDT98qzkSTmMEXMhzDkCdIxEZcYYSq3iMv8YQ+ySw==
X-Received: by 2002:a05:620a:298a:b0:6a3:973c:47f with SMTP id r10-20020a05620a298a00b006a3973c047fmr31560986qkp.487.1654026581541;
        Tue, 31 May 2022 12:49:41 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o9-20020ac86989000000b002f39b99f689sm9475369qtq.35.2022.05.31.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 12:49:41 -0700 (PDT)
Date:   Tue, 31 May 2022 15:49:40 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
Subject: Re: bioset_exit poison from dm_destroy
Message-ID: <YpZxVH7DRUkrbWUa@redhat.com>
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
 <6995e822-79a0-ca17-9c32-6089d14b5be5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6995e822-79a0-ca17-9c32-6089d14b5be5@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 31 2022 at  3:00P -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 5/31/22 12:58 PM, Mike Snitzer wrote:
> > On Sun, May 29 2022 at  8:46P -0400,
> > Jens Axboe <axboe@kernel.dk> wrote:
> > 
> >> On 5/28/22 6:17 PM, Matthew Wilcox wrote:
> >>> Not quite sure whose bug this is.  Current Linus head running xfstests
> >>> against ext4 (probably not ext4's fault?)
> >>>
> >>> 01818 generic/250	run fstests generic/250 at 2022-05-28 23:48:09
> >>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> >>> 01818 EXT4-fs (dm-0): unmounting filesystem.
> >>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> >>> 01818 EXT4-fs (dm-0): unmounting filesystem.
> >>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> >>> 01818 Buffer I/O error on dev dm-0, logical block 3670000, async page read
> >>> 01818 EXT4-fs (dm-0): unmounting filesystem.
> >>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> >>> 01818 EXT4-fs (dm-0): unmounting filesystem.
> >>> 01818 general protection fault, probably for non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
> >>> 01818 CPU: 0 PID: 1579117 Comm: dmsetup Kdump: loaded Not tainted 5.18.0-11049-g1dec3d7fd0c3-dirty #262
> >>> 01818 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> >>> 01818 RIP: 0010:__cpuhp_state_remove_instance+0xf0/0x1b0
> >>> 01818 Code: a0 f8 d7 81 42 3b 1c 28 7f d9 4c 89 e1 31 d2 89 de 89 7d dc e8 01 fd ff ff 8b 7d dc eb c5 49 8b 04 24 49 8b 54 24 08 48 85 c0 <48> 89 02 74 04 48 89 50 08 48 b8 00 01 00 00 00 00 ad de 48 c7 c7
> >>> 01818 RSP: 0018:ffff888101fcfc60 EFLAGS: 00010286
> >>> 01818 RAX: dead000000000100 RBX: 0000000000000017 RCX: 0000000000000000
> >>> 01818 RDX: dead000000000122 RSI: ffff8881233b0ae8 RDI: ffffffff81e3b080
> >>> 01818 RBP: ffff888101fcfc88 R08: 0000000000000008 R09: 0000000000000003
> >>> 01818 R10: 0000000000000000 R11: 00000000002dc6c0 R12: ffff8881233b0ae8
> >>> 01818 R13: 0000000000000000 R14: ffffffff81e38f58 R15: ffff88817b5a3c00
> >>> 01818 FS:  00007ff56daec280(0000) GS:ffff888275800000(0000) knlGS:0000000000000000
> >>> 01818 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> 01818 CR2: 00005591ad94f198 CR3: 000000017b5a0004 CR4: 0000000000770eb0
> >>> 01818 PKRU: 55555554
> >>> 01818 Call Trace:
> >>> 01818  <TASK>
> >>> 01818  ? kfree+0x66/0x250
> >>> 01818  bioset_exit+0x32/0x210
> >>> 01818  cleanup_mapped_device+0x34/0xf0
> >>> 01818  __dm_destroy+0x149/0x1f0
> >>> 01818  ? table_clear+0xc0/0xc0
> >>> 01818  dm_destroy+0xe/0x10
> >>> 01818  dev_remove+0xd9/0x120
> >>> 01818  ctl_ioctl+0x1cb/0x420
> >>> 01818  dm_ctl_ioctl+0x9/0x10
> >>> 01818  __x64_sys_ioctl+0x89/0xb0
> >>> 01818  do_syscall_64+0x35/0x80
> >>> 01818  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >>> 01818 RIP: 0033:0x7ff56de3b397
> >>> 01818 Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 da 0d 00 f7 d8 64 89 01 48
> >>> 01818 RSP: 002b:00007ffe55367ef8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> >>> 01818 RAX: ffffffffffffffda RBX: 00007ff56df31a8e RCX: 00007ff56de3b397
> >>> 01818 RDX: 000055daad7cab30 RSI: 00000000c138fd04 RDI: 0000000000000003
> >>> 01818 RBP: 00007ffe55367fb0 R08: 00007ff56df81558 R09: 00007ffe55367d60
> >>> 01818 R10: 00007ff56df808a2 R11: 0000000000000206 R12: 00007ff56df808a2
> >>> 01818 R13: 00007ff56df808a2 R14: 00007ff56df808a2 R15: 00007ff56df808a2
> >>> 01818  </TASK>
> >>> 01818 Modules linked in: crct10dif_generic crct10dif_common [last unloaded: crc_t10dif]
> >>
> >> I suspect dm is calling bioset_exit() multiple times? Which it probably
> >> should not.
> >>
> >> The reset of bioset_exit() is resilient against this, so might be best
> >> to include bio_alloc_cache_destroy() in that.
> >>
> >>
> >> diff --git a/block/bio.c b/block/bio.c
> >> index a3893d80dccc..be3937b84e68 100644
> >> --- a/block/bio.c
> >> +++ b/block/bio.c
> >> @@ -722,6 +722,7 @@ static void bio_alloc_cache_destroy(struct bio_set *bs)
> >>  		bio_alloc_cache_prune(cache, -1U);
> >>  	}
> >>  	free_percpu(bs->cache);
> >> +	bs->cache = NULL;
> >>  }
> >>  
> >>  /**
> > 
> > Yes, we need the above to fix the crash.  Does it also make sense to
> > add this?
> > 
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 49eff01fb829..f410c78e9c0c 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -681,7 +681,7 @@ struct bio_set {
> > 
> >  static inline bool bioset_initialized(struct bio_set *bs)
> >  {
> > -	return bs->bio_slab != NULL;
> > +	return (bs->bio_slab != NULL || bs->cache != NULL);
> >  }
> 
> Should not be possible to have valid bs->cache without bs->bio_slab?

Not quite following your question, but I sprinkled this extra check in
purely because DM core uses bioset_initialized() to verify that the
bioset is _not_ yet initialized.

But it really doesn't make sense to consider the bioset _fully_
initialized if bs->bio_slab is NULL but bs->cache is NOT...

Anyway, really don't need this change but we do need your earlier
patch to reset bs->cache to NULL.

Thanks.


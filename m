Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F071C4363D
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 14:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1233C206DB
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601647261;
	bh=rZ44DDCqLqF+ItGzh+HCjnIlsvgMjNd13iwS73Wc8BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EkJaJv3RKmLUJBVV7x23JFnP3//2rsMFAtLxr4XP81ROkeu6OIWTuKBQKRdan1S/R
	 AGsQAcyzjgPQbHktM0l83B/1+uKRBgJV5zD2e8Jj0Ys0WAJcA1+rY//oDayxTbm6Md
	 +O5P15W3DpPWnDCXTcgvtM2JzHrSAirUHU0JX1K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbgJBOBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBOBA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 10:01:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07282206CD;
        Fri,  2 Oct 2020 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601647259;
        bh=rZ44DDCqLqF+ItGzh+HCjnIlsvgMjNd13iwS73Wc8BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkD2Jcn4IL1JDZ4MTf3xPpV2eyD3WRBTryj+6MivDF+unoG88ATQiijwc4dt8lfqr
         9tGx7d+ZoUOaNMM54DmPzaqks8x8JMif1mtxDq3iltdUUOJOIL0JTxDkTyKSaa1omP
         PsljVgMRVugIoOTJTBhRk+VrT01R0yVutM1pbcaU=
Date:   Fri, 2 Oct 2020 16:00:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     syzbot <syzbot+85433a479a646a064ab3@syzkaller.appspotmail.com>,
        axboe@kernel.dk, glider@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Subject: Re: KMSAN: kernel-infoleak in scsi_cmd_ioctl
Message-ID: <20201002140058.GA3475053@kroah.com>
References: <000000000000a24fa705ae29dc6c@google.com>
 <20201002134944.GA8205@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002134944.GA8205@PWN>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 02, 2020 at 09:49:44AM -0400, Peilin Ye wrote:
> On Mon, Aug 31, 2020 at 03:28:22AM -0700, syzbot wrote:
> > BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
> > CPU: 1 PID: 12272 Comm: syz-executor.3 Not tainted 5.8.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x21c/0x280 lib/dump_stack.c:118
> >  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
> >  kmsan_internal_check_memory+0x238/0x3d0 mm/kmsan/kmsan.c:423
> >  kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
> >  instrument_copy_to_user include/linux/instrumented.h:91 [inline]
> >  _copy_to_user+0x18e/0x260 lib/usercopy.c:33
> >  scsi_put_cdrom_generic_arg include/linux/uaccess.h:170 [inline]
> 
> + Cc: Greg Kroah-Hartman
> + Cc: Anant Thazhemadam
> 
> Hi all,
> 
> In looking at the report, I guess this patch should fix the issue, there's
> a 3-byte hole in `struct compat_cdrom_generic_command`:
> 
> [PATCH v3] block/scsi-ioctl: Prevent kernel-infoleak in scsi_put_cdrom_generic_arg()
> https://lore.kernel.org/lkml/20200909095057.1214104-1-yepeilin.cs@gmail.com/
> 
> But I cannot verify it, since syzbot doesn't have a reproducer for it.
> The patch adds a 3-byte padding field to `struct
> compat_cdrom_generic_command`. It hasn't been accepted yet.

Please resend it, it looks like it hasn't been taken yet :(

thanks,

greg k-h

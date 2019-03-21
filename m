Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF1C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98587218E2
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 16:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfCUQen convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:34:43 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38354 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCUQen (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 12:34:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C773D608A3A5;
        Thu, 21 Mar 2019 17:34:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0xYdRvE2D65K; Thu, 21 Mar 2019 17:34:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 67A34608A3B0;
        Thu, 21 Mar 2019 17:34:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uZDAB36d4eG8; Thu, 21 Mar 2019 17:34:41 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A0D7F608A3A5;
        Thu, 21 Mar 2019 17:34:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Nicolas Pitre <nico@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Convert mount_single-using filesystems to fs_context
Date:   Thu, 21 Mar 2019 17:34:40 +0100
Message-ID: <11178040.rrurhZOAV8@blindfold>
In-Reply-To: <19628.1553183102@warthog.procyon.org.uk>
References: <20992998.5BCRIlqCZf@blindfold> <6007.1553181386@warthog.procyon.org.uk> <19628.1553183102@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am Donnerstag, 21. März 2019, 16:45:02 CET schrieb David Howells:
> Richard Weinberger <richard@nod.at> wrote:
> 
> > > Bah.  The problem is that vfs_get_super() doesn't set fc->root before
> > > calling reconfigure_super().
> > 
> > Do you still need the disassembly?
> 
> Thanks, but no.  I've pushed replacement patches to my git branch.

Just gave it a try, jffs2 does not mount anymore. The problem is that you define
an Opt_source in super.c, but never evaluate it -> jffs2_parse_param() returns
-EINVAL.

What I really don't get is the new logging stuff in include/linux/fs_context.h.
printk() is already an overloaded beat, why another layer?

The log output seems very odd to me:
[   13.117593] e MTD: Couldn't look up '/dev/mtd0': -15

Please notice the "e" before MTD, first I though this is a memory
corruption, but is your log level?!

Thanks,
//richard



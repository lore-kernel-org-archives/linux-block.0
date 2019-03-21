Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F1FC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9893218B0
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 17:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCURGa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:06:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCURGa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 13:06:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C66A83086258;
        Thu, 21 Mar 2019 17:06:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D63A85D71C;
        Thu, 21 Mar 2019 17:06:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <11178040.rrurhZOAV8@blindfold>
References: <11178040.rrurhZOAV8@blindfold> <20992998.5BCRIlqCZf@blindfold> <6007.1553181386@warthog.procyon.org.uk> <19628.1553183102@warthog.procyon.org.uk>
To:     Richard Weinberger <richard@nod.at>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Nicolas Pitre <nico@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Convert mount_single-using filesystems to fs_context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26883.1553187985.1@warthog.procyon.org.uk>
Date:   Thu, 21 Mar 2019 17:06:25 +0000
Message-ID: <26884.1553187985@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 21 Mar 2019 17:06:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Richard Weinberger <richard@nod.at> wrote:

> Just gave it a try, jffs2 does not mount anymore. The problem is that you
> define an Opt_source in super.c, but never evaluate it ->
> jffs2_parse_param() returns -EINVAL.

Will fix.

> What I really don't get is the new logging stuff in
> include/linux/fs_context.h.  printk() is already an overloaded beat, why
> another layer?

Because there are some patches that aren't upstream yet that allow you to read
these out through the file descriptor you control the mount process through
rather than them going into dmesg.

> The log output seems very odd to me:
> [   13.117593] e MTD: Couldn't look up '/dev/mtd0': -15
> 
> Please notice the "e" before MTD, first I though this is a memory
> corruption, but is your log level?!

Thanks - I'll fix that.

David

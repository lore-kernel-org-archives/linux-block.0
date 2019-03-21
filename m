Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA40BC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D40218A5
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfCUPpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCUPpG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 11:45:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F493C057F40;
        Thu, 21 Mar 2019 15:45:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6655D5C66D;
        Thu, 21 Mar 2019 15:45:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20992998.5BCRIlqCZf@blindfold>
References: <20992998.5BCRIlqCZf@blindfold> <3463221.D14WHduXq3@blindfold> <155316902426.29884.2476392753144421312.stgit@warthog.procyon.org.uk> <6007.1553181386@warthog.procyon.org.uk>
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
Content-ID: <19627.1553183102.1@warthog.procyon.org.uk>
Date:   Thu, 21 Mar 2019 15:45:02 +0000
Message-ID: <19628.1553183102@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 21 Mar 2019 15:45:06 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Richard Weinberger <richard@nod.at> wrote:

> > Bah.  The problem is that vfs_get_super() doesn't set fc->root before
> > calling reconfigure_super().
> 
> Do you still need the disassembly?

Thanks, but no.  I've pushed replacement patches to my git branch.

David

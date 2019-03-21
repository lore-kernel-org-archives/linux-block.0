Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE90C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BEF20830
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfCUPM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:12:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfCUPM4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 11:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 982FF307B96A;
        Thu, 21 Mar 2019 15:12:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4E2B19C57;
        Thu, 21 Mar 2019 15:12:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3463221.D14WHduXq3@blindfold>
References: <3463221.D14WHduXq3@blindfold> <155316902426.29884.2476392753144421312.stgit@warthog.procyon.org.uk>
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
Content-ID: <5778.1553181171.1@warthog.procyon.org.uk>
Date:   Thu, 21 Mar 2019 15:12:52 +0000
Message-ID: <5779.1553181172@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 21 Mar 2019 15:12:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Richard Weinberger <richard@nod.at> wrote:

> [    6.004504] RIP: 0010:reconfigure_super+0x17/0x1e0

Can you load the kernel into gdb and do:

	i li *reconfigure_super+0x17

and disassemble the first 32 bytes of that function for me?

> Do I miss some other fix?

Don't think so - I hadn't noticed that it had oopsed since the crash was lost
in the log and it seemed to have booted otherwise normally.

Note that I don't know if a lot of the filesystems I've converted work because
I don't have a way to test all of them.


David

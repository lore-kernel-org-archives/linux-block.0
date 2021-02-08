Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3887BC433E9
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 21:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E310464E45
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 21:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhBHVDX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:03:23 -0500
Received: from gardel.0pointer.net ([85.214.157.71]:34884 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbhBHVDJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Feb 2021 16:03:09 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2021 16:03:07 EST
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 175BFE809B2;
        Mon,  8 Feb 2021 21:55:15 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id AA8901603F5; Mon,  8 Feb 2021 21:55:14 +0100 (CET)
Date:   Mon, 8 Feb 2021 21:55:14 +0100
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Boccassi <bluca@debian.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/5] block: add a sequence number to disks
Message-ID: <20210208205514.GA46668@gardel-login>
References: <20210206000903.215028-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206000903.215028-1-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sa, 06.02.21 01:08, Matteo Croce (mcroce@linux.microsoft.com) wrote:

> From: Matteo Croce <mcroce@microsoft.com>
>
> With this series a monotonically increasing number is added to disks,
> precisely in the genhd struct, and it's exported in sysfs and uevent.
>
> This helps the userspace correlate events for devices that reuse the
> same device, like loop.
>
> The first patch is the core one, the 2..4 expose the information in
> different ways, while the last one increase the sequence number for
> loop devices at every attach.

Patch set looks excellent to me. This would be great to have for the
systems project, as it would allow us to fix some major races around
loop device allocation, that are relatively easily triggered on loaded
systems.

Lennart

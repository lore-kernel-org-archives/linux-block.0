Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F47C433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 11:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51288207C3
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 11:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Il3HXSPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgFKLUi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:20:38 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:49594 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgFKLUh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 07:20:37 -0400
IronPort-SDR: TRlUY6Sbw6GBO2PUyaGsRLL3BOYH+iccJ/vi5DyPw98yEi1khuYV639z6MOp84Sr21bmx45RjB
 gp6VmhXap1miX9P7tf2DvnMcqxNirTE/I+UZmCWGLnv9bXRE70ZHn2HB8A15QhywkPkFCsyjW8
 aufMr285bDtat7ldY3kXFMJWCG9t7p3beR3EtCmZMiqcN/pEnEaED3qt44tckgMwCbdiWnbc59
 T75Feji9NfFv1Mdl9KW3dCXn4d8YM6BsYjEu+s7ZSzJXpmOPzsdb3GQJKsc05Vy3jk1QaZrX76
 omQ=
X-IronPort-AV: E=Sophos;i="5.73,499,1583190000"; 
   d="scan'208";a="12649134"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Jun 2020 13:20:32 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 11 Jun 2020 13:20:32 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 11 Jun 2020 13:20:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591874432; x=1623410432;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ucvXkYYt7tPx+/jxBJ3kWXHMAb4QHM7JJ1bBSklbroU=;
  b=Il3HXSPNoqV4h0Bj6C4G2Lm30B0tUYye7yhBpn5+WhKmA5CPxJna4CkA
   lgYqgnNadti+7d+Dumorl3GKD5+WZQVuyNWIxmLDXZRtWAXpWyvYbbHpj
   ZvJjRrzhej4SkCS7sf54+uobL0ZrenXPbr/Nlgj4k01WohruK4hOs0ywd
   7Yss3U7CqeeSq/J99M5jTol0b0S4BemWlntfqJwrhkC38YFPj0wyxGw1T
   5tjpW2y3J91AlU7erYhbD0zMJHoamZFbp9S4w4ya0CesrvFEs4m9XkNvL
   2i0msZN2GnqlUBfUNEjueQfm68NvYdh3pwQxiMKkMS1iUr2DBC6cT5zLN
   g==;
IronPort-SDR: id5UekctAs1cKGw03oHNfmPm++wv/9AyR2WgCFVEMSiQV/BSVf09oUtHs3gFYtLoZJqmDQqnPu
 HILsQ4+zt9AcZ/1XgHoDER8CPGZIgpWX3wF/t3oBtt5UQT8IKqKijeQwpKqi11T8xnKBkxdxdC
 ymkHY4KOIqUmQST00l72Csp9ld9tWfYmMq03jNT5s/3bW7S16KNle6dnUce2DT7dSF1g2PfPon
 5BX4ui8Yeau6S0RU5NH2ChJ8500RtM2XdxAraSWZQgAkDGVcREmJ0GApYZaPGgK5e9W9XDwKJ/
 Ybc=
X-IronPort-AV: E=Sophos;i="5.73,499,1583190000"; 
   d="scan'208";a="12649133"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Jun 2020 13:20:32 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B3679280065;
        Thu, 11 Jun 2020 13:20:33 +0200 (CEST)
Message-ID: <cfcec3df57e6dd5ef353ef3a5b4b9793c28eb401.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: Consistent block device references for root= cmdline
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jun 2020 13:20:30 +0200
In-Reply-To: <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com>
References: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com>
         <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2020-06-10 at 16:52 +0200, Ulf Hansson wrote:
> On Wed, 10 Jun 2020 at 15:15, Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> > 
> > Hello all,
> > 
> > there have been numerous attempts to make the numbering of mmcblk
> > devices consistent, mostly by using aliases from the DTS ([1], [2],
> > [3]), but all have been (rightfully) rejected. Unless I have
> > overlooked
> > a more recent development, no attempts for a different solution
> > were
> > made.
> 
> According to aliases attempts, I think those have failed, mainly
> because of two reasons.
> 
> 1. Arguments stating that LABELs/UUIDs are variable alternatives.
> This
> isn't the case, which I think was also concluded from the several
> earlier discussions.
> 2. Patches that tried adding support for mmc aliases, were not
> correctly coded. More precisely, what needs to be addressed is that
> the mmc core also preserves the same ids to be set for the host class
> as the block device, mmc[n] must correspond to mmcblk[n].
> 
> > 
> > As far as I can tell, the core of the issue seems to be the
> > following:
> > 
> > The existing solutions like LABELs and UUIDs are viable
> > alternatives in
> > many cases, but in particular on embedded systems, this is not
> > quite
> > sufficient: In addition to the problem that more knowledge about
> > the
> > system to boot is required in the bootloader, this approach fails
> > completely when the same firmware image exists on multiple devices,
> > for
> > example on an eMMC and an SD card - not an entirely uncommon
> > situation
> > during the development of embedded systems.
> > 
> > With udev, I can refer to a specific partition using a path like
> > /dev/disk/by-path/platform-2194000.usdhc-part2. In [4] it was
> > proposed
> > to add a way to refer to a device path/phandle from the kernel
> > command
> > line. Has there been any progress on this proposal?
> 
> Lots of time during the years I have been approached, both publicly
> and offlist, about whether it would be possible to add support for
> "consistent" mmcblk devices. To me, I am fine with the aliases
> approach, as long as it gets implemented correctly.


It seems the principal technical problem is the one described here:

https://www.spinics.net/lists/linux-mmc/msg26602.html

I don't see any way to solve this completely, as there seem to be two
fundamentally conflicting requirements:

1) If a mounted SD card is replaced, it must be assigned a new
/dev/mmcblkN
2) /dev/mmcblkN should always match the configured alias IDs

What is the reason we need 1) - is it possible to have multiple eMMCs
or SD cards on a single bus, with detection at runtime? Otherwise I'd
expect this to be handled like other drives with removable media (CD,
floppy), with static device assignment.

If we can't give up on 1) for some reason, we'll have to accept that we
can't guarantee 2) unconditionally. As far as I can tell, the patches
provided by Sascha and others did that in a reasonable way: The aliases
would work in most cases - in particular for the first assignment on
boot, which is required to find the correct rootfs.

> 
> > 
> > Kind regards,
> > Matthias
> > 
> > 
> > [1] https://patchwork.kernel.org/patch/8685711/
> > [2] https://lore.kernel.org/patchwork/cover/674381/
> > [3] https://www.spinics.net/lists/linux-mmc/msg26586.html
> > [4] https://www.spinics.net/lists/linux-mmc/msg26708.html
> > 
> 
> Kind regards
> Uffe


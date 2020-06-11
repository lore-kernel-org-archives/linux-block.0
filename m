Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12126C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 11:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2462207ED
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 11:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="D5T4hJX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgFKLXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:23:18 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:38499 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgFKLXR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 07:23:17 -0400
IronPort-SDR: K/Fz8CzlNt0Sls90ffuamuQjdSAoeVs7WX5hKr1ZBOkWQHFga6tKQnGVdxAzyMk1J4tcbGxHqO
 kaq1IvkTFeXrBYxArTZiUbQkglQeCpcMVS/12QTfBy5x9AqyTgA5Oq7+28d7SGFUeB1OiBjQR2
 /rdNw7GD3pkbTZlZVxfrJcYXEfGbIiPjarLoTWONiyeoPe9/L5xjE2I7OM9KbQXWduSHaY3jbL
 YRgptM+9AlPZPirWGJprS1utvicTg4hLbKkHkGUMRVv25HZDhnDCT+TrPyLyxuv+ks8OvTMtqc
 Rdk=
X-IronPort-AV: E=Sophos;i="5.73,499,1583190000"; 
   d="scan'208";a="12649147"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Jun 2020 13:23:15 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 11 Jun 2020 13:23:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 11 Jun 2020 13:23:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591874595; x=1623410595;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/lgEa4ngwESBUIJx1nHCkPgKmQSKt9J/YaWqXauyUY=;
  b=D5T4hJX4FEoWAS/wvQwynmTaIeqQvuskhlM/PDu4E80stFfhaKrNz7wJ
   Ur4lAhKPqW2ZXa8EQrNmEWXqifmPoXr2J1WLASGunUA56/rlfu7xAgy1L
   IIYLgruaulVukYN4Fvjexg4rmBadBNhGVsK9yv8H2tWF6gom+OXPDcgJV
   z94gAaQWH2wVw9kS8MsbAGRJsZmdhWJFqEm/1oKRBmJPAG4su3HzlDSh9
   2oaA1rm2XwrNeU0q5EVsmcdgjtR6P/TWf1YtMEUU9Zd8QA4oeO/UVHfmO
   hVpRACaBVuomaI8rRSRxEFBYLIgoFb8efJfDIL27wEAQeBkB+Ck28n71E
   A==;
IronPort-SDR: BBPnzRjo5PtKvM3sAoKKY/91efyUw36B8KUb3x0FrhdKvXoii3SYRfpW7ffwNcSyL31qRBh+25
 93tfMfF8KK971BnNFi8HBA2zNHw4d5Q/LpoBqvKBL0D7/LWsMXvyflargHSdF9tvMy412WYp0U
 piWfYYQ/tVpSOWWAmy97dwF4HwmFcqbkpY4E7z62bwPoFcq38frXok8ntIUtIniAIiOq1TWzVy
 z9gDwgSmhmj+IUhtx6JVmaepfaAcEYtcWba8z1yj8b+A1hhjI4VIO0jvWyPc71x7DIEjFV1EOS
 hQo=
X-IronPort-AV: E=Sophos;i="5.73,499,1583190000"; 
   d="scan'208";a="12649146"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Jun 2020 13:23:15 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C7DCE280065;
        Thu, 11 Jun 2020 13:23:16 +0200 (CEST)
Message-ID: <0637641b8872a84481f5177876893cd1543a0d0b.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: Consistent block device references for root= cmdline
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Roger Heflin <rogerheflin@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Jun 2020 13:23:13 +0200
In-Reply-To: <CAAMCDef2g8t5u1GuVH7p4bM1C7UMsC=fV4RKGU9jSG1rScPc9g@mail.gmail.com>
References: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com>
         <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com>
         <CAAMCDef2g8t5u1GuVH7p4bM1C7UMsC=fV4RKGU9jSG1rScPc9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2020-06-10 at 12:33 -0500, Roger Heflin wrote:
> No idea if this would still work, but back before label/uuid and lvm
> in initird I had a staticly linked "C" program that ran inside
> initrd,
> it searched for likely places a boot device could be (mounted them
> and
> looked for a file to confirm it was the right device, then unmounted
> it), and when it found the right one, it then echo's is major/minor
> numbers into /proc/sys/kernel/real-root-dev and that is used for
> root=
> without it being on the command line.  Assuming you could get
> something similar started by sytemd and/or udev inside the initrd it
> might still work.

Using an initramfs is obviously an option, but it complicates both the
build setup and boot process, so we would like to avoid making this a
hard requirement if possible.


> 
> On Wed, Jun 10, 2020 at 11:51 AM Ulf Hansson <ulf.hansson@linaro.org>
> wrote:
> > 
> > On Wed, 10 Jun 2020 at 15:15, Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> wrote:
> > > 
> > > Hello all,
> > > 
> > > there have been numerous attempts to make the numbering of mmcblk
> > > devices consistent, mostly by using aliases from the DTS ([1],
> > > [2],
> > > [3]), but all have been (rightfully) rejected. Unless I have
> > > overlooked
> > > a more recent development, no attempts for a different solution
> > > were
> > > made.
> > 
> > According to aliases attempts, I think those have failed, mainly
> > because of two reasons.
> > 
> > 1. Arguments stating that LABELs/UUIDs are variable alternatives.
> > This
> > isn't the case, which I think was also concluded from the several
> > earlier discussions.
> > 2. Patches that tried adding support for mmc aliases, were not
> > correctly coded. More precisely, what needs to be addressed is that
> > the mmc core also preserves the same ids to be set for the host
> > class
> > as the block device, mmc[n] must correspond to mmcblk[n].
> > 
> > > 
> > > As far as I can tell, the core of the issue seems to be the
> > > following:
> > > 
> > > The existing solutions like LABELs and UUIDs are viable
> > > alternatives in
> > > many cases, but in particular on embedded systems, this is not
> > > quite
> > > sufficient: In addition to the problem that more knowledge about
> > > the
> > > system to boot is required in the bootloader, this approach fails
> > > completely when the same firmware image exists on multiple
> > > devices, for
> > > example on an eMMC and an SD card - not an entirely uncommon
> > > situation
> > > during the development of embedded systems.
> > > 
> > > With udev, I can refer to a specific partition using a path like
> > > /dev/disk/by-path/platform-2194000.usdhc-part2. In [4] it was
> > > proposed
> > > to add a way to refer to a device path/phandle from the kernel
> > > command
> > > line. Has there been any progress on this proposal?
> > 
> > Lots of time during the years I have been approached, both publicly
> > and offlist, about whether it would be possible to add support for
> > "consistent" mmcblk devices. To me, I am fine with the aliases
> > approach, as long as it gets implemented correctly.
> > 
> > > 
> > > Kind regards,
> > > Matthias
> > > 
> > > 
> > > [1] https://patchwork.kernel.org/patch/8685711/
> > > [2] https://lore.kernel.org/patchwork/cover/674381/
> > > [3] https://www.spinics.net/lists/linux-mmc/msg26586.html
> > > [4] https://www.spinics.net/lists/linux-mmc/msg26708.html
> > > 
> > 
> > Kind regards
> > Uffe


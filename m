Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C16AC433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 08:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B18620838
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="P1EI+mm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgG2InQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:43:16 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:62085 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgG2InP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 04:43:15 -0400
IronPort-SDR: AjDidzdG+PcO3UoKsXwuVaHqD8ieK0k1oVYsGWDIf8nQy7CvuQQ2ZHWq6XYvPttpKwbn0jBtO/
 wSvfwDBfTIXygYSL7DhTfJtOC7OxQg6Cfm2bDTaFNw00mbFMeuajJ4ehKUCUHmdV+72BmTNmaO
 2rPpFrVPNQjT7esU/4q/RCfAzhGhSDgm3uPo8xX3HC3rL/cA90PAMOKUwjypJtgITrBuoHbs+t
 ya77NwUJKyt2XarhSEoU24FSm5WAV96Ots3+2mvMA+AGFRHs8PHa6EwCVPZdnr7IAccSPuGxFQ
 lT4=
X-IronPort-AV: E=Sophos;i="5.75,409,1589234400"; 
   d="scan'208";a="13274294"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 29 Jul 2020 10:43:13 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 29 Jul 2020 10:43:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 29 Jul 2020 10:43:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1596012193; x=1627548193;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6/RHCmsZt+4kR8cdg6CQy2UZgB2rT8qVlvZdIEZPtk=;
  b=P1EI+mm4sbmy/xOXaocVwpY9vE78wq/Mxz0iBqVqlJqfWn6fuGv7egsy
   32ErrylFuqylO6hBtHBc7ahZFiuItPItZ0KHvCO9FUfSNaDJhMi+cunV0
   iiF6U3VBkw2hqgO/omg1dJlG1H3S000UoNjMJADAnUcuLEceWcjPUYj8+
   hvDwGYXf1Uz9ssS7Mf0606qTWk+gIXhxxe3EAgdRQtb/wrJTYpbBtx8ah
   TqYgROfhguu37pbbGFGXixD7cW53Zo+Z+FD/JznS/6RmJu1f8aEo8aj/C
   B8UeWVGzWKkTTO3ZwVkYj2U5otl5zPvXT7Tyr0DWrtn6kPyrT65wjj4Lg
   g==;
IronPort-SDR: X5t7OEl9tYsEfhFVb54/do1hiiIpyuvK57YIOWOu+/i4Ix6x9Ff1jCSPsIVo7BZpk4EqNm3pQd
 3YtY/gHAh7jKOgfJm0ukyqNIpEmE4iLMAamqbpmuC/fmeKlnjFaApGeiem/ELk0RAD26UcUUiF
 OrkHyFV+AfeKWg1Y1BYKxt00pGzHvPAFiy/4ecNRbG7Oj/z249yV7/woNGdNvnt73gZ4Sn7pmN
 rsiw622e36Um+wGtX0M77SZu7EHA1YYOz73Jm/kSBXzI6Pd5kwn+oxE5wzxYm0QwdT52zPzhxb
 dp4=
X-IronPort-AV: E=Sophos;i="5.75,409,1589234400"; 
   d="scan'208";a="13274293"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Jul 2020 10:43:03 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 4E2ED280065;
        Wed, 29 Jul 2020 10:43:03 +0200 (CEST)
Message-ID: <4ecc41303f9232319cedf414fc466a8c4c0c6dc6.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: Consistent block device references for
 root= cmdline
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Jul 2020 10:43:01 +0200
In-Reply-To: <CAPDyKFptySRTbWto9QYWZ-feL51JvPkZDGsETJ4svz0VbV31Bw@mail.gmail.com>
References: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com>
         <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com>
         <cfcec3df57e6dd5ef353ef3a5b4b9793c28eb401.camel@ew.tq-group.com>
         <CAPDyKFptySRTbWto9QYWZ-feL51JvPkZDGsETJ4svz0VbV31Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2020-07-07 at 16:14 +0200, Ulf Hansson wrote:
> On Thu, 11 Jun 2020 at 13:20, Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> > 
> > On Wed, 2020-06-10 at 16:52 +0200, Ulf Hansson wrote:
> > > On Wed, 10 Jun 2020 at 15:15, Matthias Schiffer
> > > <matthias.schiffer@ew.tq-group.com> wrote:
> > > > 
> > > > Hello all,
> > > > 
> > > > there have been numerous attempts to make the numbering of
> > > > mmcblk
> > > > devices consistent, mostly by using aliases from the DTS ([1],
> > > > [2],
> > > > [3]), but all have been (rightfully) rejected. Unless I have
> > > > overlooked
> > > > a more recent development, no attempts for a different solution
> > > > were
> > > > made.
> > > 
> > > According to aliases attempts, I think those have failed, mainly
> > > because of two reasons.
> > > 
> > > 1. Arguments stating that LABELs/UUIDs are variable alternatives.
> > > This
> > > isn't the case, which I think was also concluded from the several
> > > earlier discussions.
> > > 2. Patches that tried adding support for mmc aliases, were not
> > > correctly coded. More precisely, what needs to be addressed is
> > > that
> > > the mmc core also preserves the same ids to be set for the host
> > > class
> > > as the block device, mmc[n] must correspond to mmcblk[n].
> > > 
> > > > 
> > > > As far as I can tell, the core of the issue seems to be the
> > > > following:
> > > > 
> > > > The existing solutions like LABELs and UUIDs are viable
> > > > alternatives in
> > > > many cases, but in particular on embedded systems, this is not
> > > > quite
> > > > sufficient: In addition to the problem that more knowledge
> > > > about
> > > > the
> > > > system to boot is required in the bootloader, this approach
> > > > fails
> > > > completely when the same firmware image exists on multiple
> > > > devices,
> > > > for
> > > > example on an eMMC and an SD card - not an entirely uncommon
> > > > situation
> > > > during the development of embedded systems.
> > > > 
> > > > With udev, I can refer to a specific partition using a path
> > > > like
> > > > /dev/disk/by-path/platform-2194000.usdhc-part2. In [4] it was
> > > > proposed
> > > > to add a way to refer to a device path/phandle from the kernel
> > > > command
> > > > line. Has there been any progress on this proposal?
> > > 
> > > Lots of time during the years I have been approached, both
> > > publicly
> > > and offlist, about whether it would be possible to add support
> > > for
> > > "consistent" mmcblk devices. To me, I am fine with the aliases
> > > approach, as long as it gets implemented correctly.
> > 
> > 
> > It seems the principal technical problem is the one described here:
> > 
> > https://www.spinics.net/lists/linux-mmc/msg26602.html
> > 
> > I don't see any way to solve this completely, as there seem to be
> > two
> > fundamentally conflicting requirements:
> > 
> > 1) If a mounted SD card is replaced, it must be assigned a new
> > /dev/mmcblkN
> > 2) /dev/mmcblkN should always match the configured alias IDs
> > 
> > What is the reason we need 1) - is it possible to have multiple
> > eMMCs
> > or SD cards on a single bus, with detection at runtime?
> 
> Yes. The mmc_bus_type holds all cards - all discovered at runtime.
> 
> > Otherwise I'd
> > expect this to be handled like other drives with removable media
> > (CD,
> > floppy), with static device assignment.
> > 
> > If we can't give up on 1) for some reason, we'll have to accept
> > that we
> > can't guarantee 2) unconditionally. As far as I can tell, the
> > patches
> > provided by Sascha and others did that in a reasonable way: The
> > aliases
> > would work in most cases - in particular for the first assignment
> > on
> > boot, which is required to find the correct rootfs.
> 
> Well, if we would pre-parse the DTB to look for all "mmc block
> aliases" and keep a mark of those ids as being reserved, then we
> should be able to cope with both 1) and 2).

Hello Ulf,

it seems to me like Sascha's patches from 2014 do precisely that:

https://www.spinics.net/lists/linux-mmc/msg26587.html
https://www.spinics.net/lists/linux-mmc/msg26588.html

I haven't looked into porting this to a modern kernel yet, but do you
think that the approach is sound?



> 
> > 
> > > 
> > > > 
> > > > Kind regards,
> > > > Matthias
> > > > 
> > > > 
> > > > [1] https://patchwork.kernel.org/patch/8685711/
> > > > [2] https://lore.kernel.org/patchwork/cover/674381/
> > > > [3] https://www.spinics.net/lists/linux-mmc/msg26586.html
> > > > [4] https://www.spinics.net/lists/linux-mmc/msg26708.html
> > > > 
> 
> Kind regards
> Uffe


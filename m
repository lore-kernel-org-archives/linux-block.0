Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D97C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 21:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C772084D
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 21:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfFNVYI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:24:08 -0400
Received: from latin.grep.be ([46.4.76.168]:50895 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFNVYI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 17:24:08 -0400
Received: from [105.227.108.147] (helo=gangtai.home.grep.be)
        by latin.grep.be with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <w@uter.be>)
        id 1hbtg3-0004xK-TZ; Fri, 14 Jun 2019 23:24:04 +0200
Received: from wouter by gangtai.home.grep.be with local (Exim 4.92)
        (envelope-from <w@uter.be>)
        id 1hbtfv-0006f9-AY; Fri, 14 Jun 2019 23:23:55 +0200
Date:   Fri, 14 Jun 2019 23:23:54 +0200
From:   Wouter Verhelst <w@uter.be>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
Message-ID: <20190614212354.GA24581@grep.be>
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local>
 <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
 <20190613145535.tdesq3y2xy6ycpw7@MacBook-Pro-91.local>
 <20190614103343.GB11340@grep.be>
 <20190614133802.vg3w3sxpid2fpbp4@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614133802.vg3w3sxpid2fpbp4@MacBook-Pro-91.local>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 14, 2019 at 09:38:04AM -0400, Josef Bacik wrote:
> On Fri, Jun 14, 2019 at 12:33:43PM +0200, Wouter Verhelst wrote:
> > On Thu, Jun 13, 2019 at 10:55:36AM -0400, Josef Bacik wrote:
> > > Also I mean that there are a bunch of different nbd servers out there.  We have
> > > our own here at Facebook, qemu has one, IIRC there's a ceph one.
> > 
> > I can't claim to know about the Facebook one of course, but the qemu one
> > uses the same handshake protocol as anyone else. The ceph ones that I've
> > seen do too (but there are various implementations of that, so...).
> > 
> 
> Ah, for some reason I remembered Qemu's being distinctly different.
> 
> I suppose if most of the main ones people use are using the same handshake
> protocol that makes it more compelling.  But there'd have to be a really good
> reason why a initramfs isn't viable, and so far I haven't heard a solid reason
> that's not an option other than "it's hard and we don't want to do it."

Oh, I agree with that. It's not hard at all; I'm aware of two
implementations of doing that (I've written an nbd initramfs hook for
Debian's initramfs infrastructure, and others have done it for dracut).
I'm assuming that buildroot will have an initramfs framework too (and if
it doesn't, then that probably just means someone should write it), and
then writing an nbd initramfs hook for that framework should be
reasonably easy.

Also, the proposed initramfs configuration protocol uses the same
"nbdroot" name as my Debian initramfs hooks, but in an incompatible way.
I'd really like to see that be done differently, before/if it's accepted
at all ;-)

-- 
To the thief who stole my anti-depressants: I hope you're happy

  -- seen somewhere on the Internet on a photo of a billboard

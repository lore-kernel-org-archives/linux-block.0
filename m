Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:53535 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbdAOHWy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Jan 2017 02:22:54 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] NBD: exported files over something around 1 TiB get an insane device size on the client side and are actually empty
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <1484442228.7132.0@smtp.office365.com>
Date: Sun, 15 Jan 2017 07:13:02 +0000
Cc: Alex Bligh <alex@alex.org.uk>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-block@vger.kernel.org,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>
Message-Id: <3F2D624F-3576-4A29-A41E-88E6DE32026E@alex.org.uk>
References: <1484436698.7110.29.camel@scientia.net> <1484442228.7132.0@smtp.office365.com>
To: Josef Bacik <jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 15 Jan 2017, at 01:03, Josef Bacik <jbacik@fb.com> wrote:
>=20
> Yeah I noticed this in testing, there's a bug with NBD since it's=20
> inception where it uses a 32 bit number for keeping track of the size=20=

> of the device, I fixed it with
>=20
> nbd: use loff_t for blocksize and nbd_set_size args
>=20
> It'll be in 4.10.  Thanks,

Interestingly enough, this is a regression, as the random 3.x kernel I =
tried did not show the issue.

Thanks for the fix Josef.

--=20
Alex Bligh





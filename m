Return-Path: <linux-block-owner@vger.kernel.org>
Received: from titan.allfex.org ([5.9.57.113]:45446 "EHLO titan.allfex.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754607AbcIOTC3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 15:02:29 -0400
From: Markus Pargmann <mpa.kernel@devmp.org>
To: Jens Axboe <axboe@fb.com>
Cc: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        nbd-general@lists.sourceforge.net
Subject: Re: [PATCH 0/5] nbd improvements
Date: Thu, 15 Sep 2016 20:53:51 +0200
Message-ID: <2902197.L6pTpzKSHP@galactica.lan>
In-Reply-To: <aee66977-c8f2-dab7-0649-f4e71fdc31f8@fb.com>
References: <1473363221-142264-1-git-send-email-jbacik@fb.com> <aee66977-c8f2-dab7-0649-f4e71fdc31f8@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2996555.iI8Qp16xSm"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--nextPart2996555.iI8Qp16xSm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jens,

On 2016 M09 8, Thu 14:13:46 CEST Jens Axboe wrote:
> On 09/08/2016 01:33 PM, Josef Bacik wrote:
> > This is a patch series aimed at bringing NBD into 2016.  The two big
> > components of this series is converting nbd over to using blkmq and
> > then allowing us to provide more than one connection for a nbd device.
> > The NBD user space server doesn't care about how many connections it
> > has to a particular device, so we can easily open multiple
> > connections to the server and allow blkmq to handle multi-plexing over
> > the different connections.  This drastically improves performance
> > with multi-threaded workloads over NBD.  The multi-connection support
> > requires some changes to the NBD userspace client code, and you can
> > find that code here
> > 
> > https://github.com/josefbacik/nbd
> > 
> > I have been testing this for a few months and it is pretty solid and gives
> > excellent performance improvements.  Thanks,
> 
> Not only are these nice performance improvements, it also cleans up the
> code a lot and kills crufty old driver code in favor of using the proper
> APIs instead. I have applied the series for 4.9.

These patches conflict with the patches I picked up for 4.9 that fix the 
issues of dying filesystems on killed NBD block devices.
As I am a kernel hobbiest now, I had to move the git repository recently:
	https://github.com/scosu/linux-nbd

Best Regards,

Markus
--nextPart2996555.iI8Qp16xSm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX2u4/AAoJECi9+rkzbKwyTlAQALAAqaNxPiMRSJcuFjY+vOjq
x5qjVhMR8Nm+kbRMXx4U1wjM7oop55lSxdbgDx7HJb4QZjb9lVCyeVjjUnulxNEr
87Mi/wOeU5SvWNAMap0I1D9TjY2h4LcD+5zmE+ucdcVskE9CSVmLnyviu9mr7G62
l9Mp+lVu7ShtGTf/GcMvVxtSH6sWC3Egjyba2DKm7T/hOBBwhKHqqG52l6nHZ4kt
xKzFK+YdIG+Ovz2CZP6LctO6Gh79Iu7oMKGfBLIrei7FdXn+1e/luh4bV4SNvXlm
+yoNL14c+1iwJoCjP51hYV/GW/y3hUA988LWgkCY/kZW7FzawtEVPx+E6ClVol69
62IIvxMx2ocIvm5ILl9kBLXdSn2wl+4LgRIRh7Av8qAq8GkuNU4K/fULAlL5A9Xe
y4+q/S6PUkbqGJHCc2vU27qO+B2zYhogUZxFSlpZUzgdC187YHpFnNeAxzcy5u5u
4ND0+8j+aqSabQQw7y3NoCpS8Z+A59/M6jzzUUH7x6Nvb1hd/KKgv7TU+Fs+/VK4
+OVXURC8EPyP3nBjs9V/jecPPFXFyz8Upd8/nZpxJjecmmBKFLReW7CHklZWHfo1
wLTbyxNrLYF1V/iqgMx6D2MsX7lppEarcG6w/oGdmME1yeOrrH/rnS/2dIA8cqc1
QvINzDGE5TnyM8V5CuVe
=VMLZ
-----END PGP SIGNATURE-----

--nextPart2996555.iI8Qp16xSm--


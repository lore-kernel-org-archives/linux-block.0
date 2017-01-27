Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48767 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbdA0Jr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 04:47:29 -0500
Date: Fri, 27 Jan 2017 10:46:36 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 0/6] mmc: block: command issue cleanups
Message-ID: <20170127094635.uxuhh5vcexdx4i5h@lukather>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
 <CAPDyKFrB9UfkfGD08fTKegSB2W65pdWuDU=10mGukQmB=yhaqQ@mail.gmail.com>
 <CAPDyKFq6wzw=_6oc=hyW3B_tBAGfqzrixoy-gr=ki=M2wyhiNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mst7ckrlkdvdljgj"
In-Reply-To: <CAPDyKFq6wzw=_6oc=hyW3B_tBAGfqzrixoy-gr=ki=M2wyhiNg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--mst7ckrlkdvdljgj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Fri, Jan 27, 2017 at 08:58:16AM +0100, Ulf Hansson wrote:
> On 26 January 2017 at 09:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 24 January 2017 at 11:17, Linus Walleij <linus.walleij@linaro.org> w=
rote:
> >> The function mmc_blk_issue_rw_rq() is hopelessly convoluted and
> >> need to be refactored to it can be understood by humans.
> >>
> >> In the process I found some weird magic return values passed
> >> around for no good reason.
> >>
> >> Things are more readable after this.
> >>
> >> This work is done towards the goal of breaking the function in
> >> two parts: one just submitting the requests and one checking the
> >> result and possibly resubmitting the command on error, so we
> >> can make the usual path (non-errorpath) smooth and quick, and
> >> be called directly when the driver completes a request.
> >>
> >> That in turn is a prerequisite for proper blk-mq integration
> >> with the MMC/SD stack.
> >>
> >> All that comes later.
> >>
> >> Linus Walleij (6):
> >>   mmc: block: break out mmc_blk_rw_cmd_abort()
> >>   mmc: block: break out mmc_blk_rw_start_new()
> >>   mmc: block: do not assign mq_rq when aborting command
> >>   mmc: block: inline command abortions
> >>   mmc: block: introduce new_areq and old_areq
> >>   mmc: block: stop passing around pointless return values
> >>
> >>  drivers/mmc/core/block.c | 108 ++++++++++++++++++++++++++------------=
---------
> >>  drivers/mmc/core/block.h |   2 +-
> >>  2 files changed, 60 insertions(+), 50 deletions(-)
> >>
> >> --
> >> 2.9.3
> >>
> >
> > Thanks, applied for next!
>=20
> Linus,
>=20
> Seems like this series may have issues. I have looked at boot reports
> from kernelci, and particular the reports for
> https://kernelci.org/boot/sun7i-a20-bananapi/job/ulfh/ are
> interesting.
>=20
> Apparently, this board has an SD card attached. There have been errors
> reported in the log for a while when doing data transfers, although
> none of these errors have triggered the kernelci to report a boot
> error.
>=20
> However, I suspect that some of the changes in this series make it
> worse. Perhaps because of a changed error handling the mmc block
> layer!?
>=20
> Particular, look at the difference between these [1] boot logs, it
> might give you some hints. I have also added Maxime to this thread,
> perhaps he can help out with the sunxi mmc driver.

We also had a patch on the pinctrl side in 4.10, whose side effects
would be to disable the pull ups on some boards that have not been
configuring their pins properly (while the previous behaviour was to
keep what the bootloader set).

That board seems to fall in that category.

That behaviour has been reverted, and Linus merged it already, so it
might be entirely unrelated to that serie.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--mst7ckrlkdvdljgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYixb7AAoJEBx+YmzsjxAgqg0P/AuPFT9H6XGT4GL3r2CJDfFk
BDkeQjUlqgTKv0MDEt55GrtDLHSBdkHr+5zSEMmCOa/YxPZ20lYWOQHt8WjGVBuT
sqlIME68tfF8Ghwc7CwFZW4CXo8k3XlUa9gLRiMzVrhsIvzgi3+vN9hEhMaoTGrQ
XAiYCQPS0sxnsjT9z6F/O6mInOV+ItN5266OlWOvuIcUbwWkF1XwbAk8BUjF1TgR
gTbuVf+Ti5w5T2IkXCoqcg2SUp/Onw8GAe59s8H8jihSoJNcKU/jtMhc4UNa+fWD
QPKIDMVp/q0+RC70M/nkk+UoS0QtGYdU1mqPfPcY7JBm1BKxpsNTfnduQ7xwFlqI
OqkQUW/DnX8VfUOfLxXdWgMk/721GzTMuw3nWB38hWRWXzPBF3bw2LgAtstwH35m
ZRCUIJ5XSmcmF3ssYjugjFCwSz5H1qF0Y+NVi1s5X+PU+tbgM1UP2GBsH9C8xSK2
tsqTqi7e/GnMzqHE3Yu1VaWTwN6/Y5pS1ne9wBrMI80/fKXM36j2AqYQrgNmzSeW
qYlkylQuuH1WDqq9IxoISPEYqcrm1Uxs4ucmwcubkCT4vcmSl1zpc52OAowFfL/J
37vmg4ybpnc/oQAmImilBJ5TeKirePGoNgPs8NDhESuHkXckxuQozaXEKg9whffT
1LyLeBeNqb2SQaHmiKGS
=jSRQ
-----END PGP SIGNATURE-----

--mst7ckrlkdvdljgj--

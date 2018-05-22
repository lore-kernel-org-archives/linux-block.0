Return-Path: <leon@kernel.org>
Date: Tue, 22 May 2018 16:18:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Swapnil Ingle <swapnil.ingle@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: Re: [PATCH v2 14/26] ibtrs: include client and server modules into
 kernel compilation
Message-ID: <20180522131856.GK23585@mtr-leonro.mtl.com>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
 <20180518130413.16997-15-roman.penyaev@profitbricks.com>
 <20180522050513.GT7136@mtr-leonro.mtl.com>
 <CAJrWOzBLSaxdeeZTjaz2fufzYgRGJxhK38wsLQiBF5YNp+gvUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
In-Reply-To: <CAJrWOzBLSaxdeeZTjaz2fufzYgRGJxhK38wsLQiBF5YNp+gvUw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 11:27:21AM +0200, Roman Penyaev wrote:
> On Tue, May 22, 2018 at 7:05 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > On Fri, May 18, 2018 at 03:04:01PM +0200, Roman Pen wrote:
> >> Add IBTRS Makefile, Kconfig and also corresponding lines into upper
> >> layer infiniband/ulp files.
> >>
> >> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> >> Signed-off-by: Danil Kipnis <danil.kipnis@profitbricks.com>
> >> Cc: Jack Wang <jinpu.wang@profitbricks.com>
> >> ---
> >>  drivers/infiniband/Kconfig            |  1 +
> >>  drivers/infiniband/ulp/Makefile       |  1 +
> >>  drivers/infiniband/ulp/ibtrs/Kconfig  | 20 ++++++++++++++++++++
> >>  drivers/infiniband/ulp/ibtrs/Makefile | 15 +++++++++++++++
> >>  4 files changed, 37 insertions(+)
> >>  create mode 100644 drivers/infiniband/ulp/ibtrs/Kconfig
> >>  create mode 100644 drivers/infiniband/ulp/ibtrs/Makefile
> >>
> >> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> >> index ee270e065ba9..787bd286fb08 100644
> >> --- a/drivers/infiniband/Kconfig
> >> +++ b/drivers/infiniband/Kconfig
> >> @@ -94,6 +94,7 @@ source "drivers/infiniband/ulp/srpt/Kconfig"
> >>
> >>  source "drivers/infiniband/ulp/iser/Kconfig"
> >>  source "drivers/infiniband/ulp/isert/Kconfig"
> >> +source "drivers/infiniband/ulp/ibtrs/Kconfig"
> >>
> >>  source "drivers/infiniband/ulp/opa_vnic/Kconfig"
> >>  source "drivers/infiniband/sw/rdmavt/Kconfig"
> >> diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
> >> index 437813c7b481..1c4f10dc8d49 100644
> >> --- a/drivers/infiniband/ulp/Makefile
> >> +++ b/drivers/infiniband/ulp/Makefile
> >> @@ -5,3 +5,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)         += srpt/
> >>  obj-$(CONFIG_INFINIBAND_ISER)                += iser/
> >>  obj-$(CONFIG_INFINIBAND_ISERT)               += isert/
> >>  obj-$(CONFIG_INFINIBAND_OPA_VNIC)    += opa_vnic/
> >> +obj-$(CONFIG_INFINIBAND_IBTRS)               += ibtrs/
> >> diff --git a/drivers/infiniband/ulp/ibtrs/Kconfig b/drivers/infiniband/ulp/ibtrs/Kconfig
> >> new file mode 100644
> >> index 000000000000..eaeb8f3f6b4e
> >> --- /dev/null
> >> +++ b/drivers/infiniband/ulp/ibtrs/Kconfig
> >> @@ -0,0 +1,20 @@
> >> +config INFINIBAND_IBTRS
> >> +     tristate
> >> +     depends on INFINIBAND_ADDR_TRANS
> >> +
> >> +config INFINIBAND_IBTRS_CLIENT
> >> +     tristate "IBTRS client module"
> >> +     depends on INFINIBAND_ADDR_TRANS
> >> +     select INFINIBAND_IBTRS
> >> +     help
> >> +       IBTRS client allows for simplified data transfer and connection
> >> +       establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
> >> +       READ/WRITE semantics and provides multipath capabilities.
> >> +
> >> +config INFINIBAND_IBTRS_SERVER
> >> +     tristate "IBTRS server module"
> >> +     depends on INFINIBAND_ADDR_TRANS
> >> +     select INFINIBAND_IBTRS
> >> +     help
> >> +       IBTRS server module processing connection and IO requests received
> >> +       from the IBTRS client module.
> >> diff --git a/drivers/infiniband/ulp/ibtrs/Makefile b/drivers/infiniband/ulp/ibtrs/Makefile
> >> new file mode 100644
> >> index 000000000000..e6ea858745ad
> >> --- /dev/null
> >> +++ b/drivers/infiniband/ulp/ibtrs/Makefile
> >> @@ -0,0 +1,15 @@
> >> +ibtrs-client-y := ibtrs-clt.o \
> >> +               ibtrs-clt-stats.o \
> >> +               ibtrs-clt-sysfs.o
> >> +
> >> +ibtrs-server-y := ibtrs-srv.o \
> >> +               ibtrs-srv-stats.o \
> >> +               ibtrs-srv-sysfs.o
> >> +
> >> +ibtrs-core-y := ibtrs.o
> >> +
> >> +obj-$(CONFIG_INFINIBAND_IBTRS)        += ibtrs-core.o
> >
> > Will it build ibtrs-core in case both server and client are disabled in .config?
>
> No, CONFIG_INFINIBAND_IBTRS is selected/deselected by
> CONFIG_INFINIBAND_IBTRS_CLIENT or CONFIG_INFINIBAND_IBTRS_SERVER,
> when you choose them in kconfig.
>

Thanks

>
> >> +obj-$(CONFIG_INFINIBAND_IBTRS_CLIENT) += ibtrs-client.o
> >> +obj-$(CONFIG_INFINIBAND_IBTRS_SERVER) += ibtrs-server.o
> >> +
> >> +-include $(src)/compat/compat.mk
> >
> > What is this?
>
> Well, in our production we use same source code and in order not to spoil
> sources with 'ifdef' macros for different kernel versions I use compat
> layer, which obviously will never go upstream.  This line is the only
> clean way to keep sources always up-to-date with latest kernel and still
> be compatible with what we have on our servers in production.
>
> '-' prefix at the beginning of the line tells make to ignore it if
> file does not exist, so should not rise any error for compilation
> against latest kernel.
>
> Here is an example of the compat layer for IBNBD block device:
> https://github.com/profitbricks/ibnbd/tree/master/ibnbd/compat

I see it, you will need to remove this line from the upstream kernel
patches.

Thanks

>
> --
> Roman

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbBBi/AAoJEORje4g2clinDSQP/1QemkHQlOdKW/HgdIBk7lpF
FYLgBhuS9RtRKpFnSjXR2qGI3+tXOomfEBJi9URIR0spIY+DSPomJlI/GWtlgrgQ
/HVv9DxqAhO9ZazORz/lZN+cxCgp4QCWeP2HvVhA+ejOradmmYSq4PiXv0QAWhaa
nV6xThm9mkgXWYX/kaoRiNU5BxA3XkKs8F3KoQtGoeS4DCk9shMqajGoxmkxkuRc
NCvr4VI5RQLPnj48YQTolP7DlvPDMBm92Jrx2EXlOyAgTb3uxToF9+hOletKCYXv
2mvVm5YufTl0U9CnoDJDw2ra+1sRjutP+Ax3ydOVe4xc3aRRsr3h7D5n1sGtkl3P
p+SAbASQ7nQDdq2H2h3elqjnHlzvuMI1X2HtQ4ijMUj3HxuLTszaKrq7W8vIcHna
7Bh80PLbX3YqvzFC6vsc8/m0gaJKH49Ev4f2QsOZQs+jRwEs+ChatzN6JeMAlcOb
pQRvpiki3AAt1Qwe8UuU2AMiy8rhOAlX5UuGaGZZc3i3HOkyNX9qm8rYSMDTe34f
PnY2UV9xeQnM/JnRtb/hwvuee/v4LEi0G6UKwOu0wlWflW+4vRhi+4IQDyyx8YlG
1nLjYtYiY77Fpe6+BOeRvBt6JQ/Uk6ntQ6DhHd9TqYMBJkLCeabCSZ0eyZD83MsK
o5jq780uE1bRCXfZqhcs
=xlKa
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

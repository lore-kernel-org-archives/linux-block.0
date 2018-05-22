Return-Path: <leon@kernel.org>
Date: Tue, 22 May 2018 08:05:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
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
Message-ID: <20180522050513.GT7136@mtr-leonro.mtl.com>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
 <20180518130413.16997-15-roman.penyaev@profitbricks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
In-Reply-To: <20180518130413.16997-15-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 18, 2018 at 03:04:01PM +0200, Roman Pen wrote:
> Add IBTRS Makefile, Kconfig and also corresponding lines into upper
> layer infiniband/ulp files.
>
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Signed-off-by: Danil Kipnis <danil.kipnis@profitbricks.com>
> Cc: Jack Wang <jinpu.wang@profitbricks.com>
> ---
>  drivers/infiniband/Kconfig            |  1 +
>  drivers/infiniband/ulp/Makefile       |  1 +
>  drivers/infiniband/ulp/ibtrs/Kconfig  | 20 ++++++++++++++++++++
>  drivers/infiniband/ulp/ibtrs/Makefile | 15 +++++++++++++++
>  4 files changed, 37 insertions(+)
>  create mode 100644 drivers/infiniband/ulp/ibtrs/Kconfig
>  create mode 100644 drivers/infiniband/ulp/ibtrs/Makefile
>
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index ee270e065ba9..787bd286fb08 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -94,6 +94,7 @@ source "drivers/infiniband/ulp/srpt/Kconfig"
>
>  source "drivers/infiniband/ulp/iser/Kconfig"
>  source "drivers/infiniband/ulp/isert/Kconfig"
> +source "drivers/infiniband/ulp/ibtrs/Kconfig"
>
>  source "drivers/infiniband/ulp/opa_vnic/Kconfig"
>  source "drivers/infiniband/sw/rdmavt/Kconfig"
> diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
> index 437813c7b481..1c4f10dc8d49 100644
> --- a/drivers/infiniband/ulp/Makefile
> +++ b/drivers/infiniband/ulp/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)		+= srpt/
>  obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
>  obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
>  obj-$(CONFIG_INFINIBAND_OPA_VNIC)	+= opa_vnic/
> +obj-$(CONFIG_INFINIBAND_IBTRS)		+= ibtrs/
> diff --git a/drivers/infiniband/ulp/ibtrs/Kconfig b/drivers/infiniband/ulp/ibtrs/Kconfig
> new file mode 100644
> index 000000000000..eaeb8f3f6b4e
> --- /dev/null
> +++ b/drivers/infiniband/ulp/ibtrs/Kconfig
> @@ -0,0 +1,20 @@
> +config INFINIBAND_IBTRS
> +	tristate
> +	depends on INFINIBAND_ADDR_TRANS
> +
> +config INFINIBAND_IBTRS_CLIENT
> +	tristate "IBTRS client module"
> +	depends on INFINIBAND_ADDR_TRANS
> +	select INFINIBAND_IBTRS
> +	help
> +	  IBTRS client allows for simplified data transfer and connection
> +	  establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
> +	  READ/WRITE semantics and provides multipath capabilities.
> +
> +config INFINIBAND_IBTRS_SERVER
> +	tristate "IBTRS server module"
> +	depends on INFINIBAND_ADDR_TRANS
> +	select INFINIBAND_IBTRS
> +	help
> +	  IBTRS server module processing connection and IO requests received
> +	  from the IBTRS client module.
> diff --git a/drivers/infiniband/ulp/ibtrs/Makefile b/drivers/infiniband/ulp/ibtrs/Makefile
> new file mode 100644
> index 000000000000..e6ea858745ad
> --- /dev/null
> +++ b/drivers/infiniband/ulp/ibtrs/Makefile
> @@ -0,0 +1,15 @@
> +ibtrs-client-y := ibtrs-clt.o \
> +		  ibtrs-clt-stats.o \
> +		  ibtrs-clt-sysfs.o
> +
> +ibtrs-server-y := ibtrs-srv.o \
> +		  ibtrs-srv-stats.o \
> +		  ibtrs-srv-sysfs.o
> +
> +ibtrs-core-y := ibtrs.o
> +
> +obj-$(CONFIG_INFINIBAND_IBTRS)        += ibtrs-core.o

Will it build ibtrs-core in case both server and client are disabled in .config?

> +obj-$(CONFIG_INFINIBAND_IBTRS_CLIENT) += ibtrs-client.o
> +obj-$(CONFIG_INFINIBAND_IBTRS_SERVER) += ibtrs-server.o
> +
> +-include $(src)/compat/compat.mk

What is this?


> --
> 2.13.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbA6UIAAoJEORje4g2clinv/gQAM8napnP0KOD0Qe01eHywe4G
x2864RhHwX9hZERsKm14aUSBPbvV1tSuj+7Q5x58mAxhrhgeR7EMU7zjF53ayjON
vYhW3OZxH4BLqPr+ZRyjfzKKoUSji08idRsGeXMK3E3Pk3FJcQdgVEQ962Y1kv/0
g4/1bDRLe18su/73LQajR6vDwlB+7h5bZMXVz3zZOBqbBFqxukL3DuahJViwHoo9
WkgH+uPT4EB8MRH7aNae1L+b9tCN9ioIrHfzX6kr1iyPV5v3Zjst9UTZfnpa7WlM
zQWQRxvQ57MfLBn1nglR4udladnRT9rZXCOF84LcuTkvjjjeCzaonkLXiap3l8Pe
HQc0OyUuyR9jKASa8PnxGjc9r+vJBI0DacqyZQitSqKkZ5EYWLhTUh+mTVRr/ClF
A4GSOkq4aSgqzi3q+chZ3QQEmasKO9XrlLD0RoxsncDrXCls+mWmA/8kWcn3/Eps
tDwTvDPxw1cKOqLbPwpQ+zG+Yy5c0GY0/pLiLY0E5lWT9DATftphBveMCZPv4jf/
ABMWOzbS6SemoNe9om5yceyC7cido03lFqJoK75Gh/YQhYBtb906WdrEVAaK8s+R
uxo7Y23tMBy9xr6tkLUCOU1e/IbVWjMqsmLDM/J4IkEFiDqw/Y3pbdAbq9oQWGoW
+nMAvbPnsgEHzIjaSfXZ
=OxcF
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--

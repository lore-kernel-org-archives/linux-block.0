Return-Path: <leonro@mellanox.com>
Date: Thu, 6 Apr 2017 17:27:01 +0300
From: Leon Romanovsky <leonro@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Jens Axboe <axboe@kernel.dk>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Saeed Mahameed
	<saeedm@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>, Christoph Hellwig
	<hch@lst.de>
Subject: Re: [PATCH v2 2/6] mlx5: move affinity hints assignments to generic
 code
Message-ID: <20170406142701.GL2269@mtr-leonro.local>
References: <1491474998-16423-1-git-send-email-sagi@grimberg.me>
 <1491474998-16423-3-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XjbSsFHOHxvQpKib"
In-Reply-To: <1491474998-16423-3-git-send-email-sagi@grimberg.me>
Return-Path: leonro@mellanox.com
List-ID: <linux-block@vger.kernel.org>

--XjbSsFHOHxvQpKib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2017 at 01:36:34PM +0300, Sagi Grimberg wrote:
> generic api takes care of spreading affinity similar to
> what mlx5 open coded (and even handles better asymmetric
> configurations). Ask the generic API to spread affinity
> for us, and feed him pre_vectors that do not participate
> in affinity settings (which is an improvement to what we
> had before).
>
> The affinity assignments should match what mlx5 tried to
> do earlier but now we do not set affinity to async, cmd
> and pages dedicated vectors.
>
> Also, remove mlx5e_get_cpu routine as we have generic helpers
> to get cpumask and node given a irq vector, so use them
> directly.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--XjbSsFHOHxvQpKib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAljmUDQACgkQ5GN7iDZy
WKdDMxAAljeXK4d5Mgw37HndwWrXVYNYFqNbp/tyGfOU4uKrUB0a0Nozl8HTmxRK
9WzsnXG2Txd9rKW9Nq9OMTP5DSmfYeCm4QpK5H9uM4WCLQ1/QZ/wsNMGDw6YEOZ5
vNuT9uGg+NrqU2zeSTkvweaPRobYT3Pb6nfRFTMcp+Z64+Q2WaHURNAfPlyWv5Eg
yRRsqKYookbVKuMC71zoRF1i/6Kefi9Pz6jyK8zKUA63YOkeiN7kukteqDo8BwzC
6/X8ur3Qmtmv0G7tyy/HAm5AYDRp7V3RgRlkCW/svhPL/cn93NjURLWUnAWinGom
5ppkqHX0eaJKMUexUEh10+7wq1jKfDwlrVkdpVk5wng6oOcwlAvR5TqRV8ZZdYID
YJlRruuv88lO1RE6BZYTuzI6pQr7lwPwHU2AihLRxpHIbdprcIf7DDWIy3rFKWGi
j0TtBjiAjMak4E6K0KXusGZj3+9+3JqClcV1+fCyLqTqxfQht4zirafRLud2dQLU
LPy5TsAzBJaMQX/ve+pzwqP7pMR2Tmr0vvUQMQY9OAn/mfbfHs4MoewUjKHcsLr+
+jy1FfTBNFzTmY8df+wPXUOY6DQ/m477xChC8AqgStRb9RGTU/iFtq+Rt1TleTgy
VdHKu2YddT00O0Zz/RZm9pHFE9JZa2xtmSSJPszPjOI4W9GSNMo=
=fhTn
-----END PGP SIGNATURE-----

--XjbSsFHOHxvQpKib--

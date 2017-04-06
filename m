Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:18528
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935163AbdDFOah (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 10:30:37 -0400
Date: Thu, 6 Apr 2017 17:30:47 +0300
From: Leon Romanovsky <leonro@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Jens Axboe <axboe@kernel.dk>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/6] mlx5: support ->get_vector_affinity
Message-ID: <20170406143047.GM2269@mtr-leonro.local>
References: <1491474998-16423-1-git-send-email-sagi@grimberg.me>
 <1491474998-16423-5-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EEx6GiKZGZ1wKUra"
In-Reply-To: <1491474998-16423-5-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--EEx6GiKZGZ1wKUra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2017 at 01:36:36PM +0300, Sagi Grimberg wrote:
> Simply refer to the generic affinity mask helper.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--EEx6GiKZGZ1wKUra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAljmURcACgkQ5GN7iDZy
WKeHYA/+NGK3b9pn+BkHs5GfiXjvVyKdFrOil9NVz4InIr0NLVbFdFXYTpcN6/+v
8s1fh0FCh3EeH8wWYy10m7yMKmtIXBkdT0g8fIGXLwoK2yBegzDRjtUWdZ5SdJyN
aF8BvwdW7meV7eknp9+mXZglY34wTz5l4xAjV8tmyXXwlrBYHoryNowPS4BHhGQF
rtZh+0RnhFGRVjtfNgBhmoSITkQSo5UiRvPljgcXtj3f7NKvVYDMU68cXL5M009T
iXbvT1Ph77qYjjgacw1syUJop4SZQMLDW7UrYq5vQdHxcLsALeChpuI2CiKbiT6A
5PVy9yikTjg/n0tMR7ZDygkkoFT6g0vHj8n6TovoyuM1b+Btiv2CdlfFNsdhho6P
OLKnacf4f79Cuoa9owYHEq9LDiFg3bErP2b5gqzbbCzgbfsoVy70NDG3H1O/lgGb
IStjdSWYdR+uZzHQIYC/LdVhWzGknryUypHyWTW9mXencPX1+JL6DrjCS5jNo0XV
jGbzRLy0uoO7p0UVKRO9d2bJxI0/e0DJFmPE0UcOVhBnwiThUBYLkgexueIfpCor
4NJbIRPOOEGxH8vJW3KqQv7lr91J3ItP57oi3ksMfNivzxuvvgNLPNEHS5oZ6FiX
FFN4D361JyBYm3lunJNVYVbFyCJgffbpbdg+BhoW0vEsZHVFrWw=
=Ajf+
-----END PGP SIGNATURE-----

--EEx6GiKZGZ1wKUra--

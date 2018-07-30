Return-Path: <ps@pks.im>
Date: Mon, 30 Jul 2018 16:50:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	Tomas Janousek <tomi@nomi.cz>, Przemek Socha <soprwa@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] block: really disable runtime-pm for blk-mq
Message-ID: <20180730145033.GA1696@xps>
References: <20180730120219.24164-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
In-Reply-To: <20180730120219.24164-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 08:02:19PM +0800, Ming Lei wrote:
> Runtime PM isn't ready for blk-mq yet, and commit 765e40b675a9 ("block:
> disable runtime-pm for blk-mq") tried to disable it. Unfortunately,
> it can't take effect in that way since user space still can switch
> it on via 'echo auto > /sys/block/sdN/device/power/control'.
>=20
> This patch disables runtime-pm for blk-mq really by pm_runtime_disable()
> and fixes all kinds of PM related kernel crash.

I can confirm that this patch fixes the kernel panics I've seen.
For what it's worth, the USB hotplugging issues didn't
re-surface, either. Thanks!

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Patrick Steinhardt <ps@pks.im>
> Cc: Bart Van Assche <Bart.VanAssche@wdc.com>
> Cc: Tomas Janousek <tomi@nomi.cz>
> Cc: Przemek Socha <soprwa@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 03a4ea93a5f3..090b782df129 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3769,9 +3769,11 @@ EXPORT_SYMBOL(blk_finish_plug);
>   */
>  void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
>  {
> -	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
> -	if (q->mq_ops)
> +	/* Don't enable runtime PM for blk-mq until it is ready */
> +	if (q->mq_ops) {
> +		pm_runtime_disable(dev);
>  		return;
> +	}
> =20
>  	q->dev =3D dev;
>  	q->rpm_status =3D RPM_ACTIVE;
> --=20
> 2.9.5
>=20

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltfJbcACgkQEXxntp6r
8SyMVg/+IYmfxus3Pml4bDP89A2T02nuYcwMdllzDo7XdGpHAMydRqdVu76sqdiK
zEZcqkbv1wrxP8RwqUzzbI6yXI8hciAE2xVRhrSEcjFdZ0s0mklJ05t4Y/bPR2GX
Qd6gFbMjPVPH2Tg/a6VWBU5ZsVfa4Cbqkv9ux1sR4k7V2+DTyaedJNNz0O7MOWlQ
dWUrFboytMPUloqd5rprtUpApEqHkOGFMpjrNcMbm/EFYqkwOWBx1RCneH+EaVO7
lLCyURMXO2l/3Lqa8AHHy5LyKB4KCLdDGPsDA3wGymNJWKif+VaMs7V2419fA9Gt
eUUttD7mZN5xjN/CN4bkOuTi42tsxX7xE5ej1JxZpZ7756taP5QNa7jmSxxyLchM
eUtjcCXRJQ24WnJHhWggKiM1DQIWeWl3WYbW0l2vAifrLpEBbNkf8nPw1XCvsHmK
YnfZSV9EbJ3OsYLFGizo7VTFHCNa8XpUg6WQvqfq3ErpgCgZwtVcGbT2enBzZapE
djLw1erRBlstIovEL3J2A/LEcM9TfTa5EiFoBzPUyDx6ZdTRrvCz7FETX6te8JLG
7YQq+j1b5X8M29ow0SAzJXf+hQPNk5gihRrt5Y/FgZt5CLTZ6PES31pmM55Ds5wd
+OGWXQKhv/OpGnnTH40D4dPdg/qO3XCWCr1DH3jVMYBEFp3daIQ=
=w0iU
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

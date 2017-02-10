Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Date: Fri, 10 Feb 2017 13:21:19 +1100
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 04/10] block: Move bdi_unregister() to del_gendisk()
In-Reply-To: <20170209124433.2626-5-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz> <20170209124433.2626-5-jack@suse.cz>
Message-ID: <87wpcyu6ow.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Thu, Feb 09 2017, Jan Kara wrote:

> Commit 6cd18e711dd8 "block: destroy bdi before blockdev is
> unregistered." moved bdi unregistration (at that time through
> bdi_destroy()) from blk_release_queue() to blk_cleanup_queue() because
> it needs to happen before blk_unregister_region() call in del_gendisk()
> for MD. As much as it is fine for device registration / unregistration
> purposes, it does not fit our needs wrt writeback code. For those we
> will need bdi_unregister() to happen after bdev_unhash_inode() so that
> we are sure bdev inode is destroyed or soon to be destroyed (as soon as
> last inode reference is dropped and nobody should be holding bdev inode
> reference for long at this point) because bdi_unregister() may block
> waiting for bdev's inode i_wb reference to be dropped and that happens
> only once bdev inode gets destroyed.
>
> Also SCSI will free up the device number from sd_remove() called through
> a maze of callbacks from device_del() in __scsi_remove_device() before
> blk_cleanup_queue() and thus similar races as described in 6cd18e711dd8
> can happen for SCSI as well as reported by Omar [1]. Moving
> bdi_unregister() to del_gendisk() fixes these problems as well since
> del_gendisk() gets called from sd_remove() before freeing the device
> number.
>
> This also makes device_add_disk() (calling bdi_register_owner()) more
> symmetric with del_gendisk().

What an amazingly sensible idea!! I like that a lot.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlidI58ACgkQOeye3VZi
gbkIYhAAk0yQ9vlyYz2dGQtY4tL1F9PCxrblSQ83p6unvRYVrOdiKIa3AEUuOKxv
Xd9opOPtWkMrtfaDpiUbMtiGIxpIPFjPcZdI7JIR/eHneppDbIhYHgTZ+EegCwea
S5ZiiE0oKcipkAjsRL+bb0qPi0QZJ6U/th+Bx2YkphDWJl8KIKM9Ea7dlChBSpCr
Byzy+Q/eUx5QWM0ON3udXC0U6aD0mKwOXhZDvqWxbCw/vRwAdNPzhykRScfA647x
POh/9BI606Tt5+7XRvYaFuA7vQEde9r4ReQhCDaxATbbcAF4Wa1vB8dNWEc+ucMf
k2tH2qhWZrrv49WQ+yGCXUzsMQp0pcex4JLLKmvsnK//ezEr5D4tieg76DUZmd09
gFBJy0VeUY+9/fWsE/JMKGVkhYkFt0rjXqGbd40SzSiXto32Du9sMr1+NRsYTLiS
ZvprFEaFCPcIt2m3THfIcyr6o3hlZzAr/MbJabOi9B8a0dhDnGLDef78M8Xd0nl7
JbTpFFU1vmLtaD+mlW4F8XN81DV9XEx4A9MQcigHQQi8qwfy2n81jznvk0OgSW8Z
beTBPCPLi93QBIBb3KHjeN/+EH7ClzlG72Myr3IAvMMpNeRjxQtP1nij7OhcJrBi
PIn4u/mXRbwL4g2k6H00K3T3l2RAsuPE/ctEbXZPxO0et0Dcer4=
=vt/b
-----END PGP SIGNATURE-----
--=-=-=--

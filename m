Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Date: Fri, 10 Feb 2017 13:19:44 +1100
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 07/10] writeback: Implement reliable switching to default writeback structure
In-Reply-To: <20170209124433.2626-8-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz> <20170209124433.2626-8-jack@suse.cz>
Message-ID: <87zihuu6rj.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09 2017, Jan Kara wrote:

> Currently switching of inode between different writeback structures is
> asynchronous and not guaranteed to succeed. Add a variant of switching
> that is synchronous and reliable so that it can reliably move inode to
> the default writeback structure (bdi->wb) when writeback on bdi is going
> to be shutdown.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/fs-writeback.c         | 60 ++++++++++++++++++++++++++++++++++++++++-=
------
>  include/linux/fs.h        |  3 ++-
>  include/linux/writeback.h |  6 +++++
>  3 files changed, 60 insertions(+), 9 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 23dc97cf2a50..52992a1036b1 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -332,14 +332,11 @@ struct inode_switch_wbs_context {
>  	struct work_struct	work;
>  };
>=20=20
> -static void inode_switch_wbs_work_fn(struct work_struct *work)
> +static void do_inode_switch_wbs(struct inode *inode,
> +				struct bdi_writeback *new_wb)
>  {
> -	struct inode_switch_wbs_context *isw =3D
> -		container_of(work, struct inode_switch_wbs_context, work);
> -	struct inode *inode =3D isw->inode;
>  	struct address_space *mapping =3D inode->i_mapping;
>  	struct bdi_writeback *old_wb =3D inode->i_wb;
> -	struct bdi_writeback *new_wb =3D isw->new_wb;
>  	struct radix_tree_iter iter;
>  	bool switched =3D false;
>  	void **slot;
> @@ -436,15 +433,29 @@ static void inode_switch_wbs_work_fn(struct work_st=
ruct *work)
>  	spin_unlock(&new_wb->list_lock);
>  	spin_unlock(&old_wb->list_lock);
>=20=20
> +	/*
> +	 * Make sure waitqueue_active() check in wake_up_bit() cannot happen
> +	 * before I_WB_SWITCH is cleared. Pairs with the barrier in
> +	 * set_task_state() after wait_on_bit() added waiter to the wait queue.

I think you mean "set_current_state()" ??

It's rather a trap for the unwary, this need for a smp_mb().
Greping for wake_up_bit(), I find quite a few places with barriers -
sometimes clear_bit_unlock() or spin_unlock() - but

fs/block_dev.c-         whole->bd_claiming =3D NULL;
fs/block_dev.c:         wake_up_bit(&whole->bd_claiming, 0);

fs/cifs/connect.c-      clear_bit(TCON_LINK_PENDING, &tlink->tl_flags);
fs/cifs/connect.c:      wake_up_bit(&tlink->tl_flags, TCON_LINK_PENDING);

fs/cifs/misc.c-                 clear_bit(CIFS_INODE_PENDING_WRITERS, &cino=
de->flags);
fs/cifs/misc.c:                 wake_up_bit(&cinode->flags, CIFS_INODE_PEND=
ING_WRITERS);

(several more in cifs)

net/sunrpc/xprt.c-      clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
net/sunrpc/xprt.c-      xprt->ops->close(xprt);
net/sunrpc/xprt.c-      xprt_release_write(xprt, NULL);
net/sunrpc/xprt.c:      wake_up_bit(&xprt->state, XPRT_LOCKED);
(there might be a barrier in ->close or xprt_release_write() I guess)

security/keys/gc.c-             clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_f=
lags);
security/keys/gc.c:             wake_up_bit(&key_gc_flags, KEY_GC_REAPING_K=
EYTYPE);

I wonder if there is a good way to make this less error-prone.
I would suggest that wake_up_bit() should always have a barrier, and
__wake_up_bit() is needed to avoid it, but there is already a
__wake_up_bit() with a slightly different interface.


In this case, you have a spin_unlock() just before the wake_up_bit().
It is my understand that it would provide enough of a barrier (all
writes before are globally visible after), so do you really need
the barrier here?

> +	 */
> +	smp_mb();
> +	wake_up_bit(&inode->i_state, __I_WB_SWITCH);
> +
>  	if (switched) {
>  		wb_wakeup(new_wb);
>  		wb_put(old_wb);
>  	}
> -	wb_put(new_wb);
> +}
>=20=20
> -	iput(inode);
> -	kfree(isw);
> +static void inode_switch_wbs_work_fn(struct work_struct *work)
> +{
> +	struct inode_switch_wbs_context *isw =3D
> +		container_of(work, struct inode_switch_wbs_context, work);
>=20=20
> +	do_inode_switch_wbs(isw->inode, isw->new_wb);
> +	wb_put(isw->new_wb);
> +	iput(isw->inode);
> +	kfree(isw);
>  	atomic_dec(&isw_nr_in_flight);
>  }
>=20=20
> @@ -521,6 +532,39 @@ static void inode_switch_wbs(struct inode *inode, in=
t new_wb_id)
>  }
>=20=20
>  /**
> + * inode_switch_to_default_wb_sync - change the wb association of an ino=
de to
> + *	the default writeback structure synchronously
> + * @inode: target inode
> + *
> + * Switch @inode's wb association to the default writeback structure (bd=
i->wb).
> + * Unlike inode_switch_wbs() the switching is performed synchronously an=
d we
> + * guarantee the inode is switched to the default writeback structure wh=
en this
> + * function returns. Nothing prevents from someone else switching inode =
to
> + * another writeback structure just when we are done though. Preventing =
that is
> + * upto the caller if needed.
> + */
> +void inode_switch_to_default_wb_sync(struct inode *inode)
> +{
> +	struct backing_dev_info *bdi =3D inode_to_bdi(inode);
> +
> +	/* while holding I_WB_SWITCH, no one else can update the association */
> +	spin_lock(&inode->i_lock);
> +	if (WARN_ON_ONCE(inode->i_state & I_FREEING) ||
> +	    !inode_to_wb_is_valid(inode) || inode_to_wb(inode) =3D=3D &bdi->wb)=
 {
> +		spin_unlock(&inode->i_lock);
> +		return;
> +	}
> +	__inode_wait_for_state_bit(inode, __I_WB_SWITCH);

I note that __inode_wait_for_state_bit() can drop and reclaim ->i_lock.
is it possible that:
  !inode_to_wb_is_valid(inode) || inode_to_wb(inode) =3D=3D &bdi->wb)

could change while ->i_lock is unlocked?
It would be particular unfortunate if inode_to_wb(inode) became &bdi->wb
due to some thing thread, as do_inode_switch_wbs() will deadlock if
  inode_to_wb(inode) =3D=3D &bdi->wb

i.e. do you need to repeat the test?

Thanks,
NeilBrown


> +	inode->i_state |=3D I_WB_SWITCH;
> +	spin_unlock(&inode->i_lock);
> +
> +	/* Make I_WB_SWITCH setting visible to unlocked users of i_wb */
> +	synchronize_rcu();
> +
> +	do_inode_switch_wbs(inode, &bdi->wb);
> +}
> +
> +/**
>   * wbc_attach_and_unlock_inode - associate wbc with target inode and unl=
ock it
>   * @wbc: writeback_control of interest
>   * @inode: target inode
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c930cbc19342..319fb76f9081 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1929,7 +1929,8 @@ static inline bool HAS_UNMAPPED_ID(struct inode *in=
ode)
>  #define I_DIRTY_TIME		(1 << 11)
>  #define __I_DIRTY_TIME_EXPIRED	12
>  #define I_DIRTY_TIME_EXPIRED	(1 << __I_DIRTY_TIME_EXPIRED)
> -#define I_WB_SWITCH		(1 << 13)
> +#define __I_WB_SWITCH		13
> +#define I_WB_SWITCH		(1 << __I_WB_SWITCH)
>=20=20
>  #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
>  #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 5527d910ba3d..0d3ba83a0f7f 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -280,6 +280,8 @@ static inline void wbc_init_bio(struct writeback_cont=
rol *wbc, struct bio *bio)
>  		bio_associate_blkcg(bio, wbc->wb->blkcg_css);
>  }
>=20=20
> +void inode_switch_to_default_wb_sync(struct inode *inode);
> +
>  #else	/* CONFIG_CGROUP_WRITEBACK */
>=20=20
>  static inline void inode_attach_wb(struct inode *inode, struct page *pag=
e)
> @@ -319,6 +321,10 @@ static inline void cgroup_writeback_umount(void)
>  {
>  }
>=20=20
> +static inline void inode_switch_to_default_wb_sync(struct inode *inode)
> +{
> +}
> +
>  #endif	/* CONFIG_CGROUP_WRITEBACK */
>=20=20
>  /*
> --=20
> 2.10.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlidI0AACgkQOeye3VZi
gbm3SA/+PnMTTItByuEElpaWxnnWHfxL7BuxED7XWK1Y2gsdEIKv8HjcqtBI1mn7
y9g7AgIhADYtd2paqNjF1IWXo5Se4uVfPYX1gJg/r7xOE8YnNEEIGAqCLcFuEthr
ywvip7MXcE3R82eLMTKb702coNhZfo+1U3h5NUjh1exyUI6zD2L3UlBqFEkSvo0I
nMEzEkG4s6c+pCgz/A0PC7e4z6LgQzrd3LjoSjCbe4lA0WmFqg0gyF2CMlww4DX6
PCzkUv6nGTTAILne7pdMbichno68DBSdSGZhw5RaHyVvoB0lAHQ0/bOGDj8eOce2
GmZvbsy7G9NoR+TpChMgt6xKBJhcE5ewShWvLxTpuABYH34472x01GSg6EdnZi51
18iKrmpHHUQliQ+TjqnRWrgz5eczcEWwGMWZmi85E/I0Ao8rULB4JdvEdoGse44m
UdAW7zvC6YEkxBLdvwLzkYJUQXAcmt/odSeM49ooXEOWVAig9TNqidC1LoW8YUEb
C/RJxIVKlBsL2/rsgusU3J5HEikiCUpvrzPlXtykoKDaqoPxiaD2dv9hHk0PCGnb
Qp2m+rCzNP7SST7e6klSAwi2feV0YATDflLLtfxXOOa0TVZxQO07djPNa578/9IG
0L9uZXeRhDe+j8f3MpfV5f+jWBbjzL/nbxhaxOaKLrxbN/kp8No=
=RI57
-----END PGP SIGNATURE-----
--=-=-=--

Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7332135AF
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736824927; cv=none; b=vDs7P/1FV1kBBwzB4OoqMp0lLI7reqJDgFLOaGHWA907T6BugE/CzyWgrZayy9YheudY44qMnqP3sCDnEsRHXeUM9jawNlm/+eWX6olNkNuFI7zvV3dKJtjLrJiiKl/U19RyQLJNJAUOsckpBpqZuCwyhu+BbGVm3YApzZnyepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736824927; c=relaxed/simple;
	bh=ASEzdU0Dt5yRYAXZrvQOcsMTDNraja+0LoFgeeYo0ZI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qas0SxrnSevAuA0tc5WwRhaKERyTZIZDGDruXBGKCXoW58DinHSJNlgFwxgWpudcLODFvRz9H1mqyk/sJCrFflk6W/Or+7y7H6t9rPDwWgg7JS5uxmJWmzluTJNtQCBpoRyBx7jkji38bAnmaLvMp7r6BaDAToapmti6b8keO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=URYagUOM; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="URYagUOM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736824894;
	bh=ahfNESBqxXzJMjzQTv6Bs/9WG4kIJKwYFLG1dqbvuec=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=URYagUOM782OxRxO7PKX32HDB1ENp/Oa0wm4Ye+3p8Qz2b8phpeKtHirM83YQeld0
	 NphmJwy59xy/qKHQSUk/zTgtpQL/rGDHeczuAajMNgpMpVhbVHAUo6fpC4rG03MINh
	 b4gIMSP+pJJ1tqq04E1oX5vpLjKR5UtEUmzkSH7U=
X-QQ-mid: bizesmtpip3t1736824889tjrgkvq
X-QQ-Originating-IP: VGfKhvh1rKFPlSfP1bN3hBhqeQth+IeM1kUzh3PlUa0=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Jan 2025 11:21:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 676082716532487257
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <20250113022426.703537-1-ming.lei@redhat.com>
Date: Tue, 14 Jan 2025 11:21:17 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D60046B-4E85-4EAA-A864-C7897539524A@m.fudan.edu.cn>
References: <20250113022426.703537-1-ming.lei@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ND3CPZxVFFQc7AHkhtUk7ppgK4Fa9gGEA4wTpwfFZo8wxo/e2HTakYM+
	Y/mwJY9QQDt/CyNeN+DGpJ6WGGT0mWhOTNac9fdPghd3wbkwta4vOHyYJpZus0I+3VBwh2D
	59FNPi/A4JcoLJVyk/umDJOKGDNJ5EoEU5J2KhX9uI0AH2VjKL4hfjV+sT8Zu1j1aqbz258
	pGzBQNWt6ScPLgsrQS1p3uwmKouM0Uv7UsNN8dnwvGos9EyxiRe0MY8RjyuHC1MQjSSkJV/
	WopEqNuVTu40v0472z/RivJ2oN107SqJxAcQ+JLqA+1hJ5GGrxgfBabmMeIeg5rOFnEXfVO
	pMJL+qRLW8yT4JXzvWDOEUGTyTlVngsX8m4fJDZzhvJiQx/ioUSJpHcc1tsn/H/neuwedZQ
	lP2SRH1gfu4Bx3nE57cdcbajvQBuxBnK09/CKoJ6EQqg5r9zJY3WAY7mfe9IhAsdhYmqoW6
	hNlol59qZKD6+hhdgZhZuhu7DhgwjiX9uNLXnLfEzw4pkKcmzEJ1NOpfbV2ly0t7Y3hOXAB
	KAeDZ1SqU4jAo1qBahbOhrG/rRWRBvafp+d1RLmMvHBCZuoHDGKzE6W7yVcZMy8n840BqyV
	/+pLmNL2grTYel3MQM9rLfD05Ar9lRx47awSAsiMGfCrSTYsz1+5Xgw2EbUHfmkqO7Q5fAW
	1NrLdoSCQYh0Bmh5F8re0QRViYbfJJell74Qm1WHJ1NdObHgX2BS3nsiA9cpQXerYyBulIi
	3DwWhcZ2m11ziYSHITdmSDNK8oUflNX74AVh2w5pfPl2HY+Xex3BKVnI4D2tsK0GgOrHrQN
	ZESUc4/gkJHpq/4nc2Q/jsI3XczKgMZqvAa9WRekRNRfYfR0zv8I+ERezLWf94bLtQSvwa6
	yuGGXFCoEvSyTaM5U5EpgShkzyMLRWVAvdu9aM0ZbHxR91/y9Ci8f5rlfCUjawob9tHbUWw
	cGLS/64L3PI0b+WkVRl7YFrLm99SNsX6YobIbD7krCVfCEQH66a0nuxgNzCJUcC5n4e1SsQ
	xEFH1IOFjDxLQnVZymeWczntYQ65o=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

>=20
>=20
> If vfs_flush() is called with queue frozen, the queue freeze lock may =
be
> connected with FS internal lock, and potential deadlock could be
> triggered.
>=20
> Fix it by moving vfs_flush() out of queue freezing.
>=20
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
> Reported-by: Jiaji Qin <jjtan24@m.fudan.edu.cn>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> drivers/block/loop.c | 21 +++++++++++++++------
> 1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1ec7417c7f00..9adf496b3f93 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -203,7 +203,7 @@ static bool lo_can_use_dio(struct loop_device *lo)
>  * loop_get_status will always report the effective LO_FLAGS_DIRECT_IO =
flag and
>  * not the originally passed in one.
>  */
> -static inline void loop_update_dio(struct loop_device *lo)
> +static inline bool loop_update_dio(struct loop_device *lo)
> {
> bool dio_in_use =3D lo->lo_flags & LO_FLAGS_DIRECT_IO;
>=20
> @@ -217,8 +217,7 @@ static inline void loop_update_dio(struct =
loop_device *lo)
> lo->lo_flags &=3D ~LO_FLAGS_DIRECT_IO;
>=20
> /* flush dirty pages before starting to issue direct I/O */
> - if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
> - vfs_fsync(lo->lo_backing_file, 0);
> + return (lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use;
> }
>=20
> /**
> @@ -589,6 +588,7 @@ static int loop_change_fd(struct loop_device *lo, =
struct block_device *bdev,
> int error;
> bool partscan;
> bool is_loop;
> + bool flush;
>=20
> if (!file)
> return -EBADF;
> @@ -629,11 +629,14 @@ static int loop_change_fd(struct loop_device =
*lo, struct block_device *bdev,
> lo->old_gfp_mask =3D mapping_gfp_mask(file->f_mapping);
> mapping_set_gfp_mask(file->f_mapping,
>     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
> - loop_update_dio(lo);
> + flush =3D loop_update_dio(lo);
> blk_mq_unfreeze_queue(lo->lo_queue);
> partscan =3D lo->lo_flags & LO_FLAGS_PARTSCAN;
> loop_global_unlock(lo, is_loop);
>=20
> + if (flush)
> + vfs_fsync(lo->lo_backing_file, 0);
> +
> /*
> * Flush loop_validate_file() before fput(), for l->lo_backing_file
> * might be pointing at old_file which might be the last reference.
> @@ -1255,6 +1258,7 @@ loop_set_status(struct loop_device *lo, const =
struct loop_info64 *info)
> int err;
> bool partscan =3D false;
> bool size_changed =3D false;
> + bool flush =3D false;
>=20
> err =3D mutex_lock_killable(&lo->lo_mutex);
> if (err)
> @@ -1292,7 +1296,7 @@ loop_set_status(struct loop_device *lo, const =
struct loop_info64 *info)
> }
>=20
> /* update the direct I/O flag if lo_offset changed */
> - loop_update_dio(lo);
> + flush =3D loop_update_dio(lo);
>=20
> out_unfreeze:
> blk_mq_unfreeze_queue(lo->lo_queue);
> @@ -1302,6 +1306,8 @@ loop_set_status(struct loop_device *lo, const =
struct loop_info64 *info)
> mutex_unlock(&lo->lo_mutex);
> if (partscan)
> loop_reread_partitions(lo);
> + if (flush)
> + vfs_fsync(lo->lo_backing_file, 0);
>=20
> return err;
> }
> @@ -1473,6 +1479,7 @@ static int loop_set_block_size(struct =
loop_device *lo, unsigned long arg)
> {
> struct queue_limits lim;
> int err =3D 0;
> + bool flush;
>=20
> if (lo->lo_state !=3D Lo_bound)
> return -ENXIO;
> @@ -1488,8 +1495,10 @@ static int loop_set_block_size(struct =
loop_device *lo, unsigned long arg)
>=20
> blk_mq_freeze_queue(lo->lo_queue);
> err =3D queue_limits_commit_update(lo->lo_queue, &lim);
> - loop_update_dio(lo);
> + flush =3D loop_update_dio(lo);
> blk_mq_unfreeze_queue(lo->lo_queue);
> + if (flush)
> + vfs_fsync(lo->lo_backing_file, 0);
>=20
> return err;
> }
> --=20
> 2.44.0
>=20
>=20

Hello Ming,

Should we test the fixed code through multiple rounds? Is there a =
conclusion to the ongoing discussion about the patch?

=E2=80=94=E2=80=94
Thanks,
Kun Hu


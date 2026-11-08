Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794107928;
	b=2ycGQ5zgC/ToUUnSlX8capnoKa5iZjyHgX34rbgwHapMBl37DSgNJl0mc1NzvooL/AH3
	 BfutGg5vxIjYlFYsf1y7fA4GnTs9ncIWQ1Cvdk4y1wyDC2/6vTiifUKWQ/uIKQjccr5tK
	 LOe2F2+lyKaEq2AQaXdhlQflxG909+6WyqzfWH7OmlDBG1fKvfVSeUVAYqe7wn0A5FDAb
	 o2PLvh9o7iU0EOalwV30MG3o9gUvK50oEgVvPNGbkWlBoCnCtXnywyaZZQY5VHmA91IMj
	 vvkoE6sMl7lpXV/jteGtV68Tjhpd/8F2YG1jEQLJ++zmHcOWKSX2zc/nRYiN+JNQgIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794107928;
	h=DMARC-Filter:DKIM-Signature:Date:X-Original-From:Content-Type:Cc:
	 Subject:User-Agent:Received:References:Content-Transfer-Encoding:From:
	 Reply-To:To:In-Reply-To:X-Lms-Return-Path:Message-Id:Mime-Version;
	bh=hMhZT7psbWLR091aTqQWUxBezLC3JgL6hyV2GB3JK9A=;
	b=N8TDTUwnN4URxiw9IqGsI5Epwrd94IDvAGaibgwuHLc+B2TK0F6b3pv7qPxo5lbC0a7B
	 AcsREhMTuIwPTi9JiobsRLQKXwYIXrI0zHCKF55vrXIvK+SMihjNwVcrMreB8fIW3bnt/
	 usGk8QMIOmtP0AhxtYOA+fSOYKOrXHwtA5EhcvPUlGPTmOWSihJh6SUL74KvUJwLrc/XD
	 ZA9lUQAw27KpCXgLCqnU3udrIUz6JgO1418T8WxVe2+8MXTmplU1Wx6mj7NcCgZrMXLvd
	 kgA0c0RPdvUKCmAIj786espyKEGbgHYoYC0O0kn0Dl8CkY3RdLjxKllPZHcP9p4gKQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fygo.io;
	spf=pass smtp.mailfrom=fygo.io;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b="hkmOTbD/";
	arc=none smtp.remote-ip=209.127.231.59
Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71936606A31A
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 03:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71936606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=hkmOTbD/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1794107922;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=hMhZT7psbWLR091aTqQWUxBezLC3JgL6hyV2GB3JK9A=;
 b=hkmOTbD/mE2L9g3rImX7p8kDc8PjYRUdlMoL9iXg39p3gqLT1T4sTXFGUURll9W/cADouD
 M7Tca8zRYKvaGfiQrm8MtQp0H1wuUnNYfrkH0UnsKrEr+nuTX64PJTLwO7s/Gf/F2Tmggt
 NBlD0LHTKh0sgdMOfMtDrRtz7ElaRjsqPY9YbuXoSAtld7vs0lnvFgN5/MkX5892C8Vws7
 wRL2aXI02yP3KEt722vMs+l2MSVXqPQ3EcxwldPK1U+wfwGcI9muWZrzM2zU71seBG3xXA
 3eOjM4DIXtDHLEiApQS7RKh/qruNo76DD2EuRGqRqYSs0QFQ6pkm1pNUwoteRg==
Date: Sun, 8 Nov 2026 11:18:38 +0800
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Cc: <syzbot+cd254889291ef8666036@syzkaller.appspotmail.com>
Subject: Re: [PATCH] md: avoid block autoload while importing rdev under reconfig_mutex
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.55]) by smtp.larksuite.com with ESMTPS; Sun, 08 Nov 2026 03:18:41 +0000
References: <20261103115530.2913093-1-wangjichen@kaihong.com>
Content-Transfer-Encoding: quoted-printable
From: "yu kuai" <yukuai@fygo.io>
Reply-To: yukuai@fygo.io
To: "Wang Jichen" <wangjichen@kaihong.com>, "Jens Axboe" <axboe@kernel.dk>, 
	"Song Liu" <song@kernel.org>, "Li Nan" <magiclinan@didiglobal.com>, 
	"Xiao Ni" <xiao@kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
In-Reply-To: <20261103115530.2913093-1-wangjichen@kaihong.com>
X-Lms-Return-Path: <lba+26aefea12+6aac98+vger.kernel.org+yukuai@fygo.io>
Message-Id: <90fee426-1a0c-4964-bf20-8175a64917a4@fygo.io>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0

Hi,

=E5=9C=A8 2026/11/3 19:55, Wang Jichen =E5=86=99=E9=81=93:
> From: wangjichen <wangjichen@kaihong.com>
>
> md_import_device() runs with mddev->reconfig_mutex held from md_ioctl().
> Opening a member disk via bdev_file_open_by_dev() triggers legacy block
> autoload (blk_probe_dev), which takes major_names_lock. md_probe() can
> run under that lock and call md_alloc(), which takes disks_mutex and
> reconfig_mutex =E2=80=94 a lockdep ABBA with the ioctl path.

Is this a real deadlock? mddev is already existed from md_import_device(),
while md_alloc() just allocate a new mddev, so the reconfig_mtuex is not
the same.

>
> Add bdev_file_open_by_dev_autoload() and use autoload=3Dfalse from
> md_import_device(); member devices must already be present in the
> block layer (normal mdadmin usage).
>
> Link: https://syzbot.org/bug?extid=3Dcd254889291ef8666036
> Reported-by: syzbot+cd254889291ef8666036@syzkaller.appspotmail.com
> Tested-by: Wang Jichen <wangjichen@kaihong.com>
> Signed-off-by: Wang Jichen <wangjichen@kaihong.com>
> ---
>   block/bdev.c           | 13 ++++++++++---
>   drivers/md/md.c        |  8 ++++++--
>   include/linux/blkdev.h |  2 ++
>   3 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/block/bdev.c b/block/bdev.c
> index f20f91b31..e78936556 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1076,8 +1076,8 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
>   	return flags;
>   }
>  =20
> -struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *hol=
der,
> -				   const struct blk_holder_ops *hops)
> +struct file *bdev_file_open_by_dev_autoload(dev_t dev, blk_mode_t mode,
> +		void *holder, const struct blk_holder_ops *hops, bool autoload)
>   {
>   	struct file *bdev_file;
>   	struct block_device *bdev;
> @@ -1088,7 +1088,7 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_m=
ode_t mode, void *holder,
>   	if (ret)
>   		return ERR_PTR(ret);
>  =20
> -	bdev =3D blkdev_get_no_open(dev, true);
> +	bdev =3D blkdev_get_no_open(dev, autoload);
>   	if (!bdev)
>   		return ERR_PTR(-ENXIO);
>  =20
> @@ -1110,6 +1110,13 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_=
mode_t mode, void *holder,
>   	}
>   	return bdev_file;
>   }
> +EXPORT_SYMBOL(bdev_file_open_by_dev_autoload);
> +
> +struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *hol=
der,
> +				   const struct blk_holder_ops *hops)
> +{
> +	return bdev_file_open_by_dev_autoload(dev, mode, holder, hops, true);
> +}
>   EXPORT_SYMBOL(bdev_file_open_by_dev);
>  =20
>   struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 03e35386a..d3717e2e8 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3858,9 +3858,13 @@ static struct md_rdev *md_import_device(dev_t newd=
ev, int super_format, int supe
>   	if (err)
>   		goto out_clear_rdev;
>  =20
> -	rdev->bdev_file =3D bdev_file_open_by_dev(newdev,
> +	/*
> +	 * md_ioctl() holds reconfig_mutex; legacy autoload in bdev open takes
> +	 * major_names_lock via blk_probe_dev() and can deadlock with md_probe(=
).
> +	 */
> +	rdev->bdev_file =3D bdev_file_open_by_dev_autoload(newdev,
>   			BLK_OPEN_READ | BLK_OPEN_WRITE,
> -			super_format =3D=3D -2 ? &claim_rdev : rdev, NULL);
> +			super_format =3D=3D -2 ? &claim_rdev : rdev, NULL, false);
>   	if (IS_ERR(rdev->bdev_file)) {
>   		pr_warn("md: could not open device unknown-block(%u,%u).\n",
>   			MAJOR(newdev), MINOR(newdev));
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 0c2010230..e5121101a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1699,6 +1699,8 @@ struct blk_holder_ops {
>  =20
>   struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *ho=
lder,
>   		const struct blk_holder_ops *hops);
> +struct file *bdev_file_open_by_dev_autoload(dev_t dev, blk_mode_t mode,
> +		void *holder, const struct blk_holder_ops *hops, bool autoload);
>   struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
>   		void *holder, const struct blk_holder_ops *hops);
>   int bd_prepare_to_claim(struct block_device *bdev, void *holder,

--=20
Thanks,
Kuai

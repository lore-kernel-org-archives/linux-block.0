Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A81FC33C9E
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 02:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D754F24671
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 02:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw2vwbgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOC1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:27:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29754 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728877AbgAOC1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jan 2020 21:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579055262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MX/KqGc3zFqH4ifets/x9qWKK78+84NEcESsqTPOJo=;
        b=Bw2vwbgoKHUMpnd+j2yf22voyvpcl+WuC2Afpjewu4Cs2jgW65qrHMKuU1I8Nq70YL2c9h
        syHlDd5K9XjRZtE/dSA0iAWgZi9HAMfF6I0vQqR4Kb+Nz5pW0A+ZptYMMoJQJhP/Qp2xRb
        9ZtCkAtOlx4sSep6TA5g3JLjVMpojIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-ib40Bu_HNEi4h-Uz0Q1jfw-1; Tue, 14 Jan 2020 21:27:38 -0500
X-MC-Unique: ib40Bu_HNEi4h-Uz0Q1jfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3852E107ACC5;
        Wed, 15 Jan 2020 02:27:37 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05D645C1D6;
        Wed, 15 Jan 2020 02:27:29 +0000 (UTC)
Date:   Wed, 15 Jan 2020 10:27:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
Subject: Re: [PATCH V3] brd: check and limit max_part par
Message-ID: <20200115022725.GA14585@ming.t460p>
References: <c8236e55-f64f-ef40-b394-8b7e86ce50df@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c8236e55-f64f-ef40-b394-8b7e86ce50df@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 14, 2020 at 07:56:07PM +0800, Zhiqiang Liu wrote:
>=20
> In brd_init func, rd_nr num of brd_device are firstly allocated
> and add in brd_devices, then brd_devices are traversed to add each
> brd_device by calling add_disk func. When allocating brd_device,
> the disk->first_minor is set to i * max_part, if rd_nr * max_part
> is larger than MINORMASK, two different brd_device may have the same
> devt, then only one of them can be successfully added.
> when rmmod brd.ko, it will cause oops when calling brd_exit.
>=20
> Follow those steps:
>   # modprobe brd rd_nr=3D3 rd_size=3D102400 max_part=3D1048576
>   # rmmod brd
> then, the oops will appear.
>=20
> Oops log:
> [  726.613722] Call trace:
> [  726.614175]  kernfs_find_ns+0x24/0x130
> [  726.614852]  kernfs_find_and_get_ns+0x44/0x68
> [  726.615749]  sysfs_remove_group+0x38/0xb0
> [  726.616520]  blk_trace_remove_sysfs+0x1c/0x28
> [  726.617320]  blk_unregister_queue+0x98/0x100
> [  726.618105]  del_gendisk+0x144/0x2b8
> [  726.618759]  brd_exit+0x68/0x560 [brd]
> [  726.619501]  __arm64_sys_delete_module+0x19c/0x2a0
> [  726.620384]  el0_svc_common+0x78/0x130
> [  726.621057]  el0_svc_handler+0x38/0x78
> [  726.621738]  el0_svc+0x8/0xc
> [  726.622259] Code: aa0203f6 aa0103f7 aa1e03e0 d503201f (7940e260)
>=20
> Here, we add brd_check_and_reset_par func to check and limit max_part p=
ar.
>=20
> --
> V2->V3: (suggested by Ming Lei)
>  - clear .minors when running out of consecutive minor space in brd_all=
oc
>  - remove limit of rd_nr
>=20
> V1->V2: add more checks in brd_check_par_valid as suggested by Ming Lei=
.
>=20
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  drivers/block/brd.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index df8103dd40ac..2295a0bafb5e 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -330,16 +330,16 @@ static const struct block_device_operations brd_f=
ops =3D {
>  /*
>   * And now the modules code and kernel interface.
>   */
> -static int rd_nr =3D CONFIG_BLK_DEV_RAM_COUNT;
> -module_param(rd_nr, int, 0444);
> +static unsigned int rd_nr =3D CONFIG_BLK_DEV_RAM_COUNT;
> +module_param(rd_nr, uint, 0444);

The above change isn't needed.

>  MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
>=20
>  unsigned long rd_size =3D CONFIG_BLK_DEV_RAM_SIZE;
>  module_param(rd_size, ulong, 0444);
>  MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
>=20
> -static int max_part =3D 1;
> -module_param(max_part, int, 0444);
> +static unsigned int max_part =3D 1;
> +module_param(max_part, uint, 0444);

The above change isn't needed.

>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>=20
>  MODULE_LICENSE("GPL");
> @@ -393,7 +393,14 @@ static struct brd_device *brd_alloc(int i)
>  	if (!disk)
>  		goto out_free_queue;
>  	disk->major		=3D RAMDISK_MAJOR;
> -	disk->first_minor	=3D i * max_part;
> +	/*
> +	 * Clear .minors when running out of consecutive minor space since
> +	 * GENHD_FL_EXT_DEVT is set, and we can allocate from extended devt.
> +	 */
> +	if ((i * disk->minors) & ~MINORMASK)
> +		disk->minors =3D 0;
> +	else
> +		disk->first_minor =3D i * disk->minors;

The above looks a bit ugly, one nice way could be to change in
brd_alloc():

	disk =3D brd->brd_disk =3D alloc_disk(((i * max_part) & ~MINORMASK) ?
		0 : max_part);

>  	disk->fops		=3D &brd_fops;
>  	disk->private_data	=3D brd;
>  	disk->queue		=3D brd->brd_queue;
> @@ -468,6 +475,21 @@ static struct kobject *brd_probe(dev_t dev, int *p=
art, void *data)
>  	return kobj;
>  }
>=20
> +static inline void brd_check_and_reset_par(void)
> +{
> +	if (unlikely(!rd_nr))
> +		rd_nr =3D 1;

zero rd_nr should work as expected, given user can create dev file via
mknod, and brd_probe() will be called for populate brd disk/queue when
the disk file is opened.

> +static inline void brd_check_and_reset_par(void)
> +{
> + =A0 =A0 =A0 if (unlikely(!rd_nr))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rd_nr =3D 1;
> +
> + =A0 =A0 =A0 if (unlikely(!max_part))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_part =3D 1;

Another limit is that 'max_part' needs to be divided exactly by (1U <<
MINORBITS), something like:

	max_part =3D 1UL << fls(max_part);


Thanks,=20
Ming


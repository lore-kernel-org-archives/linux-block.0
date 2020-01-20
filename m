Return-Path: <SRS0=Aqm6=3J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5989C33CAA
	for <linux-block@archiver.kernel.org>; Mon, 20 Jan 2020 22:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A74722522
	for <linux-block@archiver.kernel.org>; Mon, 20 Jan 2020 22:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMoUJnxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgATW7P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:59:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52633 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726607AbgATW7P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 17:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579561154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYSjWv1dfnioBe8F1SvdnjqlkR0e7zTphIpvFJSRRIE=;
        b=WMoUJnxPrxB3Lp6s0xqQE2I42FEfi8x6pN8GOOmRzyovzTaSEeuxf24WjXyk6R9I6D7j83
        PxYg5hlYwI4AgFBIZ9+CdbhtXaEDpT7kHpAyqXWtc71+AZ1wOk+JUee13x7tucvp1kAKkW
        hYbR312d+kIH0Twz+l7klogrenh1Q7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-FxJAN8_wOWiCy0tquRdetw-1; Mon, 20 Jan 2020 17:59:10 -0500
X-MC-Unique: FxJAN8_wOWiCy0tquRdetw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F5CB18FF661;
        Mon, 20 Jan 2020 22:59:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF5D61001B2D;
        Mon, 20 Jan 2020 22:59:02 +0000 (UTC)
Date:   Tue, 21 Jan 2020 06:58:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
Subject: Re: [PATCH V3] brd: check and limit max_part par
Message-ID: <20200120225858.GB19571@ming.t460p>
References: <c8236e55-f64f-ef40-b394-8b7e86ce50df@huawei.com>
 <20200115022725.GA14585@ming.t460p>
 <ce5823ea-2183-90df-05b0-c02d1f654be3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ce5823ea-2183-90df-05b0-c02d1f654be3@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 20, 2020 at 09:14:50PM +0800, Zhiqiang Liu wrote:
>=20
>=20
> On 2020/1/15 10:27, Ming Lei wrote:
>=20
> >=20
> >>  MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
> >>
> >>  unsigned long rd_size =3D CONFIG_BLK_DEV_RAM_SIZE;
> >>  module_param(rd_size, ulong, 0444);
> >>  MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
> >>
> >> -static int max_part =3D 1;
> >> -module_param(max_part, int, 0444);
> >> +static unsigned int max_part =3D 1;
> >> +module_param(max_part, uint, 0444);
> >=20
> > The above change isn't needed.
> Thanks for your suggestion.
> I will remove that in v4 patch.
> >=20
> >>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices")=
;
> >>
> >>  MODULE_LICENSE("GPL");
> >> @@ -393,7 +393,14 @@ static struct brd_device *brd_alloc(int i)
> >>  	if (!disk)
> >>  		goto out_free_queue;
> >>  	disk->major		=3D RAMDISK_MAJOR;
> >> -	disk->first_minor	=3D i * max_part;
> >> +	/*
> >> +	 * Clear .minors when running out of consecutive minor space since
> >> +	 * GENHD_FL_EXT_DEVT is set, and we can allocate from extended dev=
t.
> >> +	 */
> >> +	if ((i * disk->minors) & ~MINORMASK)
> >> +		disk->minors =3D 0;
> >> +	else
> >> +		disk->first_minor =3D i * disk->minors;
> >=20
> > The above looks a bit ugly, one nice way could be to change in
> > brd_alloc():
> >=20
> > 	disk =3D brd->brd_disk =3D alloc_disk(((i * max_part) & ~MINORMASK) =
?
> > 		0 : max_part);
>=20
> I will change it as your suggestion.
>=20
> >=20
> >>  	disk->fops		=3D &brd_fops;
> >>  	disk->private_data	=3D brd;
> >>  	disk->queue		=3D brd->brd_queue;
> >> @@ -468,6 +475,21 @@ static struct kobject *brd_probe(dev_t dev, int=
 *part, void *data)
> >>  	return kobj;
> >>  }
> >>
> >> +static inline void brd_check_and_reset_par(void)
> >> +{
> >> +	if (unlikely(!rd_nr))
> >> +		rd_nr =3D 1;
> >=20
> > zero rd_nr should work as expected, given user can create dev file vi=
a
> > mknod, and brd_probe() will be called for populate brd disk/queue whe=
n
> > the disk file is opened.
> >=20
> >> +static inline void brd_check_and_reset_par(void)
> >> +{
> >> + =A0 =A0 =A0 if (unlikely(!rd_nr))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rd_nr =3D 1;
> >> +
> >> + =A0 =A0 =A0 if (unlikely(!max_part))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_part =3D 1;
> >=20
> > Another limit is that 'max_part' needs to be divided exactly by (1U <=
<
> > MINORBITS), something like:
> >=20
> > 	max_part =3D 1UL << fls(max_part)
>=20
> Do we have to limit that 'max_part' needs to be divided exactly by (1U =
<<
> > MINORBITS)? As your suggestion, the i * max_part is larger than MINOR=
MASK,
> we can allocate from extended devt.

Exact dividing is for reserving same minors for all disks with
RAMDISK_MAJOR, otherwise there is still chance to get same dev_t when
adding partitions.

Extended devt is for covering more disks, not related with 'max_part'.


Thanks,
Ming


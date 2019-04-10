Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F14C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 13:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D19120830
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 13:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfDJNMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:12:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbfDJNMb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 09:12:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAF913084248;
        Wed, 10 Apr 2019 13:12:30 +0000 (UTC)
Received: from localhost (ovpn-117-202.ams2.redhat.com [10.36.117.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E773F5D961;
        Wed, 10 Apr 2019 13:12:26 +0000 (UTC)
Date:   Wed, 10 Apr 2019 14:12:25 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio-blk: limit number of hw queues by nr_cpu_ids
Message-ID: <20190410131225.GA8210@stefanha-x1.localdomain>
References: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
 <1553682995-5682-2-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <1553682995-5682-2-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 10 Apr 2019 13:12:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 06:36:34PM +0800, Dongli Zhang wrote:
> When tag_set->nr_maps is 1, the block layer limits the number of hw queues
> by nr_cpu_ids. No matter how many hw queues are used by virtio-blk, as it
> has (tag_set->nr_maps =3D=3D 1), it can use at most nr_cpu_ids hw queues.
>=20
> In addition, specifically for pci scenario, when the 'num-queues' specifi=
ed
> by qemu is more than maxcpus, virtio-blk would not be able to allocate mo=
re
> than maxcpus vectors in order to have a vector for each queue. As a resul=
t,
> it falls back into MSI-X with one vector for config and one shared for
> queues.
>=20
> Considering above reasons, this patch limits the number of hw queues used
> by virtio-blk by nr_cpu_ids.
>=20
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/block/virtio_blk.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcreu5AAoJEJykq7OBq3PIv1QH/3Xfhaaouf6EN6cUvjc1C8S5
zptX9W26vBX9yhTbAcJTDQ8ETXOri7HIE0e6fGMPUPc5TQQlShnC74b7d8aUqFS2
lxl08VctShlE+vB3YVP5K6FOZ82sHszI+uZde/rTt+2+wZqcOqNz0rzi5H+GwZRQ
QwC3c/Juo/wdG48aWliZrQDApazeKf/2YY+LBqj43Wk7F+X5X65SEiuQkY2xzp0t
VFLrAGxycRpiL0JBTnXf4VtmP+vox26KmLtccRVZktcgckHuexe05nMGFVhy30aB
PkQCu7gUEV9AC6kNT4fO6GML6EPHNWnrGRg4qbgZ0htLuQpDTUYonrOR3q3cDkc=
=TWiv
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

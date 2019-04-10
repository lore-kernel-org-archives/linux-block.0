Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C48C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 13:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C41220830
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 13:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfDJNMl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbfDJNMl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 09:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0C982D7ED;
        Wed, 10 Apr 2019 13:12:40 +0000 (UTC)
Received: from localhost (ovpn-117-202.ams2.redhat.com [10.36.117.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 123511062225;
        Wed, 10 Apr 2019 13:12:32 +0000 (UTC)
Date:   Wed, 10 Apr 2019 14:12:28 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi: virtio_scsi: limit number of hw queues by
 nr_cpu_ids
Message-ID: <20190410131228.GB8210@stefanha-x1.localdomain>
References: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
 <1553682995-5682-3-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <1553682995-5682-3-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 10 Apr 2019 13:12:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 06:36:35PM +0800, Dongli Zhang wrote:
> When tag_set->nr_maps is 1, the block layer limits the number of hw queues
> by nr_cpu_ids. No matter how many hw queues are used by virtio-scsi, as it
> has (tag_set->nr_maps =3D=3D 1), it can use at most nr_cpu_ids hw queues.
>=20
> In addition, specifically for pci scenario, when the 'num_queues' specifi=
ed
> by qemu is more than maxcpus, virtio-scsi would not be able to allocate
> more than maxcpus vectors in order to have a vector for each queue. As a
> result, it falls back into MSI-X with one vector for config and one shared
> for queues.
>=20
> Considering above reasons, this patch limits the number of hw queues used
> by virtio-scsi by nr_cpu_ids.
>=20
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/scsi/virtio_scsi.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcreu8AAoJEJykq7OBq3PIvCcIAJk0lXKMxHlM2G2cGbmwHZh+
Vg/WLG3lMPI+4bn8Ze+aH4LqvwJWaFbd9hjs0hQ4UuDZ2obQi8neJYeUx1ZD0Wii
dOnHvCtFxvhEOKGNv9aW8EUbMrV1Aytji+inw1Cf6xawY5G8qg1LEBKd4a341Zkm
jEMguwG9Rt1fBQbd9jP14Nbj2VyD/qAxDQVC8Cd0DfLEmfjl35HEu+bvHcMnUFw5
h/WsViGOWzKmk/3YVOLzSXrbf8kgdBu30knaYhYWR/OkJkTDqGiy5kf2eqdWSLcD
RWtZxZzpMM0hoh4GwExjnCBhw0G8npzermidU/6a1j9zk74CEUvBGj0H2RfzXEA=
=kK0F
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

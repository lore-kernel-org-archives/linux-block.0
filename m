Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0515FC04EBF
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84D820848
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 18:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84D820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLCS7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:59:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62429 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbeLCS7Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Dec 2018 13:59:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3E7F309178C;
        Mon,  3 Dec 2018 18:59:12 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-74.rdu2.redhat.com [10.10.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 655B360BE0;
        Mon,  3 Dec 2018 18:59:09 +0000 (UTC)
Message-ID: <e295bca26fce6408c7265292e81107b04a1a144d.camel@redhat.com>
Subject: Re: [PATCH V2] mm: Replace all open encodings for NUMA_NO_NODE
From:   Doug Ledford <dledford@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ocfs2-devel@oss.oracle.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-media@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        akpm@linux-foundation.org, jiangqi903@gmail.com,
        hverkuil@xs4all.nl, vkoul@kernel.org
Date:   Mon, 03 Dec 2018 13:59:08 -0500
In-Reply-To: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Jgd362xHNNmppwzCQCK+"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 03 Dec 2018 18:59:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--=-Jgd362xHNNmppwzCQCK+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-26 at 17:56 +0530, Anshuman Khandual wrote:
> At present there are multiple places where invalid node number is encoded
> as -1. Even though implicitly understood it is always better to have macr=
os
> in there. Replace these open encodings for an invalid node number with th=
e
> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions lik=
e
> 'invalid node' from various places redirecting them to a common definitio=
n.
>=20
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V2:
>=20
> - Added inclusion of 'numa.h' header at various places per Andrew
> - Updated 'dev_to_node' to use NUMA_NO_NODE instead per Vinod
>=20
> Changes in V1: (https://lkml.org/lkml/2018/11/23/485)
>=20
> - Dropped OCFS2 changes per Joseph
> - Dropped media/video drivers changes per Hans
>=20
> RFC - https://patchwork.kernel.org/patch/10678035/
>=20
> Build tested this with multiple cross compiler options like alpha, sparc,
> arm64, x86, powerpc, powerpc64le etc with their default config which migh=
t
> not have compiled tested all driver related changes. I will appreciate
> folks giving this a test in their respective build environment.
>=20
> All these places for replacement were found by running the following grep
> patterns on the entire kernel code. Please let me know if this might have
> missed some instances. This might also have replaced some false positives=
.
> I will appreciate suggestions, inputs and review.
>=20
> 1. git grep "nid =3D=3D -1"
> 2. git grep "node =3D=3D -1"
> 3. git grep "nid =3D -1"
> 4. git grep "node =3D -1"
>=20
>  drivers/infiniband/hw/hfi1/affinity.c         |  3 ++-
>  drivers/infiniband/hw/hfi1/init.c             |  3 ++-

For the drivers/infiniband changes,

Acked-by: Doug Ledford <dledford@redhat.com>

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Jgd362xHNNmppwzCQCK+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlwFfPwACgkQuCajMw5X
L911nA/+Pq4noh4r/S3RhvajccFUfwzT5+IhZ7V69GHF9EaiPK8E1lka1m7BdNtX
MlRVfjw6oW1Gs5uQFJfJC2qucbFLzZOm1I25GgzLq/iEq0ItnvUBVC13P2W5bmIa
OB1zY9MRcBQs3T9W3/rcwFwxzYBIh9YsFNbq+op5uu5iUnKsLYenyPPTnWSVj5qO
PWFKzPVxp68NmPpc/vPph6SrazSdSChuZFH06PElH0ifHC+Gde6gCuBSiX4dNCm5
NzODtQz2AqmWPLS7XrgwtN2VGdjN8sPpQBcaYMV9aYOXzXdn5BexsgtoSd5VHdUN
UZOUZQi/1UwA/i+Ngg86mv7nKWh/sxflS7a+F3u3xR9BoP09Gtt41Yu+zLZ28omr
NTKrHWhoiv+WFY+iXoCCtPbI8TYjTuqyVhqHOZiMzX9rTxYBZ3wtHMOqmdQl5K69
nnpJpIJr0uFEehieZvo7Tcvj28D7kDUwYN66HkEJcie71Uu45+lW2HoaIQwURsnY
ot6h/yf8X2Pu1PY4A9FjXeFbECh4qXjZXevOz6vDaubqVwWtQdpoGl78KPd8WaJ+
8tCtiT+L99uUE6sZoLaTdYd/EYsABxfbduwcTOdpNWVgxx2bxDXSgWkAd1bk0A0k
zFoViov/qfs5E2JiGmVcxPeya+X/5gFMM8vJRwIvhMyokGfWRLg=
=LheN
-----END PGP SIGNATURE-----

--=-Jgd362xHNNmppwzCQCK+--


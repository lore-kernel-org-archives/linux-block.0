Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A81C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F3C218E2
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 15:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCUP5w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:57:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUP5w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 11:57:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A2E630842A9;
        Thu, 21 Mar 2019 15:57:52 +0000 (UTC)
Received: from localhost (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 334C460BE5;
        Thu, 21 Mar 2019 15:57:47 +0000 (UTC)
Date:   Thu, 21 Mar 2019 15:57:46 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Cornelia Huck <cohuck@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Message-ID: <20190321155746.GE31434@stefanha-x1.localdomain>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
 <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
 <20190313103900.1ea7f996.cohuck@redhat.com>
 <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
 <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
 <20190315134112.7d63348c.cohuck@redhat.com>
 <1df52766-88fb-6b23-d160-b891c3017133@redhat.com>
 <0fbdcfa6-cbd7-4f09-93b1-40898d5f77d1@oracle.com>
 <f92a5ef9-04b9-d6fa-a7f8-c855a87cd0fb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <f92a5ef9-04b9-d6fa-a7f8-c855a87cd0fb@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 21 Mar 2019 15:57:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 08:53:33PM +0800, Jason Wang wrote:
>=20
> On 2019/3/19 =E4=B8=8A=E5=8D=8810:22, Dongli Zhang wrote:
> > Hi Jason,
> >=20
> > On 3/18/19 3:47 PM, Jason Wang wrote:
> > > On 2019/3/15 =E4=B8=8B=E5=8D=888:41, Cornelia Huck wrote:
> > > > On Fri, 15 Mar 2019 12:50:11 +0800
> > > > Jason Wang <jasowang@redhat.com> wrote:
> > option 3:
> > We should allow more vectors even the block layer would support at most
> > nr_cpu_ids queues.
> >=20
> >=20
> > I understand a new policy for queue-vector mapping is very helpful. I a=
m just
> > asking the question from block layer's point of view.
> >=20
> > Thank you very much!
> >=20
> > Dongli Zhang
>=20
>=20
> Don't know much for block, cc Stefan for more idea.

Thanks for CCing me.  I don't have much input at this stage.

Stefan

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJck7R5AAoJEJykq7OBq3PISGcH+gL2UqKuOclQNeDq8We5P/mv
norBWe7BE3V9Aj0u8b9s6rNXKi9XYRoKPMMC3jf8EZmefL95c4nsaCG8cNG0juj8
uv50QGn0VoN9tXlVakv2+b99X2mXhFfok0Z68+jPYq1LMIRFaTVqZkutgiIXOBLV
rG20zEUVSHvoY/n7TWXmJRn3O/PSYxoR312UR/vwFZWlQUwZJme4yYFpBBiuY7ur
I8F2OmH0oVtb/qvJ9XF2zqI48Nwy5OWnhkTNRHSsudw7njAwJfXRNpk/GbOlHLYD
FnQGST7MJrpiQCvCWkZADFGJ1wmlb0bFJ1R5qkME5+zxYq2VbQ9CiiklD8yBXBw=
=9/HK
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--

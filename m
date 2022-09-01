Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DBBECAAD3
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 13:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiIANXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiIANWy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 09:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD527C180
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662038495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=48ZrCGZe7K0cvvuCVhO+dafm0VT4JSpog39HrYSuBqk=;
        b=IKkyBOeWy+wJv/ChR3kOY692tNVNb/JYbX4Ok6yc4VSv6ufD0RNdiEtQDXtSQKnWPyIwb3
        arpZbCQX7XkpCenNvvvbEK6UowswGGkGhEuIUJJYM2Y5ZDb10nx6Fv4pFL6vbOO09tpaw8
        hR8PN+IGd2ZVYbOdUkNJ4bV09IC7Uao=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-5Xs4GktyPaSD3ZoWpbSEdg-1; Thu, 01 Sep 2022 09:21:34 -0400
X-MC-Unique: 5Xs4GktyPaSD3ZoWpbSEdg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E24D4293249B;
        Thu,  1 Sep 2022 13:21:33 +0000 (UTC)
Received: from localhost (unknown [10.39.194.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70045403344;
        Thu,  1 Sep 2022 13:21:33 +0000 (UTC)
Date:   Thu, 1 Sep 2022 09:21:31 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH V2 1/1] Docs: ublk: add ublk document
Message-ID: <YxCx2yG9Xs6nhQ9C@fedora>
References: <20220901023008.669893-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9VmB3AVhU0P5u4vQ"
Content-Disposition: inline
In-Reply-To: <20220901023008.669893-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--9VmB3AVhU0P5u4vQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2022 at 10:30:08AM +0800, Ming Lei wrote:
> Add documentation for ublk subsystem. It was supposed to be documented wh=
en
> merging the driver, but missing at that time.
>=20
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- integrate all kinds of cleanup from Bagas Sanjaya
>     - add 'why useful' paragraph from Stefan
>     - replace ublksrv with ublksrv for representing generic ublk
>       userspace for convenience of reference, as suggested by Stefan
>     - add entry to block/index.rst for removing ktest waring
>     - add MAINTAINER entry
>     - add more references, such as zero copy and nbdublk
>     - thanks review/suggestion from Bagas Sanjaya, Richard W.M. Jones, St=
efan Hajnoczi
>     and ZiyangZhang
>=20
>  Documentation/block/index.rst |   1 +
>  Documentation/block/ublk.rst  | 245 ++++++++++++++++++++++++++++++++++
>  MAINTAINERS                   |   1 +
>  3 files changed, 247 insertions(+)
>  create mode 100644 Documentation/block/ublk.rst

Thank you, this is a great starting point that will make ublk accessible
to developers!

Grammar and style changes would make it easier to read, but I think
those types of changes can be made in the future.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9VmB3AVhU0P5u4vQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMQsdsACgkQnKSrs4Gr
c8hybwf+M9Tq3d+f61eO1xgCYb1gVk/wz6l0jC70LtV7ueKWH4ngMbSxELf4JR0f
H5/pmA2GUvLN4RiND1+mX+/QAtvjEN27xcrV/uNU26CbvPCTRL4BmZjMGjoCAFoG
tzwK9kGuO22RFgh675LfgXNmvE8EEbtyMH2hFJIPEjuF9zqp+1k1dbazq/gLMPDp
nt6hh/n4tRDSmvSgnvpSRTb76jbTooajYVVpejcwZ/zCpZpvTkwtXWOOSyKirbJm
MYmWd8UmLJxXk3j1uYcWa6Ouiaav3JieiOrtS57tOOdkEzC2tC9TjWj7nPnN2w5I
jHQjOtVzYANWFNf13AAEFTKk16cieQ==
=A11v
-----END PGP SIGNATURE-----

--9VmB3AVhU0P5u4vQ--


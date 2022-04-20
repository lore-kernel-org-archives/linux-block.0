Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ACBC433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 15:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379978AbiDTPHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379818AbiDTPH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 11:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F198244A2C
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650467080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HO3i4D+trVxcNDmLhmg0KRj5BB0NScDWZoswC9YsiRI=;
        b=iVIiAbXcksuyboYwVJj9AGleA3SaT8QYjunBBjpsrT5aJazODXyQ7d4gJNhaH4F929COtq
        vphj2GHFA1jlIZmw53fF1kad/LiW7/VrHgGxhtSfmOlIap5YpoVqOLHioPZJVEkt32jov5
        r8CETsjj7b1qzwiQQgfFhQeUfHyHT88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-FgEaMkRIPgaV0Z_mitIHYw-1; Wed, 20 Apr 2022 11:04:36 -0400
X-MC-Unique: FgEaMkRIPgaV0Z_mitIHYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED364833972;
        Wed, 20 Apr 2022 15:04:35 +0000 (UTC)
Received: from localhost (unknown [10.39.194.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62C2954E899;
        Wed, 20 Apr 2022 15:04:35 +0000 (UTC)
Date:   Wed, 20 Apr 2022 17:04:33 +0200
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] virtio-blk: don't add a new line
Message-ID: <YmAhAd3n79nDxNEA@stefanha-x1.localdomain>
References: <20220420041053.7927-1-kch@nvidia.com>
 <20220420041053.7927-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LY9BsyJbjKQX4zYs"
Content-Disposition: inline
In-Reply-To: <20220420041053.7927-3-kch@nvidia.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--LY9BsyJbjKQX4zYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2022 at 09:10:51PM -0700, Chaitanya Kulkarni wrote:
> Don't split sector assignment line for REQ_OP_READ and REQ_OP_WRITE in
> the virtblk_setup_cmd() which fits in one line perfectly.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

There is a cost to patches: humans spend time reviewing them, CI systems
consume energy running tests, downstream maintainers deal with
backports, and git-blame(1) becomes harder to use when code changes.

What constitutes code churn is subjective. For me personally I prefer it
when patches have a clear benefit that outweighs the costs.
Nevertheless:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LY9BsyJbjKQX4zYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJgIQEACgkQnKSrs4Gr
c8hzNwf9GjKTeB69Z0b8rSUOHgifTOzRElYfNVGZx9NDvbrX1+WvGuxSkJZmpwlY
CnNhAcaJ9BT5OV49uq4HuCXW5ihawy5ytWxXea1slmQlrLbG9fKvgHodOQL+jZil
MnJOBl7+IYRJ/2lNUrJPGt/q6wkOCzzxRuSMrRAhRlY8ATg36rRxEuflq4jIwEx1
K9G/4bWMFLPi5v17LZeQw5GJfO22J/ESkMZhP0qB+L6qnkDUqUI8ww/Hxfa4z4Fw
eWVxYvggGgNlRr49+H6IrPaDoqQ1tpI7HsQgZcURAEaWvkb91rrHLpo8snv4ASIR
6xbKz11fbg3MREFRVwUGBsMALbKBJA==
=iq4N
-----END PGP SIGNATURE-----

--LY9BsyJbjKQX4zYs--


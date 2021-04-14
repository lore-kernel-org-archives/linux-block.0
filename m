Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B528C433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 08:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0968E613CD
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 08:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhDNIpH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232468AbhDNIpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 04:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618389885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PI0biHAjtioVE9nE4bLO2UBKn34udcJDNDQVnJSXI5I=;
        b=Mb5U7BK13kO11IeFmvKwJqaVdYVQwror+dkDhbUXM7B4zu7kq4XEx1RUbT/g5A7Qq3M+8v
        7hrOctgG+6dx1QBtoVpkyW135ey/0I8F+El0+T9xX3ES3KdYYSR5EamC/tDvzUVHkzxTOb
        WpKzB5Ol/2SJWE76iFEMlJJ6jzPA6Xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-pGt2yJp0Puqc60dY4e2B9Q-1; Wed, 14 Apr 2021 04:44:41 -0400
X-MC-Unique: pGt2yJp0Puqc60dY4e2B9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 009788030A0;
        Wed, 14 Apr 2021 08:44:40 +0000 (UTC)
Received: from localhost (ovpn-114-209.ams2.redhat.com [10.36.114.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD5E51298;
        Wed, 14 Apr 2021 08:44:36 +0000 (UTC)
Date:   Wed, 14 Apr 2021 09:44:35 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Enrico Granata <egranata@google.com>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
Message-ID: <YHarc5gGgjyQOaA+@stefanha-x1.localdomain>
References: <20210330231602.1223216-1-egranata@google.com>
 <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
 <20210412094217.GA981912@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bauiO0UMhevZr0So"
Content-Disposition: inline
In-Reply-To: <20210412094217.GA981912@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--bauiO0UMhevZr0So
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 12, 2021 at 10:42:17AM +0100, Christoph Hellwig wrote:
> A note to the virtio committee:  eMMC is the worst of all the currently
> active storage standards by a large margin.  It defines very strange
> ad-hoc interfaces that expose very specific internals and often provides
> very poor abstractions.  It would be great it you could reach out to the
> wider storage community before taking bad ideas from the eMMC standard
> and putting it into virtio.

As Michael mentioned, there is still time to change the virtio-blk spec
since this feature hasn't been released yet.

Why exactly is exposing eMMC-style lifetime information problematic?

Can you and Enrico discuss the use case to figure out an alternative
interface?

Thanks,
Stefan

--bauiO0UMhevZr0So
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmB2q3MACgkQnKSrs4Gr
c8iCWQf/XiM3VgPA1Zs4wDtPYzkWMh607Ajshz1zQnvTv/pJs17WdQ2XSjJAdXxS
46IZ7lThbydBkeAaO0liAnBadJGipfv0MWQpkoWRVGvYH868k37bdtE/ypMeAL+b
sUXF0BKNur+PMwV643QM04oGlYnEecvbNSFH1C2tADROJC7S9uEcZYK6pC9wKhap
gKmDBhR+3qSRihK8d8aK2Bp4sUrZRGpsTnI9OZNCbZhRMGwvzGox0ffumvX0j1dA
zPpSFesL+ytUmhAT695CAW/lPlcDwCP84GXAt2uaPvA4unZSzkbk4SN9Zx8zaKqu
kiofNkpquHkH8V4R2QdBvLbK590Ixw==
=DTBm
-----END PGP SIGNATURE-----

--bauiO0UMhevZr0So--


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7ECC32772
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiHWU46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiHWU46 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 16:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD106F249
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661288216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6GpA8BrAqKd3EaQ4iUJ+jQPbV5hdMrDQRA6EhvsCCY=;
        b=KObN0Yhf0n4s6+D8uBbdB8ZuOAS9cDEAy7aD/J6UvY5PpeUvG9l/5G8o2PQSEn2qoZuTqm
        6g1l77F4PxZwiSDEkOcBrrkDTZIe8jlVLn+PNAqv5twvR5ZvtZtVK4pWVUVwhbSRNS4826
        y7KmRqBIBvoaSSZl6nn0ogSI/1bBLMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-1CUsF1F-OmWakf1N3rcxUQ-1; Tue, 23 Aug 2022 16:56:51 -0400
X-MC-Unique: 1CUsF1F-OmWakf1N3rcxUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 669C0803301;
        Tue, 23 Aug 2022 20:56:51 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC9541121315;
        Tue, 23 Aug 2022 20:56:50 +0000 (UTC)
Date:   Tue, 23 Aug 2022 16:56:49 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        acourbot@chromium.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <YwU/EVxT0a6q2BfD@fedora>
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Im5Dzx+o78egGwqe"
Content-Disposition: inline
In-Reply-To: <20220823145005.26356-1-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Im5Dzx+o78egGwqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  			virtblk_unmap_data(req, vbr);
>  			virtblk_cleanup_cmd(req);
>  			rq_list_add(requeue_list, req);
> +		} else {
> +			blk_mq_start_request(req);
>  		}

The device may see new requests as soon as virtblk_add_req() is called
above. Therefore the device may complete the request before
blk_mq_start_request() is called.

rq->io_start_time_ns = ktime_get_ns() will be after the request was
actually submitted.

I think blk_mq_start_request() needs to be called before
virtblk_add_req().

Stefan

--Im5Dzx+o78egGwqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMFPxAACgkQnKSrs4Gr
c8jiqQf/dQaaWu+Y3F9hESOhMyKVdRc88dF4/wgzl4PX7S/aBvAK18a2kq3Fd+yx
zf5E5zf18bPIdOMiEUwW4KsezYZlQZYArev/xuzEUDFnKKTKg7eJhAJ0w3xPH/Bu
19ZQ4rR/8a3WJlJYcAHS0bZEHZN11GdFo3wobbzcy43kNuOf45PTJISe/SaWLRrj
k+qCF1ocbxGxo5RZeRHDXZGtYFDa0OQjMKJToNT9umZN8kPQaiC7YAutYD81r+Jl
fSjEZtlIwAIZJgx3F2oCrqSopAQ34jYQgkpUCUnOgsblL2XW95l/V5wJ5lxrVolT
ljH3Tr5GPLqKzHmJ8+5XoGJVop0lpA==
=cybs
-----END PGP SIGNATURE-----

--Im5Dzx+o78egGwqe--


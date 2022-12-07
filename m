Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26644C3A5A7
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 14:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLHOno (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHOnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 09:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1DC9FDB
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670510557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=su2lUkDQHUFhv4VEOGFPuQBsnBPEcF90Y1ekpqoV0HM=;
        b=Q+qI4RDKxmalTL2JTLjZewurOlQGW15N+mFq1fM5pI/rTlXUn2mgmACYPmF0mQyIxcNmbN
        oEwvtMvdjLJuou35BkHcvBfxaoJDqXhczCWkATT8Q7BU0FE5FJyab62/wag1XDSNrMfQi1
        2gdvZfidfXEx77lEQTJDbJCvRQcwjYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-wesRoOmrMEuqHAmp1RPsVw-1; Thu, 08 Dec 2022 09:42:33 -0500
X-MC-Unique: wesRoOmrMEuqHAmp1RPsVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B1388039AC;
        Thu,  8 Dec 2022 14:42:33 +0000 (UTC)
Received: from localhost (unknown [10.39.194.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D76B2492B05;
        Thu,  8 Dec 2022 14:42:31 +0000 (UTC)
Date:   Wed, 7 Dec 2022 16:47:39 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     axboe@kernel.dk
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        hch@infradead.org, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after
 polling I/O is finished
Message-ID: <Y5EJ+6qtsy8Twe/q@fedora>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TLPWbvavsl8s4xu9"
Content-Disposition: inline
In-Reply-To: <20221206141125.93055-1-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--TLPWbvavsl8s4xu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2022 at 11:11:24PM +0900, Suwan Kim wrote:
> Driver should set req->state to MQ_RQ_COMPLETE after it finishes to proce=
ss
> req. But virtio-blk doesn't set MQ_RQ_COMPLETE after virtblk_poll() handl=
es
> req and req->state still remains MQ_RQ_IN_FLIGHT. Fortunately so far there
> is no issue about it because blk_mq_end_request_batch() sets req->state to
> MQ_RQ_IDLE. This patch properly sets req->state after polling I/O is fini=
shed.
>=20
> Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd734..cf64d256787e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -839,6 +839,7 @@ static void virtblk_complete_batch(struct io_comp_bat=
ch *iob)
>  	rq_list_for_each(&iob->req_list, req) {
>  		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
>  		virtblk_cleanup_cmd(req);
> +		blk_mq_set_request_complete(req);
>  	}
>  	blk_mq_end_request_batch(iob);
>  }

The doc comment for blk_mq_set_request_complete() mentions this being
used in ->queue_rq(), but that's not the case here. Does the doc comment
need to be updated if we're using the function in a different way?

I'm not familiar enough with the Linux block APIs, but this feels weird
to me. Shouldn't blk_mq_end_request_batch(iob) take care of this for us?
Why does it set the state to IDLE instead of COMPLETE?

I think Jens can confirm whether we really want all drivers that use
polling and io_comp_batch to manually call
blk_mq_set_request_complete().

Thanks,
Stefan

--TLPWbvavsl8s4xu9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmORCfsACgkQnKSrs4Gr
c8jzcwgAkqjCxjdTMpgQ9FJr1zb/9w4oIKfPrLRFiS8+aZrjF4PSgH6iISADo6LN
y5jC+JbJI9HImldIbxcJ3VBzA4Vbp6gJZv/NolxztP0Vnc/1EPCQDy1j8hoJzm7u
G7jLL2iIkQEyr4IChxEtJMrLRmNz9Lqj2dcKdLTPNGInlgUspVDKjbdjN+rfHOHg
bGG0GDreFzM+8ZuGghcJMeeUb+fUjbJd4oLyxwROhZlBD+LU8nG0KRZ1L/phGIN3
sPihNVo5okhFsDBqCqIPgGiouSpN/fsfQJV+spkFPbm2kbuURlFVQZZJSV1wZ1rn
19xu2Y5NAnew/RxTYo7OflRvnC0ISQ==
=U0Ee
-----END PGP SIGNATURE-----

--TLPWbvavsl8s4xu9--


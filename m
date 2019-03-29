Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D2C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 22:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81546218AC
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 22:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="C/6y2q4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfC2WW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:22:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40846 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfC2WW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 18:22:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so1842599pgo.7
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=NKHLHZHvEPfAkmu8ORYN1S/+tdB+dkWQPdhTsLCmAew=;
        b=C/6y2q4px2ai4TYOeIAI88jYB/9s4pHIdXfJwRVCbFylsgZ2Lr11253rJw1OT4f9Jx
         6o057KbTNufRtwvJCp2b8pbif2u7dV6nRNAElCCupYTjbCr/gb3E5ClXgo4w0HCiUanX
         yw6Tv8dsGIeWgU8BFJA67QkzcHyZ/u9uv6W5sEsYNuDyl/LBZvoL2U+/TPecyS58AWDy
         RbN86/X3rZSYxwvO2UdpsQv4tdqLXYjPK5wxeKKHj/ulNh+b6uQDvEhkSd7/zlvrLM7N
         Zt0ZkAFq2+p6wKszP0w+EPxwvbkbNM2L/yhBbfakVGanqECxI/iFh9SSQe5lR/76K+d0
         61dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=NKHLHZHvEPfAkmu8ORYN1S/+tdB+dkWQPdhTsLCmAew=;
        b=A8/nqZLrGYpxwgPMBWqpY9awFMHhqlEboPXDlmHaTjNBg/P9WgwfKtxG2E1H97fumm
         mijkT5epzcBSHeA0xe8wr56JXUVQnRSZ6UGNSakZn042q+hTpnet0gyj3Q0/tQAB/KaU
         saE12bQy7VcXSlrW3VqXuqCUvBXm/G8VIUFNuTLiTKdDVxFbohl4pCzXrSwBNBpTAKc6
         +sbEjCc8s9N3xBAvc0N8UzhEZaf3Keu2HB5wmtyy1UdCkW5WDlH3Oncaa+v13d7Yv6Jv
         v/pQLFEYCNupB8tOd7oXBQVuRR5umbTQRJsoAQtUfrDbiVyJp07w2paqa6uM1WKIMB9L
         e6lg==
X-Gm-Message-State: APjAAAXbQdNh9idy6Cjx3yKz+CZMXQbVUIjVDTuV37ZYmQbKqtTucEBR
        lmE3uROY3KcPEHcxF/IksXpw1A==
X-Google-Smtp-Source: APXvYqx+FBcLIJ9EFHYeK1ZVXgrPRWlac9zMR5MMKUFtvC672H2yErH9pSQVcWLUtumYO+/60fsklQ==
X-Received: by 2002:a62:4602:: with SMTP id t2mr35646174pfa.26.1553898146382;
        Fri, 29 Mar 2019 15:22:26 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id k124sm3789875pgc.65.2019.03.29.15.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:22:25 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0FA09E34-400A-473D-9F3A-3014F79B2A82@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2D543960-CD75-43F9-99DB-CED1525EC66B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 1/3] block: introduce submit_bio_verify()
Date:   Fri, 29 Mar 2019 16:22:18 -0600
In-Reply-To: <20190329142346.1677-2-bob.liu@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        david@fromorbit.com, darrick.wong@oracle.com, hch@infradead.org,
        axboe@kernel.dk, tytso@mit.edu
To:     Bob Liu <bob.liu@oracle.com>
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-2-bob.liu@oracle.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_2D543960-CD75-43F9-99DB-CED1525EC66B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 29, 2019, at 8:23 AM, Bob Liu <bob.liu@oracle.com> wrote:
>=20
> This patch adds a function verifier callback to submit_bio.  The
> filesystem layer can use submit_bio_verify to pass a call back
> to the block layer which can then be used to verify if the data
> read is correct.

How does this interact (if at all) with bio_integrity_verify() code?
Does it mean if e.g. XFS is on storage with T10-PI that only one or
the other can be used, or will it be possible to chain the verify
callbacks?

Cheers, Andreas

> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> ---
> block/blk-core.c    | 13 ++++++++++---
> include/linux/bio.h |  2 ++
> 2 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 6b78ec56a4f2..d265d2924c32 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1156,15 +1156,16 @@ blk_qc_t direct_make_request(struct bio *bio)
> EXPORT_SYMBOL_GPL(direct_make_request);
>=20
> /**
> - * submit_bio - submit a bio to the block device layer for I/O
> + * submit_bio_verify - submit a bio to the block device layer for I/O
>  * @bio: The &struct bio which describes the I/O
>  *
> - * submit_bio() is very similar in purpose to generic_make_request(), =
and
> + * submit_bio_verify() is very similar in purpose to =
generic_make_request(), and
>  * uses that function to do most of the work. Both are fairly rough
>  * interfaces; @bio must be presetup and ready for I/O.
>  *
>  */
> -blk_qc_t submit_bio(struct bio *bio)
> +blk_qc_t submit_bio_verify(struct bio *bio,
> +		int (*verifier_cb_func)(struct bio *))
> {
> 	/*
> 	 * If it's a regular read/write or a barrier with data attached,
> @@ -1197,6 +1198,12 @@ blk_qc_t submit_bio(struct bio *bio)
>=20
> 	return generic_make_request(bio);
> }
> +EXPORT_SYMBOL(submit_bio_verify);
> +
> +blk_qc_t submit_bio(struct bio *bio)
> +{
> +	return submit_bio_verify(bio, NULL);
> +}
> EXPORT_SYMBOL(submit_bio);
>=20
> /**
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 7380b094dcca..ddaadab74dcf 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -398,6 +398,8 @@ static inline struct bio *bio_kmalloc(gfp_t =
gfp_mask, unsigned int nr_iovecs)
> 	return bio_alloc_bioset(gfp_mask, nr_iovecs, NULL);
> }
>=20
> +extern blk_qc_t submit_bio_verify(struct bio *,
> +		int (*verifier_cb_func)(struct bio *));
> extern blk_qc_t submit_bio(struct bio *);
>=20
> extern void bio_endio(struct bio *);
> --
> 2.17.1
>=20


Cheers, Andreas






--Apple-Mail=_2D543960-CD75-43F9-99DB-CED1525EC66B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlyempsACgkQcqXauRfM
H+DRQhAAl1dcdhbWqUtnHIo/leZtKXrSub/TrhKQPmxC2iQJyX7GFo74uHRdRnQA
i3gZt96nht6EmAJokXyuadiYqzlCqpN5lkanEB/myeie27ggkKsH96QEBHoG9Gkr
2hocaDhP90vKFNhSQGSfPC9n3Q0u9X5r+MOgKkEl7x+4d4QzO5rQGH3f78vVAg86
TPVCCM5wQ0b06ubItOZgZe7ZypGVp92SXovUqoMhMZDeuB1FEonOj6T39TuCrnkf
N9pMnVUIEMFiH+aCCOv70RbEpL6OFCnxJhnTlUnCGoiczwWpWfUlP2hh9vx6pRSP
RNMSK7KM0Egvom0f6denbzvDrJ3/JTPlFyN3GpgYY1cah5wzdortAX+bk4v0yt1E
c1+eIttJBwQiXAPxURAtm9ULRFDo502fq5TGs9V+75qDRVuDIvo08797Ko6dWd3U
trgBvf1b63eoh8CTRuPipn1MHRUOBViLUqaw6jx4eTQgbCIxGmhk7FQ7KWhP3UM0
/0KxLhT6x60enj8aEUXmhAOjMA5OObIU5hT+oPrAUxeVqQ7FkL+jw1lElHlEt2rW
x1DvZJOFZxqPOMis9R2w2GEMPBPQtIHExRJBKsGH+gufUsCXPovsjB4u0ZiB3t3W
rWQ9RBtadBg5y9kOntaYldVZkbP6B1QL5UnyUjSSYHQ+oTWDiSM=
=a7IN
-----END PGP SIGNATURE-----

--Apple-Mail=_2D543960-CD75-43F9-99DB-CED1525EC66B--

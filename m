Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42299 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbdDJCHp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Apr 2017 22:07:45 -0400
From: NeilBrown <neilb@suse.com>
To: Matias Bjorling <mb@lightnvm.io>
Date: Mon, 10 Apr 2017 12:07:37 +1000
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: don't check for failure from mempool_alloc()
Message-ID: <87k26txbfa.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


mempool_alloc() cannot fail if the gfp flags allow it to
sleep, and both GFP_KERNEL and GFP_NOIO allows for sleeping.

So rrpc_move_valid_pages() and rrpc_make_rq() don't need to
test the return value.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 drivers/lightnvm/rrpc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index e00b1d7b976f..34f5f1cc9452 100644
=2D-- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -318,10 +318,6 @@ static int rrpc_move_valid_pages(struct rrpc *rrpc, st=
ruct rrpc_block *rblk)
 	}
=20
 	page =3D mempool_alloc(rrpc->page_pool, GFP_NOIO);
=2D	if (!page) {
=2D		bio_put(bio);
=2D		return -ENOMEM;
=2D	}
=20
 	while ((slot =3D find_first_zero_bit(rblk->invalid_pages,
 					    nr_sec_per_blk)) < nr_sec_per_blk) {
@@ -1007,11 +1003,6 @@ static blk_qc_t rrpc_make_rq(struct request_queue *q=
, struct bio *bio)
 	}
=20
 	rqd =3D mempool_alloc(rrpc->rq_pool, GFP_KERNEL);
=2D	if (!rqd) {
=2D		pr_err_ratelimited("rrpc: not able to queue bio.");
=2D		bio_io_error(bio);
=2D		return BLK_QC_T_NONE;
=2D	}
 	memset(rqd, 0, sizeof(struct nvm_rq));
=20
 	err =3D rrpc_submit_io(rrpc, bio, rqd, NVM_IOTYPE_NONE);
=2D-=20
2.12.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAljq6OkACgkQOeye3VZi
gbkqFBAAgZjYp9v7bXV+rPHV2bjOQYeb8OzWzUrrS6EWKK/DCY6bP5bWICEefA26
LO/n8ZKigH7GpRRXX3NAZrljcZxd7Zilnx/bVbUXggvj/bNBoZndXe5LqXhLMUHJ
FzKR4nAGxkz8xjaZjB+zqBImNh8i/TzAQ9TDXs+VOoU05Q96uQouhaZ/SYnfGR/M
MVbtn7cwIYETNOLu316YLnAp5kb8818gKUComlt5pxSL3ostfc+kqbVLxkaVMWcb
ZxBZPDzkK9mowGkMkhNRzfuQLYy8LGxqaoIe3Fy4TTWStkhifiopZEvM77AxOPPr
agt+19Ua6WExyUkHmtb3EBn9SkBcen7tJ0NRJH1PYw9483ZkjAIW8TNGTLs2gjtN
DJeBwfyWC3rlg+g4isRNGhhow31cOyIqrj/zOZpupCBOeqLxU14QLT739PaCyiWz
CX3rXYisTFf04VhUy+j6NBlStSliAdxmXGkfQ1G7xiHXtig5g7uvbCrcVa/5+fMU
O5f1Fo1hWAgSWGCcIU4RCljvmK8CqlU6go9iNhhJRgUCOf3mmPZ16ol0kNI/kvnx
+dLt78JKroZajcscDpB5xdWTKP697LFi+zjzuHhOo6tw5tlcKiHAbJY4U9EZOwUq
YDsMxSR/mvmMTtcDpPMI+ktA7OrFC2SN5kFVYA1Jb3qJ4zx0FrY=
=pQHI
-----END PGP SIGNATURE-----
--=-=-=--

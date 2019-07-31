Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEBFC433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 13:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041D020693
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 13:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="KqDEHSeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfGaNyV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:54:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32862 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfGaNyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 09:54:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so65705408ljg.0
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/dP/P13uRe43vvjt8C6QOCwp1lgDg0ptlUzZV7Cu/NM=;
        b=KqDEHSeNmULTm1N+Ex6QcsKbXhzbS0z46WTY8kzYDNWhItWmMnQDiMCUGbn7EPjKNA
         4UiD2B3/Y9BBakvLy6W3xFOrv7ukbSaXP6rRzKICPJbgCC73SryHj78t54UpBpvTw/jp
         4yVCGK08l6LKC81mMkAiNGB3lHBKDzlsWAW0BnIBUH+RqXpV+ps4NO9fyjNU6fRggYvT
         HeXqgUL12teT3fxNw9szPZQSIFw9eNwmA+uyn1Wk+prgFGtzJOsA3HPvkWZx2d84jAJD
         rWzVpq7dN9yvJTYox50JYfgvWzwuQ1NC9HA7GhJvPHNm431E8xSkNpU7BHGLr/+b4Qm6
         om3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/dP/P13uRe43vvjt8C6QOCwp1lgDg0ptlUzZV7Cu/NM=;
        b=NPfUEVhhJTWqGe3A5STOeRISWBt6/eUuUSc2Iny72Q1gCCEwS/iEj73hmMqL3VqH77
         DrOhjwR86MQ7aw29kKWJxzLUGBLzOdt9cq1N/zES1MZz6kMMlgGZyAqO/wsZmZWzL3qu
         OA1dN84yyINhXpcC/1V24vwP2quNq2ycHa/o2ugs2l52bxvvVU0Vda6Rx7dgdaX03uOV
         bs8tUgflXoTMbin1keoG2DHB61gOnritA+mTyBfVvsCZ7Bn+7fxcOvn2up1JA1v3CoNp
         KJz0MMsQ9G1/T9pvP2hG9d2PE/A8nM11yb6Pvf3410XJEIdvfyU84gl+5K4JrT47p0a9
         Tcfg==
X-Gm-Message-State: APjAAAWRxpq8vylk6uCymWnhGO0QB07EQTyzBge8Oc0F4Z2pBigewREV
        KnKVp7YE5Tq4Ob7y6wGG79c=
X-Google-Smtp-Source: APXvYqx8VUEFmveAe6BQEzhC+hFMDN5xD6KjL0nBWd4T9PkXb7DdQOLLvlQ1SZMrbnYoLpyh2cvLaw==
X-Received: by 2002:a2e:9b81:: with SMTP id z1mr64913295lji.101.1564581258104;
        Wed, 31 Jul 2019 06:54:18 -0700 (PDT)
Received: from [172.20.10.13] (212.27.19.10.bredband.3.dk. [212.27.19.10])
        by smtp.gmail.com with ESMTPSA id w1sm16124377ljm.81.2019.07.31.06.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:54:17 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <2282D925-D153-474D-99F3-4830EE16F69F@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_69A10665-6BE3-433C-97AE-23B8517D9DCC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/4] lightnvm: remove nvm_submit_io_sync_fn
Date:   Wed, 31 Jul 2019 15:54:15 +0200
In-Reply-To: <1564566096-28756-2-git-send-email-hans@owltronix.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Hans Holmberg <hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
 <1564566096-28756-2-git-send-email-hans@owltronix.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_69A10665-6BE3-433C-97AE-23B8517D9DCC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Jul 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> Move the redundant sync handling interface and wait for a completion
> in the lightnvm core instead.
>=20
> Signed-off-by: Hans Holmberg <hans@owltronix.com>
> ---
> drivers/lightnvm/core.c      | 35 +++++++++++++++++++++++++++++------
> drivers/nvme/host/lightnvm.c | 29 -----------------------------
> include/linux/lightnvm.h     |  2 --
> 3 files changed, 29 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index a600934fdd9c..01d098fb96ac 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -752,12 +752,36 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, =
struct nvm_rq *rqd)
> }
> EXPORT_SYMBOL(nvm_submit_io);
>=20
> +static void nvm_sync_end_io(struct nvm_rq *rqd)
> +{
> +	struct completion *waiting =3D rqd->private;
> +
> +	complete(waiting);
> +}
> +
> +static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq =
*rqd)
> +{
> +	DECLARE_COMPLETION_ONSTACK(wait);
> +	int ret =3D 0;
> +
> +	rqd->end_io =3D nvm_sync_end_io;
> +	rqd->private =3D &wait;
> +
> +	ret =3D dev->ops->submit_io(dev, rqd);
> +	if (ret)
> +		return ret;
> +
> +	wait_for_completion_io(&wait);
> +
> +	return 0;
> +}
> +
> int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq =
*rqd)
> {
> 	struct nvm_dev *dev =3D tgt_dev->parent;
> 	int ret;
>=20
> -	if (!dev->ops->submit_io_sync)
> +	if (!dev->ops->submit_io)
> 		return -ENODEV;
>=20
> 	nvm_rq_tgt_to_dev(tgt_dev, rqd);
> @@ -765,9 +789,7 @@ int nvm_submit_io_sync(struct nvm_tgt_dev =
*tgt_dev, struct nvm_rq *rqd)
> 	rqd->dev =3D tgt_dev;
> 	rqd->flags =3D nvm_set_flags(&tgt_dev->geo, rqd);
>=20
> -	/* In case of error, fail with right address format */
> -	ret =3D dev->ops->submit_io_sync(dev, rqd);
> -	nvm_rq_dev_to_tgt(tgt_dev, rqd);
> +	ret =3D nvm_submit_io_wait(dev, rqd);
>=20
> 	return ret;
> }
> @@ -788,12 +810,13 @@ EXPORT_SYMBOL(nvm_end_io);
>=20
> static int nvm_submit_io_sync_raw(struct nvm_dev *dev, struct nvm_rq =
*rqd)
> {
> -	if (!dev->ops->submit_io_sync)
> +	if (!dev->ops->submit_io)
> 		return -ENODEV;
>=20
> +	rqd->dev =3D NULL;
> 	rqd->flags =3D nvm_set_flags(&dev->geo, rqd);
>=20
> -	return dev->ops->submit_io_sync(dev, rqd);
> +	return nvm_submit_io_wait(dev, rqd);
> }
>=20
> static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr =
ppa)
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index ba009d4c9dfa..d6f121452d5d 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -690,34 +690,6 @@ static int nvme_nvm_submit_io(struct nvm_dev =
*dev, struct nvm_rq *rqd)
> 	return 0;
> }
>=20
> -static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq =
*rqd)
> -{
> -	struct request_queue *q =3D dev->q;
> -	struct request *rq;
> -	struct nvme_nvm_command cmd;
> -	int ret =3D 0;
> -
> -	memset(&cmd, 0, sizeof(struct nvme_nvm_command));
> -
> -	rq =3D nvme_nvm_alloc_request(q, rqd, &cmd);
> -	if (IS_ERR(rq))
> -		return PTR_ERR(rq);
> -
> -	/* I/Os can fail and the error is signaled through rqd. Callers =
must
> -	 * handle the error accordingly.
> -	 */
> -	blk_execute_rq(q, NULL, rq, 0);
> -	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
> -		ret =3D -EINTR;
> -
> -	rqd->ppa_status =3D le64_to_cpu(nvme_req(rq)->result.u64);
> -	rqd->error =3D nvme_req(rq)->status;
> -
> -	blk_mq_free_request(rq);
> -
> -	return ret;
> -}
> -
> static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char =
*name,
> 					int size)
> {
> @@ -754,7 +726,6 @@ static struct nvm_dev_ops nvme_nvm_dev_ops =3D {
> 	.get_chk_meta		=3D nvme_nvm_get_chk_meta,
>=20
> 	.submit_io		=3D nvme_nvm_submit_io,
> -	.submit_io_sync		=3D nvme_nvm_submit_io_sync,
>=20
> 	.create_dma_pool	=3D nvme_nvm_create_dma_pool,
> 	.destroy_dma_pool	=3D nvme_nvm_destroy_dma_pool,
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 4d0d5655c7b2..8891647b24b1 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -89,7 +89,6 @@ typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, =
struct ppa_addr *, int, int);
> typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, sector_t, int,
> 							struct =
nvm_chk_meta *);
> typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
> -typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq =
*);
> typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
> typedef void (nvm_destroy_dma_pool_fn)(void *);
> typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
> @@ -104,7 +103,6 @@ struct nvm_dev_ops {
> 	nvm_get_chk_meta_fn	*get_chk_meta;
>=20
> 	nvm_submit_io_fn	*submit_io;
> -	nvm_submit_io_sync_fn	*submit_io_sync;
>=20
> 	nvm_create_dma_pool_fn	*create_dma_pool;
> 	nvm_destroy_dma_pool_fn	*destroy_dma_pool;
> --
> 2.7.4

Looks good to me. Thanks Hans.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_69A10665-6BE3-433C-97AE-23B8517D9DCC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl1BnYcACgkQPEYBfS0l
eOCEZhAA2wX54VCYX3bFLZPozqYlUm9011/lbUW2WWZp/X8HPuECuo1LNfsMcDdx
5OrhRUj1smOVJJCfjUsrfQNvbla4PZtEpky22wEYDT6Pu/KTqajq8VbAOD7LBQeO
sW0RCV92R6W0i52h8sB37rYr4+lOS7iEm0gcVgjEUUS7E5E957AjPUZF95MKtq3r
nLRvSucV4LTD7XTie5DdWo/vwlrE/EDYFtHwdA9/DV2z1cNzpi6Nvtcc1RKkXc4m
O0TDQ4vtT/FGGrduj+TUCbf0zD+ZN8lUJ7yQA36jdBb4BdawyV4UKLD5Y/Og9j8+
mHb/irXzx1pT44H18LZgpdoEFjZextUdTxpgv9uPnqpXHxQHNAGzNJkuRKk72+6e
RZce7d3EtKVAAhLjy0rgTCUZNNGIAjRWmSc+pSbOJUj1nJkeAZt88YwKr7DIz8cv
nkfZKBfsUnWge8nf0f3svYlCcy3WgSYywBrYNLJX9Nq+qKInAUmHGTr7YjvB3G+n
1Fz3LFSTW1+5dcBuWVgd/8T1fJKkGaHA88Do3W2D7AP+Wk8TdSJQewMBnmQN07c2
nUw8rW9wcI26cdf0nu97rTnl3bkodXErAaW9Iy21jw7sMGSDcnoFI6qrpOo+1GFb
5KgWvkitfMYT6MOjXJFUyOEf88fh0IG/dc+1tVsYifEoS3GHbpg=
=/tgP
-----END PGP SIGNATURE-----

--Apple-Mail=_69A10665-6BE3-433C-97AE-23B8517D9DCC--

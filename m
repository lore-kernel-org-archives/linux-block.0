Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9745C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 05:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42158214AE
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 05:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="dFSX9CYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfDYFt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:49:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41641 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfDYFt1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 01:49:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id g6so18037560edc.8
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 22:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DvhQRolGIoQrpoFPNEgNbQDSOJl6x/P+jhKwBo4kzc0=;
        b=dFSX9CYUbbC0gQnsD71oSzPM/GWytCpEPfLokimQeLAyWjJt1m6b0snt1UOTksR3AU
         aTtuwHWXj0+10+KAXtcN96E+lhR7G+AKMvt9EbZLNNCSgbNr7ZdTcikignYOYi3mrL2a
         ZYV6aDmvpw6FRQeOERKlmZ661dOw4/3dtUfj5AGYRjWEvyX4qSt80CD0NMnokKx89XIS
         hB/A5pFFjuDhz3eRcTkOhzqkjwUFvBtcT+IzELzqa5n4yn0ahQ8jpwqaUZim3xn7xFDw
         C7UOH+ddTZZh66rLWCXKzVoBJ/tZmRYDO3ACSkSlW9yiA8gIegucAW42AU7lVza0c9nB
         Gh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DvhQRolGIoQrpoFPNEgNbQDSOJl6x/P+jhKwBo4kzc0=;
        b=HOaGiqwVVeN1AvqIcrPaAcuh8yMZG6MAy5F3uoUQq40Wmk8a2NSDRfxKtrmDbLv/9r
         2KoT6qSZqcAiR0MIYDSf7uUL4+1sELwDvIRmFgVPmcA6cKFdgxoPPhwStoG6U+W5UpJH
         fvWXuQKa1WWsPa8XWL4Yxz3JkEpNcMOFJfPCI9fSR6Wb+O5/X4Z6sEM8OTKMUDT3YUW+
         P66JcjN8/8fp2khlZEmmhBUFgmfn9H8YTSPf5Q307jymrFOogCA2ExJnvpbEMpFvgJ41
         EHP+JNyDbKBiY42KENXBLe/LuWTCZ3p8B7djZQMMLy2bNVqnn2i+aVjWjAUksRL9tpuq
         Qytw==
X-Gm-Message-State: APjAAAVauyb7NOOZW/ooOXc113lqxupSsKXtiX0C8NAXpsfpBKeBTX5O
        yqsq2DzF5t1k00eSQc0HJ+QpNg==
X-Google-Smtp-Source: APXvYqyG4z/z3kLaL0Aj43fXjDLS0gQ2GKWdBRiKGW1OjpaTdX/vErFkGGOS/1dUebNWAg+sJAYCFA==
X-Received: by 2002:a17:906:58a:: with SMTP id 10mr18503989ejn.36.1556171364311;
        Wed, 24 Apr 2019 22:49:24 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id n64sm5835812edc.82.2019.04.24.22.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 22:49:22 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <5D030524-1BDF-4855-8DC0-999AD98F9855@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_54B3B987-D6D3-428C-B656-99AD392CF5DC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
Date:   Thu, 25 Apr 2019 07:49:21 +0200
In-Reply-To: <20190425052152.6571-1-hlitz@ucsc.edu>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Heiner Litz <hlitz@ucsc.edu>
References: <20190425052152.6571-1-hlitz@ucsc.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_54B3B987-D6D3-428C-B656-99AD392CF5DC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 25 Apr 2019, at 07.21, Heiner Litz <hlitz@ucsc.edu> wrote:
>=20
> Introduce the capability to manage multiple open lines. Maintain one =
line
> for user writes (hot) and a second line for gc writes (cold). As user =
and
> gc writes still utilize a shared ring buffer, in rare cases a =
multi-sector
> write will contain both gc and user data. This is acceptable, as on a
> tested SSD with minimum write size of 64KB, less than 1% of all writes
> contain both hot and cold sectors.
>=20
> For a zipfian random distribution of LBA writes with theta-zipf of =
1.2,
> this patch reduces write amplification from 2.5 to 1.3 and increases =
user
> write IOPS by 2.1x.
>=20
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
> drivers/lightnvm/pblk-core.c     | 157 +++++++++++++++++++++++--------
> drivers/lightnvm/pblk-init.c     |   9 +-
> drivers/lightnvm/pblk-map.c      |  29 +++---
> drivers/lightnvm/pblk-recovery.c |  43 ++++++---
> drivers/lightnvm/pblk-write.c    |  37 +++++---
> drivers/lightnvm/pblk.h          |  28 ++++--
> 6 files changed, 213 insertions(+), 90 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 73be3a0311ff..bbb216788bc8 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1294,7 +1294,7 @@ int pblk_line_recov_alloc(struct pblk *pblk, =
struct pblk_line *line)
> 	int ret;
>=20
> 	spin_lock(&l_mg->free_lock);
> -	l_mg->data_line =3D line;
> +	pblk_line_set_data_line(pblk, PBLK_LINETYPE_DATA, line);
> 	list_del(&line->list);
>=20
> 	ret =3D pblk_line_prepare(pblk, line);
> @@ -1410,7 +1410,7 @@ struct pblk_line *pblk_line_get(struct pblk =
*pblk)
> }
>=20
> static struct pblk_line *pblk_line_retry(struct pblk *pblk,
> -					 struct pblk_line *line)
> +					 struct pblk_line *line, int =
type)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line *retry_line;
> @@ -1419,7 +1419,7 @@ static struct pblk_line *pblk_line_retry(struct =
pblk *pblk,
> 	spin_lock(&l_mg->free_lock);
> 	retry_line =3D pblk_line_get(pblk);
> 	if (!retry_line) {
> -		l_mg->data_line =3D NULL;
> +		pblk_line_set_data_line(pblk, type, NULL);
> 		spin_unlock(&l_mg->free_lock);
> 		return NULL;
> 	}
> @@ -1432,7 +1432,7 @@ static struct pblk_line *pblk_line_retry(struct =
pblk *pblk,
>=20
> 	pblk_line_reinit(line);
>=20
> -	l_mg->data_line =3D retry_line;
> +	pblk_line_set_data_line(pblk, type, retry_line);
> 	spin_unlock(&l_mg->free_lock);
>=20
> 	pblk_rl_free_lines_dec(&pblk->rl, line, false);
> @@ -1450,37 +1450,29 @@ static void pblk_set_space_limit(struct pblk =
*pblk)
> 	atomic_set(&rl->rb_space, 0);
> }
>=20
> -struct pblk_line *pblk_line_get_first_data(struct pblk *pblk)
> +struct pblk_line *pblk_line_get_first_data(struct pblk *pblk, int =
type)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line *line;
>=20
> 	spin_lock(&l_mg->free_lock);
> -	line =3D pblk_line_get(pblk);
> +	line =3D pblk_line_init_data_line(pblk, type);
> 	if (!line) {
> 		spin_unlock(&l_mg->free_lock);
> 		return NULL;
> 	}
>=20
> -	line->seq_nr =3D l_mg->d_seq_nr++;
> -	line->type =3D PBLK_LINETYPE_DATA;
> -	l_mg->data_line =3D line;
> -
> 	pblk_line_setup_metadata(line, l_mg, &pblk->lm);
>=20
> 	/* Allocate next line for preparation */
> -	l_mg->data_next =3D pblk_line_get(pblk);
> -	if (!l_mg->data_next) {
> +	if (!pblk_line_init_next_line(pblk, type)) {
> 		/* If we cannot get a new line, we need to stop the =
pipeline.
> 		 * Only allow as many writes in as we can store safely =
and then
> 		 * fail gracefully
> 		 */
> 		pblk_set_space_limit(pblk);
>=20
> -		l_mg->data_next =3D NULL;
> -	} else {
> -		l_mg->data_next->seq_nr =3D l_mg->d_seq_nr++;
> -		l_mg->data_next->type =3D PBLK_LINETYPE_DATA;
> +		pblk_line_set_next_line(pblk, type, NULL);
> 	}
> 	spin_unlock(&l_mg->free_lock);
>=20
> @@ -1488,14 +1480,14 @@ struct pblk_line =
*pblk_line_get_first_data(struct pblk *pblk)
> 		return NULL;
>=20
> 	if (pblk_line_erase(pblk, line)) {
> -		line =3D pblk_line_retry(pblk, line);
> +		line =3D pblk_line_retry(pblk, line, type);
> 		if (!line)
> 			return NULL;
> 	}
>=20
> retry_setup:
> 	if (!pblk_line_init_metadata(pblk, line, NULL)) {
> -		line =3D pblk_line_retry(pblk, line);
> +		line =3D pblk_line_retry(pblk, line, type);
> 		if (!line)
> 			return NULL;
>=20
> @@ -1503,7 +1495,7 @@ struct pblk_line =
*pblk_line_get_first_data(struct pblk *pblk)
> 	}
>=20
> 	if (!pblk_line_init_bb(pblk, line, 1)) {
> -		line =3D pblk_line_retry(pblk, line);
> +		line =3D pblk_line_retry(pblk, line, type);
> 		if (!line)
> 			return NULL;
>=20
> @@ -1596,12 +1588,18 @@ void __pblk_pipeline_flush(struct pblk *pblk)
> 	pblk_flush_writer(pblk);
> 	pblk_wait_for_meta(pblk);
>=20
> -	ret =3D pblk_recov_pad(pblk);
> +	ret =3D pblk_recov_pad(pblk, PBLK_LINETYPE_DATA);
> 	if (ret) {
> 		pblk_err(pblk, "could not close data on teardown(%d)\n", =
ret);
> 		return;
> 	}
>=20
> +	ret =3D pblk_recov_pad(pblk, PBLK_LINETYPE_GC);
> +	if (ret) {
> +		pblk_err(pblk, "could not close gc on teardown(%d)\n", =
ret);
> +		return;
> +	}
> +
> 	flush_workqueue(pblk->bb_wq);
> 	pblk_line_close_meta_sync(pblk);
> }
> @@ -1613,8 +1611,10 @@ void __pblk_pipeline_stop(struct pblk *pblk)
> 	spin_lock(&l_mg->free_lock);
> 	pblk->state =3D PBLK_STATE_STOPPED;
> 	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
> -	l_mg->data_line =3D NULL;
> -	l_mg->data_next =3D NULL;
> +	pblk_line_set_data_line(pblk, PBLK_LINETYPE_DATA, NULL);
> +	pblk_line_set_data_line(pblk, PBLK_LINETYPE_GC, NULL);
> +	pblk_line_set_next_line(pblk, PBLK_LINETYPE_DATA, NULL);
> +	pblk_line_set_next_line(pblk, PBLK_LINETYPE_GC, NULL);
> 	spin_unlock(&l_mg->free_lock);
> }
>=20
> @@ -1624,19 +1624,20 @@ void pblk_pipeline_stop(struct pblk *pblk)
> 	__pblk_pipeline_stop(pblk);
> }
>=20
> -struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
> +struct pblk_line *pblk_line_replace_data(struct pblk *pblk, int type)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line *cur, *new =3D NULL;
> 	unsigned int left_seblks;
>=20
> -	new =3D l_mg->data_next;
> +	new =3D pblk_line_get_next_line(pblk, type);
> 	if (!new)
> 		goto out;
>=20
> 	spin_lock(&l_mg->free_lock);
> -	cur =3D l_mg->data_line;
> -	l_mg->data_line =3D new;
> +
> +	cur =3D pblk_line_get_data_line(pblk, type);
> +	pblk_line_set_data_line(pblk, type, new);
>=20
> 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
> 	spin_unlock(&l_mg->free_lock);
> @@ -1659,7 +1660,7 @@ struct pblk_line *pblk_line_replace_data(struct =
pblk *pblk)
>=20
> retry_setup:
> 	if (!pblk_line_init_metadata(pblk, new, cur)) {
> -		new =3D pblk_line_retry(pblk, new);
> +		new =3D pblk_line_retry(pblk, new, type);
> 		if (!new)
> 			goto out;
>=20
> @@ -1667,7 +1668,7 @@ struct pblk_line *pblk_line_replace_data(struct =
pblk *pblk)
> 	}
>=20
> 	if (!pblk_line_init_bb(pblk, new, 1)) {
> -		new =3D pblk_line_retry(pblk, new);
> +		new =3D pblk_line_retry(pblk, new, type);
> 		if (!new)
> 			goto out;
>=20
> @@ -1678,17 +1679,12 @@ struct pblk_line =
*pblk_line_replace_data(struct pblk *pblk)
>=20
> 	/* Allocate next line for preparation */
> 	spin_lock(&l_mg->free_lock);
> -	l_mg->data_next =3D pblk_line_get(pblk);
> -	if (!l_mg->data_next) {
> +	if (!pblk_line_init_next_line(pblk, type)) {
> 		/* If we cannot get a new line, we need to stop the =
pipeline.
> 		 * Only allow as many writes in as we can store safely =
and then
> 		 * fail gracefully
> 		 */
> 		pblk_stop_writes(pblk, new);
> -		l_mg->data_next =3D NULL;
> -	} else {
> -		l_mg->data_next->seq_nr =3D l_mg->d_seq_nr++;
> -		l_mg->data_next->type =3D PBLK_LINETYPE_DATA;
> 	}
> 	spin_unlock(&l_mg->free_lock);
>=20
> @@ -1801,15 +1797,100 @@ int pblk_blk_erase_async(struct pblk *pblk, =
struct ppa_addr ppa)
> 	return err;
> }
>=20
> -struct pblk_line *pblk_line_get_data(struct pblk *pblk)
> +struct pblk_line *pblk_line_get_data_line(struct pblk *pblk, int =
type)
> {
> -	return pblk->l_mg.data_line;
> +	switch (type) {
> +	case PBLK_LINETYPE_DATA:
> +		return pblk->l_mg.data_line;
> +	case PBLK_LINETYPE_GC:
> +		return pblk->l_mg.gc_line;
> +	case PBLK_LINETYPE_LOG:
> +		return pblk->l_mg.log_line;
> +	default:
> +		WARN(1, "Unsupported line type\n");
> +		return NULL;
> +	}
> }
>=20
> /* For now, always erase next line */
> -struct pblk_line *pblk_line_get_erase(struct pblk *pblk)
> +struct pblk_line *pblk_line_get_next_line(struct pblk *pblk, int =
type)
> {
> -	return pblk->l_mg.data_next;
> +	switch (type) {
> +	case PBLK_LINETYPE_DATA:
> +		return pblk->l_mg.data_next;
> +	case PBLK_LINETYPE_GC:
> +		return pblk->l_mg.gc_next;
> +	case PBLK_LINETYPE_LOG:
> +		return pblk->l_mg.log_next;
> +	default:
> +		WARN(1, "Unsupported line type\n");
> +		return NULL;
> +	}
> +}
> +
> +void pblk_line_set_data_line(struct pblk *pblk, int type, struct =
pblk_line *line)
> +{
> +	switch (type) {
> +	case PBLK_LINETYPE_DATA:
> +		pblk->l_mg.data_line =3D line;
> +		break;
> +	case PBLK_LINETYPE_GC:
> +		pblk->l_mg.gc_line =3D line;
> +		break;
> +	case PBLK_LINETYPE_LOG:
> +		pblk->l_mg.log_line =3D line;
> +		break;
> +	default:
> +		WARN(1, "Unsupported line type\n");
> +	}
> +}
> +
> +/* For now, always erase next line */
> +void pblk_line_set_next_line(struct pblk *pblk, int type, struct =
pblk_line *line)
> +{
> +	switch (type) {
> +	case PBLK_LINETYPE_DATA:
> +		pblk->l_mg.data_next =3D line;
> +		break;
> +	case PBLK_LINETYPE_GC:
> +		pblk->l_mg.gc_next =3D line;
> +		break;
> +	case PBLK_LINETYPE_LOG:
> +		pblk->l_mg.log_next =3D line;
> +		break;
> +	default:
> +		WARN(1, "Unsupported line type\n");
> +	}
> +}
> +
> +struct pblk_line *pblk_line_init_data_line(struct pblk *pblk, int =
type)
> +{
> +	struct pblk_line *line =3D pblk_line_get(pblk);
> +	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +
> +	lockdep_assert_held(&l_mg->free_lock);
> +
> +	if (line) {
> +		line->seq_nr =3D l_mg->d_seq_nr++;
> +		line->type =3D type;
> +		pblk_line_set_data_line(pblk, type, line);
> +	}
> +	return line;
> +}
> +
> +struct pblk_line *pblk_line_init_next_line(struct pblk *pblk, int =
type)
> +{
> +	struct pblk_line *line =3D pblk_line_get(pblk);
> +	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> +
> +	lockdep_assert_held(&l_mg->free_lock);
> +
> +	if (line) {
> +		line->seq_nr =3D l_mg->d_seq_nr++;
> +		line->type =3D type;
> +		pblk_line_set_next_line(pblk, type, line);
> +	}
> +	return line;
> }
>=20
> int pblk_line_is_full(struct pblk_line *line)
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 1e227a08e54a..0d127e32d556 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -139,11 +139,16 @@ static int pblk_l2p_recover(struct pblk *pblk, =
bool factory_init)
>=20
> 	if (!line) {
> 		/* Configure next line for user data */
> -		line =3D pblk_line_get_first_data(pblk);
> +		line =3D pblk_line_get_first_data(pblk, =
PBLK_LINETYPE_DATA);
> 		if (!line)
> 			return -EFAULT;
> 	}
>=20
> +	/* Configure next line for gc data */
> +	line =3D pblk_line_get_first_data(pblk, PBLK_LINETYPE_GC);
> +	if (!line)
> +		return -EFAULT;
> +
> 	return 0;
> }
>=20
> @@ -832,7 +837,7 @@ static int pblk_line_mg_init(struct pblk *pblk)
> 	int i, bb_distance;
>=20
> 	l_mg->nr_lines =3D geo->num_chk;
> -	l_mg->log_line =3D l_mg->data_line =3D NULL;
> +	l_mg->log_line =3D l_mg->data_line =3D l_mg->gc_line =3D NULL;
> 	l_mg->l_seq_nr =3D l_mg->d_seq_nr =3D 0;
> 	l_mg->nr_free_lines =3D 0;
> 	bitmap_zero(&l_mg->meta_bitmap, PBLK_DATA_LINES);
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 5408e32b2f13..9b0539137df0 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -23,9 +23,9 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 			      struct ppa_addr *ppa_list,
> 			      unsigned long *lun_bitmap,
> 			      void *meta_list,
> -			      unsigned int valid_secs)
> +			      unsigned int valid_secs, int type)
> {
> -	struct pblk_line *line =3D pblk_line_get_data(pblk);
> +	struct pblk_line *line =3D pblk_line_get_data_line(pblk, type);
> 	struct pblk_emeta *emeta;
> 	struct pblk_w_ctx *w_ctx;
> 	__le64 *lba_list;
> @@ -42,7 +42,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 		/* If we cannot allocate a new line, make sure to store =
metadata
> 		 * on current line and then fail
> 		 */
> -		line =3D pblk_line_replace_data(pblk);
> +		line =3D pblk_line_replace_data(pblk, type);
> 		pblk_line_close_meta(pblk, prev_line);
>=20
> 		if (!line) {
> @@ -94,8 +94,8 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> }
>=20
> int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int =
sentry,
> -		 unsigned long *lun_bitmap, unsigned int valid_secs,
> -		 unsigned int off)
> +		unsigned long *lun_bitmap, unsigned int valid_secs,
> +		unsigned int off, int type)
> {
> 	void *meta_list =3D pblk_get_meta_for_writes(pblk, rqd);
> 	void *meta_buffer;
> @@ -110,7 +110,7 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
> 		meta_buffer =3D pblk_get_meta(pblk, meta_list, i);
>=20
> 		ret =3D pblk_map_page_data(pblk, sentry + i, =
&ppa_list[i],
> -					lun_bitmap, meta_buffer, =
map_secs);
> +					 lun_bitmap, meta_buffer, =
map_secs, type);
> 		if (ret)
> 			return ret;
> 	}
> @@ -120,8 +120,9 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq =
*rqd, unsigned int sentry,
>=20
> /* only if erase_ppa is set, acquire erase semaphore */
> int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
> -		       unsigned int sentry, unsigned long *lun_bitmap,
> -		       unsigned int valid_secs, struct ppa_addr =
*erase_ppa)
> +		      unsigned int sentry, unsigned long *lun_bitmap,
> +		      unsigned int valid_secs, struct ppa_addr =
*erase_ppa,
> +		      int type)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> @@ -141,7 +142,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> 		meta_buffer =3D pblk_get_meta(pblk, meta_list, i);
>=20
> 		ret =3D pblk_map_page_data(pblk, sentry + i, =
&ppa_list[i],
> -					lun_bitmap, meta_buffer, =
map_secs);
> +					 lun_bitmap, meta_buffer, =
map_secs, type);
> 		if (ret)
> 			return ret;
>=20
> @@ -150,10 +151,10 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
> 		/* line can change after page map. We might also be =
writing the
> 		 * last line.
> 		 */
> -		e_line =3D pblk_line_get_erase(pblk);
> +		e_line =3D pblk_line_get_next_line(pblk, type);
> 		if (!e_line)
> 			return pblk_map_rq(pblk, rqd, sentry, =
lun_bitmap,
> -							valid_secs, i + =
min);
> +					   valid_secs, i + min, type);
>=20
> 		spin_lock(&e_line->lock);
> 		if (!test_bit(erase_lun, e_line->erase_bitmap)) {
> @@ -168,17 +169,17 @@ int pblk_map_erase_rq(struct pblk *pblk, struct =
nvm_rq *rqd,
>=20
> 			/* Avoid evaluating e_line->left_eblks */
> 			return pblk_map_rq(pblk, rqd, sentry, =
lun_bitmap,
> -							valid_secs, i + =
min);
> +					   valid_secs, i + min, type);
> 		}
> 		spin_unlock(&e_line->lock);
> 	}
>=20
> -	d_line =3D pblk_line_get_data(pblk);
> +	d_line =3D pblk_line_get_data_line(pblk, type);
>=20
> 	/* line can change after page map. We might also be writing the
> 	 * last line.
> 	 */
> -	e_line =3D pblk_line_get_erase(pblk);
> +	e_line =3D pblk_line_get_next_line(pblk, type);
> 	if (!e_line)
> 		return -ENOSPC;
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 865fe310cab4..38bf7b28e73f 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -677,12 +677,12 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> {
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> -	struct pblk_line *line, *tline, *data_line =3D NULL;
> +	struct pblk_line *line, *tline, *data_line =3D NULL, *gc_line =3D =
NULL;
> 	struct pblk_smeta *smeta;
> 	struct pblk_emeta *emeta;
> 	struct line_smeta *smeta_buf;
> 	int found_lines =3D 0, recovered_lines =3D 0, open_lines =3D 0;
> -	int is_next =3D 0;
> +	int is_data_next =3D 0, is_gc_next =3D 0;
> 	int meta_line;
> 	int i, valid_uuid =3D 0;
> 	LIST_HEAD(recov_list);
> @@ -838,7 +838,11 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 			trace_pblk_line_state(pblk_disk_name(pblk), =
line->id,
> 					line->state);
>=20
> -			data_line =3D line;
> +			if (line->type =3D=3D PBLK_LINETYPE_DATA)
> +				data_line =3D line;
> +			else if (line->type =3D=3D PBLK_LINETYPE_GC)
> +				gc_line =3D line;
> +
> 			line->meta_line =3D meta_line;
>=20
> 			open_lines++;
> @@ -852,19 +856,30 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> 		spin_unlock(&l_mg->free_lock);
> 	} else {
> 		spin_lock(&l_mg->free_lock);
> -		l_mg->data_line =3D data_line;
> -		/* Allocate next line for preparation */
> -		l_mg->data_next =3D pblk_line_get(pblk);
> -		if (l_mg->data_next) {
> -			l_mg->data_next->seq_nr =3D l_mg->d_seq_nr++;
> -			l_mg->data_next->type =3D PBLK_LINETYPE_DATA;
> -			is_next =3D 1;
> +		if (data_line) {
> +			pblk_line_set_data_line(pblk, =
PBLK_LINETYPE_DATA,
> +						data_line);
> +			/* Allocate next line for preparation */
> +			if (pblk_line_init_next_line(pblk, =
PBLK_LINETYPE_DATA))
> +				is_data_next =3D 1;
> +		}
> +		if (gc_line) {
> +			pblk_line_set_data_line(pblk, PBLK_LINETYPE_GC,
> +						gc_line);
> +			/* Allocate next line for preparation */
> +			if (pblk_line_init_next_line(pblk, =
PBLK_LINETYPE_GC))
> +				is_gc_next =3D 1;
> 		}
> +
> 		spin_unlock(&l_mg->free_lock);
> 	}
>=20
> -	if (is_next)
> -		pblk_line_erase(pblk, l_mg->data_next);
> +	if (is_data_next)
> +		pblk_line_erase(pblk, pblk_line_get_next_line(pblk,
> +							   =
PBLK_LINETYPE_DATA));
> +	if (is_gc_next)
> +		pblk_line_erase(pblk, pblk_line_get_next_line(pblk,
> +							   =
PBLK_LINETYPE_GC));
>=20
> out:
> 	if (found_lines !=3D recovered_lines)
> @@ -877,7 +892,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
> /*
>  * Pad current line
>  */
> -int pblk_recov_pad(struct pblk *pblk)
> +int pblk_recov_pad(struct pblk *pblk, int type)
> {
> 	struct pblk_line *line;
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> @@ -885,7 +900,7 @@ int pblk_recov_pad(struct pblk *pblk)
> 	int ret =3D 0;
>=20
> 	spin_lock(&l_mg->free_lock);
> -	line =3D l_mg->data_line;
> +	line =3D pblk_line_get_data_line(pblk, type);
> 	left_msecs =3D line->left_msecs;
> 	spin_unlock(&l_mg->free_lock);
>=20
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 4e63f9b5954c..1e38adc63800 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -313,10 +313,10 @@ static int pblk_alloc_w_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
> }
>=20
> static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
> -			   struct ppa_addr *erase_ppa)
> +			   struct ppa_addr *erase_ppa, int type)
> {
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> -	struct pblk_line *e_line =3D pblk_line_get_erase(pblk);
> +	struct pblk_line *e_line =3D pblk_line_get_next_line(pblk, =
type);
> 	struct pblk_c_ctx *c_ctx =3D nvm_rq_to_pdu(rqd);
> 	unsigned int valid =3D c_ctx->nr_valid;
> 	unsigned int padded =3D c_ctx->nr_padded;
> @@ -337,10 +337,10 @@ static int pblk_setup_w_rq(struct pblk *pblk, =
struct nvm_rq *rqd,
>=20
> 	if (likely(!e_line || !atomic_read(&e_line->left_eblks)))
> 		ret =3D pblk_map_rq(pblk, rqd, c_ctx->sentry, =
lun_bitmap,
> -							valid, 0);
> +				  valid, 0, type);
> 	else
> 		ret =3D pblk_map_erase_rq(pblk, rqd, c_ctx->sentry, =
lun_bitmap,
> -							valid, =
erase_ppa);
> +					valid, erase_ppa, type);
>=20
> 	return ret;
> }
> @@ -446,12 +446,13 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>=20
> static inline bool pblk_valid_meta_ppa(struct pblk *pblk,
> 				       struct pblk_line *meta_line,
> -				       struct nvm_rq *data_rqd)
> +				       struct nvm_rq *data_rqd,
> +				       int type)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_c_ctx *data_c_ctx =3D nvm_rq_to_pdu(data_rqd);
> -	struct pblk_line *data_line =3D pblk_line_get_data(pblk);
> +	struct pblk_line *data_line =3D pblk_line_get_data_line(pblk, =
type);
> 	struct ppa_addr ppa, ppa_opt;
> 	u64 paddr;
> 	int pos_opt;
> @@ -481,7 +482,8 @@ static inline bool pblk_valid_meta_ppa(struct pblk =
*pblk,
> }
>=20
> static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
> -						    struct nvm_rq =
*data_rqd)
> +						    struct nvm_rq =
*data_rqd,
> +						    int type)
> {
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> @@ -499,13 +501,13 @@ static struct pblk_line =
*pblk_should_submit_meta_io(struct pblk *pblk,
> 	}
> 	spin_unlock(&l_mg->close_lock);
>=20
> -	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))
> +	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd, type))
> 		return NULL;
>=20
> 	return meta_line;
> }
>=20
> -static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
> +static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd, =
int type)
> {
> 	struct ppa_addr erase_ppa;
> 	struct pblk_line *meta_line;
> @@ -514,13 +516,13 @@ static int pblk_submit_io_set(struct pblk *pblk, =
struct nvm_rq *rqd)
> 	pblk_ppa_set_empty(&erase_ppa);
>=20
> 	/* Assign lbas to ppas and populate request structure */
> -	err =3D pblk_setup_w_rq(pblk, rqd, &erase_ppa);
> +	err =3D pblk_setup_w_rq(pblk, rqd, &erase_ppa, type);
> 	if (err) {
> 		pblk_err(pblk, "could not setup write request: %d\n", =
err);
> 		return NVM_IO_ERR;
> 	}
>=20
> -	meta_line =3D pblk_should_submit_meta_io(pblk, rqd);
> +	meta_line =3D pblk_should_submit_meta_io(pblk, rqd, type);
>=20
> 	/* Submit data write for current data line */
> 	err =3D pblk_submit_io(pblk, rqd);
> @@ -532,11 +534,12 @@ static int pblk_submit_io_set(struct pblk *pblk, =
struct nvm_rq *rqd)
> 	if (!pblk_ppa_empty(erase_ppa)) {
> 		/* Submit erase for next data line */
> 		if (pblk_blk_erase_async(pblk, erase_ppa)) {
> -			struct pblk_line *e_line =3D =
pblk_line_get_erase(pblk);
> +			struct pblk_line *e_line;
> 			struct nvm_tgt_dev *dev =3D pblk->dev;
> 			struct nvm_geo *geo =3D &dev->geo;
> 			int bit;
>=20
> +			e_line =3D pblk_line_get_next_line(pblk, type);
> 			atomic_inc(&e_line->left_eblks);
> 			bit =3D pblk_ppa_to_pos(geo, erase_ppa);
> 			WARN_ON(!test_and_clear_bit(bit, =
e_line->erase_bitmap));
> @@ -574,6 +577,9 @@ static int pblk_submit_write(struct pblk *pblk, =
int *secs_left)
> 	unsigned int secs_to_flush, packed_meta_pgs;
> 	unsigned long pos;
> 	unsigned int resubmit;
> +	int type;
> +	struct pblk_w_ctx *w_ctx;
> +	struct pblk_rb_entry *entry;
>=20
> 	*secs_left =3D 0;
>=20
> @@ -633,13 +639,18 @@ static int pblk_submit_write(struct pblk *pblk, =
int *secs_left)
> 	rqd =3D pblk_alloc_rqd(pblk, PBLK_WRITE);
> 	rqd->bio =3D bio;
>=20
> +	entry =3D &pblk->rwb.entries[pos];
> +	w_ctx =3D &entry->w_ctx;
> +	type =3D w_ctx->flags & PBLK_IOTYPE_GC ?
> +		PBLK_LINETYPE_GC : PBLK_LINETYPE_DATA;
> +
> 	if (pblk_rb_read_to_bio(&pblk->rwb, rqd, pos, secs_to_sync,
> 								=
secs_avail)) {
> 		pblk_err(pblk, "corrupted write bio\n");
> 		goto fail_put_bio;
> 	}
>=20
> -	if (pblk_submit_io_set(pblk, rqd))
> +	if (pblk_submit_io_set(pblk, rqd, type))
> 		goto fail_free_bio;
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index e304754aaa3c..93ef5a2bffe6 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -316,6 +316,7 @@ enum {
> 	PBLK_LINETYPE_FREE =3D 0,
> 	PBLK_LINETYPE_LOG =3D 1,
> 	PBLK_LINETYPE_DATA =3D 2,
> +	PBLK_LINETYPE_GC =3D 3,
>=20
> 	/* Line state */
> 	PBLK_LINESTATE_NEW =3D 9,
> @@ -526,8 +527,10 @@ struct pblk_line_mgmt {
>=20
> 	struct pblk_line *log_line;	/* Current FTL log line */
> 	struct pblk_line *data_line;	/* Current data line */
> +	struct pblk_line *gc_line;	/* Current gc line */
> 	struct pblk_line *log_next;	/* Next FTL log line */
> 	struct pblk_line *data_next;	/* Next data line */
> +	struct pblk_line *gc_next;	/* Next gc line */

Would it make sense to generalize this and just use an array of lines
with positions for user and GC at this moment? Support for several
streams is around the corner and we would use this same strategy.

>=20
> 	struct list_head emeta_list;	/* Lines queued to schedule =
emeta */
>=20
> @@ -804,14 +807,20 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, =
void *data,
> 			      unsigned int nr_secs, unsigned int len,
> 			      int alloc_type, gfp_t gfp_mask);
> struct pblk_line *pblk_line_get(struct pblk *pblk);
> -struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
> -struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
> +struct pblk_line *pblk_line_get_first_data(struct pblk *pblk, int =
type);
> +struct pblk_line *pblk_line_replace_data(struct pblk *pblk, int =
type);
> void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa);
> void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd);
> int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
> void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
> -struct pblk_line *pblk_line_get_data(struct pblk *pblk);
> -struct pblk_line *pblk_line_get_erase(struct pblk *pblk);
> +struct pblk_line *pblk_line_get_data_line(struct pblk *pblk, int =
type);
> +struct pblk_line *pblk_line_get_next_line(struct pblk *pblk, int =
type);
> +void pblk_line_set_data_line(struct pblk *pblk, int type,
> +			     struct pblk_line *line);
> +void pblk_line_set_next_line(struct pblk *pblk, int type,
> +			     struct pblk_line *line);
> +struct pblk_line *pblk_line_init_next_line(struct pblk *pblk, int =
type);
> +struct pblk_line *pblk_line_init_data_line(struct pblk *pblk, int =
type);
> int pblk_line_erase(struct pblk *pblk, struct pblk_line *line);
> int pblk_line_is_full(struct pblk_line *line);
> void pblk_line_free(struct pblk_line *line);
> @@ -875,11 +884,12 @@ int pblk_write_gc_to_cache(struct pblk *pblk, =
struct pblk_gc_rq *gc_rq);
>  * pblk map
>  */
> int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
> -		       unsigned int sentry, unsigned long *lun_bitmap,
> -		       unsigned int valid_secs, struct ppa_addr =
*erase_ppa);
> +		      unsigned int sentry, unsigned long *lun_bitmap,
> +		      unsigned int valid_secs, struct ppa_addr =
*erase_ppa,
> +		      int type);
> int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int =
sentry,
> -		 unsigned long *lun_bitmap, unsigned int valid_secs,
> -		 unsigned int off);
> +		unsigned long *lun_bitmap, unsigned int valid_secs,
> +		unsigned int off, int type);

Would be good to clean the pblk_map_* functions; they have grown a lot =
in parameters.

>=20
> /*
>  * pblk write thread
> @@ -899,7 +909,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq);
>  * pblk recovery
>  */
> struct pblk_line *pblk_recov_l2p(struct pblk *pblk);
> -int pblk_recov_pad(struct pblk *pblk);
> +int pblk_recov_pad(struct pblk *pblk, int type);
> int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta =
*emeta);
>=20
> /*
> --
> 2.17.1


I like this patch a lot. Thanks Heiner!

I started some tests on my side; I=E2=80=99ll send a tested-by tag then. =
For now
you can add my review - the comments are small suggestions.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_54B3B987-D6D3-428C-B656-99AD392CF5DC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlzBSmEACgkQPEYBfS0l
eOA/zRAAjGgenwGTaV0g/3WWT+McDq7VP6UyZJhHPPwW6242YUeSK/NSO9sigbY9
5hMfvwTccDI+JU1BkXU5vtY8IQYmZD4de6d7M63eV1xFOiVk0tlmLcGEl8Caeewf
I873G0mjUNNuvD0e4dfMjOckjSuCj7QHVe6/cHSyXYGd7eKPHqJSL7trAAnRWtaj
9Melq/2yGyRPS4h3hBk/qmneALt3/7SrLVqJW4MUpbw3gZI1OrHnUmG7rCDU3z8e
P5e/sevXfbHST6pE0p6Zvt30/7FTGvubJje31VOC3XDIEVdOhTlsMUBwNuESy197
BdxDJ8UCXWGebI+mmElXYmVdPg8iOsv5gQFQtwPfW4YgLeiHoUfJ9g/4o6ULBCDW
DSoPJbGjgp+yF9nCWTJleRxupTuGrKBYMQrFraWxiX0jbe1XPajYEguv/d7apBDb
UbbgewKV5lp3Qb+TOp/A16zUrVwlKxS6vxL8tvZi4pDIDx9Q1tyJrxzsqf8RPiIG
8R6FjrWElf4U6GS/8TsQuNhwHJtL9LMLEK1s32UTxDSju6McJyXQwjAwbYRDYtH3
nmCSE2MwPw3jcWV4W2H11C5nutNY5euj3soHVC+owcZBPIoxQUHh43ALOyj5p/+R
F18nqWQ4np6QGPLGn5GcooRL3ljXNsPd270AiaCPFFCTSJ3JmA0=
=YkXy
-----END PGP SIGNATURE-----

--Apple-Mail=_54B3B987-D6D3-428C-B656-99AD392CF5DC--

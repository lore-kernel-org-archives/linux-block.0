Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08A23A9AD
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392802; cv=none; b=B1Toz8SAa6HpWZUEZaiLQ4PZD//5u6+J11fSE+NAS2ycNwayMHAO3aUeB9OpGruqlWDVhGttQSgYcybAENSSlDgvv3GMHoh5RY0LRrywZhvfY9PgfX7BcboR51lu4HIwKt3hW7JQnKy9qHJN4zD7SiWai7Eeil/Iq0zgT+lLdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392802; c=relaxed/simple;
	bh=ZtfJSWRmDHhK2Uy5FpFLaIqXSw1L4SsRxkKEuyf2Kos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpc2Fq8IDrDlhKVt8Y+T1neJzveSHafejt5GjIhOhJ+H8DzHCTKRJiV8eu+PpcoXrM+jwZ1lCNPJnHdkuAupHtxzAn+w5c1cE5LZ4d+hzclABAQWsr5p1Qbd95Tza+NAlKBWKwYu84e64/L9WAWDnpj/NSFhgfbAvx5VrZexNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LO/PjrXd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LO/PjrXd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e13bf404so401425ad.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763392800; x=1763997600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ7egRaDVNMSInh9i7/SneIXMiAUZjbeT4p3WDUmNAc=;
        b=LO/PjrXdDbgVUnrPLdxVEadoDBj3m/SFbE2HaoJ1HM1gOIfsIQvCbEX2DXi+z/Uo10
         Ku24yfI60zNy3Ailyy4ALwT/NnoT5YH231S3iC5NRJC9eLl681dywVdHD/jGEU+DRP/Z
         +qCGjUAgpHIFpziJd9584DpIcgpVcQ5SLho7PXaNx49FLGtSWoy0ZnAG/dZR807wWy1T
         bJ49+7dcN7XyvtKzP14gQfc12UhTxdSCc/XfIn5lpNihG/Ud0kjDLvEKgeCMkfNYGcHp
         W/HBrZ2o3JYjj/ukMCT3DNJQGjUO++9yjG9064BUawssHEmyu2gNFD24V+gpAPFSbUYw
         RxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392800; x=1763997600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJ7egRaDVNMSInh9i7/SneIXMiAUZjbeT4p3WDUmNAc=;
        b=MkHXLEFi4tOpQRx4n6H7LRtvTtihLv4qbX4Bp7UI4lmcvvePg08Twd2UWuy8wsQfOI
         FxInyMxZkQAT+cZdjRb3h0LbfUiGckw8gsC3bMwWfZWFJ9S6y6FUrvs+BQ4U2eZA47n0
         q6FlC5RdyDmSSVyKgwZwzZ3vKCzLiCZ9BIV/KMg9vjcWe4lOMMZhMOUhz7k9IWUu0cp9
         gM9NxR1g+3yBMbjaEwK+U2dbqQ3d0OtEtR21wUGL7EcUJkeiCFWpZVTAOcFgovQhpJwS
         7eSaceiZxoNH26zFW/9eIFD5FvC8Ir6tw1ZsxjNnH1CsYu2Hn74+LydYUqBctCKd0Gf7
         Yukw==
X-Forwarded-Encrypted: i=1; AJvYcCVSl0O8sPBaPe5j+prp3hoG5wSj8I8TXs9TTgc+cf2pwbDLBOujliLgNo02bT2ZPQSp9GjYx36iBPnBlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIatWV4yLRNaM4IjhgrqfIn7sVI3zRm9if8AAWcJbY6169/fC
	ouCLrZOex5fwlXA/L1RnQpIzloo7LZ+hhFrmI0ts43oBs9NPDdHkwodoRQzLUniTZbDZ3uw33Sm
	f/KKrvnuAoSvVF/fhWoSNiPoFjPpeCGT3+4CrFJy8
X-Gm-Gg: ASbGncuT3KSCGkGxseArnM4mJqVX/UHN90HBJ4u63bhDLQWILy5X/edYIjCGaBHwSRC
	rXFgnyZlO6X/JZpGXLYfEzS3QZ2M/Warz8KUCfmCRy9It+0Qt0dG8UtO2BLRKA/xNcmqS6KlB4c
	xFUO+z6BMOhFx/Mfcg8Gj+z+ghtnjEaOTTZZR7XDLDmc99Pl3zUBpAilVpC9f0+ioz1iRh/W0sG
	WazxFjephtxK3Tn+eK5NZ1JiK8HMLufZKR6YXPhA4jznZ8Z5/4RNyEB9hpwa0Sr8RaWrcMdyqWj
	W3RExehkdWYEZNpQUWHXYvYV1+2nNysvZbBML3eo59zVSmyhWv4zPLk=
X-Google-Smtp-Source: AGHT+IFmPbwHa2zdBPFZu54nsAiHmjGzULvhKyvC/0mCK6Fve2sI66TMcNqWFEno0cy2V8XtILG9bMhNxBzcDPxJXoA=
X-Received: by 2002:a17:902:d4cd:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-299f4a3eafemr75ad.6.1763392798956; Mon, 17 Nov 2025 07:19:58
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115023447.495417-1-senozhatsky@chromium.org> <20251115023447.495417-2-senozhatsky@chromium.org>
In-Reply-To: <20251115023447.495417-2-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 17 Nov 2025 10:19:22 -0500
X-Gm-Features: AWmQ_blDTLoax8uxJhl4MtvN07CDRxv9gzuW7M7HtQx4zJ9mZPC5heCRHsy0Xws
Message-ID: <CADyq12zxzi+t727B5sm5z-z3SmRQyMDOmr_tTG1GaMVh6VTWbw@mail.gmail.com>
Subject: Re: [PATCHv3 1/4] zram: introduce writeback bio batching support
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 9:35=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> From: Yuwen Chen <ywen.chen@foxmail.com>
>
> Currently, zram writeback supports only a single bio writeback
> operation, waiting for bio completion before post-processing
> next pp-slot.  This works, in general, but has certain throughput
> limitations.  Implement batched (multiple) bio writeback support
> to take advantage of parallel requests processing and better
> requests scheduling.
>
> For the time being the writeback batch size (maximum number of
> in-flight bio requests) is set to 32 for all devices.  A follow
> up patch adds a writeback_batch_size device attribute, so the
> batch size becomes run-time configurable.
>
> Please refer to [1] and [2] for benchmarks.
>
> [1] https://lore.kernel.org/linux-block/tencent_B2DC37E3A2AED0E7F179365FC=
B5D82455B08@qq.com
> [2] https://lore.kernel.org/linux-block/tencent_0FBBFC8AE0B97BC63B5D47CE1=
FF2BABFDA09@qq.com
>
> [senozhatsky: significantly reworked the initial patch so that the
> approach and implementation resemble current zram post-processing
> code]
>
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Co-developed-by: Richard Chang <richardycc@google.com>
> Suggested-by: Minchan Kim <minchan@google.com>
> ---
>  drivers/block/zram/zram_drv.c | 343 +++++++++++++++++++++++++++-------
>  1 file changed, 277 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index a43074657531..84e72c3bb280 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -500,6 +500,24 @@ static ssize_t idle_store(struct device *dev,
>  }
>
>  #ifdef CONFIG_ZRAM_WRITEBACK
> +struct zram_wb_ctl {
> +       struct list_head idle_reqs;
> +       struct list_head inflight_reqs;
> +
> +       atomic_t num_inflight;
> +       struct completion done;
> +};
> +
> +struct zram_wb_req {
> +       unsigned long blk_idx;
> +       struct page *page;
> +       struct zram_pp_slot *pps;
> +       struct bio_vec bio_vec;
> +       struct bio bio;
> +
> +       struct list_head entry;
> +};
> +
>  static ssize_t writeback_limit_enable_store(struct device *dev,
>                 struct device_attribute *attr, const char *buf, size_t le=
n)
>  {
> @@ -734,20 +752,207 @@ static void read_from_bdev_async(struct zram *zram=
, struct page *page,
>         submit_bio(bio);
>  }
>
> -static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *c=
tl)
> +static void release_wb_req(struct zram_wb_req *req)
> +{
> +       __free_page(req->page);
> +       kfree(req);
> +}
> +
> +static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
> +{
> +       /* We should never have inflight requests at this point */
> +       WARN_ON(!list_empty(&wb_ctl->inflight_reqs));
> +
> +       while (!list_empty(&wb_ctl->idle_reqs)) {
> +               struct zram_wb_req *req;
> +
> +               req =3D list_first_entry(&wb_ctl->idle_reqs,
> +                                      struct zram_wb_req, entry);
> +               list_del(&req->entry);
> +               release_wb_req(req);
> +       }
> +
> +       kfree(wb_ctl);
> +}
> +
> +/* XXX: should be a per-device sysfs attr */
> +#define ZRAM_WB_REQ_CNT 32
> +
> +static struct zram_wb_ctl *init_wb_ctl(void)
> +{
> +       struct zram_wb_ctl *wb_ctl;
> +       int i;
> +
> +       wb_ctl =3D kmalloc(sizeof(*wb_ctl), GFP_KERNEL);
> +       if (!wb_ctl)
> +               return NULL;
> +
> +       INIT_LIST_HEAD(&wb_ctl->idle_reqs);
> +       INIT_LIST_HEAD(&wb_ctl->inflight_reqs);
> +       atomic_set(&wb_ctl->num_inflight, 0);
> +       init_completion(&wb_ctl->done);
> +
> +       for (i =3D 0; i < ZRAM_WB_REQ_CNT; i++) {
> +               struct zram_wb_req *req;
> +
> +               /*
> +                * This is fatal condition only if we couldn't allocate
> +                * any requests at all.  Otherwise we just work with the
> +                * requests that we have successfully allocated, so that
> +                * writeback can still proceed, even if there is only one
> +                * request on the idle list.
> +                */
> +               req =3D kzalloc(sizeof(*req), GFP_KERNEL | __GFP_NOWARN);
> +               if (!req)
> +                       break;
> +
> +               req->page =3D alloc_page(GFP_KERNEL | __GFP_NOWARN);
> +               if (!req->page) {
> +                       kfree(req);
> +                       break;
> +               }
> +
> +               list_add(&req->entry, &wb_ctl->idle_reqs);
> +       }
> +
> +       /* We couldn't allocate any requests, so writeabck is not possibl=
e */
> +       if (list_empty(&wb_ctl->idle_reqs))
> +               goto release_wb_ctl;
> +
> +       return wb_ctl;
> +
> +release_wb_ctl:
> +       release_wb_ctl(wb_ctl);
> +       return NULL;
> +}
> +
> +static void zram_account_writeback_rollback(struct zram *zram)
>  {
> +       spin_lock(&zram->wb_limit_lock);
> +       if (zram->wb_limit_enable)
> +               zram->bd_wb_limit +=3D  1UL << (PAGE_SHIFT - 12);
> +       spin_unlock(&zram->wb_limit_lock);
> +}
> +
> +static void zram_account_writeback_submit(struct zram *zram)
> +{
> +       spin_lock(&zram->wb_limit_lock);
> +       if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> +               zram->bd_wb_limit -=3D  1UL << (PAGE_SHIFT - 12);
> +       spin_unlock(&zram->wb_limit_lock);
> +}
> +
> +static int zram_writeback_complete(struct zram *zram, struct zram_wb_req=
 *req)
> +{
> +       u32 index;
> +       int err;
> +
> +       index =3D req->pps->index;
> +       release_pp_slot(zram, req->pps);
> +       req->pps =3D NULL;
> +
> +       err =3D blk_status_to_errno(req->bio.bi_status);
> +       if (err) {
> +               /*
> +                * Failed wb requests should not be accounted in wb_limit
> +                * (if enabled).
> +                */
> +               zram_account_writeback_rollback(zram);
> +               return err;
> +       }
> +
> +       atomic64_inc(&zram->stats.bd_writes);
> +       zram_slot_lock(zram, index);
> +       /*
> +        * We release slot lock during writeback so slot can change under=
 us:
> +        * slot_free() or slot_free() and zram_write_page(). In both case=
s
> +        * slot loses ZRAM_PP_SLOT flag. No concurrent post-processing ca=
n
> +        * set ZRAM_PP_SLOT on such slots until current post-processing
> +        * finishes.
> +        */
> +       if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> +               goto out;
> +
> +       zram_free_page(zram, index);
> +       zram_set_flag(zram, index, ZRAM_WB);
> +       zram_set_handle(zram, index, req->blk_idx);
> +       atomic64_inc(&zram->stats.pages_stored);
> +
> +out:
> +       zram_slot_unlock(zram, index);
> +       return 0;
> +}
> +
> +static void zram_writeback_endio(struct bio *bio)
> +{
> +       struct zram_wb_ctl *wb_ctl =3D bio->bi_private;
> +
> +       if (atomic_dec_return(&wb_ctl->num_inflight) =3D=3D 0)
> +               complete(&wb_ctl->done);
> +}
> +
> +static void zram_submit_wb_request(struct zram *zram,
> +                                  struct zram_wb_ctl *wb_ctl,
> +                                  struct zram_wb_req *req)
> +{
> +       /*
> +        * wb_limit (if enabled) should be adjusted before submission,
> +        * so that we don't over-submit.
> +        */
> +       zram_account_writeback_submit(zram);
> +       atomic_inc(&wb_ctl->num_inflight);
> +       list_add_tail(&req->entry, &wb_ctl->inflight_reqs);
> +       submit_bio(&req->bio);
> +}
> +
> +static struct zram_wb_req *select_idle_req(struct zram_wb_ctl *wb_ctl)
> +{
> +       struct zram_wb_req *req;
> +
> +       req =3D list_first_entry_or_null(&wb_ctl->idle_reqs,
> +                                      struct zram_wb_req, entry);
> +       if (req)
> +               list_del(&req->entry);
> +       return req;
> +}
> +
> +static int zram_wb_wait_for_completion(struct zram *zram,
> +                                      struct zram_wb_ctl *wb_ctl)
> +{
> +       int ret =3D 0;
> +
> +       if (atomic_read(&wb_ctl->num_inflight))
> +               wait_for_completion_io(&wb_ctl->done);
> +
> +       reinit_completion(&wb_ctl->done);
> +       while (!list_empty(&wb_ctl->inflight_reqs)) {
> +               struct zram_wb_req *req;
> +               int err;
> +
> +               req =3D list_first_entry(&wb_ctl->inflight_reqs,
> +                                      struct zram_wb_req, entry);
> +               list_move(&req->entry, &wb_ctl->idle_reqs);
> +
> +               err =3D zram_writeback_complete(zram, req);
> +               if (err)
> +                       ret =3D err;
> +       }
> +
> +       return ret;
> +}
> +
> +static int zram_writeback_slots(struct zram *zram,
> +                               struct zram_pp_ctl *ctl,
> +                               struct zram_wb_ctl *wb_ctl)
> +{
> +       struct zram_wb_req *req =3D NULL;
>         unsigned long blk_idx =3D 0;
> -       struct page *page =3D NULL;
>         struct zram_pp_slot *pps;
> -       struct bio_vec bio_vec;
> -       struct bio bio;
> +       struct blk_plug io_plug;
>         int ret =3D 0, err;
> -       u32 index;
> -
> -       page =3D alloc_page(GFP_KERNEL);
> -       if (!page)
> -               return -ENOMEM;
> +       u32 index =3D 0;
>
> +       blk_start_plug(&io_plug);
>         while ((pps =3D select_pp_slot(ctl))) {
>                 spin_lock(&zram->wb_limit_lock);
>                 if (zram->wb_limit_enable && !zram->bd_wb_limit) {
> @@ -757,6 +962,26 @@ static int zram_writeback_slots(struct zram *zram, s=
truct zram_pp_ctl *ctl)
>                 }
>                 spin_unlock(&zram->wb_limit_lock);
>
> +               while (!req) {
> +                       req =3D select_idle_req(wb_ctl);
> +                       if (req)
> +                               break;
> +
> +                       blk_finish_plug(&io_plug);
> +                       err =3D zram_wb_wait_for_completion(zram, wb_ctl)=
;
> +                       blk_start_plug(&io_plug);
> +                       /*
> +                        * BIO errors are not fatal, we continue and simp=
ly
> +                        * attempt to writeback the remaining objects (pa=
ges).
> +                        * At the same time we need to signal user-space =
that
> +                        * some writes (at least one, but also could be a=
ll of
> +                        * them) were not successful and we do so by retu=
rning
> +                        * the most recent BIO error.
> +                        */
> +                       if (err)
> +                               ret =3D err;
> +               }
> +
>                 if (!blk_idx) {
>                         blk_idx =3D alloc_block_bdev(zram);
>                         if (!blk_idx) {
> @@ -765,7 +990,6 @@ static int zram_writeback_slots(struct zram *zram, st=
ruct zram_pp_ctl *ctl)
>                         }
>                 }
>
> -               index =3D pps->index;
>                 zram_slot_lock(zram, index);
>                 /*
>                  * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, =
so
> @@ -775,67 +999,46 @@ static int zram_writeback_slots(struct zram *zram, =
struct zram_pp_ctl *ctl)
>                  */
>                 if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
>                         goto next;
> -               if (zram_read_from_zspool(zram, page, index))
> +               if (zram_read_from_zspool(zram, req->page, index))
>                         goto next;
>                 zram_slot_unlock(zram, index);
>
> -               bio_init(&bio, zram->bdev, &bio_vec, 1,
> -                        REQ_OP_WRITE | REQ_SYNC);
> -               bio.bi_iter.bi_sector =3D blk_idx * (PAGE_SIZE >> 9);
> -               __bio_add_page(&bio, page, PAGE_SIZE, 0);
> -
>                 /*
> -                * XXX: A single page IO would be inefficient for write
> -                * but it would be not bad as starter.
> +                * From now on pp-slot is owned by the req, remove it fro=
m
> +                * its pp bucket.
>                  */
> -               err =3D submit_bio_wait(&bio);
> -               if (err) {
> -                       release_pp_slot(zram, pps);
> -                       /*
> -                        * BIO errors are not fatal, we continue and simp=
ly
> -                        * attempt to writeback the remaining objects (pa=
ges).
> -                        * At the same time we need to signal user-space =
that
> -                        * some writes (at least one, but also could be a=
ll of
> -                        * them) were not successful and we do so by retu=
rning
> -                        * the most recent BIO error.
> -                        */
> -                       ret =3D err;
> -                       continue;
> -               }
> +               list_del_init(&pps->entry);
>
> -               atomic64_inc(&zram->stats.bd_writes);
> -               zram_slot_lock(zram, index);
> -               /*
> -                * Same as above, we release slot lock during writeback s=
o
> -                * slot can change under us: slot_free() or slot_free() a=
nd
> -                * reallocation (zram_write_page()). In both cases slot l=
oses
> -                * ZRAM_PP_SLOT flag. No concurrent post-processing can s=
et
> -                * ZRAM_PP_SLOT on such slots until current post-processi=
ng
> -                * finishes.
> -                */
> -               if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> -                       goto next;
> +               req->blk_idx =3D blk_idx;
> +               req->pps =3D pps;
> +               bio_init(&req->bio, zram->bdev, &req->bio_vec, 1, REQ_OP_=
WRITE);
> +               req->bio.bi_iter.bi_sector =3D req->blk_idx * (PAGE_SIZE =
>> 9);
> +               req->bio.bi_end_io =3D zram_writeback_endio;
> +               req->bio.bi_private =3D wb_ctl;
> +               __bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);

Out of curiosity, why are we doing 1 page per bio? Why are we not
adding BIO_MAX_VECS before submitting? And then, why are we not
chaining? Do the block layer maintainers have thoughts?

>
> -               zram_free_page(zram, index);
> -               zram_set_flag(zram, index, ZRAM_WB);
> -               zram_set_handle(zram, index, blk_idx);
> +               zram_submit_wb_request(zram, wb_ctl, req);
>                 blk_idx =3D 0;
> -               atomic64_inc(&zram->stats.pages_stored);
> -               spin_lock(&zram->wb_limit_lock);
> -               if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> -                       zram->bd_wb_limit -=3D  1UL << (PAGE_SHIFT - 12);
> -               spin_unlock(&zram->wb_limit_lock);
> +               req =3D NULL;
> +               continue;
> +
>  next:
>                 zram_slot_unlock(zram, index);
>                 release_pp_slot(zram, pps);
> -
>                 cond_resched();
>         }
>
> -       if (blk_idx)
> -               free_block_bdev(zram, blk_idx);
> -       if (page)
> -               __free_page(page);
> +       /*
> +        * Selected idle req, but never submitted it due to some error or
> +        * wb limit.
> +        */
> +       if (req)
> +               release_wb_req(req);
> +
> +       blk_finish_plug(&io_plug);
> +       err =3D zram_wb_wait_for_completion(zram, wb_ctl);
> +       if (err)
> +               ret =3D err;
>
>         return ret;
>  }
> @@ -948,7 +1151,8 @@ static ssize_t writeback_store(struct device *dev,
>         struct zram *zram =3D dev_to_zram(dev);
>         u64 nr_pages =3D zram->disksize >> PAGE_SHIFT;
>         unsigned long lo =3D 0, hi =3D nr_pages;
> -       struct zram_pp_ctl *ctl =3D NULL;
> +       struct zram_pp_ctl *pp_ctl =3D NULL;
> +       struct zram_wb_ctl *wb_ctl =3D NULL;
>         char *args, *param, *val;
>         ssize_t ret =3D len;
>         int err, mode =3D 0;
> @@ -970,8 +1174,14 @@ static ssize_t writeback_store(struct device *dev,
>                 goto release_init_lock;
>         }
>
> -       ctl =3D init_pp_ctl();
> -       if (!ctl) {
> +       pp_ctl =3D init_pp_ctl();
> +       if (!pp_ctl) {
> +               ret =3D -ENOMEM;
> +               goto release_init_lock;
> +       }
> +
> +       wb_ctl =3D init_wb_ctl();
> +       if (!wb_ctl) {
>                 ret =3D -ENOMEM;
>                 goto release_init_lock;
>         }
> @@ -1000,7 +1210,7 @@ static ssize_t writeback_store(struct device *dev,
>                                 goto release_init_lock;
>                         }
>
> -                       scan_slots_for_writeback(zram, mode, lo, hi, ctl)=
;
> +                       scan_slots_for_writeback(zram, mode, lo, hi, pp_c=
tl);
>                         break;
>                 }
>
> @@ -1011,7 +1221,7 @@ static ssize_t writeback_store(struct device *dev,
>                                 goto release_init_lock;
>                         }
>
> -                       scan_slots_for_writeback(zram, mode, lo, hi, ctl)=
;
> +                       scan_slots_for_writeback(zram, mode, lo, hi, pp_c=
tl);
>                         break;
>                 }
>
> @@ -1022,7 +1232,7 @@ static ssize_t writeback_store(struct device *dev,
>                                 goto release_init_lock;
>                         }
>
> -                       scan_slots_for_writeback(zram, mode, lo, hi, ctl)=
;
> +                       scan_slots_for_writeback(zram, mode, lo, hi, pp_c=
tl);
>                         continue;
>                 }
>
> @@ -1033,17 +1243,18 @@ static ssize_t writeback_store(struct device *dev=
,
>                                 goto release_init_lock;
>                         }
>
> -                       scan_slots_for_writeback(zram, mode, lo, hi, ctl)=
;
> +                       scan_slots_for_writeback(zram, mode, lo, hi, pp_c=
tl);
>                         continue;
>                 }
>         }
>
> -       err =3D zram_writeback_slots(zram, ctl);
> +       err =3D zram_writeback_slots(zram, pp_ctl, wb_ctl);
>         if (err)
>                 ret =3D err;
>
>  release_init_lock:
> -       release_pp_ctl(zram, ctl);
> +       release_pp_ctl(zram, pp_ctl);
> +       release_wb_ctl(wb_ctl);
>         atomic_set(&zram->pp_in_progress, 0);
>         up_read(&zram->init_lock);
>
> --
> 2.52.0.rc1.455.g30608eb744-goog
>

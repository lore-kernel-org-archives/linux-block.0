Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67A5CA9EC2
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 06:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7870521835
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 06:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tk7jPNpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfJ2G2y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 02:28:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732549AbfJ2G2x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572330532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KwdGAtrRicWBOLInjwd2Q9HVCgyk9wqp1nvVaOrMoE=;
        b=Tk7jPNpLJC6mu6HuI7rptDEcRMvbdHJmyzKOiyqQoj2JJkWY9QyjyyDZBopsgLwUV5yUGm
        ePWKZfqQd5K8J36wKGMM5DtDwJpnPVu4l40B2QKxANzEOEu07JNYb0ydpUr1btlUKZnjtW
        2I6C1Nv0/iOdZ3qKlpaMFyot/MfQwmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-yQWYGCqMPv-BKVe5n7AH-g-1; Tue, 29 Oct 2019 02:28:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E569081A334;
        Tue, 29 Oct 2019 06:28:49 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0D2660863;
        Tue, 29 Oct 2019 06:28:44 +0000 (UTC)
Date:   Tue, 29 Oct 2019 14:28:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH] block: optimize for small BS IO
Message-ID: <20191029062839.GB20854@ming.t460p>
References: <20191029041904.16461-1-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191029041904.16461-1-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: yQWYGCqMPv-BKVe5n7AH-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 29, 2019 at 12:19:04PM +0800, Ming Lei wrote:
> __blk_queue_split() may be a bit heavy for small BS(such as 512B, or
> 4KB) IO, so introduce one flag to decide if this bio includes multiple
> page. And only consider to try splitting this bio in case that
> the multiple page flag is set.
>=20
> ~3% - 5% IOPS improvement can be observed on io_uring test over
> null_blk(MQ), and the io_uring test code is from fio/t/io_uring.c
>=20
> bch_bio_map() should be the only one which doesn't use bio_add_page(),
> so force to mark bio built via bch_bio_map() as MULTI_PAGE.
>=20
> RAID5 has similar usage too, however the bio is really single-page bio,
> so not necessary to handle it.
>=20
> Cc: Coly Li <colyli@suse.de>
> Cc: linux-bcache@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c               | 8 ++++++++
>  block/blk-merge.c         | 4 ++++
>  block/bounce.c            | 3 +++
>  drivers/md/bcache/util.c  | 2 ++
>  include/linux/blk_types.h | 1 +
>  5 files changed, 18 insertions(+)
>=20
> diff --git a/block/bio.c b/block/bio.c
> index 8f0ed6228fc5..c288364b7cf3 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -583,6 +583,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bi=
o_src)
>  =09bio_set_flag(bio, BIO_CLONED);
>  =09if (bio_flagged(bio_src, BIO_THROTTLED))
>  =09=09bio_set_flag(bio, BIO_THROTTLED);
> +=09if (bio_flagged(bio_src, BIO_MULTI_PAGE))
> +=09=09bio_set_flag(bio, BIO_MULTI_PAGE);
>  =09bio->bi_opf =3D bio_src->bi_opf;
>  =09bio->bi_ioprio =3D bio_src->bi_ioprio;
>  =09bio->bi_write_hint =3D bio_src->bi_write_hint;
> @@ -757,6 +759,9 @@ bool __bio_try_merge_page(struct bio *bio, struct pag=
e *page,
>  =09=09if (page_is_mergeable(bv, page, len, off, same_page)) {
>  =09=09=09bv->bv_len +=3D len;
>  =09=09=09bio->bi_iter.bi_size +=3D len;
> +
> +=09=09=09if (!*same_page)
> +=09=09=09=09bio_set_flag(bio, BIO_MULTI_PAGE);
>  =09=09=09return true;
>  =09=09}
>  =09}
> @@ -789,6 +794,9 @@ void __bio_add_page(struct bio *bio, struct page *pag=
e,
>  =09bio->bi_iter.bi_size +=3D len;
>  =09bio->bi_vcnt++;
> =20
> +=09if (bio->bi_vcnt >=3D 2 && !bio_flagged(bio, BIO_MULTI_PAGE))
> +=09=09bio_set_flag(bio, BIO_MULTI_PAGE);

We have users of adding multiple pages in single bio_add_page(),
will fix it in V2.


Thanks,
Ming


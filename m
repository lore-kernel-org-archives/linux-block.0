Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DE8C433EF
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 06:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiGGGEO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 02:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiGGGEN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 02:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3223D224
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 23:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657173848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/OP3Pj9LZdFQ5QDe4ZN9uOwmX5clhUf6UjpkPNgezI=;
        b=e6jHvY9iLgIVeGKQpX1iyWXfmHPShFbMDNYpuajkxZayMRSjmKgjpGJvGMYqzpAzewQsjN
        5DnrHKWqgLEImQc2pqA+iAEdje0XxJla/HV/IulDmjV087RZAced/VW1OE2KClTxQjXk4i
        b7akR7RcaTtWF65lrBTxDEyMK7BMXKw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-TazVYuymNlSMEKOPXWUJqQ-1; Thu, 07 Jul 2022 02:04:06 -0400
X-MC-Unique: TazVYuymNlSMEKOPXWUJqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 83-20020a1c0256000000b003a2d01897e4so26933wmc.9
        for <linux-block@vger.kernel.org>; Wed, 06 Jul 2022 23:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/OP3Pj9LZdFQ5QDe4ZN9uOwmX5clhUf6UjpkPNgezI=;
        b=RorE1nBlTFnt5QLPbC5jIih/0ds71Wq4zxwHCcUUvWSuvqMIBkFwrBZpD/Kv9bgiJ+
         e403ZYFmcEd4gJFGTm9Y+BAhB0LNtHAI7koHtMt+hPhQdgviEqz3R/Z8VDF9v/H0ZYtx
         WmvCToHToX/0F9Xbjosd5Pb9i0QVqztRzw1JDQZTcYS4KkeULOacP/6SSArBJnW+y415
         ikOc8pMR3OHz2q0/xNpY0ieVzR7T0MKENges33+HKh5KcCCwCKngQAGtko4ItE1w6pcb
         xWorwZxKRQ/a5N8TTwlpvQKqpffJwo9kAwbdfkkha9AKonmgAFq2oSV+g+YlmwAVmzrw
         VbRw==
X-Gm-Message-State: AJIora/Qlkv1uuC77Ef5LGutfMXxLEGPaVtc47WSNMnVpHIZoYfPmjXb
        Zifkv/0m0+vcvS2TN3uZf41QQKjGaW+AYiUC5b6M5Kzq0ihlhi9mBbWWjEpwaBGuqPuNOzSbqk2
        JX25dXmc+VGDrbaIHWaTNYkf+dvcU/wMLyCSdxZg=
X-Received: by 2002:a5d:638e:0:b0:21d:68bc:17c8 with SMTP id p14-20020a5d638e000000b0021d68bc17c8mr20374874wru.467.1657173845696;
        Wed, 06 Jul 2022 23:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uI6+5jPZ+RaRadhuxeJ5qXORaimlIYcRXUVbcw2WKGVlZwigpLzdfVb5M+sCCw0/R36UYdokWJxcCmixLJXfw=
X-Received: by 2002:a5d:638e:0:b0:21d:68bc:17c8 with SMTP id
 p14-20020a5d638e000000b0021d68bc17c8mr20374847wru.467.1657173845430; Wed, 06
 Jul 2022 23:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220629233145.2779494-1-bvanassche@acm.org> <20220629233145.2779494-54-bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-54-bvanassche@acm.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 7 Jul 2022 08:03:54 +0200
Message-ID: <CAHc6FU6PcB7Ek0ZqDib-dPL-eiXy1tFXjeBFxqa8KejLH8XPuw@mail.gmail.com>
Subject: Re: [PATCH v2 53/63] fs/gfs2: Use the enum req_op and blk_opf_t types
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 30, 2022 at 1:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags. Combine the first two
> gfs2_submit_bhs() arguments into a single argument.
>
> Cc: Bob Peterson <rpeterso@redhat.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/gfs2/log.c     | 4 ++--
>  fs/gfs2/log.h     | 2 +-
>  fs/gfs2/lops.c    | 4 ++--
>  fs/gfs2/lops.h    | 2 +-
>  fs/gfs2/meta_io.c | 9 ++++-----
>  5 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index f0ee3ff6f9a8..eec4159b08aa 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -823,7 +823,7 @@ void gfs2_flush_revokes(struct gfs2_sbd *sdp)
>
>  void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
>                            u64 seq, u32 tail, u32 lblock, u32 flags,
> -                          int op_flags)
> +                          blk_opf_t op_flags)
>  {
>         struct gfs2_log_header *lh;
>         u32 hash, crc;
> @@ -905,7 +905,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
>
>  static void log_write_header(struct gfs2_sbd *sdp, u32 flags)
>  {
> -       int op_flags = REQ_PREFLUSH | REQ_FUA | REQ_META | REQ_SYNC;
> +       blk_opf_t op_flags = REQ_PREFLUSH | REQ_FUA | REQ_META | REQ_SYNC;
>         enum gfs2_freeze_state state = atomic_read(&sdp->sd_freeze_state);
>
>         gfs2_assert_withdraw(sdp, (state != SFS_FROZEN));
> diff --git a/fs/gfs2/log.h b/fs/gfs2/log.h
> index fc905c2af53c..653cffcbf869 100644
> --- a/fs/gfs2/log.h
> +++ b/fs/gfs2/log.h
> @@ -82,7 +82,7 @@ extern void gfs2_log_reserve(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
>                              unsigned int *extra_revokes);
>  extern void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
>                                   u64 seq, u32 tail, u32 lblock, u32 flags,
> -                                 int op_flags);
> +                                 blk_opf_t op_flags);
>  extern void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl,
>                            u32 type);
>  extern void gfs2_log_commit(struct gfs2_sbd *sdp, struct gfs2_trans *trans);
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 6ba51cbb94cf..90a2d7bc91c4 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -238,7 +238,7 @@ static void gfs2_end_log_write(struct bio *bio)
>   * there is no pending bio, then this is a no-op.
>   */
>
> -void gfs2_log_submit_bio(struct bio **biop, int opf)
> +void gfs2_log_submit_bio(struct bio **biop, blk_opf_t opf)
>  {
>         struct bio *bio = *biop;
>         if (bio) {
> @@ -292,7 +292,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
>   */
>
>  static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
> -                                   struct bio **biop, int op,
> +                                   struct bio **biop, enum req_op op,
>                                     bio_end_io_t *end_io, bool flush)
>  {
>         struct bio *bio = *biop;
> diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
> index f707601597dc..1412ffba1d44 100644
> --- a/fs/gfs2/lops.h
> +++ b/fs/gfs2/lops.h
> @@ -16,7 +16,7 @@ extern u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int lbn);
>  extern void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
>                            struct page *page, unsigned size, unsigned offset,
>                            u64 blkno);
> -extern void gfs2_log_submit_bio(struct bio **biop, int opf);
> +extern void gfs2_log_submit_bio(struct bio **biop, blk_opf_t opf);
>  extern void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
>  extern int gfs2_find_jhead(struct gfs2_jdesc *jd,
>                            struct gfs2_log_header_host *head, bool keep_cache);
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 3570739f005d..7e70e0ba5a6c 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -34,7 +34,7 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
>  {
>         struct buffer_head *bh, *head;
>         int nr_underway = 0;
> -       int write_flags = REQ_META | REQ_PRIO | wbc_to_write_flags(wbc);
> +       blk_opf_t write_flags = REQ_META | REQ_PRIO | wbc_to_write_flags(wbc);
>
>         BUG_ON(!PageLocked(page));
>         BUG_ON(!page_has_buffers(page));
> @@ -217,14 +217,13 @@ static void gfs2_meta_read_endio(struct bio *bio)
>   * Submit several consecutive buffer head I/O requests as a single bio I/O
>   * request.  (See submit_bh_wbc.)
>   */
> -static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
> -                           int num)
> +static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
>  {
>         while (num > 0) {
>                 struct buffer_head *bh = *bhs;
>                 struct bio *bio;
>
> -               bio = bio_alloc(bh->b_bdev, num, op | op_flags, GFP_NOIO);
> +               bio = bio_alloc(bh->b_bdev, num, opf, GFP_NOIO);
>                 bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
>                 while (num > 0) {
>                         bh = *bhs;
> @@ -288,7 +287,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
>                 }
>         }
>
> -       gfs2_submit_bhs(REQ_OP_READ, REQ_META | REQ_PRIO, bhs, num);
> +       gfs2_submit_bhs(REQ_OP_READ | REQ_META | REQ_PRIO, bhs, num);
>         if (!(flags & DIO_WAIT))
>                 return 0;
>

Looking good from a gfs2 point of view, thanks.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Andreas


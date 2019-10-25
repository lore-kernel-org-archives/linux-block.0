Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C1CA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 23:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA9206E0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 23:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxrij5bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfJYXzZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:55:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36251 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJYXzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 19:55:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so3378696qkc.3
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 16:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+sZ1F3qGiUlTqXhXgyjKXUBJnT5mWaWvRs5952iX9s=;
        b=gxrij5bTOcTRFo3vUaptmK7ujwjAlAiq+3M1xLJ523lk2QCYC+5+3/HtqzQHfV/nDy
         EtSOlVXQJkBjHMOf6eDGSlUtd2j3c0efb1B0V/R2qtjnFEqFhnODgCEBYrgoDZggqrhY
         QWcCw1oDqBH210MH/0vtPEdmM84FSa9nzED1l27isxrjzZBfiuxxNjaMExa5O5bKsrHx
         Av1vRFbhr6WIWOrYxa5fqSV6MIaxPU/Yi3ml+QeygAe8LvkWllaqDr2gAv5GXN+lNHHr
         z+CBoEWP38hLvuNGz7RWSfrY8+ZPl0B1L66VYdyzFRr+c2PENJwiDB9uoOGClWblmWml
         SLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+sZ1F3qGiUlTqXhXgyjKXUBJnT5mWaWvRs5952iX9s=;
        b=f/aAweta/2YvjN/tXg2sm+301KwmETWY3BaEzIIRiJ+bLlZySU0kZ4C4KZdjKs3Xqx
         U67lsOMP5eiTCa+twzDwB2KwU8ouUwzGHVR+qiXUy2210puOiomgP1spuQD47cd5jQVh
         dEx28VzGQ20+zrIgSX9XRNjnMeDVG8K20FxNGlIv6DTAtbYkyCD/tf6iOzHK4HaR/mC8
         AXCHJ+eBSK1wlLRXm+XCaUe1gnnCeM8i1wMsWMPT/l3eeN8aVUyg/TL3qHgLJQo7eIij
         zLI8JnZ8sJWd0OmROlKxim7fcxmaAuv2Wqs1f89XXewQJFGeIZuXolQnB0cuWNgU6Lrt
         5VcQ==
X-Gm-Message-State: APjAAAWRq2wEunMboeGl7OyeVv6QADKZyW6Nzqu3y7oVklDxUBP7RH+Q
        klUv1tnS8WoV0LgdR4t9R6arIhGS+XaGIEYZx9krG5YEWL0=
X-Google-Smtp-Source: APXvYqyHtBIyY1mEBqFuvCucx2d7JBf8UIOatLGdLcReOpWuPRyJGj1A8xlgWnV70Wnh3q3eNHRhp/ecPR6+G/Z8xhQ=
X-Received: by 2002:a37:b07:: with SMTP id 7mr5194790qkl.240.1572047723557;
 Fri, 25 Oct 2019 16:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <59f5cab7-4bc4-84cb-b9b0-48f2743eafef@kernel.dk>
In-Reply-To: <59f5cab7-4bc4-84cb-b9b0-48f2743eafef@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 26 Oct 2019 01:54:57 +0200
Message-ID: <CAG48ez38KjVn6y2fW-mDNGkJDOMw47cRpkKv25TkHgEvgdaNqw@mail.gmail.com>
Subject: Re: [PATCH] io_uring: support for larger fixed file sets
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 26, 2019 at 12:22 AM Jens Axboe <axboe@kernel.dk> wrote:
> There's been a few requests for supporting more fixed files than 1024.
> This isn't really tricky to do, we just need to split up the file table
> into multiple tables and index appropriately.
>
> This patch adds support for up to 64K files, which should be enough for
> everyone.

What's the reason against vmalloc()? Performance of table reallocation?

> +static inline struct file *io_file_from_index(struct io_ring_ctx *ctx,
> +                                             int index)
> +{
> +       struct fixed_file_table *table;
> +
> +       table = &ctx->file_table[index >> IORING_FILE_TABLE_SHIFT];
> +       return table->files[index & IORING_FILE_TABLE_MASK];
> +}
[...]
> @@ -2317,12 +2334,15 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
>                 return 0;
>
>         if (flags & IOSQE_FIXED_FILE) {
> -               if (unlikely(!ctx->user_files ||
> +               struct file *file;
> +
> +               if (unlikely(!ctx->file_table ||
>                     (unsigned) fd >= ctx->nr_user_files))
>                         return -EBADF;

Not a problem with this patch, but: By the way, the array lookup after
this is a "array index using bounds-checked index" pattern, so
array_index_nospec() might be appropriate here. See __fcheck_files()
for comparison.

> -               if (!ctx->user_files[fd])
> +               file = io_file_from_index(ctx, fd);
> +               if (!file)
>                         return -EBADF;
> -               req->file = ctx->user_files[fd];
> +               req->file = file;
>                 req->flags |= REQ_F_FIXED_FILE;
>         } else {
>                 if (s->needs_fixed_file)
[...]
> +static int io_sqe_alloc_file_tables(struct io_ring_ctx *ctx, unsigned nr_tables,
> +                                   unsigned nr_files)
> +{
> +       int i;
> +
> +       for (i = 0; i < nr_tables; i++) {
> +               struct fixed_file_table *table = &ctx->file_table[i];
> +               unsigned this_files;
> +
> +               this_files = nr_files;
> +               if (this_files > IORING_MAX_FILES_TABLE)
> +                       this_files = IORING_MAX_FILES_TABLE;

nr_files and this_files stay the same throughout the loop. I suspect
that the intent here was something like:

this_files = min_t(unsigned, nr_files, IORING_MAX_FILES_TABLE);
nr_files -= this_files;

> +
> +               table->files = kcalloc(this_files, sizeof(struct file *),
> +                                       GFP_KERNEL);
> +               if (!table->files)
> +                       break;
> +       }
> +
> +       if (i == nr_tables)
> +               return 0;
> +
> +       for (i = 0; i < nr_tables; i++) {
> +               struct fixed_file_table *table = &ctx->file_table[i];
> +               kfree(table->files);
> +       }
> +       return 1;
> +}

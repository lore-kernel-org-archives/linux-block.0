Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A25CA9ECB
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 05:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB0F2082C
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 05:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZwxzmm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404110AbfJRFhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:37:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42325 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395210AbfJRFhH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 01:37:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so4188865oif.9
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2019 22:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZfQ3YcR54EbpttrnQUrtNXWUUftHFVFQjHIRQYfMjw=;
        b=CZwxzmm29wlEIKR/7b2q8DbocmeFVU0EUjx7L5M5j5Ll7zEx8p+Z3AbxsipxjN0Ukv
         hzKH58FkBft4vf+MiYKSBVznDszWlYkTxyKh7nmcni2y+UxghB11x6FCOaGUE2LdJCKm
         Wk0koikhjDT8JPXEX7vC0b5LrA+rhZEqtRWQRpQoLygbu99wOpUP08guBJQZXF+up/dL
         VoGj8kYtSflPCt5JbHrVgF1g6y+C5LbbT5kpL9AiAVu9H7HhFVOaKTP6afsOo7ioTQMv
         qZAkNVwO65jyHnjVym/i/bMBGx/nB8QLPZJyo3cWZaHbdrwcEqhBP/60nuJH7eJ/cNlQ
         mm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZfQ3YcR54EbpttrnQUrtNXWUUftHFVFQjHIRQYfMjw=;
        b=A9XSL2aU0dq4Tkh1XoIrvdgoWdjHC8X1rphdG26lQe83X7Gtg0f6p1BQOM/0GlGggs
         PjHejI+QNhfEJ6l5xAXAkdmAjuuTZHeKxtuJK0HPevUij+OuV/j6/OcTKoj/TxyY2wJ7
         0KYiYsxovDsgsYb9uGb5FLhbWbXOl3nNAfINtbLb2Qxc1Zl2HF4wnr1Rv7HPT4aFUrHO
         M/Ipb09NPGbo/iF6l4wPjjQ0Mcst7U+x1+esWH57GPnfhsWrqt6XBiM+8+gHdm1bvJVB
         jQX62nd91d79eX/YQ4MDeBPqX7rhKaam0ZotTne5jqsT362JCEPB0c0kURcnnn3CkaqZ
         gTOg==
X-Gm-Message-State: APjAAAUEWIgM3i1VzVdgvoUgPPTD1fIN0YBFEPUp2CqLpDMLeOSOF8zG
        152GCT20Ytvxtq4VCsSp7riaAvlgOGxuDUPF9+hZDGi53jgj9g==
X-Google-Smtp-Source: APXvYqzWeSTVVWr5DlCgqsMN+TRetKV+8M8BdxIvQZEvTo07uvNK7CrlnKXFvsQaG0ikNcs7MBggK6EgScwD/RYsv7Y=
X-Received: by 2002:aca:aac5:: with SMTP id t188mr6056901oie.39.1571366510570;
 Thu, 17 Oct 2019 19:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191017212858.13230-1-axboe@kernel.dk> <20191017212858.13230-2-axboe@kernel.dk>
In-Reply-To: <20191017212858.13230-2-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Oct 2019 04:41:22 +0200
Message-ID: <CAG48ez0G2y0JS9=S2KmePO3xq-5DuzgovrLFiX4TJL-G897LCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] io_uring: add support for async work inheriting files table
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 18, 2019 at 4:01 AM Jens Axboe <axboe@kernel.dk> wrote:
> This is in preparation for adding opcodes that need to modify files
> in a process file table, either adding new ones or closing old ones.

Closing old ones would be tricky. Basically if you call
get_files_struct() while you're between an fdget()/fdput() pair (e.g.
from sys_io_uring_enter()), you're not allowed to use that
files_struct reference to replace or close existing FDs through that
reference. (Or more accurately, if you go through fdget() with
files_struct refcount 1, you must not replace/close FDs in there in
any way until you've passed the corresponding fdput().)

You can avoid that if you ensure that you never use fdget()/fdput() in
the relevant places, only fget()/fput().

> If an opcode needs this, it must set REQ_F_NEED_FILES in the request
> structure. If work that needs to get punted to async context have this
> set, they will grab a reference to the process file table. When the
> work is completed, the reference is dropped again.
[...]
> @@ -2220,6 +2223,10 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>                                 set_fs(USER_DS);
>                         }
>                 }
> +               if (s->files && !old_files) {
> +                       old_files = current->files;
> +                       current->files = s->files;
> +               }

AFAIK e.g. stuff like proc_fd_link() in procfs can concurrently call
get_files_struct() even on kernel tasks, so you should take the
task_lock(current) while fiddling with the ->files pointer.

Also, maybe I'm too tired to read this correctly, but it seems like
when io_sq_wq_submit_work() is processing multiple elements with
->files pointers, this part will only consume a reference to the first
one?

>
>                 if (!ret) {
>                         s->has_user = cur_mm != NULL;
> @@ -2312,6 +2319,11 @@ static void io_sq_wq_submit_work(struct work_struct *work)
>                 unuse_mm(cur_mm);
>                 mmput(cur_mm);
>         }
> +       if (old_files) {
> +               struct files_struct *files = current->files;
> +               current->files = old_files;
> +               put_files_struct(files);
> +       }

And then here the first files_struct reference is dropped, and the
rest of them leak?

>  }
>
>  /*
> @@ -2413,6 +2425,8 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>
>                         s->sqe = sqe_copy;
>                         memcpy(&req->submit, s, sizeof(*s));
> +                       if (req->flags & REQ_F_NEED_FILES)
> +                               req->submit.files = get_files_struct(current);

Stupid question: How does this interact with sqpoll mode? In that
case, this function is running on a kernel thread that isn't sharing
the application's files_struct, right?

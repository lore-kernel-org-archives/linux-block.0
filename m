Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4FFC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 10:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74C620873
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 10:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfAPKx6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:53:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35615 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfAPKx6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 05:53:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so6654980qtc.2;
        Wed, 16 Jan 2019 02:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJaEjUbOZXcVecPHteV4A4vefoZrtlQEjwI/Xiw1/ik=;
        b=E+DhvYFgVygxHS2YPcXJ+gWgm9MKjVWJWX9l6jYsUc1CX+3rc/D0ZZwujN9bRqW6qU
         Ynb2KIb5v6iHzVvtFECEwbUusYLAF5ex2R9AG/oXl2t3mKj4YuNeejLtOKP4d3RsfVdT
         H3zdC+iKFTxLWJ9yyBwmlt4+BspXOLV8umq8q0Gxt2Xz3K7e6xgyKtyO6k2uDo3/HlcM
         u/8HJmdT01Jz9N3K2i3876zR6XtYe12LXdrOckjF68ZaXaOALRwd87rbSRin3Dpc1gPe
         KodxxU/58IY7Ux1Zj+ECetj05CKgQO/DzN027I/3LrAiYytgyw6CkWSIWMYCq1CRQZkQ
         HZqA==
X-Gm-Message-State: AJcUukd1kzlRXnu5/0JByjeGV8rpKLUMhkWArah/XAgWu4kSrlHZ/5r2
        zl7H2+ejN+xRGO+71d2msnzs/g9qVYE5IQ7zh50=
X-Google-Smtp-Source: ALg8bN4tbrXveJXaeR78at/otSbDAyS2P4kI3x50h+I51piiAt4FNxCxsdrD9yy3QD9D4P83HnrpTlkn/NPIoi+I3jY=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr6363749qvm.149.1547636036997;
 Wed, 16 Jan 2019 02:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-14-axboe@kernel.dk>
In-Reply-To: <20190115025531.13985-14-axboe@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 11:53:40 +0100
Message-ID: <CAK8P3a3aTZ-VEc=uvOeYov4DiaBN1iNuhR41BfP0Qdf3AXx74w@mail.gmail.com>
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO buffers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 542757a4c898..e36c264d74e8 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
>                                 struct io_uring_params __user *p);
>  asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
>                                 u32 min_complete, u32 flags);
> +asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
> +                               void __user *arg);
>

Would it be possible to make this a typed pointer instead? If this needs to
be extended later to pass a different structure, a new system call may
be better for consistency than overloading the argument in various
ways.

> + * io_uring_register(2) opcodes and arguments
> + */
> +#define IORING_REGISTER_BUFFERS                0
> +#define IORING_UNREGISTER_BUFFERS      1
> +
> +struct io_uring_register_buffers {
> +       union {
> +               struct iovec *iovecs;
> +               __u64 pad;
> +       };
> +       __u32 nr_iovecs;
> +};

As before, I'd suggest making this structure compatible between 32-bit
and 64-bit architectectures, by avoiding pointer and implied padding
fields.

      Arnd

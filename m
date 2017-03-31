Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34662 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdCaIVn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2017 04:21:43 -0400
MIME-Version: 1.0
In-Reply-To: <1490881776-28735-2-git-send-email-dmonakhov@openvz.org>
References: <1490881776-28735-1-git-send-email-dmonakhov@openvz.org> <1490881776-28735-2-git-send-email-dmonakhov@openvz.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 31 Mar 2017 16:21:40 +0800
Message-ID: <CACVXFVPNpZgo4-Hjbg0_BN2Xby-P4R_zcWTR_MDN_v+8TGM3sw@mail.gmail.com>
Subject: Re: [PATCH 1/8] Guard bvec iteration logic
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 30, 2017 at 9:49 PM, Dmitry Monakhov <dmonakhov@openvz.org> wrote:
> If some one try to attempt advance bvec beyond it's size we simply
> dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
> This simply means that we endup dereferencing/corrupting random memory
> region.
>
> Code was added long time ago here 4550dd6c, luckily no one hit it
> in real life :)
>
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  include/linux/bvec.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 89b65b8..86b914f 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -70,8 +70,7 @@ static inline void bvec_iter_advance(const struct bio_vec *bv,
>                                      struct bvec_iter *iter,
>                                      unsigned bytes)
>  {
> -       WARN_ONCE(bytes > iter->bi_size,
> -                 "Attempted to advance past end of bvec iter\n");
> +       BUG_ON(bytes > iter->bi_size);

This may not a good idea, especially Linus did not like BUG_ON(), please see the
following link:

https://lkml.org/lkml/2016/10/4/1



Thanks,
Ming Lei

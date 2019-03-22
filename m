Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C7AC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 16:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93E1218FC
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 16:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGqrfmWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCVQdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:33:13 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37492 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCVQdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 12:33:12 -0400
Received: by mail-it1-f193.google.com with SMTP id z124so4235378itc.2;
        Fri, 22 Mar 2019 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFdh5su4BD4vPggq8QdolC54ZdktUMxSqZocHhZqF9A=;
        b=sGqrfmWmQyF5KNClIkWxbumhmE4nXo8YEbmHn9le4vfkhpmCu/gaZ4Z9yO5KQ4NJlF
         t9KhdgfwDsh5pouXJdaPaoXpOw4dNKnEEgDQNfuusRGN+CqvctfzWNCmRKRrJ++7EZZa
         YfjVC1nK3ICGeKr4wcWAM033O4qGGw2zaQ4YmKzyt8i6MGhJ/MKlZLhsN0WGGH74wrLO
         qbf5Ft55vUHdqdbP++u9ZwA8QSey8wWR9GzFef7NjxRBxXqZLkyd5TLlMz+Cs+caXU5Q
         XOtE9PyxZsdbxmphhb23DC4+tfegZ6OhPoW/lDOgss5kDs7XG0qTH7tH9F59PyVLlhlN
         WJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFdh5su4BD4vPggq8QdolC54ZdktUMxSqZocHhZqF9A=;
        b=EBnIHmlXCc/YntYpuRWD0jTBRt8AkMqVID3Lz7L6lR6ONIOs1OxupWUf0S9p4ZggKK
         7hxLHmtHJjKUggAU4J1ti2iB9ZDmZZssGCowTrNhfDAl7IrUKB0avDPGEnu4YSCLGAk0
         pz+GWFoRlCdOY0eWuVp/uI4p5gY90FCO0TSoFlIeiQ6eUuxqaWzSBWqkw96Mz2R2I7d+
         ZVmKV03VR0QnECG6uvzi42LWQf7CuJOQ4uRe7px6ojyN4fqrueZFCO8PCH7hgxgncfOk
         7SZI3JI0B0vZn+t99USrvweVwAST7zVz+q2V+FH7vpPBY7aOcLLmGn+H25aSiQiWBNKY
         PMcQ==
X-Gm-Message-State: APjAAAXkdYxpTsYC7Hm92WgDhHAFfiGVS/GyoR44ItUJNCTZfBvyH4dq
        H2FBnM5uEYhmicQqwceCnI9+cHIzm2VC4M9PU2mKOKAN
X-Google-Smtp-Source: APXvYqy9RAYEpkJbfVm1kNZL+ObumBJkNzFxbB8+/0XhaOArpR4nqrU2CRUXg2r0rFd/rjIqs1PKjx0lRRcYu4cOqak=
X-Received: by 2002:a02:3b6f:: with SMTP id i47mr7841684jaf.39.1553272391734;
 Fri, 22 Mar 2019 09:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143643.1317312-1-arnd@arndb.de>
In-Reply-To: <20190322143643.1317312-1-arnd@arndb.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 22 Mar 2019 17:34:26 +0100
Message-ID: <CAOi1vP9scH+DECa1udToEvtYMRTZ1-VMuVajAh8uwpxzuMq0RA@mail.gmail.com>
Subject: Re: [PATCH] rbd: avoid clang -Wuninitialized warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Dillaman <dillaman@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 3:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang fails to see that rbd_assert(0) ends in an unreachable code
> path and warns about a subsequent use of an uninitialized variable
> when CONFIG_PROFILE_ANNOTATED_BRANCHES is set:
>
> drivers/block/rbd.c:2402:4: error: variable 'ret' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>                         rbd_assert(0);
>                         ^~~~~~~~~~~~~
> drivers/block/rbd.c:563:7: note: expanded from macro 'rbd_assert'
>                 if (unlikely(!(expr))) {                                \
>                     ^~~~~~~~~~~~~~~~~
> include/linux/compiler.h:48:23: note: expanded from macro 'unlikely'
>  #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/block/rbd.c:2410:6: note: uninitialized use occurs here
>         if (ret) {
>             ^~~
> drivers/block/rbd.c:2402:4: note: remove the 'if' if its condition is always true
>                         rbd_assert(0);
>                         ^
> drivers/block/rbd.c:563:3: note: expanded from macro 'rbd_assert'
>                 if (unlikely(!(expr))) {                                \
>                 ^
> drivers/block/rbd.c:2376:9: note: initialize the variable 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> 1 error generated.
>
> This seems to be a bug in clang, but is easy to work around by using
> an unconditional BUG().
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4ba967d65cf9..cbcc3baf3807 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2399,7 +2399,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
>                                                       &obj_req->bvec_pos);
>                         break;
>                 default:
> -                       rbd_assert(0);
> +                       BUG();
>                 }
>         } else {
>                 ret = rbd_img_fill_from_bvecs(child_img_req,

Hi Arnd,

You did a couple of these last year in commit c6244b3b2377 ("rbd: avoid
Wreturn-type warnings").  Let's change all of those default cases to BUG
in one go.  Do you want to do that or should I?

Thanks,

                Ilya

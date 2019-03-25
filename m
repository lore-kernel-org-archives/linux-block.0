Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7FC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DBC2063F
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdhsIEq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfCYLKw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:10:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43001 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfCYLKw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:10:52 -0400
Received: by mail-io1-f68.google.com with SMTP id c4so7216470ioh.9;
        Mon, 25 Mar 2019 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdcK+7ybdBXm2Dc31iQ691Y34fxFAlh93ocycClmkGc=;
        b=LdhsIEq/+pLXic7tWDG/kbcGhSKSQtZq+sJrbU6JQ6sCvcD4h8YNpXyCxz/7BAdfFb
         Fmxg1Zc4HAH4bW0T+iGx5sa8JJoiY30DnMEGB8+DJeynA7mrUGyHm9GnBU4Tl8MdYtqc
         HnAszlg4XJMYuCqcWleUA8RrOVREIXLPT/Uq9hKR/l5Bu9WUr41CGdoLDzbxZDEgL3L5
         BpL2jTH/EyGP5hD2lOYtW/NY2hMNzCNBfkIsgFnqm68F1z6pcIZmNXcEOKD1Y04QUyrD
         ufUXvz79o7QUzENr4CWTWYFS+U0LdsPShQR+yYX19H70GsHnKUO2qAC3tr+7scGx02I5
         +ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdcK+7ybdBXm2Dc31iQ691Y34fxFAlh93ocycClmkGc=;
        b=O7EuNUQH/NQIxX32NJs5SQdfWDRqRyAx14detu2ICY6ZIBJ62xyFBRdr/LLTgZ/CbC
         AFZ1L7S0UDNCQG4GBdytd02W3g2kD7zF8Kt8b9hQ3u8omh64izaYYi8FAOr7ST0g25+h
         roquXu3xwKQROnu4n7CYloOvGOHV86WFe4rcw15a5x/RrZyEUmWss3SGiVXPulua6O4B
         faqSgCwB+YUkZwrTETaiiOJ+D8Hssg5txFU/+eO5ioD/uWF2zynqbIBZGZKva3/NJbDp
         2AOwJrHPUqAiWnIwReuHNg1mVo2qlFsUKoueYk1oJcuEB5dEmyKMDosjBEnBXQ/3Tb9R
         iuIA==
X-Gm-Message-State: APjAAAUD0x1qv9rHFI7MOH+zjB0tJl3vlVYW/os5rGiXaYNUHUQWdxO/
        TA5lMF9EaeZQ9DTGV7eXmpLbrD3xzYX8T6V1jDI=
X-Google-Smtp-Source: APXvYqwjphE6fhNhzNGJstt12luS7nAsbuJSDJOEsOxutQTiWuETkw9bQBib0LDC+/F4nojXp53NLUCK/AULX91J0Z4=
X-Received: by 2002:a6b:7112:: with SMTP id q18mr16294600iog.5.1553512251655;
 Mon, 25 Mar 2019 04:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190322165404.2859356-1-arnd@arndb.de>
In-Reply-To: <20190322165404.2859356-1-arnd@arndb.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 25 Mar 2019 12:12:09 +0100
Message-ID: <CAOi1vP_KXQd5=YCGvO4m-WbnPDdpeBS5gTVKkdkBZvR=N-d7fg@mail.gmail.com>
Subject: Re: [PATCH] rdb: convert all rbd_assert(0) to BUG()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jason Dillaman <dillaman@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 5:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> rbd_assert(0) has caused different issues depending on
> the compiler version in the past, so it seems better to avoid it
> completely.
>
> Replace the remaining instances.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/rbd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index cbcc3baf3807..564c5069cc78 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1342,7 +1342,7 @@ static void rbd_obj_zero_range(struct rbd_obj_request *obj_req, u32 off,
>                 zero_bvecs(&obj_req->bvec_pos, off, bytes);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>  }
>
> @@ -1597,7 +1597,7 @@ static void rbd_obj_request_destroy(struct kref *kref)
>                 kfree(obj_request->bvec_pos.bvecs);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>
>         kfree(obj_request->img_extents);
> @@ -1797,7 +1797,7 @@ static void rbd_osd_req_setup_data(struct rbd_obj_request *obj_req, u32 which)
>                                                     &obj_req->bvec_pos);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>  }
>
> @@ -2052,7 +2052,7 @@ static int __rbd_img_fill_request(struct rbd_img_request *img_req)
>                         ret = rbd_obj_setup_zeroout(obj_req);
>                         break;
>                 default:
> -                       rbd_assert(0);
> +                       BUG();
>                 }
>                 if (ret < 0)
>                         return ret;
> @@ -2531,7 +2531,7 @@ static int rbd_obj_issue_copyup_ops(struct rbd_obj_request *obj_req, u32 bytes)
>                 num_osd_ops += count_zeroout_ops(obj_req);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>
>         obj_req->osd_req = rbd_osd_req_create(obj_req, num_osd_ops);
> @@ -2558,7 +2558,7 @@ static int rbd_obj_issue_copyup_ops(struct rbd_obj_request *obj_req, u32 bytes)
>                 __rbd_obj_setup_zeroout(obj_req, which);
>                 break;
>         default:
> -               rbd_assert(0);
> +               BUG();
>         }
>
>         ret = ceph_osdc_alloc_messages(obj_req->osd_req, GFP_NOIO);

Applied.

Thanks,

                Ilya

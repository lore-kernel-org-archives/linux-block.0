Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34322 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0LnK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Aug 2018 07:43:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so9797851eds.1
        for <linux-block@vger.kernel.org>; Mon, 27 Aug 2018 00:57:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180825100619.17868-1-yi.zhang@redhat.com>
References: <20180825100619.17868-1-yi.zhang@redhat.com>
From: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date: Mon, 27 Aug 2018 09:56:57 +0200
Message-ID: <CAJX1YtbeZ8b9xxFmYw_AJyKq02P+E=3eqckq-6QXQW5rAPLC_A@mail.gmail.com>
Subject: Re: [PATCH] blktests: remove unused null_blk parameter for
 _init_null_blk in block/016
To: Yi Zhang <yi.zhang@redhat.com>
Cc: osandov@fb.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

looks good to me
Reviewed-by: Gioh Kim <gi-oh.kim@profitbricks.com>



On Sat, Aug 25, 2018 at 12:06 PM, Yi Zhang <yi.zhang@redhat.com> wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/block/016 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/block/016 b/tests/block/016
> index 0e6f2e1..e0a63ad 100755
> --- a/tests/block/016
> +++ b/tests/block/016
> @@ -32,7 +32,7 @@ requires() {
>  test() {
>         echo "Running ${TEST_NAME}"
>
> -       if ! _init_null_blk null_blk queue_mode=3D2 irqmode=3D2 completio=
n_nsec=3D2000000000; then
> +       if ! _init_null_blk queue_mode=3D2 irqmode=3D2 completion_nsec=3D=
2000000000; then
>                 return 1
>         fi
>
> --
> 2.17.1
>



--=20
GIOH KIM
Linux Kernel Entwickler

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 176 2697 8962
Fax:      +49 30 577 008 299
Email:    gi-oh.kim@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens

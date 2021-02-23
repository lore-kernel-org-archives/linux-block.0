Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614BAC433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 14:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2844864E60
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 14:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhBWO4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 09:56:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:60553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhBWO4b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 09:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614092066;
        bh=h7PrhrBVOsfQpraZXzgrSkoPfNyeWD3upFXj0lOjJbw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=kIJWIYO4KVejQ4e5ddHeAQrydRmNrUdXSDyhTQHj+99Giodin4Bq4AtlSbOwzZLXz
         b8ufH2DGPkjhhScaNHkc/doqDCOJ1+KVhh3cLKw1jybBUVntmWlNtQGCh9Zlox3Qkc
         sEzYKP/EOy3n9PSi+Ra1sM8RGhyrSoMr6lfMmTjw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Valinor ([213.216.209.188]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUmD-1l7Ax32PSJ-00D1oa; Tue, 23
 Feb 2021 15:54:26 +0100
Date:   Tue, 23 Feb 2021 16:56:10 +0200
From:   Lauri Kasanen <cand@gmx.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
Subject: Re: [PATCH -next] n64: fix return value check in n64cart_probe()
Message-Id: <20210223165610.4d781615cb1fa4b370444db0@gmx.com>
In-Reply-To: <20210223140104.1743541-1-weiyongjun1@huawei.com>
References: <20210223140104.1743541-1-weiyongjun1@huawei.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VLcxbxkGinG7J99RFH8ODehiaGi0QZGd9DJtlnXt9vDKa73f0pN
 OTG/xnCPa6J2RzlH9zzZkXuZvrWkhz//aXpAVL3FZSnrEgdzxbk4FxEotFtJHcKUH4YVgFZ
 nvC78TjfozMwEaPeZMAJiIhokL6D9Hb8SXyWLnUaRYggpOOErupcF+dzfsG/Gh8oIYMkZoa
 DNqYv1TuGTeEUaMJad/8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jnD7qIfWX/I=:Y00SCDY+SdgYXE8Bn+fF9j
 S+PZpvhdUdgW8M0S5tOazYatPMviqhqINwcLdgGDIDMz5J4TdQcqKk+s1b7QwdH1GWKNYXRs8
 UeX7YJo3Gb0OUqbZ1OBbGyeT/lrWhaUZcrXWuvXO05i5Ovpt7r5myG6uhddlUcLT1e9wtG9Kg
 RepcXdT3ZdSlf5zPqWu//4NPQJkGA/NQPNG3eoJOhQbpVWbfo66lDhe5VuLESZINzSoT/1vZb
 1ReXVxrAJYWLWqdh96DdvYH1bluwI5aLabfmFwBmXYXo7oVJlri2bXp2APp64gvAVwx57HZiB
 k0FLiAY2+n2Sy8+R7kQXRODPQZKZ1J40BYjiKVBLvljazS9Q/J66jowJ1FMLX+OCge+Nknmfj
 /yB9/yWgzlITjNos/AAojnjgZdGFNIcyeDRbJx1ci4Go9UFZF9kAgs851txXLGjfkZp2FGfjv
 sZQuccFA9ivdv1icNpM/f7NGsQmgc0BACniagB07APQdqH+Eedp+Py3XTrXMrkJngLxkgBhcN
 ydP1bmCmqt+XvrBE936yrNcdTgNcnM/VKeIFy3TGgw284CHgj1C3trNSxjTC+o1UzHon1IBwo
 jGRK3pF8hy67/HNQotwcC4sEwuIGNlGFDqtc1UQ4b1zej4GTvFKeRFYd1jo2wltVmqD7CIvgt
 lkqcCer7siKb3la7koZVDyJbWBcUprTP77zZEkJGRo+jL+eD22jV2dDTFXfE5CuQu5oDE+N78
 eAxCwaS3l7VXQ40gdxsJCC8DiN+9lubZWB7Ko8xO6SyESytL/F9p+CUdX8L4cQPkVkxvgnA0W
 GDLS2WqGkYlyo0awq/W+HTAvQQXITAt7XUzMMt1HoQZP1opKa4r4Yzmsy3DT9x5XI1SeD5pI3
 K19sbZF6Xx86Yl5n1yvg==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Feb 2021 14:01:04 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> In case of error, the function devm_platform_ioremap_resource()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
>
> Fixes: d9b2a2bbbb4d ("block: Add n64 cart driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/block/n64cart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
> index 47bdf324e962..84a0f8d0be29 100644
> --- a/drivers/block/n64cart.c
> +++ b/drivers/block/n64cart.c
> @@ -129,8 +129,8 @@ static int __init n64cart_probe(struct platform_devi=
ce *pdev)
>  	}
>
>  	reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (!reg_base)
> -		return -EINVAL;
> +	if (IS_ERR(reg_base))
> +		return ERR_PTR(reg_base);
>
>  	disk =3D alloc_disk(0);
>  	if (!disk)
>

Reviewed-by: Lauri Kasanen <cand@gmx.com>

- Lauri

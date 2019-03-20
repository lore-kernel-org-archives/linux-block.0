Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF934C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 02:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68310217F4
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 02:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BqQ9CbWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCTC44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:56:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:54345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfCTC44 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 22:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553050614;
        bh=446xnWccmwxmzq6ZScgPsRNAjdCDISotdcTHzMLPmFI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BqQ9CbWvwIMzL6FifHBNk3wK1Zt7iVOQBiPYhj5bmh3N8hZL7Y9EkwHeIgCcLx098
         Rfw9WYXUwOx1w9hWdHD8zIC93u2nOAvIpWSFCiIchEZYhNVwCfs7BZP/dZCPrdNI5a
         Flm5ArClXWS88pH7/GFrk5dYSQeVYAABHzL64zPY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.183.223] ([218.18.229.179]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MZOan-1hR7zU3Zin-00LAta; Wed, 20
 Mar 2019 03:56:54 +0100
Subject: Re: [PATCH 1/2] block: increase bio_slab_nr only for necessary case
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20190308101540.24337-1-cgxu519@gmx.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <672a4135-9d68-e6c9-f9b6-c759018c3d65@gmx.com>
Date:   Wed, 20 Mar 2019 10:56:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190308101540.24337-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:w+GUcBWeiDFy+BoM5+Q9RmJfIJZsHbgqQtur1c68KTMVLQlDnlD
 jwgoyMntJS+LalkB2ZGhoCeKQWHQEWfN58gyqehiOyhPAK8B65tCZsgp0IqyMOQrJS7eXwG
 jSUEbW+qa/Kuv6NL1vMCOcrhxibva4rF72o0VIGvOzqOtxzsR8J7kvMBQvz6u5gCBLzs//Y
 c+9pMsBho4k1a3i5Mx+pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SSCdehzoSBE=:VGKqvLFDN7aUrsMOTqS15t
 xSTh2wlWb0kWD93I2293X3YZ6+SgcJUyZtaB5cy+aqzDewtCBy8W1MiFNHyINdx/7YJ0UNxv5
 34kwKIUu1EWUuwmgKwwUQ9wIYBYf8N6IYkTsC6jDoIY8HhGyjGCjFd5vlg+wyTyODTI453C0N
 UJczCn+5HLVj4aqmYLIXGJlJiyFVczfZhPKx4P4T3oPHyXgbNJBdu3oPKMrAv2ZuiBPuSkVqE
 KCDlAFwBC5HtxHntYHLEUcS7Jq2fQd8uZcHtKu4l0zLwAtB2vTYwU3h9upjyQxVdPHnxpDwu9
 WcvSZfCTAwlc5mvHciv3nVb9S/V0jDVewbIGpy/ucMyxlzgSscGmkG1ppVEOIMP54si0uqCqQ
 LK/EsQ3OFJh2fa6dMlMuoW8DwPIovmsd03h6aSdhCtjx5+uW2zhXV8baU0E+zjAneuex0s8cT
 Ej1Yn47FBdD5cCvmfVZhEIGwTdA57230kvUTGwxzvztUAMpiJOeAjSah4K0EhERGNcnt1jXwk
 MDXlmAyAcIfuPIzlD8c5r4h0IyHUBPMdOYdrdt0Eiq3N7FHh3lCZGSSJioOE5RpBFnz+34W2Q
 9vIKrmlrEMN9T9fYMv/dINSbkAWJVDFlsIRy9naUWahFJfEDzynrjSAe93hy7L1bOZnqFE56m
 bjP50OM5birnutP+NhRKEFmQ6PtU/PAyvcb05ue7+6zomHKDboIeKW0anX4+cknaX9CYJzDUj
 L3gM/aaZHZ7cvHHgWGA4NcdvlcAB+HGu2tIKNAQLi+SDT/0Kk8gOqpvGcaGMWhzWpt9ya7CAw
 0y60TOKtQ2hxvgCLAsjrRBdlEkjYYa9720v9FeFcGX27xWdbjRVzQh2HyCb3Iq7UpW4qbLBUY
 ky2cHJ8ZPPrMlTVQpYmq39Xng1OTTQDy9QBi17SgwH/jyj9Cd3X9OxA/Gy+g5VKJ9kNe2ondI
 OHDMnv0Wutw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/19 6:15 PM, Chengguang Xu wrote:
> When fail to create new cache in bio_find_or_create_slab(),
> we should not increase bio_slab_nr because it will cause
> referring uninitilized data in subsequent search.
>
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>   block/bio.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 4db1008309ed..8081906f5d01 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -109,7 +109,7 @@ static struct kmem_cache *bio_find_or_create_slab(un=
signed int extra_size)
>   		bio_slabs =3D new_bio_slabs;
>   	}
>   	if (entry =3D=3D -1)
> -		entry =3D bio_slab_nr++;
> +		entry =3D bio_slab_nr;
>
>   	bslab =3D &bio_slabs[entry];
>
> @@ -122,6 +122,10 @@ static struct kmem_cache *bio_find_or_create_slab(u=
nsigned int extra_size)
>   	bslab->slab =3D slab;
>   	bslab->slab_ref =3D 1;
>   	bslab->slab_size =3D sz;
> +
> +	if (entry =3D=3D bio_slab_nr)
> +		bio_slab_nr++;
> +
>   out_unlock:
>   	mutex_unlock(&bio_slab_lock);
>   	return slab;

Any suggestion?

Thanks.

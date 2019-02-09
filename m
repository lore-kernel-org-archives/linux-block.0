Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B8FC282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0487E21916
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 18:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsjNo9PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBISdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:33:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41716 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBISdA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 13:33:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id u188so4108701qkh.8;
        Sat, 09 Feb 2019 10:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=DgK5pMDyMltP/yC/7G/HZMduOCOiTLHdOzV0+qNTsKw=;
        b=jsjNo9POuVgN4MXK3AebQ/QZF5GobaM3fj2dSDV+a15JBfhFw61IeH4ZwQJCrg5AzZ
         ieQzXCpv7ybu4EoO4oqI4ldQgJKk8Qhtuncivfp4UDkrdhsPuFDxHFFWHfc2nfCRDghc
         SkbgwH4MfGNyuC3vS+5FNXo3Sf2tEOpDRyePoxZJdXdWr52XMjSJIF7ST29jIQspRQDk
         uv7GSAdhdX/v3L8q4bBGok68KSZMrBbr3S+p7KF3q6krvzXBSjXZjJedl2ceQedqnU6W
         Bug2pr4UtETTxVhbSPO+LO0wt8dCLDSJtABXCZA6uHxQ7PGHuEv51JFAbZQCqGi2Xnli
         rJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=DgK5pMDyMltP/yC/7G/HZMduOCOiTLHdOzV0+qNTsKw=;
        b=dOK55adZ2OBOZ4dhIJF3DKInSvylam6/GUfqqFSgEg/snKUCoHLzXL0FJBg6iIWlzl
         97uo/vvLKsR3yz95qj1cDNa1AVZ5LvaHNz5JarPAsTNXxYfgxURDTX0uJxFfk/R7dHmB
         kmtscJ3ENeu7CwLz3zxlHaJdW7etb4a3sdHjrCAiUwNhdjfHhaoqZxtgzhic3O4xRHX0
         tLHXyrU8DRTh4gRgLkXYK/ljIcBVqcNz9JO9DR6j4V5P8TN4RcUnZjeNd4Kdyw2oBNtX
         CugblanpK39CiFhfWcgR578Mv583zgAWiE+bgE8mKnORr2eRZc020zPHyePsU4bpdv84
         QkIA==
X-Gm-Message-State: AHQUAuZYqsyDXErsMMIlAKhM9pvUuFXO8O3ynXcCSJm+jgDRdy0V4YVn
        iAVr9WS0BF4pDFgyqEJc5H7QCNfOdZw=
X-Google-Smtp-Source: AHgI3IZY5Ysi+vuhCbppeHA17JaCxTSyJBQ5NjWLhMLSK2nBewK/webrgsVMkt4eahAyvCZ4GB71lQ==
X-Received: by 2002:a37:6e07:: with SMTP id j7mr19955878qkc.298.1549737178295;
        Sat, 09 Feb 2019 10:32:58 -0800 (PST)
Received: from [192.168.0.153] (189.26.177.147.dynamic.adsl.gvt.net.br. [189.26.177.147])
        by smtp.gmail.com with ESMTPSA id f33sm10422736qta.91.2019.02.09.10.32.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 10:32:57 -0800 (PST)
Subject: Re: [PATCH] blk-sysfs: Rework documention of __blk_release_queue
To:     linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190131011139.2264742-1-marcos.souza.org@gmail.com>
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Message-ID: <02fcaaa4-3667-7144-5ca2-4e5346380439@gmail.com>
Date:   Sat, 9 Feb 2019 16:34:01 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190131011139.2264742-1-marcos.souza.org@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------7FEFF2AB327E4DB99FE0DFEB"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------7FEFF2AB327E4DB99FE0DFEB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping :)

On 1/30/19 11:11 PM, Marcos Paulo de Souza wrote:
> The Notes section of the comment was removed, because now
> blk_release_queue can only be executed from blk_cleanup_queue (being
> called when the q->kobj reaches zero), and also blk_init_queue was remo=
ved
> in a1ce35fa4985.
>=20
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  This is basically a v2 of https://lkml.org/lkml/2019/1/14/1098
>=20
>  But, I tried to describe when this function is called, removing redund=
ancies.
>  Maybe it would be better placed in blk-core.c, where the q->kobj is in=
itialized
>  with blk_queue_ktype (which .release pointer points to blk_release_que=
ue)?
>=20
>  block/blk-sysfs.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 590d1ef2f961..d4dea9179fa6 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -817,21 +817,16 @@ static void blk_free_queue_rcu(struct rcu_head *r=
cu_head)
>  }
> =20
>  /**
> - * __blk_release_queue - release a request queue when it is no longer =
needed
> + * __blk_release_queue - release a request queue
>   * @work: pointer to the release_work member of the request queue to b=
e released
>   *
>   * Description:
> - *     blk_release_queue is the counterpart of blk_init_queue(). It sh=
ould be
> - *     called when a request queue is being released; typically when a=
 block
> - *     device is being de-registered. Its primary task it to free the =
queue
> - *     itself.
> - *
> - * Notes:
> - *     The low level driver must have finished any outstanding request=
s first
> - *     via blk_cleanup_queue().
> - *
> - *     Although blk_release_queue() may be called with preemption disa=
bled,
> - *     __blk_release_queue() may sleep.
> + *     This function is called when a block device is being de-registe=
red. The
> + *     process of releasing a request queue starts with blk_cleanup_qu=
eue, which
> + *     set the appropriate flags and the calls blk_put_queue, that dec=
rements
> + *     the reference counter of the request queue. Once the reference =
counter
> + *     of the request queue reaches zero, blk_release_queue is called =
to release
> + *     all allocated resources of the request queue.
>   */
>  static void __blk_release_queue(struct work_struct *work)
>  {
>=20

--------------7FEFF2AB327E4DB99FE0DFEB
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFwGdegBCADpmN2M/qgid640GczjjQNKUqNDYr8WXDxZAIjNPNeTeQFNbMeq
PKCRzmEXD2bCs8Dzss9OOWWMbphb5+jiU9lfuZZMnhh6UL1DzZGU7HpCqb/rWL9K
gdo/GhN1ZNyc965+VdltiI5dhhsEuoptkvCw9wpcQcL9DpCldD+ix7dO64jz7VgH
97H0B8jC5nkvnafsnSC+oKN/bIlVnKDjMdvtsUEEkf910APOHswfX8nm0uOIk7In
8ECT2c/5fkCKBq+Wozc3MCsNShV3KFgs6IrBFcI+eu4xb4PO0OEWn+C1w70jJTuk
XJXvIJ0Vsshp+ue2ZPMpaQ9oC/eu4JY3I46HABEBAAG0Mk1hcmNvcyBQYXVsbyBk
ZSBTb3V6YSA8bWFyY29zLnNvdXphLm9yZ0BnbWFpbC5jb20+iQFUBBMBCAA+FiEE
c1x2fap6ddr/tht1jy9yDsZUoRMFAlwGdegCGwMFCQHhM4AFCwkIBwIGFQoJCAsC
BBYCAwECHgECF4AACgkQjy9yDsZUoRPv8wf+MdfRcElEJLisTaIoxfqrmDvi7+CB
76FhFev0q9JXUqzu0Ijgdv+MOnSn5KFmh6bTza7rkMCMC7mj5mYUnmOs2DvsDSYB
KmUT5/Dc+uuna32Mqz017tzyWKbGpbkI9xVy6lIaQvkGvHox3a6WAWQbvUvf2MRA
lkhEAHEzdyYVxIc7uqMBFuMh9X9WOlv8ySkgNyNgnMat/d5fHrSx4X2tyBMyR3Xq
B9UkxlkbvSSjkKYsMmPYj8q5Rv3Hnqr9tgnxJYJ4fZF18nv8PeZnz1hsdEiZYxUz
HDFrEPrxdLPu7dS6sbYdKUIIPLxfIcyxnv5l1T3rBeF9Ldwv9TxxUTJWR7kBDQRc
BnXoAQgAyRLO7dO0DA0reOjvoydxE62/gEkMy3hX0D+eLFgBIIvaWyMwgnQR7Vjg
4AlF62Pp0GYru1otsq6Za+cCK2j3ptLPeAgquT3J5MziPzG1lOtCHUHdDcd4wAXW
p+0sOPaV/ilmf80ROyt8Ky2wtPZULHFRfdPObyUcdjjFbkRH//tDLVwnE8sqJVwJ
DyeAkeVlG434Wtr9C+TDnO9sKOeTOB3yfZUEnAr460GmyrfR0tlskMqFF7AgPSGg
jyez0tS5SVIaLZUL7hXUfthd4x0OOw9gm9jitqRx/HLRP/NrgZ59xqPcJMi5tI0y
A7J5NZAAKdfZkpD+0BHED5I+wBpGUQARAQABiQE8BBgBCAAmFiEEc1x2fap6ddr/
tht1jy9yDsZUoRMFAlwGdegCGwwFCQHhM4AACgkQjy9yDsZUoRPZWwf/f1C1afJ+
FN0afFOpxxLGVjIL//O6z+w666nd+uNfFDHO1PDFUXQiU8u0KkxfjBF3FhKxjewZ
kO+Nb4Dy6EvdvG5Hm2uU5sNE+FJ4b1h9Ue0Dg4kCe6ZGytCvy6/wP/TXlotejOq6
US+F4VW6oyldXWjvwYHrTpDRZvza1nhqGypB9fsPGa3JbtvNNGcg+NMliE+YnxhF
NbN6Dth7f9jLyw13/PtmHL5HZX0rU+vz7JuIW0nm2Zp7NosmfgPevMAF8S53BS9Y
8vQjqkRcduLTTpArZeaPoXJBtYo5L1Ysn/dUV4xeZYIcxlrmKNGKEx28eXxZ579q
LbbJ/5zeVzltzQ=3D=3D
=3D5HUz
-----END PGP PUBLIC KEY BLOCK-----

--------------7FEFF2AB327E4DB99FE0DFEB--

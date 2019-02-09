Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE9C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 18:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBEA214DA
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 18:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTD535Rk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfBISbt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:31:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38595 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfBISbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 13:31:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id p15so2447711qkl.5;
        Sat, 09 Feb 2019 10:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=HTKsCuoWv3B6eRPKKnz1ZtmH6rHf+rvW+qab88WvitM=;
        b=NTD535RkTmbNZ56wDmUu5SrBBliZ62yA7AI2yOy/or+Yle7TBJtzBSb6QrKhedSqwq
         8/8JcE0kbSgPM5Zw3ExVIu7FpmOIcr6LQVN96+HxrjJNakDrt8NvgZYH2gFYoUj/VxRu
         IctwJoUBw2HQLMuT66HniYQpg+GWFl7uSrtYYsWV0LyieYYMcWNpMcULGftIJLfh859f
         Q2NNEupNlY7ECYnNOm9TjsGTB+IhezjD0xL65V9Dk2nnloW1a586abpZpiQSur08CdpM
         zJ3KtJje+njTpwnqd1aEmPjaIHo/fkQqEhF2q6JujuOs1VwnAFT+herdqre9HTsK+efF
         evSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=HTKsCuoWv3B6eRPKKnz1ZtmH6rHf+rvW+qab88WvitM=;
        b=sODz2rMGnqZstzlU5Ak+Dw0ehn8eDOfZL8sE6c4+SHGxV9nqQr3zhmFHQ+6BEm5u25
         4nCcNLnRFxshZob4jt+lFvktBbzYv5gypmc+drT70ijzCjOyRSdkJRq0Hf2BQGuWnx0u
         IOS4eNUxgf0UmrWArC+U282ErqIfwiBZQEABfa/H5sbcrZS0RBfM4MYLEXbYVh4hlcuO
         5Uvd1JgcuFZIgspgnDbGF5NWZQ13UKzfKnQKStbNcr9WVrIpzbPAEC6pGXmMyo68WaTt
         sQt0p/yPjTHt/+Cn/GMdIybSYdzQsxb0hl9BO9Z7DuHTKI41wCIi9cRDrY8yw3vgsu0L
         pKYg==
X-Gm-Message-State: AHQUAuaPW5DImRo+MfS4nEFuOuuVWcyXK/TIYM6B+iQ/E8+u5g1EcSOZ
        o+FSaHC+F3z4suzHzSqx/b096J4lAVQ=
X-Google-Smtp-Source: AHgI3IbG4uotXu9ucRHVVJAPkCtK5EwJfBCCrmE/NrkJCXahQIj+MrLH5bFTtGy6209HdBJtNir2sQ==
X-Received: by 2002:ae9:f212:: with SMTP id m18mr19976616qkg.5.1549737107639;
        Sat, 09 Feb 2019 10:31:47 -0800 (PST)
Received: from [192.168.0.153] (189.26.177.147.dynamic.adsl.gvt.net.br. [189.26.177.147])
        by smtp.gmail.com with ESMTPSA id 20sm5666496qts.82.2019.02.09.10.31.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 10:31:46 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: Fix doc related to blkcg_exit_queue
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190125020142.921371-1-marcos.souza.org@gmail.com>
 <06802295-4dc7-20bd-a511-99dc37bf8777@acm.org>
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Message-ID: <bb1d8c20-d6c1-535b-fd23-f1f4bd6281ba@gmail.com>
Date:   Sat, 9 Feb 2019 16:32:50 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <06802295-4dc7-20bd-a511-99dc37bf8777@acm.org>
Content-Type: multipart/mixed;
 boundary="------------503F852264E26282EE66674F"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------503F852264E26282EE66674F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping :)

On 1/25/19 1:50 AM, Bart Van Assche wrote:
> On 1/24/19 6:01 PM, Marcos Paulo de Souza wrote:
>> Since 4cf6324b17e9, a portion of function blk_cleanup_queue was moved =
to
>> a newly created function called blk_exit_queue, including the call of
>> blkcg_exit_queue. So, adjust the documenation according.
>>
>> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
>> ---
>> =C2=A0 block/blk-cgroup.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 2bed5725aa03..77f37ef8ef06 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1269,7 +1269,7 @@ void blkcg_drain_queue(struct request_queue *q)
>> =C2=A0=C2=A0 * blkcg_exit_queue - exit and release blkcg part of reque=
st_queue
>> =C2=A0=C2=A0 * @q: request_queue being released
>> =C2=A0=C2=A0 *
>> - * Called from blk_release_queue().=C2=A0 Responsible for exiting blk=
cg part.
>> + * Called from blk_exit_queue().=C2=A0 Responsible for exiting blkcg =
part.
>> =C2=A0=C2=A0 */
>> =C2=A0 void blkcg_exit_queue(struct request_queue *q)
>> =C2=A0 {
>=20
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

--------------503F852264E26282EE66674F
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

--------------503F852264E26282EE66674F--

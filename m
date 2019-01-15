Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CF6C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 10:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A54120651
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 10:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9gob+D4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfAOK2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:28:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33491 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfAOK2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 05:28:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so2149358eds.0;
        Tue, 15 Jan 2019 02:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=NjZVaR/uEKWj/WwWREcgZLHV7gJW+E6szq99IZnsj5g=;
        b=g9gob+D4fHpJt+4TUlLLM8+v7WfWFzB+7Pe9VxI54LrjH6mHA72Et5uddAef0bn0uC
         36+tAeFrtWQOdHP9jRV1I2VbX5j/YzJsCnSrghIICvpw1GVKQ1JIUjeW6VM/q0YyFYsM
         +4Ul1sNIMeDYBd/+ilVcdmEcVDdg7WSjAxjz3VT7euC2/NUnFn9bMByN7mejbIUn+OTs
         ziFGQgsbkrv45mYC8FtFAkGhBLCd7oaz3L4qrjDCM3su3JrnIvYazkDu1Yqf/UoVbp7b
         GFCJLiPhT5wXXfIZJhnDQ/1uk82Z2v/wp83OMtBjXVSGFQU2wdLqMjiIXKZ9iqRHEId3
         DH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=NjZVaR/uEKWj/WwWREcgZLHV7gJW+E6szq99IZnsj5g=;
        b=bfNWkfrjfvtXNeghm2qYX1JupRML4x6QAf/R2MVENri3EdYfMfKF8GnKeXRMtZD4+4
         tgeK+aYY98Px2Hy/Rc0DwD/ptzf/1lMWYnjSiKvjBRAdLfpVVXlaIeeKOj2QelHYsjr4
         y+Xkrt4nU0cIsVLRRIA/7KDPFnfbe+qLyv2wxCqvMfcgYatzBnLX+fmy+euoTWqvYTn0
         7R4cqt41ZI5L5/xAmqSAeDtUX+OMLBXqh2Z8mIzdqNpA5sUNLESnlsyMYHqFVHMMVjLJ
         I6RKGHDh02wfI1H8rmzFDwiMXQkHLUHxbl9LqTnZWFUv/RmCTVAPSthm5Cuzmkx6uqkR
         u/Wg==
X-Gm-Message-State: AJcUukfJq72AELOxOVY7y8foBDhJq+yux8S1C+6NAW9xE3PW0zxwRg0b
        /nROiT4tZwEt3Wa4/LsN3gaBbhCd
X-Google-Smtp-Source: ALg8bN4ZfO4DzPo3jNpPytM/fASL9SxeWToV4xJ0vfYQMjvtxICxsM4FKIGICA54t4yK8TR9gxaEcA==
X-Received: by 2002:a50:9315:: with SMTP id m21mr2817747eda.58.1547548112505;
        Tue, 15 Jan 2019 02:28:32 -0800 (PST)
Received: from [192.168.0.153] ([189.58.147.179])
        by smtp.gmail.com with ESMTPSA id x38sm4976425edx.24.2019.01.15.02.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 02:28:31 -0800 (PST)
Subject: Re: [PATCH] block/blk-sysfs.c: Remove last reference of
 blk_init_queue
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190115030615.1090578-1-marcos.souza.org@gmail.com>
 <d255d497-62aa-9fc3-fa21-20c9b0226a17@kernel.dk>
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Message-ID: <69bddff5-22a1-4ccd-91c3-5dab6c07b1f9@gmail.com>
Date:   Tue, 15 Jan 2019 08:29:11 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d255d497-62aa-9fc3-fa21-20c9b0226a17@kernel.dk>
Content-Type: multipart/mixed;
 boundary="------------CC264F47AAF4CBE506416273"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------CC264F47AAF4CBE506416273
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

HI Jeans,

On 1/15/19 1:54 AM, Jens Axboe wrote:
> On 1/14/19 8:06 PM, Marcos Paulo de Souza wrote:
>> blk_init_queue was removed in a1ce35fa4985.
>=20
> Honestly, most of that comment is wrong anyway. Since this isn't
> a visible API, I'd just kill the comment completely.

I will send a v2 trying to describe better what the function does and
where it is used (or removed it completely as you suggested).

>=20
>> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
>> ---
>>  There are more two references in Documentation/block/biodoc.txt, but =
maybe that
>>  file needs a rewrite in rst anyway?
>=20
> It probably needs a rewrite - period :-)
>=20


--------------CC264F47AAF4CBE506416273
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

--------------CC264F47AAF4CBE506416273--

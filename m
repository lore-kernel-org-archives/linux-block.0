Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9217C001DB
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 10:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjHDKM1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 06:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjHDKL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 06:11:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03094EDA
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 03:11:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so29391551fa.1
        for <linux-block@vger.kernel.org>; Fri, 04 Aug 2023 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691143901; x=1691748701;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1NyZ2ZcEUgRJ05nh4qGkaHP8XwB2d++wqI7O42ED1c=;
        b=Ll5IFace3oreRLGj4UuXZ8P6oCeFDrrzBK771h6azQQEjz4rAuLG52KQiFFlmvesba
         SMTqy+JDw6UGy3gO69FUpAkAG1qVIrS5c4Zvmu+sIkIJwPjCFihNSKxoTOB1awPHK0el
         5vJWgq7/JLvBVaqTvG1igX5EZlvhrWqaeATIG5TWMSh6nCDrsRDq2P3zasreSlK21oeo
         XBmHmX7wNI60u7JwZSIfj6vytHToI0bVKiaK982ZNKW0/wt+Efg5ZcNEO94LE5LH61i3
         SAWygQpVfCgjToTSmKryKk3iZCSCNUj3LWeH+xdYjCNqfBcKsktE3Hm6gd3wFfV2zS1y
         sZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143901; x=1691748701;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1NyZ2ZcEUgRJ05nh4qGkaHP8XwB2d++wqI7O42ED1c=;
        b=l4G0VvWjBePAEeAtGRHO+pKJ4uy2bTLg1dbE1soB2isX0H8g23Vwl9Yg4zzyYmQRco
         ZLd0MMfHQot3JEQY6UMVwyoG/md728sAZO9U5azIY/dVeO2ZNDPSN3vXaRo3KOAfqbOp
         tEp3sZjQObggK5jI+M0gB4j0F9leJGSZDsffGnzQl8vW7z8JYS7gz9gLsFMoHdpxBcgA
         OO9dBnnixo99LeVxxDvcABQT9dRo7KXWaNn2ZW9D2RGUpeX1RVnwcGLHZF8fZ6OLjQ8w
         9A9vqaNh4rBtZ45r1oUL3BlluMa/tPujYzqU6PbKbTtJmh7nIbuYfjiYN71IzEXxCBD0
         PYBQ==
X-Gm-Message-State: AOJu0Yy5nzXfPgpaT+VPt+xJoN4qcebZbCejQj65Q+kn/ZtwICLfJ8R8
        n+uAxn+5/Z8q76XiQf34O8lOqA==
X-Google-Smtp-Source: AGHT+IHMm/cDQmqDveE+uqKs6mjna7XVIhwy/27dUDJSYJo9be60LkkzqE9EGqB0f7Bq3vZv7TOvcA==
X-Received: by 2002:a2e:9c02:0:b0:2b6:d8d5:15b1 with SMTP id s2-20020a2e9c02000000b002b6d8d515b1mr985558lji.50.1691143900793;
        Fri, 04 Aug 2023 03:11:40 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id d8-20020a1709063ec800b009927d4d7a6bsm1083243ejj.53.2023.08.04.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:11:40 -0700 (PDT)
References: <20230803140701.18515-1-nmi@metaspace.dk>
 <20230803140701.18515-3-nmi@metaspace.dk>
 <ZMy+dTpJzln7DlgZ@ovpn-8-25.pek2.redhat.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/3] ublk: move check for empty address field on
 command submission
Date:   Fri, 04 Aug 2023 12:08:55 +0200
In-reply-to: <ZMy+dTpJzln7DlgZ@ovpn-8-25.pek2.redhat.com>
Message-ID: <87350zxgkk.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <tom.leiming@gmail.com> writes:

> Hi Andreas,
>
> On Thu, Aug 03, 2023 at 04:07:00PM +0200, Andreas Hindborg (Samsung) wrot=
e:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> In preparation for zoned storage support, move the check for empty `addr`
>> field into the command handler case statement. Note that the check makes=
 no
>> sense for `UBLK_IO_NEED_GET_DATA` because the `addr` field must always be
>> set for this command.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  drivers/block/ublk_drv.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index db3523e281a6..5a1ee17636ac 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -1419,11 +1419,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>>  			^ (_IOC_NR(cmd_op) =3D=3D UBLK_IO_NEED_GET_DATA))
>>  		goto out;
>>=20=20
>> -	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
>> -		ret =3D -EINVAL;
>> -		goto out;
>> -	}
>> -
>>  	ret =3D ublk_check_cmd_op(cmd_op);
>>  	if (ret)
>>  		goto out;
>> @@ -1452,6 +1447,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>>  				goto out;
>>  		}
>>=20=20
>> +		/* User copy requires addr to be unset */
>> +		if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
>> +			ret =3D -EINVAL;
>> +			goto out;
>> +		}
>> +
>
> Given you have to post v11 for fixing build issue, please convert the
> above two 'if' into one 'if else':
>
> 		if (!ublk_support_user_copy(ubq)) {
> 			/*
> 			 * FETCH_RQ has to provide IO buffer if NEED GET
> 			 * DATA is not enabled
> 			 */
> 			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
> 				goto out;
> 		} else {
> 			if (ub_cmd->addr) {
> 				ret =3D -EINVAL;
> 				goto out;
> 			}
> 		}

Alright. I was debating with myself one over the other =F0=9F=98=85

>
>>  		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
>>  		ublk_mark_io_ready(ub, ubq);
>>  		break;
>> @@ -1470,6 +1471,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>>  						req_op(req) =3D=3D REQ_OP_READ))
>>  				goto out;
>>  		}
>> +
>> +		/* User copy requires addr to be unset */
>> +		if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
>> +			ret =3D -EINVAL;
>> +			goto out;
>> +		}
>> +
>
> Same with above.
>
> BTW, I have verified this patchset with ublk-zoned example in
> libublk-rs:
>
> https://github.com/ming1/libublk-rs/tree/zoned.v2
>
> cargo run --example zoned -- add -1 10240
> mkfs.btrfs -O zoned /dev/ublkb0
> mount & git clone linux-kernel &umount

Thanks!

BR Andreas

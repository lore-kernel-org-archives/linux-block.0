Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7828CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4221D7F
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5oKffUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392145AbfJYJsP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:48:15 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44569 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391988AbfJYJsO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 05:48:14 -0400
Received: by mail-wr1-f50.google.com with SMTP id z11so1522960wro.11;
        Fri, 25 Oct 2019 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:autocrypt:subject:message-id:date:user-agent:mime-version;
        bh=BdjaYlvumIYai6YwjSnesLOQq5Monp3ohavRaWWmlr4=;
        b=m5oKffUVcI4bt3oVPf2ZzL7tR0R+R1/8RGYO5KmE9fmjuxu4FW4/8sHaVexIJFKHri
         impfoZnJaAfBwymaSgyQZUeST0IZ0o8/VNl2zT5yeBYdBwmYCzw1rp9A2TUNz3vyPEOP
         3Al2cbySJc1XhVS52W8WqW0iOhG1sdzxfvXvwloUwQBMZpeJ0+EVud3oFADIctjpTt22
         BKhrWumX1hzqlKeh0SvZmZsIm164GXd2bPHR5vqcZTcDEbt9puDP7KdDj5fb9WsjeI0t
         6viFY6+KfQEGfRF/bfWqPyTbjH3hEVpQo5ldcY83plbvAqpbq7DtR0rTzUgJV5UTJx+l
         ZjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:autocrypt:subject:message-id:date
         :user-agent:mime-version;
        bh=BdjaYlvumIYai6YwjSnesLOQq5Monp3ohavRaWWmlr4=;
        b=JlKpGieGctshR1nmk1VN9vj1AowogAdGQqcl38wNEWFC+bsSKsak8AdxwUgT2W4X8U
         /2UFAqzeUA8/FqYMp6sA0OaMYebeXCXl0u4wIXgNrfRbh+OVCxT0gGH7BVRpfotF/f+5
         vkD9mWsGSp0pZ14WfcrR6BvGRfBHk/tHKfWxAM59Cylqxy7wJ99PsrJaSRXVmVmxJWoX
         YR4PB8AEubQZFqSrfuxbDpk9UWr0XkQHsv9VxXTj8taQsp6M9XS0JYjRx4glVFN3WmBk
         DE9arlTRljYoTiEXN9YJ7eOtsjS9HnM7z7vPqrVOlbnK1ap1Hk92WnyihZ81wbbD5im1
         9MUw==
X-Gm-Message-State: APjAAAUN1qjxPLWYM94KSFGXOJkZQvif5MVHTNz54b0WSmasDo5LCBtI
        NFvjUZxYJd97CIWmhQTPcsLl3rgY
X-Google-Smtp-Source: APXvYqzOa/UYxntEPuytj3j4BhQq81JMiz2Rl8Y+XUGhLQyFVH3Xsc3Vt8uTsIfB6rBfjv6GAAoUfg==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr1974718wru.87.1571996891373;
        Fri, 25 Oct 2019 02:48:11 -0700 (PDT)
Received: from [192.168.43.159] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id o11sm1474787wmh.28.2019.10.25.02.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 02:48:10 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: [BUG][RFC] Miscalculated inflight counter in io_uring
Message-ID: <bfecc5ba-274b-b2f7-52dc-8ac6e0fab352@gmail.com>
Date:   Fri, 25 Oct 2019 12:48:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XRQZWAm4V5oBsv6yDZAKSZB2Qieagb5W7"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XRQZWAm4V5oBsv6yDZAKSZB2Qieagb5W7
Content-Type: multipart/mixed; boundary="y8qh1m9uXyXY41YulhwBAxBDD1EhBX7gE";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <bfecc5ba-274b-b2f7-52dc-8ac6e0fab352@gmail.com>
Subject: [BUG][RFC] Miscalculated inflight counter in io_uring

--y8qh1m9uXyXY41YulhwBAxBDD1EhBX7gE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

In case of IORING_SETUP_SQPOLL | IORING_SETUP_IOPOLL:

@inflight count returned by io_submit_sqes() is the number of entries
picked up from a sqring including already completed/failed. And
completed but not failed requests will be placed into @poll_list.

Then io_sq_thread() tries to poll @inflight events, even though failed
won't appear in @poll_list. Thus, it will think that there are always
something to poll (i.e. @inflight > 0)

There are several issues with this:
1. io_sq_thread won't ever sleep
2. io_sq_thread() may be left running and actively polling even after
user process is destroyed
3. the same goes for mm_struct with all vmas of the user process
TL;DR;
awhile @inflight > 0, io_sq_thread won't put @cur_mm, so locking
recycling of vmas used for rings' mapping, which hold refcount of
io_uring's struct file. Thus, io_uring_release() won't be called, as
well as kthread_{park,stop}(). That's all in case when the user process
haven't unmapped rings.


I'm not sure how to fix it better:
1. try to put failed into poll_list (grabbing mutex).

2. test for zero-inflight case with comparing sq and cq. something like
```
if (nr_polled =3D=3D 0) {
	lock(comp_lock);
	if (cached_cq_head =3D=3D cached_sq_tail)
		inflight =3D 0;
	unlock(comp_lock);
}
```
But that's adds extra spinlock locking in fast-path. And that's unsafe
to use non-cached heads/tails, as it could be maliciously changed by
userspace.

3. Do some counting of failed (probably needs atomic or synchronisation)

4. something else?


--=20
Yours sincerely,
Pavel Begunkov


--y8qh1m9uXyXY41YulhwBAxBDD1EhBX7gE--

--XRQZWAm4V5oBsv6yDZAKSZB2Qieagb5W7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2yxNcACgkQWt5b1Glr
+6XOexAAnDmDBk6vOk6MiMuWMw46MlfyaOANpt889WfCRXDsQXYdyOVXDYhTzDPM
ihsl/J1OwBG4PQe0d5dUY/1GspU7GHAwLzvyp7/TJFm3WdI7TjRLv0JLieFQy1Y5
WanZgsb6hq0wS5pZl4BkHgg75Pfw6WIrGc5klvse22kVyQXMy+uQK1NcMcWrYbpG
oWD9H08/khA8qaK9rviHdCHUqzEzaizK/KC4WtMPSlK5fBlRerTs+S3rgQlXzOCI
SydNmmmuQ/8s3ofYx7fGfKhIBJv+I99rDMf6Ks7OzChoaPn3vtKXp6glcHx5hG4u
qFOc9UXlVVZwA4Ihdn53+PRrddDcpuYxbBVpEgHDQX4fH+r48a5FJKEebSAYFEgm
6XGjgffh9MUIrXijmIFoPK8teoKh0JgR7VvEGbqobC6BDEM6Zrbx/oR5Y9KDd4R3
VNq3O6zIDUeIVpYEpb+B3zy/RhvPdHKnzfZuHMuH+LSh1oreUZADVhMeWTxKOzWP
aeyY2THKq3U3oPWm8+9negritEb5PP53iVDX6RmPxXL50erjOWlXgrgPvd/pbGyl
W1pi5mjhGOtbGdTxEKqb9M0/zxZu7FA7Re4TjfKrZknQZWscx2uMsaKbSvcX/jv4
UtWD/svY798oKKAVwgbwNVVFLilmVlz93EdCFIsqURj2KBXbGW0=
=KG/V
-----END PGP SIGNATURE-----

--XRQZWAm4V5oBsv6yDZAKSZB2Qieagb5W7--

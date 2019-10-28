Return-Path: <SRS0=tc1V=YV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4D0CA9EC2
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 11:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BA1208C0
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 11:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh+q0qSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfJ1LMi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:12:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37104 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 07:12:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id q130so8671550wme.2;
        Mon, 28 Oct 2019 04:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=6errtsQvZpg7QgqLKvQtqin9PkVdpQvTzRqvig4GCPg=;
        b=Eh+q0qSNYVa7T4e05gsUfIFXEEXcPXe29mQ6OADF/iNHXJvahooLYok0GLpt+Td0E8
         hP5HxnYi0Dro6yXKdpsG3hH5XvqCj73NvFJ3Q296az6yurJzxC+/Tqqguf1n+A1vwlWj
         yyAYgpKPgMqtbHcqWFcguEU1lWdUMIFsOxO6/hTHRSOVG3/fZdMM1VwTafT2Z8PYN8+E
         VAa0z2vyFoxeJ2CqgAiZ4m3rWt5x3bvx5bWaWXeZTYJNhQz8hXsriUnUjJplHUslZ2Q2
         KEjOZgNgn/HguX5MUcXwqobONUGae8uDeQCFhcdKCS65u3nyXZSp+06X+oXM0pHoBPyW
         BSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=6errtsQvZpg7QgqLKvQtqin9PkVdpQvTzRqvig4GCPg=;
        b=H9ulz4VbvqJL0tBDtFb2aiKQuTAVRRPKcbPCb7zNPkOJerCETDuJOvZOGT3kbOfZy5
         GDbomutD8i77Zbiv5fLI9H9ruqQFbO3CmZkVvSr7CYUyVSKUguJBuY4sRxKDvxhQ2QoX
         zxbhnZMAW4AFHBtlaO0Nwjejg1FsPThtIGu03di1B9Olw/QfjeP6Y0WK1l13ijVD9nSB
         KWq/XC9ljY/ew0sfwTOU3rtsKOnE8qS55AJry5qxl/38hRRpuIe5FAm3UC4pVj2wqNmI
         TNyT32xIM3JOCY4fs9MPY9+FjvGgaRoQEi3feGA6D7HxCSE9V12HAGlRA+EmrtciB6GV
         Hwog==
X-Gm-Message-State: APjAAAXkTDoujnw0tQvucCUHfq+85WsdH4IWisAanaULZEmBVTv42ZMD
        +TmE6zOtZp5uzPPiYdeq46Dd6P6u
X-Google-Smtp-Source: APXvYqxqiuG3sNryW8Sy22c24HREAapk86XqY/lBTR1KGOdvs9+VcLoMmqFKZgfNp3FEZuuG4XCXHA==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr15469016wmi.65.1572261153998;
        Mon, 28 Oct 2019 04:12:33 -0700 (PDT)
Received: from [192.168.43.153] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id i18sm11359931wrx.14.2019.10.28.04.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 04:12:33 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
 <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
 <63f93f8a-4207-3ac4-a301-4907882009c9@gmail.com>
 <728dec9c-465c-2341-d7b5-929a50400e9c@kernel.dk>
 <3b8b84d0-cde2-6bb0-c903-a1d71f9b83e2@gmail.com>
 <3957148b-0dac-a621-8f12-5d2d45557e24@kernel.dk>
 <1e0ae1a6-6b8b-a78e-8ec0-fb7aa5972d00@gmail.com>
 <02d42c75-1d48-35bd-abad-8230d2449c67@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
Message-ID: <7cbec6a8-beb4-0738-9b4b-6d436efedc83@gmail.com>
Date:   Mon, 28 Oct 2019 14:12:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <02d42c75-1d48-35bd-abad-8230d2449c67@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i5bkzkjDhLVbrw7ROj8XCow8wOVHu95eE"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i5bkzkjDhLVbrw7ROj8XCow8wOVHu95eE
Content-Type: multipart/mixed; boundary="CqCjm4AXnxroyZqHLeEfYWAFw1eFjB4Vg";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <7cbec6a8-beb4-0738-9b4b-6d436efedc83@gmail.com>
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
 <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
 <63f93f8a-4207-3ac4-a301-4907882009c9@gmail.com>
 <728dec9c-465c-2341-d7b5-929a50400e9c@kernel.dk>
 <3b8b84d0-cde2-6bb0-c903-a1d71f9b83e2@gmail.com>
 <3957148b-0dac-a621-8f12-5d2d45557e24@kernel.dk>
 <1e0ae1a6-6b8b-a78e-8ec0-fb7aa5972d00@gmail.com>
 <02d42c75-1d48-35bd-abad-8230d2449c67@kernel.dk>
In-Reply-To: <02d42c75-1d48-35bd-abad-8230d2449c67@kernel.dk>

--CqCjm4AXnxroyZqHLeEfYWAFw1eFjB4Vg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28/10/2019 06:38, Jens Axboe wrote:
> On 10/27/19 1:59 PM, Pavel Begunkov wrote:
>> On 27/10/2019 22:51, Jens Axboe wrote:
>>> On 10/27/19 1:17 PM, Pavel Begunkov wrote:
>>>> On 27/10/2019 22:02, Jens Axboe wrote:
>>>>> On 10/27/19 12:56 PM, Pavel Begunkov wrote:
>>>>>> On 27/10/2019 20:26, Jens Axboe wrote:
>>>>>>> On 10/27/19 11:19 AM, Pavel Begunkov wrote:
>>>>>>>> On 27/10/2019 19:56, Jens Axboe wrote:
>>>>>>>>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>>>>>>>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>>>>>>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>>>>>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>>>>>>>>> A small cleanup of very similar but diverged io_submit_sqes=
() and
>>>>>>>>>>>>> io_ring_submit()
>>>>>>>>>>>>>
>>>>>>>>>>>>> Pavel Begunkov (2):
>>>>>>>>>>>>>          io_uring: handle mm_fault outside of submission
>>>>>>>>>>>>>          io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>>>>>>>>
>>>>>>>>>>>>>         fs/io_uring.c | 116 ++++++++++++++-----------------=
-------------------
>>>>>>>>>>>>>         1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> I like the cleanups here, but one thing that seems off is th=
e
>>>>>>>>>>>> assumption that io_sq_thread() always needs to grab the mm. =
If
>>>>>>>>>>>> the sqes processed are just READ/WRITE_FIXED, then it never =
needs
>>>>>>>>>>>> to grab the mm.
>>>>>>>>>>>> Yeah, we removed it to fix bugs. Personally, I think it woul=
d be
>>>>>>>>>>> clearer to do lazy grabbing conditionally, rather than have t=
wo
>>>>>>>>>>> functions. And in this case it's easier to do after merging.
>>>>>>>>>>>
>>>>>>>>>>> Do you prefer to return it back first?
>>>>>>>>>>
>>>>>>>>>> Ah I see, no I don't care about that.
>>>>>>>>>
>>>>>>>>> OK, looked at the post-patches state. It's still not correct. Y=
ou are
>>>>>>>>> grabbing the mm from io_sq_thread() unconditionally. We should =
not do
>>>>>>>>> that, only if the sqes we need to submit need mm context.
>>>>>>>>>
>>>>>>>> That's what my question to the fix was about :)
>>>>>>>> 1. Then, what the case it could fail?
>>>>>>>> 2. Is it ok to hold it while polling? It could keep it for quite=

>>>>>>>> a long time if host is swift, e.g. submit->poll->submit->poll-> =
=2E..
>>>>>>>>
>>>>>>>> Anyway, I will add it back and resend the patchset.
>>>>>>>
>>>>>>> If possible in a simple way, I'd prefer if we do it as a prep pat=
ch and
>>>>>>> then queue that up for 5.4 since we now lost that optimization.  =
Then
>>>>>>> layer the other 2 on top of that, since I'll just rebase the 5.5 =
stuff
>>>>>>> on top of that.
>>>>>>>
>>>>>>> If not trivially possible for 5.4, then we'll just have to leave =
with it
>>>>>>> in that release. For that case, you can fold the change in with t=
hese
>>>>>>> two patches.
>>>>>>>
>>>>>> Hmm, what's the semantics? I think we should fail only those who n=
eed
>>>>>> mm, but can't get it. The alternative is to fail all subsequent af=
ter
>>>>>> the first mm_fault.
>>>>>
>>>>> For the sqthread setup, there's no notion of "do this many". It jus=
t
>>>>> grabs whatever it can and issues it. This means that the mm assign
>>>>> is really per-sqe. What we did before, with the batching, just opti=
mized
>>>>> it so we'd only grab it for one batch IFF at least one sqe in that =
batch
>>>>> needed the mm.
>>>>>
>>>>> Since you've killed the batching, I think the logic should be somet=
hing
>>>>> ala:
>>>>>
>>>>> if (io_sqe_needs_user(sqe) && !cur_mm)) {
>>>>> 	if (already_attempted_mmget_and_failed_ {
>>>>> 		-EFAULT end sqe
>>>>> 	} else {
>>>>> 		do mm_get and mmuse dance
>>>>> 	}
>>>>> }
>>>>>
>>>>> Hence if the sqe doesn't need the mm, doesn't matter if we previous=
ly
>>>>> failed. If we need the mm and previously failed, -EFAULT.
>>>>>
>>>> That makes sense, but a bit hard to implement honoring links and dra=
ins
>>>
>>> If it becomes too complicated or convoluted, just drop it. It's not
>>> worth spending that much time on.
>>>
>> I've already done it more or less elegantly, just prefer to test commi=
ts
>> before sending.
>=20
> That's always appreciated!
>=20
> It struck me that while I've added quite a few regression tests, we don=
't
> have any that just do basic read/write using the variety of settings we=

> have for that. So I added that to liburing.
>=20
Great, thanks!
I think, I'll postpone patches including these until start of 5.5

--=20
Yours sincerely,
Pavel Begunkov


--CqCjm4AXnxroyZqHLeEfYWAFw1eFjB4Vg--

--i5bkzkjDhLVbrw7ROj8XCow8wOVHu95eE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl22zRkACgkQWt5b1Glr
+6U0fRAAj4teffPteuGV6bBcOazD+wOxdJrTAaDVaNz6yyE5Rqk+yxDHpQQQFQhm
EcW48n35ApX3nim6OJ1Qk/Oe6QKYKqHrGNoR3hN6FXs1S6D9NpZtZepc2i4wNAQL
tdcfKgnpXuZwPk8rZJL6r/gZ+WTy7qM2pCNz3kSWjKeWG0taVx42a3C/VN7sLLvA
glQOrr85EebcVc5EEfvE4rIpZQTO8u9KibBb3THSrdmf5fFr65NbdquxVqsJcO9+
7keg83+qnAeNQSL7ONpa/z6zkvBCwTFSxfPiqBUPl4OQr/CMb7LQEAPk5jv1nf8p
Kr3qlUPXxFUb4iwCD/UA2tAnpN4YGLYmNX7qqYr58r8WJZSKtLgOUQsQcIA6/cHE
ChceRv+WOMmpPZ6DOm9eA+3GuD6tJPEwuQix97t0/jjuGlhiMqyPADYkCyqUm+9H
SaFHPMfXMlz704cMeJRJTne+4mYcJUQ/0/jP+EZajo1Wo6CtrDJzwI0XPvo5yOBd
3zRSm5Z8YKqz8exuNHdhcrodnSsvD8mnFomRpK3bPmZeuH4eSVmu9Xt2Jq81Yp1l
pQ/FYKxBZMrLyK4Y5oQB5SOwkqMsZYkT9+KGOWojZvTAkFbq4h3HcsXD3sIiZEm2
AxvcxWjzGGbQZXI0ZB/Jx3OSBi8wi3RUwjKRyh5Xf0rVjaRWd1g=
=aEDW
-----END PGP SIGNATURE-----

--i5bkzkjDhLVbrw7ROj8XCow8wOVHu95eE--

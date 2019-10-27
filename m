Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C397FCA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 18:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBE220663
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 18:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti0Asg77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfJ0S4j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 14:56:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43035 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfJ0S4j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 14:56:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1so160191wra.10;
        Sun, 27 Oct 2019 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=bglhYZNTV9fu/FaMKsx75LDLd5rBW/Y1HGNA5hBVZ+Y=;
        b=ti0Asg77UTD6FscEp6lMH2+d75/yicn6dV1FhnZQJRBGsnEP3Snyi4ex9WexBZGaHA
         SslM7sua32icVQzUPXh2Flh5hItH61FyVCRKzw4I9jZcMpnyopZPaTxiOwSpFJz7T3HJ
         1FxsSvwTkZDHk7TfWdN1yarHiHEizip4dB1pje09TNWsF185iL6KFNsNXHFfsTGBxQ+c
         wLtm9fZWK6zOO+kiP782j5SxWat9GKA27ObqFl40zSs7mYBLAUlu2Dnm8uGwTsoMMb0b
         2ocX/tHoKIkKzNNhdDpX66hHFxv069wkRqZoLsA+uzNlk8TzwHpLYimKShk9rLDEMZwK
         efAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=bglhYZNTV9fu/FaMKsx75LDLd5rBW/Y1HGNA5hBVZ+Y=;
        b=Pe1tmcnFzKjwfOS+lZWEqY45E1ejFPz9FFSgXwvdSatq2drVWZoMcjyhE2FFHrXSDa
         Nx9s2v4pp9IMq7VCz3YxMC9k089Y6JcmEn1OPADxH9TV6+xGZr1y2ljPG3sSi+nBa0GJ
         8OML/rQmH+CqGNsUQm6PTy5nnEWuMVyW8EKD8ruxv7rNfSEt4tRUMjSCktFW+ilzLGar
         2vTJ9wAdSUsCWc4WIMIMmi41Lkh89+YcXvlwDKriHvdJ9oNu4e28ihO/sEnRz+lQI1/c
         /almTGe0c5wDAvR4ZFNoZPNfh+P2WC5A6iqozw0uBZ/EktFpPzBOvTzjjV6mpAV1e/Uv
         HQBA==
X-Gm-Message-State: APjAAAVqsZ9nL3TmXy1JWVWcvABA4k57YVdOBi/3UgGK3hnyxC22/d10
        bf6i5V+Vn8xETHvWrecSAPhJRn61
X-Google-Smtp-Source: APXvYqwUuiJP4FVrW5joN0Inbf/U0AeMhpjpfxJPV8to5WQAoCje2B5cb1j5apyDYaKy3YtYXm0kpQ==
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr11883943wrx.30.1572202595642;
        Sun, 27 Oct 2019 11:56:35 -0700 (PDT)
Received: from [192.168.43.222] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id o18sm11681605wrm.11.2019.10.27.11.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 11:56:34 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
 <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
Message-ID: <63f93f8a-4207-3ac4-a301-4907882009c9@gmail.com>
Date:   Sun, 27 Oct 2019 21:56:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Vp2yzNqpYwhZGc3iL1mKmga8SbEaDB7ub"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vp2yzNqpYwhZGc3iL1mKmga8SbEaDB7ub
Content-Type: multipart/mixed; boundary="Eb2tVtpzlHQDaZLrQKL6omfFvHBnfi3Uq";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <63f93f8a-4207-3ac4-a301-4907882009c9@gmail.com>
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
 <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
In-Reply-To: <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>

--Eb2tVtpzlHQDaZLrQKL6omfFvHBnfi3Uq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27/10/2019 20:26, Jens Axboe wrote:
> On 10/27/19 11:19 AM, Pavel Begunkov wrote:
>> On 27/10/2019 19:56, Jens Axboe wrote:
>>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>>> A small cleanup of very similar but diverged io_submit_sqes() and=

>>>>>>> io_ring_submit()
>>>>>>>
>>>>>>> Pavel Begunkov (2):
>>>>>>>       io_uring: handle mm_fault outside of submission
>>>>>>>       io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>>
>>>>>>>      fs/io_uring.c | 116 ++++++++++++++--------------------------=
----------
>>>>>>>      1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>>
>>>>>> I like the cleanups here, but one thing that seems off is the
>>>>>> assumption that io_sq_thread() always needs to grab the mm. If
>>>>>> the sqes processed are just READ/WRITE_FIXED, then it never needs
>>>>>> to grab the mm.
>>>>>> Yeah, we removed it to fix bugs. Personally, I think it would be
>>>>> clearer to do lazy grabbing conditionally, rather than have two
>>>>> functions. And in this case it's easier to do after merging.
>>>>>
>>>>> Do you prefer to return it back first?
>>>>
>>>> Ah I see, no I don't care about that.
>>>
>>> OK, looked at the post-patches state. It's still not correct. You are=

>>> grabbing the mm from io_sq_thread() unconditionally. We should not do=

>>> that, only if the sqes we need to submit need mm context.
>>>
>> That's what my question to the fix was about :)
>> 1. Then, what the case it could fail?
>> 2. Is it ok to hold it while polling? It could keep it for quite
>> a long time if host is swift, e.g. submit->poll->submit->poll-> ...
>>
>> Anyway, I will add it back and resend the patchset.
>=20
> If possible in a simple way, I'd prefer if we do it as a prep patch and=

> then queue that up for 5.4 since we now lost that optimization.  Then
> layer the other 2 on top of that, since I'll just rebase the 5.5 stuff
> on top of that.
>=20
> If not trivially possible for 5.4, then we'll just have to leave with i=
t
> in that release. For that case, you can fold the change in with these
> two patches.
>=20
Hmm, what's the semantics? I think we should fail only those who need
mm, but can't get it. The alternative is to fail all subsequent after
the first mm_fault.

--=20
Yours sincerely,
Pavel Begunkov


--Eb2tVtpzlHQDaZLrQKL6omfFvHBnfi3Uq--

--Vp2yzNqpYwhZGc3iL1mKmga8SbEaDB7ub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl216FgACgkQWt5b1Glr
+6X0eg/9GCtLSNmL6SuTeXQMOptSVKbpzvBFW2k3qqnt1TbVb8HFIwtIZlEDUEIx
o9TQyQcS+P6xQ598/KoQSCxyE9vuwqIeFx4dMwyY5iRlLUz51HExg9fc5j0NnjMQ
By1oahPhF4WIROiajy/AULL/WcNS8XRGRO4H1QtRos3esDVOUa6EiOLj97u/i05s
htuiut1hUrI2VZrHPVHKDD8548uiKaQJBKkINLp8ZhZUyUvf36Rg47/jx1ZIFjGm
R4kMguZRXcp8y5u1GpbUIweYBvrNC9rL8WGZrS1gag9LfAXClj4gUvP9VNG3Y3Zb
M1CQ75P30wsdaZxYFxyIvTZQ/zG807G5blPUMWW1igEskADgfzWArn8LgOVRkpt4
E1YQctsRUjDEvVTUybaLmZRyFl+CAbnNMz2SwsY3+0TQ2ICR09TlxPumkVFZ7hTc
gg3shySXZq9yltS3o26GKy9FJL/z9KQ23UCDJJnT7/5mZQDZfhjUs+IKdRdNTgDi
CKC5iiTjL/fDmM42wuGkWuyjHaw7NEwYATlOMlYQLp3LhuofHfFuaqXnqylXcWJj
0xLMivI79amwBVLXo/v7/deHw4p7wFkD0rjFkqVjxVmdLByL9gNp8NIvXa5NSRQC
HA/Erp7GK1aPbMN8jkDcbvTpCUS/K2e0lGg6mTIkytkfx8mGc8s=
=mPep
-----END PGP SIGNATURE-----

--Vp2yzNqpYwhZGc3iL1mKmga8SbEaDB7ub--

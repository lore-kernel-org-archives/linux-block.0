Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0118ACA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB03D2070B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSl9/puw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504243AbfJYQJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:09:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51509 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505000AbfJYQJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:09:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so2741023wme.1;
        Fri, 25 Oct 2019 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=czOp/T3npBk9C7fiqi3psxzMlnlBW16KpiLlubM9TIU=;
        b=QSl9/puwu+VnesPKmkdc3eFZGkXgZQicf9GPZhDluecppZCrvbnHLJ1kXmCPm5twv2
         BTHq7T8IZfZ4W2cEW8vaZ7yxQUh3jv+Dt7FR6UdAT2N+tfdWrntQJeXqAj6+0/lwHeQh
         n/mN1T9Jiwp/hOtvkHWbaVArF8vOfkWK0hp0Hqu1H6kDIqnu50ssxOOyMV8h/yzhbP5c
         k2kyTvCNS7sA66ahFPZl/6YViMNyKivdMqEhmso0jNmdoTG5VbqotkcYp6I39+kLDj1v
         7EmM9krke1NCXf7ZtbLPpy+cjethZn5bbG8ZKQJq17KIOf08wMiiApxrvyyABHFRZaHS
         Rx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=czOp/T3npBk9C7fiqi3psxzMlnlBW16KpiLlubM9TIU=;
        b=KvlGasa52lBLqiKBtwV4gmdHT6+MPd7ITED6V3nXYjc9UGXmQLyp9vU/hvgGZjYQQN
         bCbT6VHca7zGjfN/eCP6/8vvN5G9kOzZtFACIWFgxWZh8A+LL0Ci++di3v53ukFBIHrz
         JSb0vgM2br8uy3lporzWvsod/092R3bnbjvoaJez1zcdKEyVL9rsAJQ3jebw6nLRLv+6
         NGDYFAnp8Ol//W+TcOWQ0RTyJBZQUb5JSNfOpPJKy75pcIHihwSJ8iFSE1EIObEBL7+2
         h4Hnlu3R8tGDhSAFYploUdDyhPL7WtLuDUKRWgEcSY/VPp6NmpKso4+DW7HOr3E0KOmn
         6TnQ==
X-Gm-Message-State: APjAAAWuAXZXIrpooDf5Vh8nLik+hVztWn6nv01TnZT6PKTXzJ10L5KK
        R2iMkeXC/eIrX3bD0sGOyr5kj57o
X-Google-Smtp-Source: APXvYqygFN6qbQoX2q/x0BqEhMhkgEnu+Yw8/cmq5KfRaqc+cS2Sfv34oJE59unUbkQMrEO+Y4SAUg==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr4451896wmm.39.1572019743373;
        Fri, 25 Oct 2019 09:09:03 -0700 (PDT)
Received: from [192.168.43.159] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id r15sm5285766wme.0.2019.10.25.09.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:09:02 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <bfecc5ba-274b-b2f7-52dc-8ac6e0fab352@gmail.com>
 <539958bc-7010-c6dc-7647-b6632b37569c@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [BUG][RFC] Miscalculated inflight counter in io_uring
Message-ID: <360f9685-084f-b174-ccee-5bfe92d0ad3a@gmail.com>
Date:   Fri, 25 Oct 2019 19:08:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <539958bc-7010-c6dc-7647-b6632b37569c@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3bYw159Qj0hkd7JBLcDvVTAU4viat62Hs"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3bYw159Qj0hkd7JBLcDvVTAU4viat62Hs
Content-Type: multipart/mixed; boundary="0WzUU4ivWnv1xbLNJN5opq4NtI5HiCvnA";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <360f9685-084f-b174-ccee-5bfe92d0ad3a@gmail.com>
Subject: Re: [BUG][RFC] Miscalculated inflight counter in io_uring
References: <bfecc5ba-274b-b2f7-52dc-8ac6e0fab352@gmail.com>
 <539958bc-7010-c6dc-7647-b6632b37569c@kernel.dk>
In-Reply-To: <539958bc-7010-c6dc-7647-b6632b37569c@kernel.dk>

--0WzUU4ivWnv1xbLNJN5opq4NtI5HiCvnA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/10/2019 18:32, Jens Axboe wrote:
> On 10/25/19 3:48 AM, Pavel Begunkov wrote:
>> In case of IORING_SETUP_SQPOLL | IORING_SETUP_IOPOLL:
>>
>> @inflight count returned by io_submit_sqes() is the number of entries
>> picked up from a sqring including already completed/failed. And
>> completed but not failed requests will be placed into @poll_list.
>>
>> Then io_sq_thread() tries to poll @inflight events, even though failed=

>> won't appear in @poll_list. Thus, it will think that there are always
>> something to poll (i.e. @inflight > 0)
>>
>> There are several issues with this:
>> 1. io_sq_thread won't ever sleep
>> 2. io_sq_thread() may be left running and actively polling even after
>> user process is destroyed
>> 3. the same goes for mm_struct with all vmas of the user process
>> TL;DR;
>> awhile @inflight > 0, io_sq_thread won't put @cur_mm, so locking
>> recycling of vmas used for rings' mapping, which hold refcount of
>> io_uring's struct file. Thus, io_uring_release() won't be called, as
>> well as kthread_{park,stop}(). That's all in case when the user proces=
s
>> haven't unmapped rings.
>>
>>
>> I'm not sure how to fix it better:
>> 1. try to put failed into poll_list (grabbing mutex).
>>
>> 2. test for zero-inflight case with comparing sq and cq. something lik=
e
>> ```
>> if (nr_polled =3D=3D 0) {
>> 	lock(comp_lock);
>> 	if (cached_cq_head =3D=3D cached_sq_tail)
>> 		inflight =3D 0;
>> 	unlock(comp_lock);
>> }
>> ```
>> But that's adds extra spinlock locking in fast-path. And that's unsafe=

>> to use non-cached heads/tails, as it could be maliciously changed by
>> userspace.
>>
>> 3. Do some counting of failed (probably needs atomic or synchronisatio=
n)
>>
>> 4. something else?
>=20
> Can we just look at the completion count? Ala:
>=20
> prev_tail =3D ctx->cached_cq_tail;
> inflight +=3D io_submit_sqes(ctx, to_submit, cur_mm !=3D NULL,     =20
>                                              mm_fault);
> if (prev_tail !=3D ctx->cached_cq_tail)
> 	inflight -=3D (ctx->cached_cq_tail - prev_tail);
>=20
> or something like that.
>=20

Don't think so:
1. @cached_cq_tail is protected be @completion_lock. (right?)
Never know what happens, when you violate a memory model.
2. if something is successfully completed by that time, we again get
the wrong number.

Basically, it's
inflight =3D (cached_sq_head - cached_cq_tail) + len(poll_list)
maybe you can figure out something from this.

idea 1:
How about to count failed events and subtract it?
But as they may fail asynchronously need synchronisation
e.g. atomic_add() for fails (fail, slow-path)
and atomic_load() in kthread (fast-path)


BTW, tested the patch below before, it fixes the issue, but is racy
for the same reason 1.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 32f6598ecae9..0353d374a0d5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2650,6 +2650,10 @@ static int io_sq_thread(void *data)
 		bool mm_fault =3D false;
 		unsigned int to_submit;
=20
+		if (ctx->cached_sq_head =3D=3D ctx->cached_cq_tail +
+			ctx->rings->sq_dropped)
+			inflight =3D 0;
+
 		if (inflight) {
 			unsigned nr_events =3D 0;
=20


--=20
Yours sincerely,
Pavel Begunkov


--0WzUU4ivWnv1xbLNJN5opq4NtI5HiCvnA--

--3bYw159Qj0hkd7JBLcDvVTAU4viat62Hs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2zHhkACgkQWt5b1Glr
+6W7Jw//SuE0SoblGLuvDRJtkosrptF/I1AHKK1/CRtOsHQnxRe/B8NFDGBGnpxV
NcypD8qX02G4S+9oYGy7Nx1GkoF1qlGF+LKbzNyaKRsR4pKnc/4kfwk97uq2fPm1
NI+gjB9AU8n9cte0QKIKrknGyXWla+gE+O4xY9PBI/SBh9sWOubbLzlboaeFgE6P
aByOg61ClX30+YObERTbXlTT7a4t2Raey8qTQvw4ALwTQe1oQQ/hdESPpjgcKFZV
adH/qzSeYM30+nkCo9AnpFEX4VPB39ARqgp2GkYX9/flEzTKHEMu3pdenIDCf/fr
koD1WWiRk+WXYclUGa2dz68jArpO2Pi+qeel3foZiK4iIx6o5DvfPoAIj5U6+4UN
iJgYUw52piH/NMDs/KY60THm33b84QYjhRKcKvME9KSgR2qcr2jVpBiWWmxr5ORT
d+1n2i0Fjq3R+VHqRHVAv8xn7qrNb5o49FTo8RMmzfdV99SNpNfU98TtOivrq6ox
+IgNclqWE1mwjC6lo1UKjdCWRaaIdB9/IFVi/hl7180wlPl9V0fCP/b+hgHYCze2
TBFPDLKXCy5lwGiA+oUUte8YLirEFny9rY2YULkl7kX+6OJB6q1XDxVvZHK6TsQV
MJ7N1FJn68BNbXcjo9d6F5Q9QWnK6LjGxSrN/s2bLJAKdn7j/r0=
=VAag
-----END PGP SIGNATURE-----

--3bYw159Qj0hkd7JBLcDvVTAU4viat62Hs--

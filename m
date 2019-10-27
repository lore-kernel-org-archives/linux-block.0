Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320BACA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31C020873
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPjlymui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfJ0TRr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:17:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55221 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfJ0TRr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 15:17:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id g7so7229842wmk.4;
        Sun, 27 Oct 2019 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=g+1BaCYbcqYqJTcRj92AAC72Bmx4eyYJa653RkiqdAk=;
        b=dPjlymuiWEKMstcfD4wkUwIn/nab0NCR9hZwH/tLSUDV+yly4QMzARhwhPaDQFUC1b
         2VvFru4yZVRTPt9uJttqE3QwnHMGMUt4Z8cRQvBjF5Azs63R6Af+sUUZ+8eHiNnagjfa
         rKJWWd0EoNVi7xrH5X9nic1APE21P+6pVDBGXlnVrEoaO4FMHN0EwMWBgBwNus3CagrE
         yMRRfdmPdj6r33RsHqoiF6lW74K21HDhAVLINAfMGkk1whEx2CxHjjzG81c6wP8Dp2No
         VjZHcjTO99MFWkcM/G6f95XAsXkXp8FmEYdf8RIefQzHc7LPVDgL7O8r15rsQfielESR
         V6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=g+1BaCYbcqYqJTcRj92AAC72Bmx4eyYJa653RkiqdAk=;
        b=oeRX39oHmWRg8BeUvbzs3MNSHb3VHNcOLwISD4M8L3mnR2GEkDyQFkOqUbSj8rfavi
         Sq67mj/Uns1VRraiKYGCg+W1QkZBQV+N4Lwd1jHQIDFjOl38byiuqCCMHaDXaweJAWh+
         AxYOk1SsjOiAtpZQ/pSqrWSltlkSbTElcc61LzZoQIzLsd1FnUye7lUBbMGc73n3QXq+
         /8L0q72XBJUHtDXs9tzpSORsQmXQWtWgKUJd0eZULapdyAKtmR8/aADdUlHXJvRE9xUU
         F60DGNVdAoYUvOC/AtTSiybObJHNpN4aprkNFFgKcngim+NXRhgqQqTbcphmtaw51uxe
         rKAA==
X-Gm-Message-State: APjAAAVK8nfyJ1P/IBTt7SRTSEAxXaOmg9uQazMAcl6yxbGlMXG6kVe6
        Lw+ppYTaDD1jf+Pvaqag0Cl5NCoK
X-Google-Smtp-Source: APXvYqzLuuf1xjb/j2bn75MgYgkK9FYEN/2Vr7df4hI8agUWD99eg5pL9n0Nw2GpDJr8cfHU4Tyniw==
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr12412370wmd.19.1572203862923;
        Sun, 27 Oct 2019 12:17:42 -0700 (PDT)
Received: from [192.168.43.222] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id p12sm8966934wrt.7.2019.10.27.12.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 12:17:42 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
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
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <3b8b84d0-cde2-6bb0-c903-a1d71f9b83e2@gmail.com>
Date:   Sun, 27 Oct 2019 22:17:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <728dec9c-465c-2341-d7b5-929a50400e9c@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kP4hwIaGn6GdQ4ijPDmqXMwGoX0Pxxviy"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kP4hwIaGn6GdQ4ijPDmqXMwGoX0Pxxviy
Content-Type: multipart/mixed; boundary="QK5GLNxwTN9ZtXPjaRlDGaVhxJjmv9gVZ";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <3b8b84d0-cde2-6bb0-c903-a1d71f9b83e2@gmail.com>
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
In-Reply-To: <728dec9c-465c-2341-d7b5-929a50400e9c@kernel.dk>

--QK5GLNxwTN9ZtXPjaRlDGaVhxJjmv9gVZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27/10/2019 22:02, Jens Axboe wrote:
> On 10/27/19 12:56 PM, Pavel Begunkov wrote:
>> On 27/10/2019 20:26, Jens Axboe wrote:
>>> On 10/27/19 11:19 AM, Pavel Begunkov wrote:
>>>> On 27/10/2019 19:56, Jens Axboe wrote:
>>>>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>>>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>>>>> A small cleanup of very similar but diverged io_submit_sqes() a=
nd
>>>>>>>>> io_ring_submit()
>>>>>>>>>
>>>>>>>>> Pavel Begunkov (2):
>>>>>>>>>        io_uring: handle mm_fault outside of submission
>>>>>>>>>        io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>>>>
>>>>>>>>>       fs/io_uring.c | 116 ++++++++++++++-----------------------=
-------------
>>>>>>>>>       1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>>>>
>>>>>>>> I like the cleanups here, but one thing that seems off is the
>>>>>>>> assumption that io_sq_thread() always needs to grab the mm. If
>>>>>>>> the sqes processed are just READ/WRITE_FIXED, then it never need=
s
>>>>>>>> to grab the mm.
>>>>>>>> Yeah, we removed it to fix bugs. Personally, I think it would be=

>>>>>>> clearer to do lazy grabbing conditionally, rather than have two
>>>>>>> functions. And in this case it's easier to do after merging.
>>>>>>>
>>>>>>> Do you prefer to return it back first?
>>>>>>
>>>>>> Ah I see, no I don't care about that.
>>>>>
>>>>> OK, looked at the post-patches state. It's still not correct. You a=
re
>>>>> grabbing the mm from io_sq_thread() unconditionally. We should not =
do
>>>>> that, only if the sqes we need to submit need mm context.
>>>>>
>>>> That's what my question to the fix was about :)
>>>> 1. Then, what the case it could fail?
>>>> 2. Is it ok to hold it while polling? It could keep it for quite
>>>> a long time if host is swift, e.g. submit->poll->submit->poll-> ...
>>>>
>>>> Anyway, I will add it back and resend the patchset.
>>>
>>> If possible in a simple way, I'd prefer if we do it as a prep patch a=
nd
>>> then queue that up for 5.4 since we now lost that optimization.  Then=

>>> layer the other 2 on top of that, since I'll just rebase the 5.5 stuf=
f
>>> on top of that.
>>>
>>> If not trivially possible for 5.4, then we'll just have to leave with=
 it
>>> in that release. For that case, you can fold the change in with these=

>>> two patches.
>>>
>> Hmm, what's the semantics? I think we should fail only those who need
>> mm, but can't get it. The alternative is to fail all subsequent after
>> the first mm_fault.
>=20
> For the sqthread setup, there's no notion of "do this many". It just
> grabs whatever it can and issues it. This means that the mm assign
> is really per-sqe. What we did before, with the batching, just optimize=
d
> it so we'd only grab it for one batch IFF at least one sqe in that batc=
h
> needed the mm.
>=20
> Since you've killed the batching, I think the logic should be something=

> ala:
>=20
> if (io_sqe_needs_user(sqe) && !cur_mm)) {
> 	if (already_attempted_mmget_and_failed_ {
> 		-EFAULT end sqe
> 	} else {
> 		do mm_get and mmuse dance
> 	}
> }
>=20
> Hence if the sqe doesn't need the mm, doesn't matter if we previously
> failed. If we need the mm and previously failed, -EFAULT.
>=20
That makes sense, but a bit hard to implement honoring links and drains=20

--=20
Yours sincerely,
Pavel Begunkov


--QK5GLNxwTN9ZtXPjaRlDGaVhxJjmv9gVZ--

--kP4hwIaGn6GdQ4ijPDmqXMwGoX0Pxxviy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl217U4ACgkQWt5b1Glr
+6XWAA/+OZ4ye6Xxgf03JzgJEdG/lmvV9Yquv5Aeh6nGf+3QCj7iCWZ4dkWFkRsb
ub45a/8wEEf8F4NgJwbH0U2zfeKUthzGBJXGgnIXveoSo3xZJYWUhiXMOukC32CZ
yVUDIUCuj/htN+Gao1D+2EeFBsiNuEKSem+4vmq6Jo6m3ITleDWv5V7tJiT0ANpT
dwHeFldqvZXd9L+iZmH4S5HDqMQWk2gZjYfmahbOD6qmuPrUeGpfiGkeNxCI3c2E
1ubZgVGSBKbiEg7zSFpsdSBsIJCXSiuCKaK9gzgZy4MD4g3lXmgPvFVpfuOXzo2A
5xDnAH1/J2pSY3v+EwIA+Fsoa4cZ+u6h/iUz2FZNpjNqcIViv6AQfgsDVwN0fXnE
f54AgU+DougnsE9nhtV4hIzfvfQuGZKH6fchpuMGWquhwEE7wVHGemxVyg3UHO1N
7uEF5M3bRpt0cv7QADsbDt7bdBoiGAHT6Kdf7eNRGQ/HxriKmD9GNtjcsx++3tUI
Exv6H0XdK1+f4ggKamxIcFWycY7f6KXsi9S2CGtJ5eZ4dTsk7nyoAFmr6Kth3vS5
7dSsm2iaZlXME8m3bTFeGtxruF90EaiTcdV69DH58tUPRoYlEHPXulzJlD01RwLp
/o5ofqt/caY2cXb3mrsnLUzKh1sSjLd54PCxk2uYh8vKenqU+9k=
=M3RG
-----END PGP SIGNATURE-----

--kP4hwIaGn6GdQ4ijPDmqXMwGoX0Pxxviy--

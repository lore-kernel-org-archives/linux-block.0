Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66445CA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB4520650
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoDKsyHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfJ0T72 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:59:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52803 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfJ0T71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 15:59:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id p21so7296264wmg.2;
        Sun, 27 Oct 2019 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=VKd7uUdXkNBUHQDeXQk53nwNyJLXkfZWDjObuvC3Axk=;
        b=uoDKsyHygMSAlr790+tMA/Wyh+OUA5Yx1pgPoY0/0E33/gT/ghBSHdyaZOCrTtplZ3
         vCSL0DJNkRHH6eTi3xdnyjoX1Y6ojoPPs5arCoSOObGE1WUGDudrJcsPvYZuHhQkRXRN
         lKEiMP05NRXu8YGOvEdXoVTAfN9Kxh4HPpLl4nEQSVA0yMVGKzrbcjKmqvABd3Xx4ovP
         m8XFfElVl5D4uFNQGdxna6RFeS/e7Wa0mHcv+KWL4g+B67RwWe7wtifjfGItqIHZvltJ
         Fnh0zzqXIi0VWhliFdl5aVc1UT9nMiB/9nGE055vUimY8j6mzcEUnT624SX503KPZdAJ
         dOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=VKd7uUdXkNBUHQDeXQk53nwNyJLXkfZWDjObuvC3Axk=;
        b=H+/mbLyiMNZ3HV1/h101XddikXnATBycILTxSul19NVNAb/vxCYwo2LRFLbFTWRfHG
         xmxql3JuO7cgOgAiBE2F6wjnUpw+AHZr+Rr/a/PL75XTsOAH4uaz8YdVhhFXfQmV7sIg
         Q8x7oZfD7hCrXNwKpLGgSjC+CwceWTl7ol2nZvINFHbCZQ3BYqtm2p/wH9wXNI9mqe/E
         nnpAuOWLVHLrO6b2gtaZASlSZcf72LwXApAzG2DecPHNbLjHF8lCrAuaQuw9qgwJEvMg
         O9cYGBe6cv1oRfbnKvIcE2BLmDHYlq7ubZrP9MPhXH56K8Xr85/zflTed3f+pjYhJqzo
         E3tA==
X-Gm-Message-State: APjAAAXvDumzy9VPR9Q6QF95jADshAM2q5oh+PNyIrALjVFIbmTnFQ8O
        DK+PLGHZYa/JgiJsedup94MnLRe1
X-Google-Smtp-Source: APXvYqzGkjFfG36XjBfTb/ypm4dB8+miuWXHAIrO23veBSZ4HMqYyrmJa8LI+E3EjojypcpVFNkS2w==
X-Received: by 2002:a1c:234c:: with SMTP id j73mr13416640wmj.51.1572206362179;
        Sun, 27 Oct 2019 12:59:22 -0700 (PDT)
Received: from [192.168.43.222] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id z9sm9772435wrv.1.2019.10.27.12.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 12:59:21 -0700 (PDT)
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
 <3b8b84d0-cde2-6bb0-c903-a1d71f9b83e2@gmail.com>
 <3957148b-0dac-a621-8f12-5d2d45557e24@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <1e0ae1a6-6b8b-a78e-8ec0-fb7aa5972d00@gmail.com>
Date:   Sun, 27 Oct 2019 22:59:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3957148b-0dac-a621-8f12-5d2d45557e24@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GObgO3sOgC8ah8HnT4oBuFA7qjQujGt2y"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GObgO3sOgC8ah8HnT4oBuFA7qjQujGt2y
Content-Type: multipart/mixed; boundary="98fVirafzizKudZWDtPLXNCuHEz27QghD";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1e0ae1a6-6b8b-a78e-8ec0-fb7aa5972d00@gmail.com>
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
In-Reply-To: <3957148b-0dac-a621-8f12-5d2d45557e24@kernel.dk>

--98fVirafzizKudZWDtPLXNCuHEz27QghD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27/10/2019 22:51, Jens Axboe wrote:
> On 10/27/19 1:17 PM, Pavel Begunkov wrote:
>> On 27/10/2019 22:02, Jens Axboe wrote:
>>> On 10/27/19 12:56 PM, Pavel Begunkov wrote:
>>>> On 27/10/2019 20:26, Jens Axboe wrote:
>>>>> On 10/27/19 11:19 AM, Pavel Begunkov wrote:
>>>>>> On 27/10/2019 19:56, Jens Axboe wrote:
>>>>>>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>>>>>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>>>>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>>>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>>>>>>> A small cleanup of very similar but diverged io_submit_sqes()=
 and
>>>>>>>>>>> io_ring_submit()
>>>>>>>>>>>
>>>>>>>>>>> Pavel Begunkov (2):
>>>>>>>>>>>         io_uring: handle mm_fault outside of submission
>>>>>>>>>>>         io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>>>>>>
>>>>>>>>>>>        fs/io_uring.c | 116 ++++++++++++++--------------------=
----------------
>>>>>>>>>>>        1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>>>>>>
>>>>>>>>>> I like the cleanups here, but one thing that seems off is the
>>>>>>>>>> assumption that io_sq_thread() always needs to grab the mm. If=

>>>>>>>>>> the sqes processed are just READ/WRITE_FIXED, then it never ne=
eds
>>>>>>>>>> to grab the mm.
>>>>>>>>>> Yeah, we removed it to fix bugs. Personally, I think it would =
be
>>>>>>>>> clearer to do lazy grabbing conditionally, rather than have two=

>>>>>>>>> functions. And in this case it's easier to do after merging.
>>>>>>>>>
>>>>>>>>> Do you prefer to return it back first?
>>>>>>>>
>>>>>>>> Ah I see, no I don't care about that.
>>>>>>>
>>>>>>> OK, looked at the post-patches state. It's still not correct. You=
 are
>>>>>>> grabbing the mm from io_sq_thread() unconditionally. We should no=
t do
>>>>>>> that, only if the sqes we need to submit need mm context.
>>>>>>>
>>>>>> That's what my question to the fix was about :)
>>>>>> 1. Then, what the case it could fail?
>>>>>> 2. Is it ok to hold it while polling? It could keep it for quite
>>>>>> a long time if host is swift, e.g. submit->poll->submit->poll-> ..=
=2E
>>>>>>
>>>>>> Anyway, I will add it back and resend the patchset.
>>>>>
>>>>> If possible in a simple way, I'd prefer if we do it as a prep patch=
 and
>>>>> then queue that up for 5.4 since we now lost that optimization.  Th=
en
>>>>> layer the other 2 on top of that, since I'll just rebase the 5.5 st=
uff
>>>>> on top of that.
>>>>>
>>>>> If not trivially possible for 5.4, then we'll just have to leave wi=
th it
>>>>> in that release. For that case, you can fold the change in with the=
se
>>>>> two patches.
>>>>>
>>>> Hmm, what's the semantics? I think we should fail only those who nee=
d
>>>> mm, but can't get it. The alternative is to fail all subsequent afte=
r
>>>> the first mm_fault.
>>>
>>> For the sqthread setup, there's no notion of "do this many". It just
>>> grabs whatever it can and issues it. This means that the mm assign
>>> is really per-sqe. What we did before, with the batching, just optimi=
zed
>>> it so we'd only grab it for one batch IFF at least one sqe in that ba=
tch
>>> needed the mm.
>>>
>>> Since you've killed the batching, I think the logic should be somethi=
ng
>>> ala:
>>>
>>> if (io_sqe_needs_user(sqe) && !cur_mm)) {
>>> 	if (already_attempted_mmget_and_failed_ {
>>> 		-EFAULT end sqe
>>> 	} else {
>>> 		do mm_get and mmuse dance
>>> 	}
>>> }
>>>
>>> Hence if the sqe doesn't need the mm, doesn't matter if we previously=

>>> failed. If we need the mm and previously failed, -EFAULT.
>>>
>> That makes sense, but a bit hard to implement honoring links and drain=
s
>=20
> If it becomes too complicated or convoluted, just drop it. It's not
> worth spending that much time on.
>=20
I've already done it more or less elegantly, just prefer to test commits
before sending.

--=20
Yours sincerely,
Pavel Begunkov


--98fVirafzizKudZWDtPLXNCuHEz27QghD--

--GObgO3sOgC8ah8HnT4oBuFA7qjQujGt2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl219xUACgkQWt5b1Glr
+6X0sA//V+BYQKiamHWh1HPokONtr05Z/HWGZ0EgdLJQ6qtvgVEZgzgfCFBKgfpy
F04f4ok66I881D5iA7sRWP5lCDi/+mVzGPUPkG05MSwfR3UXEi3uryPcbCWCdFvi
9mZjET8cV2WfBesN+Ag5rVIw0EK840ngMoIXCA+78zNzbJ6zzU92x7vIodpb+SKw
hULhcatfUR0PmkGq1u+bs3AWC9NC6rhMGD2H94XFVbSw/Q6K9EX+e0Th/ylSy5uG
RAI4Ft6c6mYY7EgWVnwaBr+zwCZdFDQaj6HdFr75r1crHklRtwDdI7hC4IRwUXK3
z0uW8TTb45GCpaLF33RrdClCTyhJeyARBdrmHOxFQlArUNojpT1j3pnH9hEIntBE
v9HHuBPyyTlNGiUPcxtyNXfkNCiPaVcsxoI6/5My7Znj36hdSSLVrqhpkL0g4QVP
3e9SeQuenn7FxFhWgA9XDfgM3MBy6UQ22x7P8EG3LH37WZOM++Dc//zDPac/ipo4
jxAfpWlUGWme3GSi+m7DMduYdwRMCHuZMrR4HAO1PO+uMW2mheH5bp1BEn2CCZpb
ksHakwY6ZQz26agfd4L6IBeGjMWHdA//nJxmLyVupYhBmBKYm6RlDUQQf/FZJGPM
ibDKaG5NJKWVpK6pDUL9/0XSHSNGWc0YxhJXyOMd1PlNez5BHss=
=QojS
-----END PGP SIGNATURE-----

--GObgO3sOgC8ah8HnT4oBuFA7qjQujGt2y--

Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDC303A0A
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472793; cv=pass; b=ieO3lLeM6FLnQGA+DXh+5jcqP5diOQ4wf7XeUR94s6RhYhay1d05I861RXKqSE7xvp/8/72Qrxw69iEiamqkiqHX9xQ+yaMTGozh8fz3RupllcTb64E7ZbLyHrjcRM21gPJsF8OFkQm3MoNfPRvLnqpvi3ixFucY9CVJ89b9+Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472793; c=relaxed/simple;
	bh=7xI9AQ6tZUuFKwMUeQZHIpwamqGIWKJrJNxNM4JnsE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bq62Y07e8bMcK9IV7KyqEKwq/6vuhx9QbE6yUtl0foWkRcOqRoIKAqSbe4IQxvK8Wd2SWKqtmS8xojJlmAD/8MUeOHyVWGhqOuKmbs3vZRkqFAgzegHqNu0t5THf0ERR9fhk95OmLjyzN56kIDq12GzGPjyYFe94V89LTFt7a+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=I05XuEn5; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="I05XuEn5"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38be5e86918so142221701fa.3
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 07:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472789; cv=none;
        d=google.com; s=arc-20240605;
        b=NK6ohptz/VKyEKBvPgwbJ+1RdNj/hYIKV6W6GlSIbVhC+26GOctLZl/8sJu5kxZ8q4
         KPoam0LBnFklAjavN0/dbKV6NP9DdJR0aadmM58TlhHCeOlSt4kisuzKktZZVr48mrNm
         RJXLFNgTC4adkFLMWEZGj/owB24x2AtbNdSvgZxQTA1NsIavxA/2MDps09ONkWLzHWzx
         GYOcDt9p5Y/ocNb9Nb/DJ92emtvIHj7xA8TRAEVNVGnyKY9HE1vGaa4hLFVjdfL/ZZIz
         tLWM6J6ueKixkbQYQ5s3UWO0KdnvtxE26a3ZcSXdSbf9WJv4XWwotBVX6fWIU2/XvPvN
         WVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7xI9AQ6tZUuFKwMUeQZHIpwamqGIWKJrJNxNM4JnsE0=;
        fh=5sBAdvXtvf6UAjszU/YRgoWsujL+bzv5KF8WpPgZPF0=;
        b=EqNCVrc3avGTeGd9DZoKSlPyWTcKSGXpa98rZu82eTn7b1NM7RGAQ5VKtw6fDkUThi
         19rQE4EyZy+R5+kPwDlMmBYyzqMGra2XEIz+1enYEV9Okp7FFUhfojTWHXzvgD9BPhB9
         4KGy7byHbReEMMAowNDXRxsJVmda0QPiVWm65RqeieZA9op54iBt4D+SY4jdzma2Pzt0
         QV6qO3sDAwvpX9QGYvPByPLHyuCpyPhy3tI1oA5Ln7l7XcbJcVL9yTIAdc5UGp6doQII
         yhn/tdWqO9niNtmJ34M/iWhxH3rkRh8eOSxepHRMbrQqxs2AbZFE85Llht+k46im4XXG
         iNBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777472789; x=1778077589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xI9AQ6tZUuFKwMUeQZHIpwamqGIWKJrJNxNM4JnsE0=;
        b=I05XuEn5yDlVti1D7ti7dpl4MN3sx8bVC1MVe84z5NovGAPJfnbHrvfjRaN5bo4kfA
         phrvLK10EfXR/zCSPPhr/0ifZXMj3Bh8CP/icnbZsckpRYWoMaOzPZ/WwmlFs1/Dqk7l
         SU3BDtSWuGvYoz1HEY+n8A1Rds22SfjApMzC9IsnNML1MXL7X2f7L+zTsT+H/9cXpqZx
         1T2vzzSFeoKF5nBEY3NqDZ+WOn73nxvk4VK+PTGFVyr4cJo2iLc9kZm5gYvcOBs0Qa35
         VrgW2YzvcvERfFBsDw9eKM0MhCGV/QaEVZnYxlQ/GEH59J1jMEhzRkJHpIaWGNkSTHwy
         EFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777472789; x=1778077589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xI9AQ6tZUuFKwMUeQZHIpwamqGIWKJrJNxNM4JnsE0=;
        b=lins0bFwgPKNBOBd35XVP2CMXEcMakLilEimoyHA6XxCEIj48LT2wxUyeasJop6XXO
         /BnsoV4rtasGpCLxEsaRVDtSdvd6DQxu/aEoxAWvb4f2ZaoX8gquKNW6HtutnW5hW1rm
         fknIBUy7PMmdlH+XVu3bEc9EwaLH7wYdFPt4I6zeuQqAhHr1LLcAD00xXA9Sw1b2sgUG
         mSk0tns1H+AkiS9dTdjTJQK4TYLcCv3+a2FO/NX+qL4cb6cnialJsb/XeiGgnx46Jebf
         AnxxnLtoNYcDaKpUeuUbzQfNZ3G+jXSMwLETmJ64SmIjxIdXZmXNGA8KV86ln438rbYj
         Ux7A==
X-Forwarded-Encrypted: i=1; AFNElJ9Dpla48uZhGI8s2tJnCTiCg9rdJ9fVJjxJiC2Stm1gO/T6gco0myidViS1F6GRxrhmGgfFHHs+aPDuWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKghVrUbBvimBkBQnHcBsSh0R9NKCLxpOwtc6JNj+uorh9rO/
	0Ekj87c1U0bDQ6QIBmqqBwH6HjNnhX+tKDf0FqCpY/lfxiP5hkZ8782atP+5qNIJwD/zj1IOmJg
	2L40o8ko11eYCEWHm+ovlZEnPS4D89f9Jukh4qnDqBg==
X-Gm-Gg: AeBDievczSsaM781UdUvvAhAGfEgMTeI+Ma0YTmOqjmsFNm3DAFQG0FfNKHHRreDvk3
	ZHNgGfqrLubxCoD8STkFx7dVuDUkkcbMCwnGHvW6DbmNfsRXmujNE9GiEn/3NgjW6/cZjtOS5Ar
	33pCqPwK+yBpDk94cY+JlW7qahGYu+jJILaLsvx9V08wXfkAigOzhzGNbIqhZUuYIJgN6Gxkxlu
	P6VURwTmWkYcSGlSwWUdDvmId1o4cLMILyZbX3BOLWIn4jGR2mlbjYY6LkQMqJfVVNJvMFhZbh4
	j1W1wc7S65huAap/s8bflV3pNsqkiR5un6FMgzOM2+mmVh/EK90m0oggiqc5TS9uxqxnnGAzN1n
	es54=
X-Received: by 2002:a05:651c:23d2:10b0:38a:902:dcd with SMTP id
 38308e7fff4ca-3924bcdeb13mr12504311fa.20.1777472789037; Wed, 29 Apr 2026
 07:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <7aca0686-b255-4ece-b766-ebfc90df7340@acm.org> <CAJpMwyha9Tuzn1nEDvfPbdaPFa6WbVBO91QoPEKJC+DB7V4PBw@mail.gmail.com>
In-Reply-To: <CAJpMwyha9Tuzn1nEDvfPbdaPFa6WbVBO91QoPEKJC+DB7V4PBw@mail.gmail.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 29 Apr 2026 16:26:14 +0200
X-Gm-Features: AVHnY4Iwf5MmMYkExI68LxCrn43SXMOiFXgqjdVHXqxda9PoZwxmIJwNjUWSrxY
Message-ID: <CAJpMwyiPYNKDn74NA_cKovFUZ7-gUnKgayQ0jf-h907rLZqDZw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication solution
To: Bart Van Assche <bvanassche@acm.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 11:43=E2=80=AFAM Haris Iqbal <haris.iqbal@ionos.com=
> wrote:
>
> On Fri, Feb 13, 2026 at 6:32=E2=80=AFPM Bart Van Assche <bvanassche@acm.o=
rg> wrote:
> >
> > On 2/3/26 7:09 AM, Haris Iqbal wrote:
> > > We would like to present the idea and internal workings of the
> > > solution, and also discuss design and some benchmarking results
> > > (comparison with RAID1 over RNBD/NVMeOF devices, or DRBD) during
> > > LSF/MM/BPF. We also want to get feedback, and potentially get more
> > > people involved in the project.

Hello,

As mentioned earlier, we have open sourced the RMR+BRMR code and the
documentation is also public.

https://github.com/ionos-cloud/RMR
https://ionos-cloud.github.io/rmr.io/

> >
> > Please prepare for the question why the choice has been made to
> > implement this functionality as a new kernel module instead of
> > integrating this functionality in the DRBD kernel driver.
>
> Hi Bart,
>
>
> In short, it was mostly because of 2 reasons.
> 1) We wanted to keep the "single-hop replication and syncing" offering
> in a generic transport module (RMR), so that it can be used re-used by
> other modules in the future.
> 2) We think that DRBD=E2=80=99s core abstractions (per=E2=80=91node peer =
replication,
> single lower device) are orthogonal to =E2=80=9Cactive-active replication=
=E2=80=9D
> model.
>
> We can discuss this further during the summit.
> I assume when you said to "prepare for the question", you meant the same?
>
> >
> > Thanks,
> >
> > Bart.

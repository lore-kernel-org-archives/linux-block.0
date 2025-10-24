Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C828DB56
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333766; cv=none; b=tKPDq5bMheiYPMWIHwAJs877tHiDNhTYOdNFJF0aqh/OTLWkVWYYjU0BIX0tdj46ZTOwrLQG8nR4Q7StVLztovyrwq/2mCxMKNg0O8FOImG2H4+3SmoDOybxpWtuy7j/kVncCHxjg1MXL/Hw+bHCPrtFsuQ3doLgaBD2PN9uLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333766; c=relaxed/simple;
	bh=QgsR+Vv3MGDc6mihpTVQXoOx12Z77gAlV2xrGnLO6/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQSXj5ULwCYpGn6bxyNoKTN/kRYeP7u3aMzS28xBhBoNTeimI3qi/AHgXzFVZgbKWqsEL1vPf1xr6R+KwO6eje1WAeTXv3AX4uBkrujW1/ttMi0faHhpu1b1Lp61JCZrtKLhRjjHwiR1vnrH2TxUy4H53dbePk6dole2MtWLloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPjfy8RF; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPjfy8RF"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e886550a26so11323611cf.3
        for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761333764; x=1761938564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgVsq2p7ysLPME1WhWajPgNYUjlNdQ3sSEmcEy2qO6w=;
        b=BPjfy8RFaXc653UEcDt7aXACeN5dBOMeuj4rA77Emfracun9ngFDcRYifmFpEP2AXK
         5m8C22v7SdieEVE2rVxNAFRd/1Xc35kZLKBy9wl7zSvt2qfcQnsXmcsAFF7cUA9LNkqA
         SytL4/F3PHlWEKaUTFmlran24Xb9TNKnOV/BhYmhBRFHM2OSm4FiJ1/DcbkRJ7ZXYK7X
         FumnweK7iumntqEMKm94QaR5Ssc6S0OVZDEMIUPAiOuAsHk6xqnswWbBWDWKTs3IOcAI
         wTJ0muof9YdKtxEpxjMCIbnAISM/wVevoa9m7D+4RcHdqFPfObTHJLDHDL+NXhaTzDW5
         zUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333764; x=1761938564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgVsq2p7ysLPME1WhWajPgNYUjlNdQ3sSEmcEy2qO6w=;
        b=KxINe8ZIBqrG2RNSbGkV3DYeWzq1wXvIHCGIhVCbK1ka2B2SuXg7wSslckQ7oqkIvP
         SkGqkjY96K7JtCnllmcasVBQ3Zr//BaiA7MKh4cDrr/+TfrRwo++rdNyzZmqa40tVjVX
         SDAvELjwkoJTt/uMfg2L/5L+34zfBgSQVGDgLse3DrTIQMxskvgQ15qbsPViBHkI9hRf
         b5y+R870b4K2MY18qH1HJw1rmX+IPW/Cfs1wLEU5J2S6r//wFqXlpMJNP+aP6ecB4GPp
         5HlyF6ch290h6iZe3Hj4og9FTTLWNVVV9rNELem0cuMIpKpy6bK6sGSFoSCkq0Ty49B4
         ZZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0hh9SW6B5cpp7wKcD3bWSK7HxUYoy+zmiEcYMciTT1OoQ7k1Yol/Qb+iCyZW2ZFTznk2AmnpCRbhrsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+I8UkdCXFcx7L8mmSK0nmqYqhv5lWjikgKq83+okepyY7Bw6e
	iHojf3fqaWyTuWh/ZP8hjoQYZs7B1XqaKIAYZhYH+7xD2mCuT3HMQA4nev+Y8VRH8Z4/lN49sYC
	vZUYWiIfKVmLqsDq2yl6hEYl1dXz5Cnc=
X-Gm-Gg: ASbGncs74+SyywLnqfJGK5y2vAP+fnxmCnYfwypvhFqfWC4ywnP/y4QhIQ01M/tGG21
	1CGooF+jm2vMhEXdRdjT8KU9jtWO+9R1gWm3qG++1U3vTk8SlzJB6uNsjqf169znhsYLNEUgcfF
	AcaPYdIuo2JX41M28nRQXxiuAG/Z8tY1rp6rERqiYuaQJmJ9PSQ36A9lXURwLjKSJVFrckXUjj6
	SqGR2aqYU0pURsuxQ3m/hLOuGL/tI91NGtW+GuyEhd4y6isupE9E/wkxmQCC4ejRBrwVMlj9dsd
	C0iTuhGwhOCQw5OgzFFE4rdI1A==
X-Google-Smtp-Source: AGHT+IGxXnezM7H6ghoHWHVk0i5IpwGNkPTA0TF+xQoIAFjkCgqjiFTZpTBBYWa/w3Z7zp2bKm+jQ4qd+hmkKIGk2Xc=
X-Received: by 2002:a05:622a:138a:b0:4d8:531e:f896 with SMTP id
 d75a77b69052e-4e89d293c59mr371291051cf.27.1761333763653; Fri, 24 Oct 2025
 12:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com> <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com> <aPu1ilw6Tq6tKPrf@casper.infradead.org>
In-Reply-To: <aPu1ilw6Tq6tKPrf@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 12:22:32 -0700
X-Gm-Features: AS18NWDml_8GOzBxWkDpLBz16byJMfZB750GwQQx4HmcQAC4dkTAAf9RVH0Fz44
Message-ID: <CAJnrk1az+8iFnN4+bViR0USRHzQ8OejhQNNgUT+yr+g+X4nFEA@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
To: Matthew Wilcox <willy@infradead.org>
Cc: Brian Foster <bfoster@redhat.com>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, hch@infradead.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:21=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Oct 24, 2025 at 09:25:13AM -0700, Joanne Koong wrote:
> > What I missed was that if all the bytes in the folio are non-uptodate
> > and need to read in by the filesystem, then there's a bug where the
> > read will be ended on the folio twice (in iomap_read_end() and when
> > the filesystem calls iomap_finish_folio_write(), when only the
> > filesystem should end the read), which does 2 folio unlocks which ends
> > up locking the folio. Looking at the writeback patch that does a
> > similar optimization [1], I miss the same thing there.
>
> folio_unlock() contains:
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>
> Feels like more filesystem people should be enabling CONFIG_DEBUG_VM
> when testing (excluding performance testing of course; it'll do ugly
> things to your performance numbers).

Point taken. It looks like there's a bunch of other memory debugging
configs as well. Do you recommend enabling all of these when testing?
Do you have a particular .config you use for when you run tests?

Thanks,
Joanne

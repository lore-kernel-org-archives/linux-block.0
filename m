Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5531352C4E
	for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787477130; cv=none; b=i+yNd4qfPsRYRUK7bxhaKvSNxW3S7lZqAszZx2A+8MnJSq2RLNPF0p5bGw/VPTaALLdpIBOYvx4frr2hSi1J7KBKAsscNu+Uo9CppIBcjF2YUPJ8JOl59enbqX2ioeh2v8wnvvpj456ZM9okrto7yuRw9ZchPB5RNgidXjl/se8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787477130; c=relaxed/simple;
	bh=fg3fhJ4gZUU9/IjEluLltYMIDqvR369u1Yw4y2i27tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JM9gUte5NFQQdBwMC7JxZEz/648TYw3Nln3uzUy7IialX1/GfiRJ+TbyahgSPlLVktungNPPraUmk6ksGAYjga3ci60NzweD5a9bW3ip4HPqp9u7lk21hgpxJCDoVLNX6YmoVnTeSoxD48n1ZknLTsA4O+7yYEajc1HJqDNY7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d111ca99so286869266b.0
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 02:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787477127; x=1788081927;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tvr23X+CegyVjqQJgHYb0m01ZH3nYD0og+5XwoMdqrw=;
        b=gUHXB7u2v20ZxPufliSzmz3DN8psFW1Jtp+GD0iHbvZTm3xkneLpuHDl16veNG8/+y
         Fn5ALd3vvPuoMsy2Hi1wmJyGYX9BeSEWPVTSasr0ND9tcK1yHkZrud6M7IIE8Je1o5dl
         nxJBGGpA+zADxhEutsd/u1x7PLlxA3cBnnY0106SyIJqsaz+zwTSY/PmO1/Iqrv+vPVy
         0TiB78iUsZNwVRU3nM3a1G6d36veiOPWwSFbAeZTDpnUO2WmLFum3ArX086Eh9gjGawi
         Yo1tRtrmhsfv6J6tyTjU2YHI3eOBjWiqwyVlH0+CO62HgtYGRUvaCWsoJhOdHc7Xzgus
         hbEA==
X-Forwarded-Encrypted: i=1; AHgh+Rour5ks/hO9qpiDm6OdDLPwTlh616U8EKGWo6z+mD+XjK3HP66jBTRqkTpn0DRpdSTcLOwNRWQXCfr+uA==@vger.kernel.org
X-Gm-Message-State: AFuF++k4imQ1GVfM00opce3Srx4q3IIPHJVRrgP2yuo0Gvz+HiAD6RYY
	iOGazjCN7ECAfRZ9aPSGLpaz6yhn/f+wapL2bLLD9OZdDv4fsfAcFq3J
X-Gm-Gg: AR+sD10T1mnKzQeL6r/iwSu9uGEnYLc/1vSvv7sTICL9oRRDY6GWNBxtrRBGxFiVbds
	MYgXE2Nb43ef3hWED4hxPDSKmGVeu39yFh0Qf8651+lEGgpYgrbaqe8r0uqOgH7n1GqvJeCd0if
	OXqOAQCTTxdHfy1hKIeCUnxo4hblmRwJWDcD+pXsX3e2zx8T+fWKYMfyxb+ujj3kWtE4ouPb+Bh
	GuGHJCQAkDKPbSTrkujazMThg0AcZ+x+hx4fzo/2vNfvMrJAah5jcxpsrn0/TPTEgH143HRBq+1
	Cc0Sl7OKSmq1e23G157r1EOoOECb6Q20CtzA1CuZLgCHIK+jw+234IqVjra0V6KM2NEhWGV0yiN
	0byVbV3bzW0Vz48bdP8Us+BJrZjb9bdrH1cgZYrofphNAWeNMFyoWl7bYoA+p/DHwURp9m49dBo
	wk+eBs/LfaKs6Cwtj38+60wUTA3jussatouzww3/R3aPJXBD8nA3kuEk2qlss2+ldCc2jZSnGYi
	ZbfTFkd6CEMsq7r7hrBVlhFHzTEn9s=
X-Received: by 2002:a17:907:cb81:b0:c16:831c:427d with SMTP id a640c23a62f3a-c249274b411mr1257104866b.21.1787477126909;
        Sun, 23 Aug 2026 02:25:26 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b696sm789418266b.7.2026.08.23.02.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:25:26 -0700 (PDT)
Message-ID: <fa36cd8e-ecf3-471b-b1fb-0cfb8a684718@grimberg.me>
Date: Sun, 23 Aug 2026 12:25:24 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/5] block: move bio validation into
 __bio_split_to_limits
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, tom.leiming@gmail.com,
 coshi036@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-5-kbusch@meta.com> <20260520072548.GC14937@lst.de>
 <ag3Q5wdOBFNclfMe@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ag3Q5wdOBFNclfMe@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/05/2026 18:19, Keith Busch wrote:
> On Wed, May 20, 2026 at 09:25:48AM +0200, Christoph Hellwig wrote:
>> Moving the checking from submit_bio_noacct into __bio_split_to_limits
>> means that we lose it for bio-based drivers except for the few that
>> manuall call bio_split_to_limits.  So we'll still need a helper for
>> them, which could be called just before calling into ->submit_bio.
> Oh good point. It looks like many of them don't even want their bio's to
> split, so probably would need to factor out a limits check from the
> split so that both can call from an entered queue context. Thanks for
> the feedback.

Commented in the previous patch, would it make sense to move these
to __bio_queue_enter itself as bio_post_enter_checks() ?

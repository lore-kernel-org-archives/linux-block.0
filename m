Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795242862;
	b=SRDAm5lRGO0ALfMWTPQ3wiUEVpmJ4pCmYYb6ephLEbo3wREjUZcBl5Zt2UHH0QpNCA9O
	 SVMO8bDyM3Y5CeN1oYOvvPEdG1orKq/55jUomHH0nLKQeIJ8tez+zC4hINWv9EV1vlBdF
	 Y/srw55aOlYjNjXjbrFUEQX+zVRmtQDUWnaVtsVd3qxRgaYCIKuIhs7sI8d9JuP0/1VAY
	 kRn8FcDc1rHWb5LSN8rp/WiS0PEtDZ5jOGRs8bYHCOWMhK0diTmvHrXjeyliX7tI1D/yF
	 rQ8j/cGSBL5qHwOE3qrAywccuZDj9Y7Oo+YA3TymesgaihOLvyAPoZaKjnfezSYj9iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795242862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=QIo3a06+f6WBr6Mw1qb3r+J2x+nDBIFqmxAPWvx+J9g=;
	b=SFZug2IEbllMCh1y71MmZidCP+uQuCtP0x2eaOK9TUnNPhFEchjzADWKeHoNU0PvIpeh
	 1oITbzVXiqZQ5xE3LDW/M7iXHeW21uCt4FSbLcn5EqH6TG1FhslQdNBVml+TpV37OdqUK
	 jmDkty4ehd4Rvf3Hvlwy/jFbXdelN0tjw1BfU6arq9UtyImv0ps0c1iBxA6fll7MJ3eTH
	 YDzLutI2HbhbRpkXM4WD2GGYzIa4JxNQMOVSqqMypAFGTB8xKE3fEsG/DYvTALJOrI3WL
	 Ps7hMSnc7+iyuSEtLmEtVr9c1yOECYiQXwOYTiM3GCIS8S1CDBSSdZnqAH4sybUsqyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJaq7uYY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BA606A335
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 06:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A5BA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJaq7uYY
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso904767241.3
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 22:34:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795242861; cv=none;
        d=google.com; s=arc-20260327;
        b=ErEmrQDJUwjr5WSVGSdMsbTzNtrGm6uhmvkgQXV3W6SP2YnSMalZx0Ii2OeDTsBpKk
         jH1sCOdtrwUtibtGTFR32rh2mNVXn9gEzjDjHYiZ6SKCYj9UOTZGvrR2u9p2ZR2uEc5M
         Fs2Gzs7jh5O5LJTeNqTqh3QuJjFrZkn+WifZc2iMLZOyk++Ymk72FGvqsdlEWp331nuS
         Yhnf7NDt5qZbUMqp3arvMh4i8mu31UcALc7cCfx56VDsRdaH8Vmc2em8CsspMAsJJSmZ
         WN3sKl1RmyJI36InksWLWWDVuq43oUdXQiHMmXuG3q3Aizc6KdbeoBsMu1GIG0UIjan2
         TuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QIo3a06+f6WBr6Mw1qb3r+J2x+nDBIFqmxAPWvx+J9g=;
        fh=IlgMN0n4SC1Kib+SgxIRiv09XVJw79pXFOUBHVaBepw=;
        b=Qhe7fajdegrZf9wdmwL0I31iHUfja1Vdn005Q8/bkpadn8A/C6cLNCnrpF8Cx+Rn3D
         hO4tyfk9EJev/NSOx1oPgKVxngFD3AxJH7QSKD/9Vh7XUa2XpUZoDaHi1BTvY77Fesw6
         j+XFRJdWVhZeMzgfZdFEu9oTtvt9YJaPQRKJaYJJi/3mH1N9tjdRExwS0w413dguCno8
         FYLHCdpILA5iuCKnyBt0vpK/rJ+xkzBxYzsJkdmjuOMqIJJMLkm43rgB8V/wZMMZHWzk
         mAXLJciTmFB89kEQDZAHgydq/oVkX2f+MTxTbWghmo9VSHfAEOE+YwggxeuqZ19QwlAE
         JN4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795242861; x=1795847661; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIo3a06+f6WBr6Mw1qb3r+J2x+nDBIFqmxAPWvx+J9g=;
        b=TJaq7uYYnytNSNPr3ULKI6GfbQy/InKASQkern5TQYSrbN5LpNelVKpaN+z5mw+k+D
         lDsGBjwIdlANl8eSiZ4vSBdQxupZYZlMkn+MhOWBKnYJBIp2TI9R77RMKmrBGH0Zm06Y
         3QiVyE90ZNV9hsQqNl4qS8vUHxq/geIwFM2xIVJaXnczJUDIA/Q8flNimXYMSUHYNLRX
         aNBkAhdvlpz+Y963oVmeoN8WryZcCSt0SVjH2LaLMfFrCKGKIl7L+fLSPZswzmGVeu0Y
         d8ppgxdqhHLeFjXwYpV9rkg2cSgJ8+J1GdeJvT6uJPw/2s2R/QsrgOCBRquvZ8v7FfYH
         iZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795242861; x=1795847661;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QIo3a06+f6WBr6Mw1qb3r+J2x+nDBIFqmxAPWvx+J9g=;
        b=I7jLoxG2Bcg6TM/LalTOcMyAJXb8NEQR9Imkovhnp6/GQsbK42aW/X1c3eeiDEV0v+
         0fZT6b3xsU6UuuC5SdmYaGcYzd/CecC8riUqNsgKrdnTXEaBOyZkPir0Smby74pQiJQf
         tASqf6mMgKgZ99yBdLleqgbdA0510SscKq8FhWGs4wZ3vx/fOfhSU6HksPvmMg4vl8A7
         xSnKfKPJM94ofm+jkSi7vOWmZnQViUv7TVz5ZF9z8JiJU9iaFIED9YI/rwm7rdcOv9oP
         fK90QjpvxTPjMbfuUeT0WSYAut1mJ5drlO4yBf/5E1d47HqmuYI0kf94p1wp4WlrzcyH
         Nk7A==
X-Gm-Message-State: APuU4Z+laOF1wJnksrjaZMq7joVrEjEYm/PVN/Fvxo9JUBnv2fordGtv
	yOKZHf3PtvOKZ+0A2vk42EMQNy2yHo3bJGYMbffOz6wjsGx7IkY8wjYQEhLGEcwAMfjVVHrLxzU
	VxocQ/PZt72UBS0XCrKw1JRftZZBk8NS7d9IRLPw=
X-Gm-Gg: AZFdTZdQZOQqWkrPrgz8iDzYgD1kSDqKpS7zrrNiNWFDXtoLbbKkizPaZJvihayU56c
	SYE7EuJDA/FFoYyJV/rHntLS+oQcfbHSg/fY5s1i3ioz8zIZcss8+eDwaNW7f3QkSaHmtFxjAI8
	m/Zo2xKOEYCWYSi00RgnB3rFp1Wt5EqdGA17GN8W/o6mmL9jyJioq4E35ysnZxq283lYSNiT+DA
	5BVK2fWnuULR9or7p9H3SwdBuVz9nfZQy6dmhIjE/4S2Lrxd0vjT7BuXMi6ShWaU8YV1M1slw5t
	prpLTeHy15qZHpE6s4VqYOoPXu8GO1Oanf/vFZA0PqYnCmoMvFbPjfdaZJb+vmrFdm0xjcEWqFe
	wc8MGHhBPRNlXVxmL556GmBVvfEHjXM4J/VntfGTwWXvFtC6M4BuNeD4jdhckamnYRTCJzwqaqO
	/NvwGzTDmpBRhc8y+geZ66tB6cXt5asv3zwgxLYWjBA0LqZbg=
X-Received: by 2002:a05:6102:f97:b0:7cc:226a:f977 with SMTP id
 ada2fe7eead31-7d7396157a3mr2218791137.36.1795242860976; Fri, 20 Nov 2026
 22:34:20 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117052741.25471-1-ankit6791@gmail.com> <awD6iLYWPuEgEi1C@shinmob>
In-Reply-To: <awD6iLYWPuEgEi1C@shinmob>
From: Ankit Gupta <ankit6791@gmail.com>
Date: Fri, 20 Nov 2026 22:34:10 -0800
X-Gm-Features: Aa3M54ogdmsVe0mK3YgtYc_aYRIIm9NF-0R9znF7ooCslEa4CV-P_qTqm3wpJ-8
Message-ID: <CA+OH82huu6zL_ZpwZs1AO7Pvadig1kDeZzpLZ55woU+2YfD3MA@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/080: test write zeroes larger than 65536
 logical blocks
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="UTF-8"

On Nov 21, 2026 / 02:05, Shin'ichiro Kawasaki wrote:
> I made minor nit comments in line below. They are not critical. If you are okay
> with it, I can make the changes when I apply this patch. Or feel free to respin
> the patch. Please let me know your preference.

Hi Shin'ichiro,

Thank you for the review and for the trial run. I agree with all four
comments. Please go ahead and make the changes when you apply the patch.

Thanks,
Ankit

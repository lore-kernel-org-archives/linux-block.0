Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0BD2848AA
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763807332; cv=none; b=s0OquD1u67CJwowNuItLu7ZPEPrtQ55Vi7wDMCzXatA5zn/x59v2vPn39HTlOFx5JgsR8CwSz6hcV715nAC+BIqFnrNx9jYtL38L+BYlSJn+gGwjcoicoaHhIyh/BLooNojTjtB9i6UzaFzlfofEzFZu4BFazscoOOLJo6pF0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763807332; c=relaxed/simple;
	bh=iySq58Lxfld8udENzmzwD01KWqtTxbFvsCk44McFfHs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XF7IKthjTGN5SGF3dOkxVCrgbSEISwRM7wmLjctyfN3krm5SMYcW/6fqp53h4BWw/jyBJ6pN6bgu4VHGa2LCxNK6Wupb2+HEtYi5xW6EZzdv68offPu58hbzsOLJRHLNpEhym6pRRcQwTOLLkrNm12zEDrKYxgf8IxPJGDkwvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXCkgCj+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXCkgCj+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so16645675e9.1
        for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763807327; x=1764412127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iySq58Lxfld8udENzmzwD01KWqtTxbFvsCk44McFfHs=;
        b=eXCkgCj+Sg3JSER668/MoSsvS9/9e0lJ64FcBSiOhc+Yzpa+4Jq29xzs+W0SepW4B9
         OpgMOczWcRSZtwOSpKHNJqIS3dKMWZYrLe+L3W1nacf/7rsfgdS0mwKRqhSPf53LtncO
         caMF75TOt4LgmAKPavvPdFU9qTO47G87eNGtdRw1gRJ99rmm40apbXQk1thG2J2MGKGv
         EsrIfYiUiQDTmvM3wyjh4JPKKw8UcSKyWH38m7OIVoEXXNR9gidVtJ58nmpO9QuzMqpp
         PPUcmT1C87cBHEOvrEM6G1gxhshfjTCETQCYW/rFnx7xcTXrlLwLXXxtmuh3AY8EYeY+
         NBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763807327; x=1764412127;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iySq58Lxfld8udENzmzwD01KWqtTxbFvsCk44McFfHs=;
        b=AhL2x9P6Z4c+EWyXshVd9VKffY1nEN8QF8TefJu/7j8srkctKAnRYpZUOMoSmSQmO5
         LoMyEjYP1FpmepKddrrLHMPvTaUtJSu7JAS9JuZtgV200BdvirSgjPXvYaEv7WKPn1hX
         3AVjc1DkkZZhZDKLymToGNOfNhBu3DoO1oF/m6NwHHycMQDo8YLNHWLox7648v3140no
         I1v9E59iMO/BQ0fNdUqH4Od35S+4M9gumQmPJcc0hl55AcGRe8WQ/nnSv2uRYk5wUeU1
         NbtKqIETuVllmL7K6wvApt0aUU4i7i8ZRdZLYgV0MxXKXy34JLdDU5x6h87119kZ2W4F
         kRWg==
X-Forwarded-Encrypted: i=1; AJvYcCU2yYwSoVu9bGUGSxRvCsTBarhCQ7CQosdOAD9LuI/qj6xGtkDJoFk1J1s0yNxrRpRen5fRalhpJ/Xb5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4VckX8nvTnyJ0BqQ+aOTkXTG9ERcBs9kqeTaezsoE5NXXMMl
	AodImoRCHRHmC/fLFD1ZA4WD67j+nXiLAbRrfhJHNLySijboFlFZh6vO
X-Gm-Gg: ASbGncsGP1Fr2IsLDiCLRr4+s4Ba7EXteFoZjCzfOrQy6Ylm4tW0Av6yhQa6KOiPil9
	aHkkzY4jauXSRucWUvQqODonOLbLiSGqqmzGmF1cXw+LFXtMCV2nxLtWnM6U/0bMAlR7Ksgd5xZ
	JUSHFOUCNYowsfgKvp436eSFUUercMb1xHbkjXH+02Jdm0zN/3P0N8MkWNLgfndu8gDxFtWEmvm
	Z3GkooR1IfpNgb/5mxL62WPtBZ4jjls2lEfe2t+ir9A+4BuZOjDkucna4bMPIp9Goxqb60Ui7uh
	vVCpmRictmvU2aC9rjNjn/m2wcep+F6+bTnAWycZyNGck3R8QiAjRhRSQ3w42qjySyqfbz6tT0b
	4DcHHkJmIkagTsN3mgB4pXBfNHEyL7PtA5v7cnTR+AYa+1I7KwmK8doKe+gfuDkhR/u/FV2nSYX
	P42lshH0IA7FDoevy8Sm3Xkkb8Pf51OfwGwxeV04MAiXcpqP1ZmNojKxKS
X-Google-Smtp-Source: AGHT+IEZ1TPSuzVZ+M10PT6f48UHg7uZlgCS/jOlWJf9pDjCbYrpdcX4dNWueIQk/WSIW5o0InM4kA==
X-Received: by 2002:a05:600c:548b:b0:475:de68:3c30 with SMTP id 5b1f17b1804b1-477c01c0c91mr59121485e9.16.1763807326741;
        Sat, 22 Nov 2025 02:28:46 -0800 (PST)
Received: from ?IPV6:2a02:168:575a:f00d:ecda:ab22:8304:63a1? ([2a02:168:575a:f00d:ecda:ab22:8304:63a1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477bf1df334sm87486425e9.3.2025.11.22.02.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 02:28:45 -0800 (PST)
Message-ID: <2b67964f-22f0-4d38-9df0-fe50b9b9436d@gmail.com>
Date: Sat, 22 Nov 2025 11:28:44 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rene@exactco.de
Cc: efremov@linux.com, linux-block@vger.kernel.org
References: <20251114.144127.170518024415947073.rene@exactco.de>
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
Content-Language: en-GB
From: Gregor Riepl <onitake@gmail.com>
Autocrypt: addr=onitake@gmail.com; keydata=
 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
 qAI1ww==
In-Reply-To: <20251114.144127.170518024415947073.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

You can add a Tested-by: from me, if you like.
My Ultra 10 can read floppies again!

For the record: I only had a handful of 3.5" 1.44MB PC disks lying around for testing, but I don't think it will make any difference.

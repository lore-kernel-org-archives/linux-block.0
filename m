Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350627;
	b=qkmejMnbm/ujCFpkRRvt9SjErUJZna9eU3v+KTqX1RAcErr89txb7R05txlJBt1sS6Au
	 yBkgzAz9tZmpwNkLWBUuxbp/z170Nn3Dsx5kWO1u/wYBaOOKrpQFE6hE4ZbcA+46ZXdXc
	 QwPjbVMkHed7OQuqMwXmbqE85g+QXuPQhQGk6i/rWh5HMjZ0TznC5HtqT0NDnYPMHO2EX
	 dG+/Cghh0f/Nt1elq727SgpGYjWrQCPnmlZccczchWpeGKN0m5Ttf/g2ZKWDQEMd9U6hk
	 FAiXuYwHU5B4XvcaxqE6kxdgl9SdUhEPV9Qnf9JHvB75s1Y7fhL8v4x2gz0YiASrTyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=uFhvyB9IqlLC0kGF+3i6HyfHGEXzwwrDZQpgQht742A=;
	b=WHJuJrod860D2sDmygOxEkGCpzEHFBdStsfFy+IIuDfLvH5WGpJCRGZHmBM8xqwcEnL1
	 /wbq0Tp8AYmgfrom3zTZU3ljXz9VJ3wU2q73KTjBMhtFRv9A5iryFK0E2uTmGue8s9rr+
	 0rWlxq3d003eYqhoTuW70G17V53mTdoRYEt1D7Gbs/NcBob/Mql53vlSk/fJbYufLc9uS
	 TKdh103Z+rkhbB10S7wugFObUlwnwtUDiSzbUdFUt2ydvbjUa4ODg3zKS8dMLRmckNCTM
	 t0sQ1py8EbfFfkSRPls2P4kcZzZdSZz6XXuOOLHOudEH6iO56PnZvSsO7RRHFddLwCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=syLnyRFv;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266E606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 08:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4266E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=syLnyRFv
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso322751f8f.0
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793350625; x=1793955425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFhvyB9IqlLC0kGF+3i6HyfHGEXzwwrDZQpgQht742A=;
        b=syLnyRFv+IeEPXjX/ZXtqyLgYOz9FU4n34RfCd1iv1AjhtdwutREkSu8D7RmD1IWBb
         UWqh1ZJnVVwSOXt3As6xiCF1NmZIxDUIVp5CnzQSws333fT12XtiiWX85uDAOo7txCa8
         oDr91Sdlgz67WvRq0ri8Zg7U11YL7Pf5W7Yall30UsI8raufOJoLLfri1JXB8BHaBiSr
         nCo8zHaC3bJ4j/QGfR8SVc/wjJBWMf9BrVzc9AIvDd5TyIY5KI26g35WXFTzOsTN4pg/
         TuFjQfm6cxyEf1hso9BIbHEPq9yn7knWhffpd+/CR68TjzUsKow32JXRPG9ZlhxBB1Y1
         JDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350625; x=1793955425;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFhvyB9IqlLC0kGF+3i6HyfHGEXzwwrDZQpgQht742A=;
        b=z9y0Ftr38FLQNEOs0e7tirqmU1MdD7VQvypz4KbN9mYG/w3KljDVU4TslRu9Mc140C
         DfO6q7Nx53etOhi3FU1I5vFzfNZ731abdKoVLgf3qbkxErdv7aDSbCioCorAKD/e6aDj
         CKOlcVbuGeIEBkKbOHYc5mK27h8ZsUIVo2HUkozNjIivsm9kyquczrz3HrNBaPJrCVgS
         5moNX6S/mraN96GAElTUXHyxFcTswTHyPo06O/tM+uzfN5GeWNcL7wHf5k3KvQTJrUwq
         BD5Yt490qO9zWp8YFJJlEuN69dgQgXqTNcWng4zHmgmpOw9rajQs42fP0BzXsCnrfkwf
         3zDw==
X-Forwarded-Encrypted: i=1; AKwUvBwSuVtYSdSQb8fSZlDYeKJ7IZ3ox/VPsLw2TvuSNBMJ2tH+dGIQczOdzjcXoIQbAow/f8wOsjP8kQyYJQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLB1qAq4ojUmO4jnRLlvOaaIYZbThrU1O5/7PbsyjJlBAz5epXU
	twRr0ErhaJnXl2MCRvLRpmNbCWRwGGTq1wV5VD/E0qQ4FMUx+Wxr2QFD
X-Gm-Gg: AYBFou01H8uCyE4bOjLf+BKYyXLuRCLUWmYzryQ93GlDWc1dYMCc1bfjnUjGfiu2RhE
	cG0dekx7NtcA+ZkyYFaVnRIoABXtdKdNmLKK4v4Y2TPNSV6d09Dhtq9xFXMCKtphIgRwbDIldw6
	+MbN9iQLQtW/RUgwRxq3SnRLqzxuuXTKLceK5880sV0O1aGj9Uc7faTt03yQRWF0+tBQ8nwqyUi
	/08mgEnDD6RHoWzgvH7UP/K4Sg316Um/fZOSu2I1T244tH0PINrPUXvCHS7//wGJjPLiiOMxKZh
	C5fqv+uVwXT2z6JZ/9cd17XRlG8l6TCt8Z0u813mH7Hh+/QAoIU4WfLJQqPn0Dp7VxafWFefKN9
	MPjsLq2fwTHdpPFY4g44rff3ofSCI7Pnno50LzmUvYMEBG5Qp7zddUzxX5wJbbMTtB9/EnBuYgE
	fbm9bAsoQ9Ic7rOliTN4Mize4Ja6SSMIAHoYL+z0+duHY0Cd4GObOYLyVE5fWSuiLT+8TNKqFf7
	DPumRXWxFX2UEM3iiqwWWqpqf4YeVY340L+Mn4jRhMHLZbBLLm0KFxlkH5GbpHnRufOPaCyrPlu
	x7rT5FYcKGve/Hhc6ezg7Htx5Qe8zjBtjqaLOpV4JFFEK5VhjaBaZUB6R08kw7fLXjf4vfOq00o
	zSaQILrDENVktIQkrq7EDHu9LkxQm63MFLsB8Mu45umomZVeb5/OqKp60EVO65ipt88YAbORogm
	EeGRWDIC5AP575hJLkwD5zGXo=
X-Received: by 2002:a05:6000:2387:b0:48e:20f9:8d75 with SMTP id ffacd0b85a97d-48e6e50b79cmr3967049f8f.48.1793350625445;
        Fri, 30 Oct 2026 01:57:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm2019014f8f.43.2026.10.30.01.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 01:57:04 -0700 (PDT)
Message-ID: <15e9aedf-2205-4c73-b1d3-f95626c1612a@gmail.com>
Date: Fri, 30 Oct 2026 08:57:05 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use the bvec fast path for dma-buf bios
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, hch@lst.de
Cc: kbusch@kernel.org, linux-block@vger.kernel.org, anuj20.g@samsung.com
References: <20261029105330.1427462-1-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261029105330.1427462-1-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 10:53, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> bio_may_need_split() reads bi_io_vec, which for dma-buf bios aliases
> bi_dmabuf_map, and interprets the map as a bvec. Always run the full
> split check for dma-buf bios.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


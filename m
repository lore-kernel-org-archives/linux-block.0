Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465296;
	b=CzOW5izG2V9p9LsOWu6SCsQXi40XDIA7tGm2VUktzL7qZCs7yjwTkbPwfI+hihebXf4b
	 Ol3kGHLfgonnToXv/gqZH7HwlArdbrqDrMpRL8Oo4hkqnGhL/Lt4hvOsPyZswgQ2LWNC5
	 juNHd0KmIguSBC2iJahOpb2L0kvXhTFIIw8CRRVZJZ6ti9lQ6Y87qiGOJfiPE0PoM2KGb
	 L8XR3pTOg6agH/If8uOdQObPKUwMExQVfDq3lKGoxOT74HLs0QC8Uh8gGV+BypuS2As3z
	 Q6Y5JLkKx615U+wPG7qMdwj6H5tP4nAZocOVQJa15urp/UcloRwR3zaIepYsEAdwYYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XzN+ftZH8nOljyMprPWsB+uz3H4ojG5d3KlA9M9z9jE=;
	b=JCy/+Vk1Xj/h84HUTd8J9KIJfWG4S4DsKbjue/wy9V4TsscdSGLBL+FascFukYSwZoYN
	 HMJY9Rz/56cQwj2+CtskZ4hRdQWDOlJNa8339hf9KvIoi2VHTXqqhg1a9xmNw5nkVA2J8
	 Z54cQfWiSJYs+2R5WqI0WnVlC7qTf2iy2Df+NjVofEBFTH0R7WPp3y1qw9KxtrftU9ZwC
	 9TFTcLdf9foltzb7UuLBiNOFVoGZ4KwG9DlxwR2vgPKbJ5hAMoINPOyx6NHajnbuNT8Qt
	 MK8NmgZwFP5Z6jtBcByxAnWxPYtj1PHnjT/vVAg5PuP3S+GgcBJqsdKWA+0NtsiY6OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=f24zqfC2;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7F606A31C
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 06:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB7F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=f24zqfC2
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so29693065e9.3
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 22:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794465295; x=1795070095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzN+ftZH8nOljyMprPWsB+uz3H4ojG5d3KlA9M9z9jE=;
        b=f24zqfC2sGIBsI0kWpFkCCkygINwUTYVlHQDYSfiHVWQuqnAzYSUFr9LugKke/eiJ6
         tbZbVWjzCj1v6zO8JPipjGRc4mAGUg/3pUBsVG9fpR7qdQEyRjYh3zH4QHiB2rYFNoLW
         DC7IjCohdHpkzeUM73jSCYcY8ACK/NNMvXhoZMey9+ocS7Nn8Ar2EvoU1mtcVXY9+GPu
         h9WYYKLoxcNw5/ue/rIB67dFH43SKyl2IvFbxc1QlD304HW65aHW+CBa8sJPEP6rVWop
         plV6211Y97rUz8XcJDmelyEkqg7uTXE4xNjhs1EPdls+Qopspn4rH5MvsK2apotCM00O
         zNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794465295; x=1795070095;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XzN+ftZH8nOljyMprPWsB+uz3H4ojG5d3KlA9M9z9jE=;
        b=Wmjbdo807wO73uBNCCYuEbLKlSeUU1p0B76zL2QsoBoaw1KqqVXfBZsrq2m8AZJbyT
         gpH81tFXXeAq4O3tqN/0pRml+lMTFxLvDLOx96SE8Uy2NpR2eNGJmHyqbbfjPTYYQv+3
         OWGVN5I9JR8lu1zzNAEckShaEw0fawBWMbVaqlGovKTn7CHNrQi48mhUWYT3F/fEhwgb
         8KOWMQ2OK/10nBOrbrZ7XK8vveU0Rar1jKdaXgXdIP8P00TJGkmUVOX5zG11V7C5E3c6
         sGQexrI3fsEOvZfyzzT+3nfJWLPphF+CmqrNiw0n6o6ur6vc2XIKwZqTIqEoRU1xzlaE
         aWew==
X-Forwarded-Encrypted: i=1; AL+hErFS70JIG6UDmFvQedPs5wZD8LPS1pryee+FVhWHEh3ipE+5aTa6A3JTYuuStlzGTh5wO4NWXDwnLXEr4A==@vger.kernel.org
X-Gm-Message-State: APuU4Z99cAXy0kFJptcJ305w/hC5qr35Svumeo8y0SkhE15O0BIBMtTo
	X4QIFKzQ7kyHpXngUzR6Pz4JUAAJv37Qx6Vt1YE/h4Kct6U2kd9YZnmLObE8GvCn5g==
X-Gm-Gg: AYBFou2rdBLZHt9OOMazr/AqN6BaIYSWAm021yI5JA222iwZH4Qb0GBRc/2I5h9v53J
	CD9wkWIG89jAbgBAdDtne0q5cXgiMUWmuwIl5De71jfHG01rOjaG5v0kDI6fBrJG0NdcBqKHPYe
	GtzNwgpGoi0qPHYdSCwkNMWQnapAD4ptwxQtl0dRfRLxDmr1ylWk2pQWYT+gh0yY4E8WMvpYzT0
	BxgrAQSwHTHYuENayJDW675djgSFrYq8vepUC8FW0MBbwbD7bHUN9O8CLwQOiOhSGk2cBTlJ6wA
	llC17HZJgeeWhjp+g8IdtzCcg4e+3E6cyCb0uIWaZ+aC64WPaQ6biybTzYYuAUe3lDTvVISZoQX
	vcajbZ7vgiflyS2zDtaQrd/t31Q8oeCTtegrwHI03ao4G4zgk1g/nKYzVxoQX1H62mhbojHvQjT
	BSpOGOvE9Fmye3aHkPVuL8ww5n4OsgFFgnFlX6fYZyFPbmdij9bylZqHcW50pzl9oHyJug8FCZF
	+amoPTc6OK0saZmG9zLYiutirIFvMcOm1pRrSm0KKD6/VyBUSu4Q5hnMwHBXehqJ0c5ni6RaKIj
	YGk95mGnwF//A9qt6XrjH2g6T37/O+SA+EKlTt8ylpTwc9+UE4i6yq5vxrr9gxnZbxASObyKh1w
	GeubXF+UGOM+YEzLZmvkad4HMeCExjyZG2PbhkWOuXgkgM8gm53DqHUvE2vNtr5WsR+f2UFwt6Z
	O1eOE6uOY=
X-Received: by 2002:a05:600c:3151:b0:4a5:cfc:1e95 with SMTP id 5b1f17b1804b1-4ba093ac1f6mr79613765e9.33.1794465294776;
        Wed, 11 Nov 2026 22:34:54 -0800 (PST)
Received: from ?IPV6:2003:ca:b726:28fe:61da:a0a6:3f98:b9fb? (p200300cab72628fe61daa0a63f98b9fb.dip0.t-ipconnect.de. [2003:ca:b726:28fe:61da:a0a6:3f98:b9fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e271378sm52598445e9.13.2026.11.11.22.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 22:34:54 -0800 (PST)
Message-ID: <7af69a18-fcd7-48f9-a9e4-c2ddc060755e@suse.com>
Date: Thu, 12 Nov 2026 07:34:54 +0100
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
Subject: Re: [PATCH 0/3] xen-blkback: do some I/O statistics rework
To: Juergen Gross <jgross@suse.com>
Cc: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20261111162058.804033-1-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20261111162058.804033-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.11.2026 17:20, Juergen Gross wrote:
> Some rework of the blkback statics data handling.
> 
> Juergen Gross (3):
>   xen-blkback: Remove statistics logging on console
>   xen-blkback: move statistics data into sub-structure
>   xen-blkback: make statistics data persistent across disconnect/connect
Reviewed-by: Jan Beulich <jbeulich@suse.com>

In the last patch a brief comment on the global stats instance may be
worth, to indicate it's guarded by the rings lock.

Also, do I maybe get a Reported-by: on the last patch?

Jan

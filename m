Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213E3BE626
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418009; cv=none; b=ToSCcGgTDGHYPpyNgYjBJtdnp+hQ8YqJSgEmXV667+0Bzlx9AGAbNCd+vwpZtaM7gplvZ/kVvXh4z4tL0PfCYHVscMgnNt9uaU30ZSCN226uZ38A9rtNJ2Lc5MaI9mxugg8XVRAMX3nQXyd4au8ElbArTkmT1kPQrRwGN9FKxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418009; c=relaxed/simple;
	bh=mrgB6OYq5fl6la156FZGEjM8+cGmsWQazLL+9mA/3YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uctj/ffIbGCtdD4z8xY1KIVz7KZUl6HD/biR9tMsz5z3/X41Ojw5sk7KzSY2IqlXKexb0yA5P4uA+kJoMXoblvgRnavbD6ibFg6IG/4LeQNhYYKLT6xTak+J9C0/P1swtnv1wvnUCfRtg0IrrxF7PavUkqNneFRSkQunSiebod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=16zJbp0A; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="16zJbp0A"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67bb5e4cf7eso1253935eaf.2
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773418007; x=1774022807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIGUjW2HEf5IAtuw8pLHFD1v6D6psz7Cx6Shlu3igSk=;
        b=16zJbp0ACT8RrIF2FoehxWQzpwxTRXPKVzfMIAgUGQ12zsW/H9XIfhff7ecLpkYKp4
         Dg6aGzY4WuPb/bpEs8PE7Orb/wbWsbqUPOYynPqx002QSDAfz7ff0hhQGLgLrIa4+Xys
         ZYxXkuN038Eh0M/4Okpg3uyTXtK5Jqvsars9HPGTYSxVqjAbwHhNlPMyJhml4E00q/Dd
         HzEDdpK82ZGzwvZXFgpNRWrcpwNmm+LHHTwxHljz+PyQKE/bbvbwZgEW/ZCD5RMtQfNU
         DR8sMYKEyjSYS9pSreA+/bhyAriD1SomiKBbp8vVLJ5aARG26ob3Eydq3LCYIK9SILdp
         gl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418007; x=1774022807;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIGUjW2HEf5IAtuw8pLHFD1v6D6psz7Cx6Shlu3igSk=;
        b=YC4DyKHQGf2xPSxTNfi0f5GTLQYHxD2Ay6ZLg2psxS1kfTjS+7LS+FWWRd0X/hXFqH
         00fNncXORrfy3TlqnZjSB/xigR7ZO6qipJyVqOpSkvdyxhCyBQOmR2XN5Bd7GdOiR3yh
         tVu3eokObV9n+gbEKgg7xtW1UULpNaBGixKD7lIUsDS01b/fsSfpGbzi7guqVg96vW05
         9Ottw3JevD+jumlA0wCQRyC6YYWbjkPlEHsqkkJNgwBsQEffiaE/qrhxVzqseTrutBvF
         9u9V+kwBHOcAVv2SysRh7EyTxt5nVISwyV6Yup6G2yZs8voThpNkX5PyB44923chV1pn
         7eUg==
X-Forwarded-Encrypted: i=1; AJvYcCVgwqwFhTu60y16IckVcWX8DBmimPGm6IOM4FjYTMGG9UAY/+JVmenGbcGE9sPS8pe9UP9gevD2Vkncdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGyAcWEyq3WPKMYsHAif2wCm8gsQFVUS+NfOC49QW6WZXqqV0
	VI4TiIe9NlRGN5nXASPEa7bMfSEbAHikGWBWfPIg+qNNQHPzoTdIEomvD7cisQmHk84=
X-Gm-Gg: ATEYQzzJ95aN1nbhCPT74/a+cevkE/TjUhCnPX33kxc2IjrwZ3fzPmK1hoe2ClyTxDm
	8FcP9wVFwO25dS7m+bKlbctff/OJ1cnD2bNxHJ87SpbxxEQEtm3q7wVT5Nj6Zy3jUD+7HrnqdAc
	TZlH+KrcNKblKf9wP/RM2Lu5jHr+kUiXTa0K92VB7Esv8ZrYHZ554LHeuZi81ccgQ2/JFmdS+I9
	egNVHJXY+7DuORxO7azpAJjAJQdXNdC5yyZa8x6IVMm4q8HIKKD2EDHm5N0Igh4CQ8vKKcvNUNV
	h70haUKCflxzoa4hc1/eQ1kX49Q2DEsOjDa7JPxKBOt9ztNHSHpAfvfdRLNl6rpKL0kwgymNJem
	A66DyxiRX8UV2o+Rj7PbXDCz3Qm+5G4VMIDl+6qdX18n809rvlnXhUc7Z/f1RkrCyyj0WdKw4jQ
	CGYZ3+rUOoqKWfhrTABp+lmKF0hdqgCMhz9mRFm/vZq+GytdAEP4f3SAE+djAFVUe36Ldf4k/9i
	HU5mKU1Aw==
X-Received: by 2002:a4a:d312:0:b0:67b:dd84:2798 with SMTP id 006d021491bc7-67bdd842e6cmr1168312eaf.57.1773418006742;
        Fri, 13 Mar 2026 09:06:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc9307b4esm4858249eaf.11.2026.03.13.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 09:06:45 -0700 (PDT)
Message-ID: <9d8205fe-c788-429a-985b-8472217dbe32@kernel.dk>
Date: Fri, 13 Mar 2026 10:06:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Josh Law as reviewer for library code
To: Josh Law <hlcj1234567@gmail.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Vlastimil Babka <vbabka@suse.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Josh Law <objecting@objecting.org>, mm-commits@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, "David Hildenbrand (Arm)"
 <david@kernel.org>
References: <20260307221931.2848601-1-objecting@objecting.org>
 <3cd25de5-3737-49f4-aa8b-eaaee471af50@lucifer.local>
 <ee644e1b-5759-477f-8aec-35c91a5a938e@suse.com>
 <20260307222154.2848660-1-objecting@objecting.org>
 <667b75ad-bce9-4997-8ebf-8077952c2797@gmail.com>
 <20260313-anvisiert-gemeckert-352414e3d58d@brauner>
 <20260313-halskette-annahme-94e782eb4ae4@brauner>
 <01a6bbcc-1442-48c7-be5b-14f07fe655c9@lucifer.local>
 <28175752-2775-476d-9485-499335a99aea@gmail.com>
 <e2278198-22a4-402d-9179-c7cbbb186d5a@kernel.dk>
 <8bc3ea9f-4e56-4e41-8cf6-97e3b5a45b31@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <8bc3ea9f-4e56-4e41-8cf6-97e3b5a45b31@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 10:00 AM, Josh Law wrote:
> Thank you guys for the context and the history. I understand now why
> my request was premature and how it looks from a security and
> procedural standpoint. I appreciate you taking the time to explain the
> 'Jia Tan' caution, it makes total sense why the bar is so high.
> 
> I'm going to take the 'no rush' advice to heart. I'll focus on the
> technical work, learn the etiquette, and prove myself through quality
> contributions over time. Thank you for not being super mad

That is the way! Just keep at it, it's a long road.

-- 
Jens Axboe

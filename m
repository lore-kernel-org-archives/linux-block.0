Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115022288C3
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497702; cv=none; b=JfR7iL1hze5x57RxY4UCx3/P+HT+U63KBU1mqYk/rACK0pC2+uAM5mJVBLAQraN7p+JNovM4Xd616lBO69HNvcJbwQdoJyQkhswvReqSDeiObWPijJ6zGr5hI/fusgoC7CSmxccQ9rhFD+/CIgKBRbreZVW0xeBM/OipVCAsXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497702; c=relaxed/simple;
	bh=duNKhmzxoU62cimrbYFzjeTfzKcykPtZNqQcgqxlpXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8kgMOn4kaT7X1GoVTAgLUbtIA51vIKKfVfFa2G3/Tya+IWpdlk9JUgH8ZcpqrYcDpHiZ3jRagSV7ulb+TMmd7pLSr/g1nhxl0cXPPLmS/D1uFX8w+iQymhr59WLlIG73XNDl4+1oJsYPIuEO+XZlSFX7Tc2fcVLzO+lOZtvhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rsm2bvPD; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rsm2bvPD"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d7f11295f6so3284535ab.3
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745497698; x=1746102498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqXVyyxnuwcD1BIG99/aSq9M/jNFiAFkfCwzRkuTtlE=;
        b=rsm2bvPDpfX9+Wjw9Ia3lsoACs+JQ4IXn7Akm5DcYaUjcRG8JIKLA0hqnXr+Sd2/Lj
         lw24h1UCCq39Q05bt8vvQ6Z3RQsRsI+GXLovI9skpMFv7BsvtcUDK9PshT60sAJIUu0K
         f1UIqliwbfOciCkFfNS9cPrifvLxcC3H0F39ffJx8Wj8MZ9Sk4V8Sj5vdaPCSdQ4RDvT
         BsMyqjqEmOy6dP+/7D7dkoIHJuYzGKAUvxEDLrVpSuLEnlv3mDY+sao23KcTF93PKNvx
         OLq4wFS5QVbCg39aLc9c9inEsjGfMjGJo7RCBhqUlAceXQNbmMeTtFn2iZANoIaU9zFk
         2QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745497698; x=1746102498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqXVyyxnuwcD1BIG99/aSq9M/jNFiAFkfCwzRkuTtlE=;
        b=UvGB3/nofy9EhKJGeu9dKNM3OtfmnbdiSoNiZY4hs6l/FaqiMyRYFA6ragV71xRQiW
         iQZ2w6Rco19KMdffK2UvOEVhtruiT/pzdZZ+RKyciAmWDlrgDequYgf3vHvK3YyLG3td
         5CzJq3cqce6CaCtKXwPbiRlXhyz3DrDgLnaB0oizJLeKPN2mI32Kv/DEwIdJ62liKlJ9
         hkz9/32wFR30DVNNTQYvqYuQZS9EgtyFe+fFkenyZtcwAfAeH6PCY8gqFqOQPNVjO+1P
         HN1XKsiFMf/7qQwA5Mg/itE0F3pYqMKETRx6RapWSRZEgF8km58AUwUmiNgSibq9bYLk
         jzyA==
X-Gm-Message-State: AOJu0YwqtRM106BUW6JKlsavzV4kCJ68c2R2UCEG6fyXgwHvzfyE0ryM
	h+x5Qo6EaD40rXsNfpqatkh2tVWsjdKMlEFaG/V5BoM4N2DlLyWBdTyzLdI8rfk=
X-Gm-Gg: ASbGncul395g+I5Zz7sksfvNeFNvmad05bkfMhte5ThQtTyxon4P4rqvg+V+RHW0slG
	hd3kkR1wo/PXZ4NIbtAoTRc05x8jHN4uy/HLdQXin3XU8HLc57y8aDAuw6Tbe1lmuJ+zLo1upNi
	KTHNBcFcCYAktAAf477XNyCQhP4NbjLnkcvq6Sju6L8gHMx3d1ZvvOkx9Wi9HzHN2mb5/572RZ9
	DNZ9C66EKehrTFbHfvzURzGiaaOOsT3dO8fELGb5euMxQgnW2WxRnz92M/C2v5Z43WWAtzo5rL7
	IzCkQxpm2wcjiCHHrnSgCXr8hKA3Ua1xfivegQ==
X-Google-Smtp-Source: AGHT+IG1bJLMbknqw2vpRhpLjNKOGnQXUnkNLIjQIrHWKNvSaX55zTaj96I5pBS/AwFgSDAJr+z7eA==
X-Received: by 2002:a05:6e02:19cf:b0:3d1:97dc:2f93 with SMTP id e9e14a558f8ab-3d93041ad0bmr23964145ab.20.1745497697784;
        Thu, 24 Apr 2025 05:28:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a40ab1sm256606173.40.2025.04.24.05.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:28:17 -0700 (PDT)
Message-ID: <faf4ed42-1842-469b-b052-c88a8324ef3b@kernel.dk>
Date: Thu, 24 Apr 2025 06:28:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: hch@infradead.org
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aAofJOcb2NzkXsP9@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aAofJOcb2NzkXsP9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 5:23 AM, hch@infradead.org wrote:
> The following changes since commit 81dd1feb19c7a812e51fa6e2f988f4def5e6ae39:
> 
>   Merge tag 'nvme-6.15-2025-04-17' of git://git.infradead.org/nvme into block-6.15 (2025-04-17 06:18:49 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-24
> 
> for you to fetch changes up to 3d7aa0c7b4e96cd460826d932e44710cdeb3378b:
> 
>   nvmet: fix out-of-bounds access in nvmet_enable_port (2025-04-22 09:50:28 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.15
> 
>  - fix an out-of-bounds access in nvmet_enable_port (Richard Weinberger)

Pulled, thanks.

-- 
Jens Axboe


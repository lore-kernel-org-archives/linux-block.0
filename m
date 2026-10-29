Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270621;
	b=BcJKQHwyOMT2Pn1gFnMK3fXQ6FrnlrCorHcJ1cs5qm6rjsVLnDh2zHOyrD11xX2jgmHc
	 WUfhvZDihmun3bW91s81PQQ/Q91jdqBEcbm3Df1Wve3se+zz9UT+o4bd6cSSc3VB7UzDa
	 9mOCoY32vqYJ89XN/JVIwi+gzLK8/1zOClKZeEHhxPfQy+AV+N40jHI0/YeiyI+FoSp9S
	 SerS1Pto8pjrWn9Zo99+vNtMc+1OdEzMVoZ1wQYhG37BerKLPekcSE98AJMD5XU6hZ8dL
	 7Fp6HKAt5SDg+xeHitUiZHi7FRKvHO0iy6Ujqy+aV4byOi/TIREHZ22CStnPtlxXmKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6XOKkfJsefWjpOEYol68Fomb3WNK9nIfoprYMh5LhYo=;
	b=1MjL9SqiU4XTchRVClNQL0Exg8X8VJI/A5xuUzqVpO/hj2zBni0CUh7Af2W8twthsYk5
	 R1qLgI/8sTkzQv+giGoFZML006SfRVusIKIsAeo5BPTotmgpb7oPB46cndjGNr61NcKIs
	 8sjGNMp/+YV/NtcRQPZzCRY7OkaRMKaxbz9/p+xvRyoq4Ra9wU8GcuUlfy40tXuYXKS+8
	 OXMT9AmiOxwJKdVGW92xdnOKz5x3SjqjTx9eq0RcrIiXRcjEfRgLrHQi0gy44da6/Q2NN
	 /6U1Tk5AqPHh7UMaawOGkk20IcHKs85EIEbJhkRh0X5h20VIO7lyAqYNh4NwsBPg+HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L10ktrJK;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CE606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B4CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L10ktrJK
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso17388885e9.3
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270619; x=1793875419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XOKkfJsefWjpOEYol68Fomb3WNK9nIfoprYMh5LhYo=;
        b=L10ktrJKN6okWgDge9N56XwZKPL8WktAO6uHm2Zk/4dFNgy1RlGz0BVhY52Xst5U9V
         EdqBZiljHAwu2Dh/bcfZmpppX9dE2UIE/2/Ul73rHShJ3uM7B/g6jgCByyv1SNBs7cHE
         Oz31XCk3LctSXwGXUIf+k2I04vJmTDdR4Qf8YRVS4wlnw0UnRiP2IaA4llb41qNy/YTq
         kDHpWKwB29pV8DFndNNN3V/UrutXwUwgbFM2r1cNSgwwpAW5nUReonMXawoNs0fO+EVw
         580HcoCstQbN/XHS3Fun17diEkCODOdjRJKn2VhsNUl2Ad5IBgBKGPJZLASyIDhnfAbq
         QnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270619; x=1793875419;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XOKkfJsefWjpOEYol68Fomb3WNK9nIfoprYMh5LhYo=;
        b=xESBiQTjLHParG4oPQrrtsWgDDEH1bD7k053810FFNFOs2qJvF9TF15zUpzSO0dYxe
         z26UCG/feXeMUncU70nae6RjUlyu8bRps3iyFEIu0MXkQrYDkd0Yu1G5FF4W/kswfAQU
         F3YH62ufXbYtEZP5arWZjYk7U5SnewXsutkqJEcpCIkva3Ci3P+AolbsOwf3zp93B4k0
         r+aDLkcD4PzAyq+pcY1LMDR+i8g/RR8w3i3zvNs6i8MAudQWqCyGGUK5kmoVfx2RXGeO
         Ee4T7ZWJ2pcg6VqwrvV2mvgyTUCfGk4zunBTPKZGlx51yNAFmgV8ySIV2XbtJdRjY5Lb
         ZyNw==
X-Forwarded-Encrypted: i=1; AKwUvBydLBAH2qQ111L1wZ8pMuqqcJZiNa2mzT53lyAPoIGxIpTgZWeY7BmJ6I5ru6WNcz+UvRpi00P7/LWrMg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLZeqaIlSLzzxgLMM8/HYBOxLqUrSOF3PwArEqmnQQjTQB074a2
	ienOQTpJpiBYrVmVCmx4DR1/q54G/rJVGwXiuBG+aWt9Pia1DCPsfGHWyVyz/g==
X-Gm-Gg: AYBFou3mp3+M0vRm6uN94l14krsxedGEbd5oGX9vIFoThpFK9vhYnKe456Hgd8wl04U
	MI4aIyvvLW4wCeZBbR+9RyrI8LUfhCdqyOVnD+oLcnwffx14QnqkgY+iAOqRs7WtoxNPdvYjioF
	quanQS8UWCQNy20G6xKF6C6DetNFsPecWq6Dd9wdMI07i00vVna/CvI++lTKCfENHjzUTZL8/X6
	wK/Z85PHEQif/IdQ657+FqlbrYSc2nt2dAwg1cfn8JBIdIriXe0D5qC3C82pScODVCZcdnyig5v
	1eq/DaYEgRiT7c9aAlUId3AlPomX34irw7u9TC7gVR5jcbD2ELj0ZwvcO4Y4Ps+zhJ5Uu4i5IXQ
	QKGvTtKSsWJLYiPBFDfJOXA2YNuY77ncqW3SxBYv5Mm7uTYwVB43ttkvAX/dfYa/IOTYKGN1Ga8
	Q/XWt6gybveTnMbKfeEO/OF8fGTYfXi53d08NAk0O5ph3YDIwSc35NipS4jm8STdEuGIXdAPry3
	tspy3EzfG4IQL+sGP8s1ByeqMbOru8MzuyMw2Ok8Fdsq92lqaFsvBdUiKhQm9yJ5hKBBP1SMazV
	OSv3mmZ4V9TqxP0TDWgI+qlo64qTNae6no/mjFyIRsH2VjZPSqaoQQd4nhWhfSi3+lwQjYIKZPP
	AEjTd04+DYYzRNRuBGwEy4CUJT8Jcy8bL8Q2vliP+W3WwIERSRGp1UL1s46sX45YwVYqYZklcL9
	IAoA==
X-Received: by 2002:a05:600c:34cc:b0:4a1:fa33:441a with SMTP id 5b1f17b1804b1-4a963ffc267mr124682955e9.2.1793270618838;
        Thu, 29 Oct 2026 03:43:38 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94f629d5fsm47165475e9.3.2026.10.29.03.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:43:38 -0700 (PDT)
Message-ID: <e6b98a2e-a9da-406e-8969-3eb73b6d71b5@gmail.com>
Date: Thu, 29 Oct 2026 10:43:39 +0000
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
Subject: Re: [PATCH v2 2/5] io_uring/uring_cmd: add import flags to
 io_uring_cmd_import_fixed()
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
 <20261022144501.2478417-3-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261022144501.2478417-3-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 15:44, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Add an import flags argument to io_uring_cmd_import_fixed(), so callers
> can opt in to buffer types they support. No flags are defined yet, and
> all callers pass 0.
> 
> No functional change.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804853;
	b=hDHnzUHV1WnV/zeOHH8oL6KoZJkCoC0C6sSuDVuih/Kn5boh73LlFp26DKcnzd7mwNmp
	 rNmMduyGu7o/zbvwsoAvvZbmB6LJIoczidr0ehhePYfpNIK/ilBdDYZhrYU2hR5eK9tKe
	 IWP/Nbeqw1Jvc0YKYYO759I/GlsXNSUT0MjlI/y/eVIkZn50Gc5o0RcBvKUsu4ijBTupm
	 PCGm1GY0tWmzbtbs6fVMt9Qx93iFZNRlJ8O4WqycMqIK85oaGaG5NFOfQ2ZQgMuQN2/rh
	 QINcAmie4mDxkQNjNc9QD49F0D5Cz91vajBn0hshVGoVucI18466MkoVFVQdWHss4rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=ltBTia0nii7it5tfNdPGKdQmAKjBDB1nyFVPhBm9VBA=;
	b=qlugBwcbeB+ZpDc9C0RjqVv7nir00OK4bnBa/mpH5SuVK8j+ym7htU2yc1ViE+LvXCxN
	 fuZxjat1rcZtoF/1c86d3p1RovkOzLVsFpKWzTrJ3+Tp5yIBdXmjSa3s0pNwRDhoU2CRo
	 AnuysJU7wm94Mzr5pXdZJ5NQLjuaF4dCQdEQdUwmT/E3bYgr/p00K8fPL4czUx9ztUT3b
	 lL07ZLlO3bf5RT6rEBogjO75TZzXHj7cgZ8BtcLR2eHJiUoq+8jWgptLUAQeJ75JDQEv/
	 CWqC6dAVzB24Nubu03REREsiCAO36hC3TKTi7vGPvJzE/NxX7nG1rgyZATI0GobTj5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F2gj1HK1;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF4606D80E
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 15:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1FF4606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F2gj1HK1
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-7143451981fso493711eaf.3
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793804851; x=1794409651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ltBTia0nii7it5tfNdPGKdQmAKjBDB1nyFVPhBm9VBA=;
        b=F2gj1HK1x8jxM+X3krmaVUAILWIRI4eLTbUXmOS1jUGUIOlSyvjMIxN6vzSv1DYjhZ
         ODPlQp00iU/As5SYswYZQdwBd69qSRBRp2fYy33Q0jDCMPjs7pDX8eM4LOrFDHb5mm56
         ZOjxtZzPIXx04Grbh7OTG/vrnzE2A3+rgMbeH8vRHUMW4qINP4FIoe4fWLBvFSqwA46m
         Fels8C8DU7I6gFPmFEB5GjuC9kfHCgj+Fku2zGh2MLpTTEIyxWWYhxkEXBDQaQDJ2eaH
         nAhjAR3yVVaDyqM56z6tQ8o+w4ox4EBt6GK2i8kEbL9v3up1SiBebkTI0jfPDkXg1aYd
         NWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804851; x=1794409651;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ltBTia0nii7it5tfNdPGKdQmAKjBDB1nyFVPhBm9VBA=;
        b=mcFLNM2+cHI8c1TkOsdG4XJ3s5lDeSFIwWfM0P1TNXSllWYjKX4rzTl2MsrlmjZRLz
         SbFtk/nijYMbzo0CHNfrplj9PKNmYwcXHec/+vdLcRLmcpMHodwiSEISxfT86ZizeOV8
         7bgMNyCmBl6Ja1ZEwMjag8Uu/bWG92AMkx+nN9DF5kMHa2M5GDDF7vuW/RFHiYAQpG3m
         YoBo7FX1koaRJtKoFHDpnEPY/JThK22j/BetK1hODP3i4u/q4VjXwaBwYigp2rWfyWn9
         vN9J8xujinBF3quhBI8fYzTtt2a1v6mZ8PIeCUxbj8cZI+6pHgx4016/GLW5a640tBH4
         pXiQ==
X-Gm-Message-State: APuU4Z/Rv7LJOw/MdArJdOuoeP4GzEUwkbRZFbDicUu1VtoGBFCeHCTV
	zNJxSlSMB6aNzlrR79wr5K1DxMMAIDDB3N9neNavVHn1r2GYDXP1K5qi0m+RJsQ4t2g6SQ5RiJ7
	ixhCYBq4=
X-Gm-Gg: AYBFou23dARvOhjafkMcTzOmB47tiucTN7/TzISPA0mWLw56tGttSG5CHCEMP61mA7+
	aHcEboeEVrKVb1aXbxJOQ+rlahD8snIjlzQS2zA5lvowpFgLXjZn9rvH1da72DZxl6+QjfBSTYr
	a2EtyzTZNBIkUZgF4RACs4h4elwAZCMKC7CZxiWVnRVcBkKqIdsoozlMHEN8pjlSWsg1sHXqUkO
	qAV7wDpIs3Cd+4Ey44eb2vPf3WmS8bZWk9uF1vgmc8GjuV/FoRiJzVAnyiWVklZ9PEtS15JR+/0
	ADRmUSo19/3/ue/1zO14/wFF/RJYZBkt2dUTnsWwyidWMZnc7EFZErNg6GfUqrs52vR60dhtgty
	qpYLfGGQJSpVFx4fBXg0k8+rjYSqCzZkiWHfhncMctfjbx7KtTOtOEWWD/fsNUDYStI91Mn/Ms5
	TZQvAWiupMILow/BlsIVIwQHyElu+PS3VdCaAqw8GX0UE/pcoCzoQTWxGVsJ7irvgT1TwPZLLI/
	xJ+l7Q+A4PW1aA2V+SxZhMvDPXGv6GiL0S9P88wwLubWcPNy/jEEnmgHSAVAOyn1ZvsBzuv161A
	f87M/rz+SqroS/ZPs2s3j/7kWUURfk+utCJaJIFoefzNgdPPWLlTGW/PoYuKo8y17kySHI+c1pP
	8DowyPvs38Q==
X-Received: by 2002:a05:6820:560d:b0:70a:d839:2b39 with SMTP id 006d021491bc7-714f24d3fccmr5442543eaf.3.1793804850833;
        Wed, 04 Nov 2026 07:07:30 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c0cdb22dsm1886033eaf.0.2026.11.04.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:07:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Yitang Yang <yi1tang.yang@gmail.com>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260901142438.237586-1-yi1tang.yang@gmail.com>
References: <20260901142438.237586-1-yi1tang.yang@gmail.com>
Subject: Re: [PATCH] ublk: add missing DEL_DEV_ASYNC to unprivileged
 permission check
Message-Id: <179380484979.4021488.14146946134679521400.b4-ty@b4>
Date: Wed, 04 Nov 2026 08:07:29 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 01 Sep 2026 22:24:38 +0800, Yitang Yang wrote:
> ublk_ctrl_uring_cmd_permission() is missing the UBLK_CMD_DEL_DEV_ASYNC
> case, causing the command to always return -EINVAL for unprivileged
> ublk devices. Fix it by adding the missing case.

Applied, thanks!

[1/1] ublk: add missing DEL_DEV_ASYNC to unprivileged permission check
      commit: e6ac1da6a53c5f670bf09e60a2500d15be68d2fc

Best regards,
-- 
Jens Axboe




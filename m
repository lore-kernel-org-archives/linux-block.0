Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682172F12C3
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766262351; cv=none; b=C4ur14fq+q0QjYds918H7C71aX8Nk1hMOIDJ+XUBlfwkpMDNfLq3KPU3nXAZykX8xoG4438T7lTQbDdJa+QO2+snfxoumWltLC+2F04mUXRuCWOw37XUe6FydDYaPbpmrGKkAZncJWBZgHxpWGVGQgCLtnQAW+5nKSrHSN6Cvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766262351; c=relaxed/simple;
	bh=MYVHHDYPJQlGy377kN/D5GQTkJQCWYfxlfGGoipB9Qo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RTog+MNWoud8y7G6H6O0XL8YThutv6gz95JD9QJ4C9ziSk5tpG2C8GkVwh6N9luJa2XgHr7AIgqmHoI8sSiOymdnaov0Z3lVxfJ9QAlrzoGOqbcNAh5lyxpuTWVp6syeiighdxVluZ5A9ClzrqurS4EBWQcIZqjq6PAdlhml6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FtvsBmqD; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FtvsBmqD"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c6cc44ff62so2085386a34.3
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 12:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766262348; x=1766867148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECS0k4XdVu/LKfu6qgP9Zpz4mmQaxblDFvP7Po9U/iE=;
        b=FtvsBmqDRdkK/HP39EkHqymXzLOsOnR27hHTXftcSxpm/cTjvu61DKR5H4RG0KYTw1
         Oo4MJIBIROvXeJ+BtGDkcvjbRV99vVAel7CLT5inJq19Qv6Kpc76uiWArvG+X5GrU3PT
         nYM52JVsil1HGpmjXruk6W+ig2TSqYZW7ZkJELpLRKx1S+46yK8ILlCfnxeWaqyYj8jg
         0+ZrfIt9mqGTmJ4eOpB6szGkptp5cLTjoZMIpOypILkeIYXI4bW2BAa/8fjIpoeX3KSB
         SSvF8FYXgyUFddSxFl/1mNmPk/6wRmofTx/6a3f72PB+j4aJrsHktvnGudVSZXJX7FnC
         yg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766262348; x=1766867148;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ECS0k4XdVu/LKfu6qgP9Zpz4mmQaxblDFvP7Po9U/iE=;
        b=ktQKXxryutSoqU6cGQAnJMCkQAGiEwhLcU+ur5IhezOxCQN2bEzzSnTf9bUC9Oq47H
         I+yt2oa3etaAksEyFnJTlhXWbRsujqxUsTVWCmZ6q1GhXEVcXWcvnzuXrQYNya5U0PCR
         +jDF+HDCxdToO1I2abOEkoXE2Uiwha5mtKNNPdDc9eKIpslpCC+uBs4c4cTQyqEIFENN
         8JHz4TDi/Go+ncmFyCAesqphPZqT9cUZgkQw3n6bfZ5Oul1YLrxJz96BkTtpEz3Rg0me
         VA/v9qM2BQZPy4YOolr8nifW9oKWaheCs4DTpXNXJR4DoFR9KBVuPlGi/wsg+nhK4IKb
         mvRw==
X-Forwarded-Encrypted: i=1; AJvYcCUsXnp/s1kCIisHRy1FWMjI8Cgxo1I2wUo5UFJ3a828vBFGj0FivSEG98zz/ZTA2sobdaFx9Ir+G+032A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbxACKUSl5vn34YqwlJD1cgZGBNc/ynIr4tp4zIhxHcP48M4N
	EvW8G93ypDl7ULfG57lR85jdJI3HwY/+TS9w7M1qZV6YafgqncEdFS7TZrEywCm/oC6tX3D+2di
	RCHeNQGI=
X-Gm-Gg: AY/fxX6b/f71fiHZlpRSX5z/OUA2+MO3zeB+dJ0iN9bC3uN34Igb36MzN5DcVktJ91b
	JtojofOkWsMddZXT6aCKdN97dVEKlfVipe77qSEjMG7h6KNP1op1mqmOtghLkCdJUSbMu8hrWF6
	utJ67kQeSFoQgtrc86KkT+D2qZlfGjBFqCfNrvQa5Q7eMoI+tXFF1hKu2fMAgf1XMKmJcJ2yagx
	ZjPmaMPszwOasaYGleLuwGgtxDiZVeHjLMkGsmnDixsqUQWUaxubq0zaZm1SkucN206nDzuDTRF
	zOjxI8TArR/gQzNJ6WbL3aUPz77Gzr/pbWY+KepBvlSg6s3nDFLyvdNasWzuEafdl/rruil804C
	rgyexSScXl658o+OFq4mn0n/GLc5620WBR3wH4Mno9dGimqO0BEyfNKfl21c9SpxZQPQa84yjwd
	i6gVs=
X-Google-Smtp-Source: AGHT+IGHnqUq6qhMw+8+QOCNGqZfJqkiKdZkMU3QPQCb7RcdfwN5RfqQ27Wgup/3i6q2X+NpNWmxjA==
X-Received: by 2002:a05:6830:4c0e:b0:7c7:827f:872f with SMTP id 46e09a7af769-7cc66a5a9d7mr4103333a34.37.1766262348252;
        Sat, 20 Dec 2025 12:25:48 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673ccc2sm4240033a34.12.2025.12.20.12.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 12:25:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Thomas Fourier <fourier.thomas@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aUZiUjcgaOue4j9S@stanley.mountain>
References: <aUZiUjcgaOue4j9S@stanley.mountain>
Subject: Re: [PATCH next] block: rnbd-clt: Fix signedness bug in init_dev()
Message-Id: <176626234708.413702.6669635606958101937.b4-ty@kernel.dk>
Date: Sat, 20 Dec 2025 13:25:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 20 Dec 2025 11:46:10 +0300, Dan Carpenter wrote:
> The "dev->clt_device_id" variable is set using ida_alloc_max() which
> returns an int and in particular it returns negative error codes.
> Change the type from u32 to int to fix the error checking.
> 
> 

Applied, thanks!

[1/1] block: rnbd-clt: Fix signedness bug in init_dev()
      commit: 1ddb815fdfd45613c32e9bd1f7137428f298e541

Best regards,
-- 
Jens Axboe




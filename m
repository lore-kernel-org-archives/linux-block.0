Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3827466A
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497332; cv=none; b=KYfdFHSHtSVe1uhsGmlxeB0cSKtvRjbc0uHUu52GkBOTTJ9Mf8Pg5iZB2rAjLHZSLj7LM8D0cmr+OXT18VUayvU51lYLCaqf4WIiJf9znAayAQzdJTw5Hcu0nYTYw9c1+YBC3tSbpoSnziNYsEr7kztrDYEinq3jquN25yWr4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497332; c=relaxed/simple;
	bh=PuDTKyv9tfB+xWxUoTe8q848BjQ5X8QmcPoOZoPitcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCNk7pwl9uafTQQykFk9htyvfNtuUlaSKKF4XGFP3R1sBoFVzrTddDM+cAAFds885SBoUcK8j/x7Gmf28AEK+Yxd/rd7PQlb5TXfciO98hcXA2N/oF5FkIIaFdC0B6Op9ZbnyYqE03lezhL7/LCZFJnUB4FVVcGr4nYkflnsRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=h7GP2m1T; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="h7GP2m1T"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-486503ae8f0so1371545b6e.0
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2026 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780497330; x=1781102130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18nx2zWThaM2VYJdQpVl8cS/jzs9v1SzCLV0t+4aIpQ=;
        b=h7GP2m1TQ59bEN06v9nFX4w6ukml3QA0O3QxIyEdeaSpbXoR5IQlnHrsA6k3Nb+9vT
         uCZYWfTy43oDmQNYt5wqaYHouJ+gRUT+ZcTNrcyqQFhKyhCZqp3Y5dKKmZvu08p2SFpA
         umZ/2OzCLvw+v1YJtdrSC5AU5dzLxyLALg5vwZrtk3FCLtSSyKPw4N1aZ5z8rG4zrOOh
         EGsXA2foMr8g8y1rgRHp+bNvH7pnqVKvpo50/iJMTZsiluLf8vcl6ldGrW7kr+GfGlUn
         gAyu+sbN/eujvc0l9kDojCD8f8ZACYMhznAuBysFtyZMLrTISbDpv3y2zr4MlwEcqsIE
         e50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497330; x=1781102130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18nx2zWThaM2VYJdQpVl8cS/jzs9v1SzCLV0t+4aIpQ=;
        b=mTbnKpUq3FRtgu1yCOecXBOnI5llx0wrdVeuKa0F+4KF6Q4+cOgn3zuXPFkA/NooYO
         Te6P2f0jKqvSJNPIqpRPL+p4yuqT6sTNdh5PZ+LYvY7St+sU+QI7AekXVpcfIggbiqwJ
         FA5TUN0PWOt4W3ioCXHLHKblIN49CsuEFGvJ6rMk/uys5hBkrm/HY7kjHIzZWMb0Umau
         gyhajG8UMesGkcuxpsHqzf6Pt/MqTQPMhbrSYx5DA313kyU5WrMePFW6as5+AXVU1Swv
         XbSbJ+UIDd1rk6/RtVEXaWhfzETqmGK4rD3QwFxoLjdDGk6x6bRSMdMjTuQIvEcFkB6p
         PI6A==
X-Forwarded-Encrypted: i=1; AFNElJ9Z19Ol9WDhiWVTAcJ92sMt/NmsL72lbZ5JEguoH5yb845B+N+0tfSMnS34l3J3rDB3bzoOxY+S7INZqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLehhX7vHeIzpZrbgChLR/0U4FPOSt+CU/adUzHYgZffRKR3V
	Mudud8/WY6ROCfSXHt602huau/++FPcjONeD7/3CPKZwQGfT6qa0x3EMb04v1mOfHTo=
X-Gm-Gg: Acq92OG6SmL+IMU/q89izrPDA1h5LDL1LU9jXqCfw6AvHyYKfpazwPYjl/FKhQr2twJ
	L2jN5J0hawH52oByVz1Wehztu+9dH3i3ACtueqDf7OkyyM1qq9IWYo0jzKUAjyZARpN0X4r4S+g
	5uguYOPVic3WtfD+dtUIAssv3yiZioybQCBdAT/XMRQzhYg5ZKrhUuV2YukY4uAtVAlG3pjB0Dx
	rXpawrsJQuskU+A2Mu6DZ0tmvWiphPBTffimbTMk9iAZL8ti4reZ4TCD/KLzjuK1sEW/AnXNmnT
	lpbQln1T59uOMmEX8Efj6KaNqxGij799EGIyH0F48QGnWXlhG2nld7w5ExiIXW83vgQgTRs9vrk
	MxE5ZCV6tJpavvNAN45PHhjPrLOQ5eDdK1kXxWrc+1UrnC2Z2+cutUQDWPUViAxJEgX5udIS52H
	I6F81qfg+GlDm9n1tP+T+RRGOkhPEqB3u4VlwvqgrVXbT1drGYcHXsf9aXygCk3VOzEoYRraLm+
	Oqc4Qpx4HGzDoSFSUc=
X-Received: by 2002:a05:6808:2e47:b0:484:e5e2:6b93 with SMTP id 5614622812f47-4865ab9d9d9mr2419978b6e.24.1780497329744;
        Wed, 03 Jun 2026 07:35:29 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a53bcsm1943090b6e.3.2026.06.03.07.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 07:35:28 -0700 (PDT)
Message-ID: <1686f891-599d-4cef-8f38-420033355f2d@kernel.dk>
Date: Wed, 3 Jun 2026 08:35:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] blk-cgroup: fix blkg list and policy data races
To: Yu Kuai <yukuai@fygo.io>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1780492756.git.yukuai@fygo.io>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1780492756.git.yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 7:27 AM, Yu Kuai wrote:
> This small series fixes races between blkg destruction, q->blkg_list
> iteration, and blkcg policy activation.

In spam:

Authentication-Results: mx.google.com; spf=pass (google.com: domain of srs0=eh6w=d7=fygo.io=yukuai@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) smtp.mailfrom="SRS0=EH6w=D7=fygo.io=yukuai@kernel.org"; dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE) header.from=fygo.io

if you don't get this sorted out, your messages will be missed as they
end up in spam for most people.

-- 
Jens Axboe


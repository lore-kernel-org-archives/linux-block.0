Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDB39851
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892371; cv=none; b=fsAfNwBaKMjhS6OhKXwxwIFYH5RNceG6rKXhPQHAkiI0B/gEiZA7nEC23QhDHy30okoeRiPm0E3IXjlt0VuGXK6KMPHeTCGMgJkVYRCRAuH3sWuOkku8PT52RXnwS/eUhlnP+tWX9GRl6I7X6bVoYjr8NMyk/I6HYmorbcBF8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892371; c=relaxed/simple;
	bh=VRmZUZ7hzW28HRtQvdGXN6KU2MCZx4r7s3085QPjl9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mshNnGVn/mu6rTKRUpnhpf6jCEqKe+AM2BSX1gBWyc+JJ5fgcKgo/QT4J1X5R4NcM7taSNNf/w51+v3tr65iw5JuXVSlyW4aW9g3/WRGAPqz4BVChJnQhqjEGIGDHbEHJh9DuxDVZtV48NejZloCQ2zqobeKqpvlupN9k4z+Sj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FEaGlaHO; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FEaGlaHO"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b3f92c866so14475539f.3
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744892366; x=1745497166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCVyYVrtKOBFzuIw/BRxSXJq2vJQsJUFfVx+zDaigBY=;
        b=FEaGlaHOEhFy8wo9JNpkE6aA5GQ1pUUTezTCi0ifhT0j7wT4u0LQiT2eRdRX/aiD0i
         OO6HiyFVvOYwo7xmIASOZ+M5uaSnc8Hr3PBFAQfg7QXcTIJffeX4GZ+OE96LMbTmLF8f
         Cmb3DjnjUTWwkHdbyyu3zziiGlDAalCxNjvdwpWcDjmbvaigePv0dnI4kKwZ/mrbnEjo
         XnE6rYxZ/tIz1ZmNCxVzh9S5rVIYLQY8equzzOh9eOWl8oy/RowdKPH1WFDvCLiYWeCM
         nHm/Oqdcr3Q2DBSMJSnvzHbnH3SO8PIdJgz7juwDf618Fap1FSfzgvP3qrGnTbpHv9RZ
         q5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892366; x=1745497166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCVyYVrtKOBFzuIw/BRxSXJq2vJQsJUFfVx+zDaigBY=;
        b=ljd9O3xFauEeB+MpqbMHs5OIPCS9wZp09q57L8lQj9aTJBT/zW8SGnvlB0pN/FIdT1
         mskDX7IUAGUnYsVBPb5pc/L/FfFzEbUTmAZCGrLUzvZW9cws7cZbeJVfJQjhE8q+YXKJ
         nQJ1ZgpteVvqtut45UijWx4nHmZev6evaLy4OGhglZEq7X1M63iZ0OQpQszR226diLvG
         sTo66026ncjN44BmRLFmybzAPfL/1LWqhTzVXJFM/RMkARjh00n1XSDm+I6EBkwvmcIk
         Jo5X9Ax6SXJqBzM8o4QtoTcLxgwHIXropgMHThGR1Wty8X4PvIMCoOOWz37VqcXuwJan
         7jEA==
X-Gm-Message-State: AOJu0YxLdrPZuvLvsFib9bMvmsC412Q9IrwK0akDkJ/ClPV8Leg88AXC
	pIZix2sgK90m5E3eQWe2eHYM2wpRnew4Wovx8bHW3XpIPGBvNfOiyoAnwj3NJR8=
X-Gm-Gg: ASbGncuDTZvUb0FwBGkgBRPu98/IqN2gUlPcS2OC1A4dHtyLhGqXMFm3V9dcaPePtcW
	rrPit46pxvGlZlOgHph9bHx1ZgfX8D8l1zVxSCn8sFfl47nGsdEqpXDAvlvdJU595OjI8km3tNO
	4laQwQaDwcKlwjbSYpYo+FZ7W/bBslm0h3AhK7dEYsPq8DiIBIzzExSmKHq8PtnO5hj3atgvxIk
	gr1O+CVpmhwZ4g7rcpg27iDvjXresw+oBYHxkUGCtGW+6KAT7iWSaJIaRSEPQAUVuqjlDH0IlJt
	m/gXb7+bN/bWnRwMtb54MBAXRqAyddNpqSPSVEMKFV3+0wP4
X-Google-Smtp-Source: AGHT+IFxN2fVUF8+aXwwbC3OrT+G4BayntFAvihGJjXPkvu6KzSNQ0SIqbg1CP/sS7JBnPH5xE1/vQ==
X-Received: by 2002:a05:6602:4006:b0:855:cca0:ed2c with SMTP id ca18e2360f4ac-861c57bc69emr600785439f.10.1744892366322;
        Thu, 17 Apr 2025 05:19:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d16679sm4193000173.35.2025.04.17.05.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 05:19:25 -0700 (PDT)
Message-ID: <b84e959c-c8a9-4f73-aaad-5b905117e3af@kernel.dk>
Date: Thu, 17 Apr 2025 06:19:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aACj5pg7dLAsfZ1u@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aACj5pg7dLAsfZ1u@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 12:47 AM, Christoph Hellwig wrote:
> The following changes since commit 0b7a4817756c7906d0a8112c953ce88d7cd8d4c6:
> 
>   ublk: don't suggest CONFIG_BLK_DEV_UBLK=Y (2025-04-15 18:59:33 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-17
> 
> for you to fetch changes up to ad91308d3bdeb9d90ef4a400f379ce461f0fb6a7:
> 
>   nvmet: pci-epf: cleanup link state management (2025-04-16 07:37:37 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.15
> 
>  - fix scan failure for non-ANA multipath controllers (Hannes Reinecke)
>  - fix multipath sysfs links creation for some cases (Hannes Reinecke)
>  - PCIe endpoint fixes (Damien Le Moal)
>  - use NULL instead of 0 in the auth code (Damien Le Moal)

Pulled, thanks.

-- 
Jens Axboe


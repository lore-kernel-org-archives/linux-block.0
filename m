Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA52E0B6E
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181713; cv=none; b=rvJJGHkO+e+aT/JgAEDwos07g4DbBz1Yezdth+sD5/cM2RO8AOivs66YZV6+Wsk5KOlyFDvFBuWUAaeYMRSHAn9R6NRr8c2Yr9L3qCypAg8WFO5MtaFjMVsvJicJkWaGOCSnUpQwgi4th88MxFhtKg+A014jk/DCTgdz93lSa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181713; c=relaxed/simple;
	bh=8c3ghX9kbjh14YRu4po0WyGn4QtrA3Wu0UmRP7E5kZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPtOuel84QHg/uzHYl0ykdXjCQ03yhF1WvWQ/lzcfOCIg2jTJD9rbSoUs9IuWVG5mu9As9RUBNqJf6TmC3uUw9kR6D0SF9KdMgWVitmVF8fyoo8AXIGmrj5FE/1TiRq4k7Th4NF7yGYrVGa2wSHhTmDhoZ/jvLRaHEwbyZ9XJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pjHGy9YG; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pjHGy9YG"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-87c420ac179so80163839f.1
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753181709; x=1753786509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8mQgNDfj9/DCSMwSj4e+eU/AqdUmKFCb2rpaObipto=;
        b=pjHGy9YG8494AyVm/kHHFdIm9D0ZNj5+elteR0lFF+rhSt+J59vbNeIol7UINvPmSg
         GFZSN/8tbhrW/rk5ASiA6HFKPfkOW4jOoLw3QcWAnGcPpP0aDNFWn4xl6Qh4pdsDvBKn
         EYYxZeALm6BiMcw+SQgUhjIn+oZFX1I0EeCWqmXblT/av8wfNGlikqt0wCDG6ujMT66R
         oGDWT2gQASFH7qtA4KBKhq+NMQlqQrj17i+f9v0wq80vHnF5J9F5HfUXG0Cp9PdiwD5h
         VfUIxf8hYyXy1OgeaK3ppkL/3BThFdxlDQiGuAoCm5pyZMeJmubx4RdsVBnKYtpBTnDp
         Nhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753181709; x=1753786509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8mQgNDfj9/DCSMwSj4e+eU/AqdUmKFCb2rpaObipto=;
        b=IYAkQ5KRwSZ2eCGJIagFiI2tGuv9OV0kCjGmmQLZ4YsfEWh+3ZwlkinAaFqt+pq9aL
         2nzJKSAJZ1in4MEFXDvJq0ciSDjwHyWWaZDOXzK77E6aKZ9w431C3KDv6Rsdr3Kxs71G
         wusc8O4C1nJia9eXf868VFwl44ETd8ZZjKeqmw8un90awbREbEd76fqoMIvjz8MNW8/Q
         O/HlDxo95vaypOUL3aziVgsxgIpUquLNMI/lK3sAgDdx7CsN7eMVNr/HX12AEkUAnRMg
         p06EUPZmG2yAg9wkPyFSR/DPsLJh3SORtRFthRevltGxL9gKCrYpRNePSQjiHV9+JRFU
         b2jg==
X-Gm-Message-State: AOJu0YxY930/9d/NWyicl39DQSRrjPpOiv0aIRJ61ldCUMddaEfUPfu7
	7SP7Y3YmFyO0LYEiF4cdXU4s6mvxlW9fDAnoGQ9QPBPQELzhw46INBK8ZFKC6xek+mVefMO/yOB
	mZMjV
X-Gm-Gg: ASbGncuFSZpFnjJkKQzshKsO5GTDKHw9GzyYHe6c/40N/xLgDVrYx4IxbBwjgHb84L2
	JDir11i33EXADwk4kxi1hVsqI04BbEECOplJL8/MYNuOoJniSJlKXieMyOlo8jFmssxPNvwBA2/
	ObvRpNuPBGMRe90OWIn+BrW6+mVLZjNmvAEOwFdT2Gf1enRVlDGuKslt3q6lVSluSn+d75HjNpt
	p7P0q+tiwqHv7ezmPYCN0rgziSElCuqaWbUCFvOjmr/SioPBNpTAPxGxnO5WInEO2cLHZjM9z6b
	JgL4vLlMpAwHduAOePhPuXBkoK9Z/DIfu+UTD6Vc6BZLtDw1sYsYBX4Q4rgDNrek0ebOJgNX5qg
	YS/r+QBj87XQG0Migzp4=
X-Google-Smtp-Source: AGHT+IFg4g8uCoZqaZi2cgFfI8SmZnEMwMa0z6ZfpKmCt/Qia/PM+IeeQoX8fzecqzLOKJrgT8ciiQ==
X-Received: by 2002:a05:6e02:180b:b0:3df:29c8:49ff with SMTP id e9e14a558f8ab-3e282ef06b8mr312674345ab.22.1753181708591;
        Tue, 22 Jul 2025 03:55:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2a86bb755sm20270715ab.57.2025.07.22.03.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:55:07 -0700 (PDT)
Message-ID: <252e6af4-7024-4805-807f-ac8407808c24@kernel.dk>
Date: Tue, 22 Jul 2025 04:55:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.17
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <aH8qCeSvpt3eH5g_@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aH8qCeSvpt3eH5g_@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 12:04 AM, Christoph Hellwig wrote:
> The following changes since commit ab17ead0e0ee8650cd1cf4e481b1ed0ee9731956:
> 
>   block: fix blk_zone_append_update_request_bio() kernel-doc (2025-07-16 10:02:18 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.17-2025-07-22
> 
> for you to fetch changes up to 5b2c214a95942f7997d1916a4c44017becbc3cac:
> 
>   nvme-pci: try function level reset on init failure (2025-07-17 17:46:33 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.17
> 
>  - try PCIe function level reset on init failure (Keith Busch)
>  - log TLS handshake failures at error level (Maurizio Lombardi)
>  - pci-epf: do not complete commands twice if nvmet_req_init() fails
>    (Rick Wertenbroek)
>  - misc cleanups (Alok Tiwari)

Pulled, thanks.

-- 
Jens Axboe


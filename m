Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EA7AE70
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705010; cv=none; b=eSEhmGW0QtnnOuXA6lrlLXD+xBIAYJOJ+BLNl7dWK99PlvXUIjpyVH2sT3HIbBIMnsKUM6vUbC46KKYGdfnOU2rbSMBgC3hfP1VbNwZ9LlX9lqE6Iy0VVCrUv9eQBuhtmgmEXG0gOm+/mklsrJxm+KeAsvWurnV2TlETYWQlICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705010; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aypDhWBh3+jy3N06v5Iq/8KkHHp7XOesvZdbo72NNvlx4zMky1E0DNEqljRFPC8MvdLBcOfkpGdKFa5epmv1pLIl+uPg9aBE2G8IObl0Xgy2li+LFhP9YDVK7gIBJqEcpyk+x9cTgu/F4d5lzjL+cvWiPfqTqYurFCOxQD7YLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b0706a35dso78266f8f.0
        for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 04:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705007; x=1707309807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gjcVAkiqfejdFAnVLPbLslOIqXMZBhyOtXa1cUeuXHsdcECYzQ6wlZdNY6PrcY/rfa
         JxO7MosJ1zh8fwwj4XrWK9DE0W9qZwSca7im3rNWCkMWij5ftgUxHoew2pfgrhzj2666
         sMHMPNv/XmddI5wFrafYIYa8SQLp6eAaa9cEK4bnBKrP3604GLqGAO8mAn/hBLXFihRH
         4k+48heTtSTuLUPClrRo6zKMgb14TE9d6zrwY9NFXYWXI2PEFgPYZ9yvpqMGY1NlYHVS
         vEROaagPv89RlQj34GdG1rCj8zubrLFdjYDLNKOQxWN6f3uT6JPMO9vrRcJUPf1O6mdF
         8Yow==
X-Gm-Message-State: AOJu0Yxv2b/9buvPrsfFZYeEbn0S41BSKfLPmzVMSTsRsW2piJ3kq0Th
	4Y5EGH8rosQPmMQk6qrI5ZHZoZgewGoPODYL+5DFUmlV/qzV1hpK
X-Google-Smtp-Source: AGHT+IFwfA4qb0TBREO28lrjIs0bgdWaJlY6uqduBwDmhEfJmwPEi/lIrMh3W2X4Z9uUPBwvOX8sOA==
X-Received: by 2002:adf:ab19:0:b0:339:44e1:9541 with SMTP id q25-20020adfab19000000b0033944e19541mr1016634wrc.3.1706705007541;
        Wed, 31 Jan 2024 04:43:27 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b0033aedaea1b2sm7893801wrs.30.2024.01.31.04.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:43:27 -0800 (PST)
Message-ID: <c5e0651e-c3f6-4fe5-b9e4-e84ae5490d82@grimberg.me>
Date: Wed, 31 Jan 2024 14:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: allow integrity when PI is not in first bytes
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, martin.petersen@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20240130171206.4845-1-joshi.k@samsung.com>
 <CGME20240130171929epcas5p24f6c25d123d3cd6463cbef1aaf795276@epcas5p2.samsung.com>
 <20240130171206.4845-4-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240130171206.4845-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

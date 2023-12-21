Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049111D6BD
	for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KPKcqm//"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3995921e4so2279485ad.0
        for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 06:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703170080; x=1703774880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzQtoSlpyWBkQFf/sgtyIrhrqh6SczsUoRKAnRqLvvk=;
        b=KPKcqm//FUrM7zmZ621ZcySSUXARc0xNS1WLcHzUcFfenJvub9eemwdgDkoDKOuCxa
         I08wjvEfrA3x9Gj9F6bAr4WkUmRkk206owxuk4aFlFL3bCu+Uo+AMquovjHiBte9o3A0
         q5BBQPh5pujNCXP/bAsoytoHyb5SOIegv4L+/CvTRr1lknQE2nkz8vq/cmYMvgI0yXE9
         rUM2tn+G3sKnDDz0Spi/3UI/xBm3Z9MpkgYcic1fS6YSTl4/JZ5DPyBVWWybg1MvURcN
         tNIPox7w7ckDu8Hqf4MyqT0qpoTPzmxznvDFJ4qG3yaqPF/yh/iuQ8pic19f3VQndEr9
         cf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170080; x=1703774880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzQtoSlpyWBkQFf/sgtyIrhrqh6SczsUoRKAnRqLvvk=;
        b=O40YQHqEmWsEciMMfFZPQmqbOuv/8b2/WU1kn2EHHiejwkzZGaZhcBcfdWjCmW8YbT
         eoEQi3v9H0O6PvoFAjGiSYNPy7pXtqPBT1PnJFSr9CyvUZ/9jR23zrnPKeiPieJI6C+Y
         2Qc2su51e3lPmeXAgtITs8EiCyiY9Un3rRZMyfewW0dtE/UPbYQdrfO6Jjy2HfkQ6gJl
         9Orro0jxmad7F2q30UuGhMDcNDE0kC0tiLxOWXXOBUWhOS8RXyNhx0C0r1M2S3Vs+le7
         uNVTR1czJW6S0gM4yosWGz58Kf56VGdfWhUfkR5pFXfMCiEhTbRCzD2mdjgaSf3xKwNW
         l8Kw==
X-Gm-Message-State: AOJu0YzCbb1yz48cdoThm4YdDZXDRgpye0X0SSjiTfsqEnDfCniSweta
	q9yNG89NJazV38qs9N4NY/COWjsrZRgKGH1zGzXpvQ==
X-Google-Smtp-Source: AGHT+IE+uHEv4GoQP9TMhfeKSThvwLcflnTuIQ3brHKngrqm/ScZdgN/dUz2/DT4zPqeGgj8vQorNQ==
X-Received: by 2002:a17:902:eb06:b0:1d3:e40e:84d0 with SMTP id l6-20020a170902eb0600b001d3e40e84d0mr8180502plb.1.1703170079960;
        Thu, 21 Dec 2023 06:47:59 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id g22-20020a170902869600b001cca8a01e68sm1713869plo.278.2023.12.21.06.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 06:47:59 -0800 (PST)
Message-ID: <7202bab7-e729-46a9-8a9a-78bcbfc9effc@kernel.dk>
Date: Thu, 21 Dec 2023 07:47:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: export disk_clear_zoned
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20231221052815.1063146-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231221052815.1063146-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 10:28 PM, Christoph Hellwig wrote:
> disk_clear_zoned can be called from a modular block driver like sd, so
> export it.

Already queued one up for that after replying last night, so all taken
care of.

-- 
Jens Axboe


Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0714A4C7;
	Fri, 31 Jan 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738311233; cv=none; b=n6SgyL8OREXM7Ytg1au+J2oVHom5VxgEZFg78GHPhv1weMlXno8cXuKibdKQwbFMCijjoYKxypNpN3WhuQ500oYMbSN1MZcRIEybv8ZNipwSncSlqh2hSe4/zVNzy4zyHlB9n8TjIrrDcJUz+cU+GjTL/wVIElyIyOXieiZ0NXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738311233; c=relaxed/simple;
	bh=oxkRbc3o2P0p/SsOZc3MA32q9r/+xAgUWRcI37qjvj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbkF/BtTfeL1fRlMzH2/Cj4EVhsligfZfNEnN0FHEJqYOaJov5qiSD0xl0fcRB3WzbnmuuNuYYeKOycB3Gcj1DKiwIzn6VEv/hMjJYQBoMCEin1L1uvZ742mSN2gjQGl2vM1qMmyKL7xj01CG8QxlhfVDRBZjfiJ9gTxUwP8sbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361c705434so12444925e9.3;
        Fri, 31 Jan 2025 00:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738311230; x=1738916030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50CUTD+eXlDFcOOIGMT4jmUgN1KvlNlJfvsnt0dgNiQ=;
        b=bWoVLXzledjSk4AONgHep1gZbpajCLQqiGkFBKn7FJSQsePumy1XwcXaVOMp18u6rJ
         5ahUo5+2G4L6wZiu+O7wjqaGCLfSyoNyY7OH/dwTWuyoAhAN8NFWLVmAIEd+papzfJzK
         lXjPsz+Ej7n18GKVEqy4fZRDZ1an4AUwQCGU8dsXvzl8ljLBjKtaKfaZrL6RNvSDk0aO
         aK2vIkRB8abqkrd7S/xw7/yDaoWd44sOEQYA/HOFZsSLfEOLdbhwDJ++WGqCgHytMmqR
         oPHUu/LVkQGYFgy/XEnQoZNv5fM+PRFgvHvGXlS4Ovbd50eQcHeyFzpH9em3TT1rtgli
         5rSw==
X-Forwarded-Encrypted: i=1; AJvYcCVyZOXvUcEHJciTuceG3aMdAhteSJk21eDmhBa/QxPNit6skgxLqElhY2IHodc/DmZwi+v40W/KGdMKkA==@vger.kernel.org, AJvYcCXkl55XmpxQA2sqhHJw64CFd2cgq5zGTUI82wMB+oYNH6Olt8J2BQega1Dmeq8X1f7B5GvmP9r7EMcFW3Wu@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcAdnL3jrLg7EkGeFLXFLqe95M7uOIoynKeQJsNU9HUFaJzyj
	5c3CVbXY/2ebquBo3U0dd7iWn/WOOW1QjD1BQ4Rv5ry3wGfzV3TE
X-Gm-Gg: ASbGnctxAhEn5d6o5mtG74kRlykg/os4Gp6UITk9cALuc97YbsDAfTiJ+YIQSmo5tdm
	BPKRTcR+02BS65yjAN4ojb5QmikAgvZJp+jnbTjvUUZIfnqXHY5Ch979O/+C62DjAuoLqYEee4b
	4fsZwYZLpNTYC2jzCay7MAGhzxJxbPShs9vnw15xNCdEEqEqzw0mZqWcG1Rc6Cu30GgLiSNIuiO
	TbKRCE3cQpfV+7+nEt35bA5rsBy/TjBuql0ecNRwrxbSGUQgjG5elNMY4EeKQtLfNnG4CLanQWn
	v8VS/M1N8ciTaeIcF0RNC/i2sDJEKJzIYI/uujbMZpoD62C0nnc=
X-Google-Smtp-Source: AGHT+IEHmAcCX7brBdYswAnG+ah2odio1aZslsU8WT8VXhb3+lqKiizin7jbBKbTFIpnR2Acwshg1g==
X-Received: by 2002:a05:600c:5252:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-438dc3ca802mr92486035e9.13.1738311230257;
        Fri, 31 Jan 2025 00:13:50 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244f087sm46717975e9.29.2025.01.31.00.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:13:49 -0800 (PST)
Message-ID: <b53dad99-6a8e-402e-9330-597289ecd8fd@grimberg.me>
Date: Fri, 31 Jan 2025 10:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] blk-mq: fix wait condition for tagset wait completed
 check
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
 <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 28/01/2025 18:34, Daniel Wagner wrote:
> blk_mq_tagset_count_completed_reqs returns the number of completed
> requests. The only user of this function is
> blk_mq_tagset_wait_completed_request which wants to know how many
> request are not yet completed. Thus return the number of in flight
> requests and terminate the wait loop when there is no inflight request.
>
> Fixes: f9934a80f91d ("blk-mq: introduce blk_mq_tagset_wait_completed_request()")

Can you please describe what this patch is fixing? i.e. what is the 
observed bug?
It is not clear (to me) from the patch.

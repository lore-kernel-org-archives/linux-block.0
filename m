Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3F274669
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545279; cv=none; b=h63OJj3lgOoN7F8e+NZHpHI6LeJ7diHnh3AapJsdHhPeoEWiAxw1+v26ID4BjJDVoFwAWR0zSD2iGHD6ffI4t4AsC+Y/ExwGhu9wbBOqEO10jKKAOBA969bc6K8hT5GrxcXn5UQCs320EmIrekSje64ZYOp7Mnvi3t5U16sQqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545279; c=relaxed/simple;
	bh=9FNEzHVnZ5vhZNPRYTu3QWZEJUJ8raRtCphgsef2K7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvS3FKCfT13lZRUru/Nig5qyzUGyaGBHQ26McX+8JkuOZhcHF9OMKuYOfuQBkifBtPCcgIHoaUNamKYsiqVtS8L289I0Omfgz2xbDwvB0aDrm/rMX8ouboI5q0vuofnnDScDk8+v56QuyZz4o9ufBMEagYFxPADdiJj2JaPGnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lj3Fc7pE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lj3Fc7pE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29806bd47b5so41867615ad.3
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 01:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763545277; x=1764150077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XASxHRleQBRSHULYp7OnhBgV/g54YwSfkjBP3jWDjdc=;
        b=lj3Fc7pE7uk1MVmSslx96e7HSWHMfKQUBL4IAfJxQUSXKodxMAq8HjQ1CeQoEyKRcS
         8/k73g3A1Sg7qMZsBT9YiuPBqIP3kYsbjL21W4BfiOWZ4sKfPrA7aETV/Bx9OLHkJefs
         QVjAGGcbwdoLcEKcBmtitbiKg8uSGYWijnts8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763545277; x=1764150077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XASxHRleQBRSHULYp7OnhBgV/g54YwSfkjBP3jWDjdc=;
        b=Gtq9q7bvWFh6MsDEormlnjQWFo8XINFCMzYbie2BmtrbpT885WnfZiycyZbRdYwLLN
         70UrnGqtZ3d486Dfhzoi3VwrwEoOL3bJe8gQDJujaqB9j3ILePCfLtB/zIvrsYuyj0/6
         /HLsGslzWFT+AJ94oxmH0MgspNH9pk4nzWgqeObwzGrpDMlmdw2SzdvUfRsCIZzOEvlm
         lRcghsNVnNgQwk6vUf4WjiPv6HTVdPyNoBtSh5D8tlBVMNnARAtIwkQUhnsgp4st6fGI
         BybL1mXqhSkX3u0RAJh7pBdzIeOTJ1n1FCbwNw/1xgLhEWlg0Q8s5kvTxqza5/ktyV/8
         D2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVl7tr+QVtV4XE4g8nfI4tBfipp2GW6nVm+nVGj7bhs8pfIDpxwqkPyrABEmQh84G8kHSwGi6n9h8L3vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOyY5SmFbrqDW4nl36JpHtHHdoWYWaGuip/K7fTj9IKaQN9ICB
	nk/FV/+i3LT7qKyzgWSP2ivL0X+VSPhjySlDObDEwhtRlG1z4Mp9bGntqltce7pwZA==
X-Gm-Gg: ASbGnctKrwQaH5yLxLQquBWzjefcuk2ZSrbdJiPBIFZ0dqD35Tv1cpxNKvEDNrd8KRx
	23uX8ADnusR6jIVLqm8DuOCPgxR0N93SsKo20UpKTmZu268+t6HRTW9rDP4rLR0pWDYl83uVBuu
	TVn4HBxvobzV5pECUUyn2K08TQMr6utBtP7cAsn6dMv0yA6tJeJAlALgKRs3N4ONNYoEBlY1Dr9
	hLNHqRhvVe6gs4hLjflxINs/s8tG8NsO8BJdHWOqQpMVrL3nDYdkeI2eoXDVF3gNyEnpCHg/fGL
	PQVxTX03abAQt5LO63khdnwmzUTXW/wVkAivzuqrbtHRrEOA777YSv7obe/2jqmhRlv3OToW7fT
	Zz3DVVPOLlkrmnFrkpHIvQiV3x+4e5n+SeRqY1INX55ycftsk5okaNzZ5jjv2dIcU+3FSczWkO6
	PTMrnASlbuHZkSD6UNmWPVaAg=
X-Google-Smtp-Source: AGHT+IEIbGV68qe5ogDM3LY1Ql/EM1ZBfBfrjzGbXq126G1CDb8vAAEYIwxCopcs98zeOGilMmoCfw==
X-Received: by 2002:a17:902:e947:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-2986a6b873bmr222485745ad.7.1763545277153;
        Wed, 19 Nov 2025 01:41:17 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5505:c63:fd70:efb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b11b4sm199455605ad.73.2025.11.19.01.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:41:16 -0800 (PST)
Date: Wed, 19 Nov 2025 18:41:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: dan.carpenter@linaro.org, linux-block@vger.kernel.org, 
	senozhatsky@chromium.org
Subject: Re: [bug report] zram: introduce writeback bio batching support
Message-ID: <xvqcwgajkno2ngielrg2nhu6a2mdmwfuxelkws5rn7ylmosycg@hpokysg7vfze>
References: <tencent_EF2ECF2226EEB0712DD7EFF3963CE1AF9107@qq.com>
 <tencent_58CEBDF202BF42BA908A9EB9D5C7FB5C6B09@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_58CEBDF202BF42BA908A9EB9D5C7FB5C6B09@qq.com>

On (25/11/19 16:50), Yuwen Chen wrote:
> Hello Sergey Senozhatsky:
> 
> Regarding this issue, do I need to submit a patch for correction or
> resubmit the following series of patches?

No, that's a simple fix for a patch that is in akpm's tree, I'll
just send a fixup to Andrew.  Dan, thanks for reporting it.

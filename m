Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050E1CA9C
	for <linux-block@vger.kernel.org>; Fri, 22 Dec 2023 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K8GBMXry"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ce3281a307so206321b3a.0
        for <linux-block@vger.kernel.org>; Fri, 22 Dec 2023 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703254479; x=1703859279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxP846ila5HC5QUIHWCzeeMfNdvXzpaqqn4iHockCig=;
        b=K8GBMXryppkRH9pVeQI2Hzt8to1lR0jTpngp8bcys5yIVbL3LH3CrHjEDRmZOLscd3
         PmP3Y+c/XKnLfuVXC5jUbZIHvbPbB3Q0AShp4l+3ad5pq8HzaPWNopoKq4klPxwq0Vk4
         Fwy46iNMj/Oz1uDolFyrXCYpXMfYzRIy/pcjtVdBv6CMmNer/aqCyoJcM59JO5t/0EdB
         /OAdX94OTyEJJmyrC/L1TX6Ioe910Qww4jvmT+wNuK4eHJ7NZIcUXbaQWNvX3CbKRBsn
         ri391Ua9PHTl9tuC3D1FiqovWva5MfmtVapqXd7QmSTiAnTCj3tmHiR0iDIxNYWQr5PB
         /RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254479; x=1703859279;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxP846ila5HC5QUIHWCzeeMfNdvXzpaqqn4iHockCig=;
        b=kQZcSStYFU0wiJdOQ0zRkkEYhE5ENe9lnG4r+HhtZBd0Q1y7twgzmlrNVOcHihlwhw
         Mu8ztvP0DCChZEwft1Jsnv6jbnk8ujXf+mEUEYWzNAl+Kc58KZTZP6HP5Rsd3yyZZizM
         7zCfVl1EBokLfQG2ZfnYkFB81BZuskwBkv/UMSnUTUUpPvKM/QCB4mWsSx6Khd11nuhX
         j1Y7Zzowl9zSNK9vLgia+MhNVmQXdQ1jRpMJsxXVGKzcyKcebIdgt9YiKCkeqBoSzJI1
         d0v65akW/4L3BEcTHbKhDDIVEkv8YxaLy2JUZHDf/Ii1TMKfzOOZyDL8o16XKOMGHOMB
         Ddtg==
X-Gm-Message-State: AOJu0Yx0yYdP6hp/rQHBoxUjkp/P+cU+L8HBdUR3ge2LS8hyZov/riel
	xFSEJo4rEnSbbE5+vcJTxdhdqVKwcgAlgm/kg9fLNFwpSDg5qA==
X-Google-Smtp-Source: AGHT+IGSxkEMZ+cyUT+MYpvbhIDTAdyeZCVUWWbHVqw+nlHpg2d6NT2avyOo0QtNQKqY/Gz8RIrdfA==
X-Received: by 2002:a05:6a00:188d:b0:6d9:6ab8:e40f with SMTP id x13-20020a056a00188d00b006d96ab8e40fmr2743351pfh.0.1703254479259;
        Fri, 22 Dec 2023 06:14:39 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jw27-20020a056a00929b00b006d980e3ded9sm1953668pfb.203.2023.12.22.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:14:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, Kundan Kumar <kundan.kumar@samsung.com>
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231222101707.6921-1-kundan.kumar@samsung.com>
References: <CGME20231222102344epcas5p43711f96bd85104cfcb3e3a1fab5eeaee@epcas5p4.samsung.com>
 <20231222101707.6921-1-kundan.kumar@samsung.com>
Subject: Re: [PATCH v2] block: skip start/end time stamping for passthrough
 IO
Message-Id: <170325447823.1023473.16227096348315136854.b4-ty@kernel.dk>
Date: Fri, 22 Dec 2023 07:14:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Fri, 22 Dec 2023 15:47:07 +0530, Kundan Kumar wrote:
> commit 41fa722239b4 ("blk-mq: do not include passthrough requests in I/O
> accounting")' disables I/O accounting for passthrough requests. Since tools
> like 'iostat' do not show anything useful for passthrough I/O, it's
> wasteful to do start/end time-stamping. So do away with that.
> 
> Avoiding the time-stamping improves the I/O performance by ~7%
> 
> [...]

Applied, thanks!

[1/1] block: skip start/end time stamping for passthrough IO
      commit: 8e6e83d77227d9ba39e0c7b50693f1b4f8728006

Best regards,
-- 
Jens Axboe




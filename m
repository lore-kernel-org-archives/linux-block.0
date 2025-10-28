Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D071D54FA
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622283; cv=none; b=hPPVTugAc0LZkqcfzYSM9c75OvY8dhDtbIi0Y/o92iiDOtwc1dppGTd4zBkTghbirxJjy290IprFodpq2QPqT4b2sxlbAa9iPPRzyjC/62R2owKzjMTYQEzgjFKVV4mDOzkLMZT29QKpg4oRyBQ6tzUJ9aWg1H+zw1pqhIg6gMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622283; c=relaxed/simple;
	bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Njll4cR5Ue49qXwGWEx2qL1Y//HJx3kEqjjn19hi/Y3ChNMdsy8ULIP/RbEo6Th1iA1kRiOOuJIfpYo7pqoyqG2dZpH+23bG0kq8JbWufIXgVywztJXO2+JiYwlFWhKPvd+BDt7vGB3mLipKdNPW2m8iGisEedLI7xkt34zOfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mr0pPjTK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mr0pPjTK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290ac2ef203so51293485ad.1
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 20:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761622281; x=1762227081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
        b=mr0pPjTKpqmKglIs4NbjktC22qUtAQDnv5F7niBoXR9XL6cq0j8BGWDf1xYaQ4GzNp
         ZqMtTTTmHGkW8/iZTQR2hgm67vDtkBS9v//LIu7KXOPI1zV+hB8mEHSdopPUyvAcVWZo
         M/lxNmOSp4JvdjK/7ouP+R64DZCKANW/dXJI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622281; x=1762227081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
        b=adQ1XlG0NjOI81XXGJ2YDXdRcXDRgjJIyot7168zOLPpmwLmFmQSoU/otiAx21gdal
         ZKKh9JDxMITWhqB8gWt65kZlAO9j091jAEmcrcqI3b6iMmC7C2LROd8q1dZbxtO58E9F
         KWkSya7xPaiMtZ6Zw9XOa/lSbXvHxMG4gk8djgZouAUBDrthnekFsYiiwNIBzktG8Np9
         3gclSDyKH34jhOs2qmDqZ94pyM4iJf6hd1fIcyJNs1mPOMVLhZYBGzvuABKqDApv8RR7
         XvWqfWVwp7rJTLzT04fTBaT2A6mCaSRCDX2UAplvWGF25rNUsJQhb9FBBnNj6jaAafma
         30IA==
X-Forwarded-Encrypted: i=1; AJvYcCXFI4+p6wcYaaXsbhtJT6IUnNP6usJT5n2RW37WYKFSHbxfrtOFYOGtL1VCaF9im4n31Gga3M8qSDcz5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+4mO9jLLJ8SShlZQfMbX18uHldFTapb6wbYu0jUiiXxqGs//
	6Ped/VMBqNadrQvukyYT2LGtV013FKv8QI8BWT2nSdPDgdq1xQ3gLggTHg8QGo6w9Q==
X-Gm-Gg: ASbGnctLFkPDY1Btgi8ZM4z/XH+DpENMpViTxGXwXHKz6o9ybnG0N1RW2HchJOquaL6
	LsPWrqVBMLSFmWNJQ8vkBa27Y0NEzwEFydzKDDsEoj+97gD8LQ9aR17M/T9KtXa3JBMylexbkUG
	rugwe8uscFB6adAH6k6Fi+iL0YfxjRQECBG2GtQaKvYiFAm868yVnZGUtEn20RJMwXhY50EEJxJ
	xlxFE76pjqNjaoy+ysj6arrTdPT+yltJwxMfePHLbceBjtqbNKQxeo7qR0PeOacKj+V90Bv6SDq
	uUvPRdvmGeIyTROmNvZrKVZzN/skOYt+OPOh9OgXp9TqluOC+jqrc3eMGa42uIt++t41MjSSZaM
	GAgs1Ef7Q5/ieyAI0cnFtuGKHG3eLiy0+OxS9tj2G+EAWcPKZYx3VIXWZ+Y+KAdg+h/3Ug8AXI7
	937Vhz
X-Google-Smtp-Source: AGHT+IG4vfR0LE0WG8LCYJmEN31gkl7hCsYmhmgxpsNHn1XBOsYb/cbkA/Iv5cZPqQ3IQLRXV2PyoQ==
X-Received: by 2002:a17:902:dacd:b0:290:af0e:1183 with SMTP id d9443c01a7336-294cb6746c8mr22090685ad.51.1761622280960;
        Mon, 27 Oct 2025 20:31:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:2c65:61c5:8aa8:4b47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm100342125ad.6.2025.10.27.20.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 20:31:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:31:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: jinji zhong <jinji.z.zhong@gmail.com>, minchan@kernel.org, 
	senozhatsky@chromium.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, corbet@lwn.net, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, axboe@kernel.dk, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, akpm@linux-foundation.org, terrelln@fb.com, dsterba@suse.com, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com, 
	linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, zhongjinji@honor.com, liulu.liu@honor.com, feng.han@honor.com, 
	YoungJun Park <youngjun.park@lge.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Message-ID: <4tqwviq3dmz2536eahhxxw6nj24tbg5am57yybgmmwcf4vtwdn@s7f4n2yfszbe>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
 <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>

On (25/10/27 15:46), Nhat Pham wrote:
> Another alternative is to make this zram-internal, i.e add knobs to
> zram sysfs, or extend the recomp parameter. I'll defer to zram
> maintainers and users to comment on this :)

I think this cannot be purely zram-internal, we'd need some "hint"
from upper layers which process/cgroup each particular page belongs
to and what's its priority.

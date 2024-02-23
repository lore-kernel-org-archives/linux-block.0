Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D1DDBB
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663148; cv=none; b=oHEVcw8PIGs5ceGjLWUnHgLoCviiRPXBQULqDeQpbLPAGXrB58m8887BeBDtb7Nl30TspWzcH9TQTY+xiE/JGND5+fPsFRqmQAfaxqdZh4aGCr48bV5ZDYHUoj8XtMS2hSvPeyrbsgb35JK/WnY3UR4dUbbIpMygwm6la0ERDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663148; c=relaxed/simple;
	bh=1UIUOs5r/dRsJsyYr08dqARlq+at8E5E1OgR3H/M8Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmRIwffcFhLg+5Gxnz0h84QW+tvUpQuAgFr3DbaFKU/MHyts2akat9uez5oVOBgu7j59jXJ3VEvvsH+yT6K4I0TwxYl7qgxfJA2SerZYCMMXzOWG5hKezrd5mwhuAJbqte4/UxnMFJ1yHFAFVcEUY8q2wF5tbmdD83qPad+pm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ni1qXX5H; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ni1qXX5H"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c0a36077a5so320260b6e.0
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 20:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708663146; x=1709267946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9v9ZauwyDe1M37AS9Y7KfjEzml4TFiFvv9tU2AEEYig=;
        b=Ni1qXX5HSAk1reChoqh1B1ZgoicFxtAOAqzGUs2U48Uifb32a/wx/Cqq8b/Mk45amy
         1Ih3c2Yfuj9AFa8nXs2/SrrPBLQHANDQ272Y2h8x5cd/jQGCpF/mgtKUVYwSXdz2+D6K
         B4eYfYTr/kfDcl0C1uxESzhN2bS+H2W3GsEaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663146; x=1709267946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v9ZauwyDe1M37AS9Y7KfjEzml4TFiFvv9tU2AEEYig=;
        b=bovDoo+v9SR18z6VEXFxgmme68XE4EYWceDT5j+o99+ib5g91WhHyvIa+5Htga5fnH
         ZZuquqzhwxY5FKOp9IyBQFmxwVMVkvtcpbiu1gUJmnBY1WB16wTFALfj7K4PxpvySvFo
         GbvQgdU6vrIC0mErFbxREgnb9IIwIasjMqJjt6xMpFA5kYfINHZoUL+H0gix5d+uB4FK
         RKGldpozf1RuQY09el4YFEro99DAkMTC2DXmpsOV0pHY1PGzf0wLBwOT6uhCrchN1V2a
         3IT24q/PR7rwxcaituW+XvOn3mmXjfE7UmVSJEWAVsdK9/y9+RcDJOZum48IniukDwn7
         Fa1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtciIb0+m4hZYgmm31zxtbFTtGONZUqf+wsO2Ox127Gk1wPbPgukusWG1PzUsV4V5cwxv3832uwyk8ruwQ0kAB6wo7z3rS5SqPL6s=
X-Gm-Message-State: AOJu0Yxra/ceROAJykZZvyc2m2R+CbXUETNl+BTXaxAjl0Q4EOiBqypR
	KemcfLzK6YIxSTfetdQY6qeNgin2AN9lTBXz86k7hS0gHw5NHsHQLs1+RbB+XQ==
X-Google-Smtp-Source: AGHT+IE9FtCF9D6Y/7m/Rp+S65RtVGR52kYfJHQsOyMQT8TeU2Ki6hAWZQM3SqVkBlGljiH5fkm/fA==
X-Received: by 2002:a05:6808:d4e:b0:3c1:7d97:c4ba with SMTP id w14-20020a0568080d4e00b003c17d97c4bamr975397oik.48.1708663146506;
        Thu, 22 Feb 2024 20:39:06 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b194:4f71:568a:eeb0])
        by smtp.gmail.com with ESMTPSA id p129-20020a625b87000000b006e4762b5f3bsm7601766pfb.172.2024.02.22.20.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 20:39:06 -0800 (PST)
Date: Fri, 23 Feb 2024 13:39:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/5] zram: make zram depends on SWAP
Message-ID: <20240223043901.GI11472@google.com>
References: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
 <20240223035548.2591882-3-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223035548.2591882-3-wangkefeng.wang@huawei.com>

On (24/02/23 11:55), Kefeng Wang wrote:
> 
> The zram is useless when SWAP is disabled, make zram depends on SWAP.
> 

I'm sorry, this doesn't make a lot of sense to me. zram is a generic
block device.

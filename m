Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12E213E66
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920911; cv=none; b=K8Qw9rIewey1QDl7ys09ZJqw9laKoqO0l/rwT9xdquDVeodx3osLDwhQeilg06x4Me3THLjo0Jsyx5mqSqUM+IBTTw8dKyaIzsGQI7Q5GypvQ69NVcKaKrggegsLKHDp7JG/GP1cnGFvT6ykCpf+VMmf8M+sNJ+wDaFckPk8dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920911; c=relaxed/simple;
	bh=wpWRq9lWa+DAIkUGC/99XuLhmwZ64WJqGihZA0nEgco=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PysYUWf1vf4nKZaxj6yiaYRNZEqMCndXGdiU+TFFKS4syHiqufyLc+eBOSiqSYzE7VbgFjmDJjghIq9ahNPjOLtQxbK/m09pClr+0uUv/93UjRlij1cIwjhvhiZP8wqp4e9pEZynUN3f3NblMNHx83nwakUdfUrfed6mQWWk8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fe4vvSYH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fe4vvSYH"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b429b2470b7so2655196a12.3
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920909; x=1755525709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxzfqq0wX7ihIYD40/KuEi0QaM/6IHAFXiB/aKCGEZE=;
        b=fe4vvSYHMk/NGPpeXRWMtmpxIMDvqjFKAvGnVXr4GvuuD/aCPRt8CrtXGB8AH3mfdo
         oVxsbAg4B6py8w7RrW884JHVnxOHLXnEwjN+ztjAD26zHzkB76TMqBzWNTyYTFV6q6PB
         eLs6M35HoJfpzk42h66FPaDed84YaopVPPMzN1SzR8clSoG1HcqIqIBnPCBWqs+AAH4P
         uHPhna87FSznGkv7P8UzdgPD+WHxlBRbNUQhkCHcyfIJctSlVMBS9cYaVgm/iQScFO+E
         bP+z2YIMNSLe868IZec/zrXcFGIUwXqFgtE8SJaDi/qanixdaNl3waqFHpUAvp+Ei4S9
         hW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920909; x=1755525709;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxzfqq0wX7ihIYD40/KuEi0QaM/6IHAFXiB/aKCGEZE=;
        b=h10YQAqKto7LfYXyvBgZkxPU2Lp1M3ZObWPtLWLTuIpj6Y+FQL8G017kUGNZloOiBS
         m6GFgdDFH18sK1JC+1OEKRCe8ePXJ40uoQRKbCR8WHEWGS0Lk7XIDtmKX4pLyWSiOeD7
         iaD8+/WW10GOZKR1Bzz6eaSyhdC3csDUjs/Otukc40prvolXXBQfw1lEANLPjYH4Yyj4
         ItWhoLkdxWqoC/sk8tQRVJRwHzwgMMblgBK1ENGaQpcsnv8ys5gwTHtSp4K/YVYO4z08
         4dJvOL+u7EWC0NC0jlkKh44x5vgd39DxzvklSTU+2kmXjlYlfDBJ3fClNzqv4TMipk9w
         k/ww==
X-Forwarded-Encrypted: i=1; AJvYcCVXiW4yJTjrP5hhYNgUhwBMUj4DVKD86ejMMC62hFxt0Gjx2e4NTcQs+SED6OnVpc8zX5lP77uy659kJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5G9scXCvmMR4Fpj45ypHUyk2QLJHYlSsMIDJJ7urBrDeyFR7n
	e+OgFKyWJV98Cm0F/7O4pV8M+W6Bo8aYFVddUows0DwALoz9uJN5hmVKycKrKiBZ5g9JovxuM30
	epA8Z
X-Gm-Gg: ASbGncuwnpMOk8DKnGHQWdA1oC2bVc64faJeHYNvAKbhqm3YCDdu0Qh7WjG7orj2n9U
	Y5+QvtjYOMNGCrcLhjLtfca8bdbQCJwHUiLj2mhaiEOOkD1hz1mW3h+UWX3R29442XV74G/8fkH
	rD9AT7cci1M1/ejh/Uik0zQsr3Xbys8uflNwjHalwk5E8TOqUpqOKwzOl9MsBqfCq+B59bnaBDt
	wNnZ2Mhy4HFpjuvU/T4+njlEekypfI8g5BdacvJ6Dtz+r18Wr+m7oAJMKG0jxxBPO5keLl1rMbK
	6wSD5tKQUa6Z/DE9AHyuK0d8t9bsdnaUVPr1P7Wbe4RvQnOhh69TJKvQ8kYtNPuAWR+8g0qZWtt
	PWfMZkYUCBJ3UMU0=
X-Google-Smtp-Source: AGHT+IFYAdi9oz+XX6PvaUdl2rhcqAjpMkKXAAMFn0WpQhspYxYJUYREl3sf7qAAFMAFeXroFXUnDw==
X-Received: by 2002:a17:90a:c105:b0:31e:3f7f:d4b1 with SMTP id 98e67ed59e1d1-32183c461b7mr19933233a91.24.1754920908868;
        Mon, 11 Aug 2025 07:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai3@huawei.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250811081135.374315-1-rongqianfeng@vivo.com>
References: <20250811081135.374315-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH v2] block, bfq: remove redundant __GFP_NOWARN
Message-Id: <175492090666.697940.8178912057347940228.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 11 Aug 2025 16:11:35 +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: remove redundant __GFP_NOWARN
      commit: 8f3e4e87b0945aeea8b5a5aa43c419f4a1b4ca6a

Best regards,
-- 
Jens Axboe




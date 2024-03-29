Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC343DBA1
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704029; cv=none; b=PpAz1jeLxZIvXUGVb5uWr5ExBxN+O03XaR82IUXfQbhFjnRpdcwKHOhhk7e1uEo379MWv62yfZ/9SyF3PkwRqj6XwAhdE/V1AsaMAeCAkA7yfDD8rJLD+Quk4mwnhV6DJ7dGEI6byeUrGGHt2oPoHOmO9k9Uxz/tAGgWJxcfJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704029; c=relaxed/simple;
	bh=lsKygOzvWLl0FFhuYPC1IU4/YVdmC9lNJ/3CEGGRJMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmc7XTFf1CgVXUvHXnLiG6YWSpM0lDx5ZL+zgurywv3+lnNGfeXUmLBnDeuezAYsWTAuEsxzC3zKO9wikAVzfI+W0aKLGSMR0xw/EPdkMI5h9L206h04kEbRZbb1OWwamgqt42RnGISoJPcvYG8vWSIrLsRiMvAod7mJALXRpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QsxNbjAV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsxNbjAV"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a207208187so1042623a91.2
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711704027; x=1712308827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsKygOzvWLl0FFhuYPC1IU4/YVdmC9lNJ/3CEGGRJMg=;
        b=QsxNbjAVOmX5tDI30F3e8EeyIYbnPG3B3njZ2pfgTd1zMOl8/twy8KAydUo7ulHWKo
         IdHLxf3j/M/jOEyHRwVm+xXfWyRNj+fn4LG6bEN1ZKvZWejuIWshhA5+LVID71sbZPvG
         aHHT7kBam3SgUfzOVjm+VVkvJg+s5nuNY0Vd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704027; x=1712308827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsKygOzvWLl0FFhuYPC1IU4/YVdmC9lNJ/3CEGGRJMg=;
        b=QI3OcPbUF0YlatfBwAGdfS6ha0CRYivik8+MoAugfjV74KL09iTxLdto9kHzyKvBHG
         F8LHO0FJMDeAmjLfb1I6lwj41jpWs7+TDkxmg5a/XD9LQWo5e8R84QA79ckzavusn4vU
         4AQL+WdRplHnL6RKtUPOuIACPuHi0ySG+ISqVksvFxBwFQyF/ivuOQCfQ8dfV+NLm5F+
         J9inwVEBPBM53fiKYZttp3Ush9GaDGaSxezfL1fytnZcHNPpWHVmscrFfUNyv89/ROml
         +1/M/Zbk2Ttm3KkY68LekQjtSYWaekWUiLaNTGXqTAef9vMTcsl4bPN5IlD5sD+EbUQO
         R80g==
X-Forwarded-Encrypted: i=1; AJvYcCUsUVCbUZMpTNZJDjksWCKP/+VK3mTkXbYbyZ4YuyJJuO566cI13FDtU0MtGfHjhz43bL9x6q1CIh/QCurkP0dD7Hjv5iTwpnmaqms=
X-Gm-Message-State: AOJu0Yy9IzJ8jBekuquktoZtpd+DrHEXGPzJlURIwLrFPe2gIUzBM1fy
	rnbBltdaYfDnFsJ9v5zazRgcLsJIkOVUj0RqG9GtxvZqPBxZJfNZ9kB5byxNRsfeCD6m7M/8bJs
	=
X-Google-Smtp-Source: AGHT+IHQqAtT/9cATJMKv9jBfWQX8IflMXS4FDJOKDbHHGfHQMqg53v5n/NfmlEfqYyL7Ohe0pD7Bw==
X-Received: by 2002:a17:90a:b10c:b0:2a2:151c:6246 with SMTP id z12-20020a17090ab10c00b002a2151c6246mr989149pjq.34.1711704027406;
        Fri, 29 Mar 2024 02:20:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:91ca:ac62:b18d:2b7])
        by smtp.gmail.com with ESMTPSA id gv15-20020a17090b11cf00b002a055d4d2fesm2605024pjb.56.2024.03.29.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:20:27 -0700 (PDT)
Date: Fri, 29 Mar 2024 18:20:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: add limit to recompression
Message-ID: <20240329092022.GE1041856@google.com>
References: <20240329090700.2799449-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090700.2799449-1-senozhatsky@chromium.org>

On (24/03/29 18:06), Sergey Senozhatsky wrote:
> Introduce "max_pages" param to recompression device attribute
> which sets the upper limit on the number of entries (pages) zram
> attempts to recompress.

Scratch this one. I think I want recompression limit to
respect size thresholds, algo priority ranges, etc.

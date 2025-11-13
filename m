Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3B2F7AAC
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020549; cv=none; b=hKtNiI8UQAhkfhpP1wEdOnPGVSUTh2+E9rZLTwXFisWUNFPTKaeE9b6C43DdClrh/joeiJp5xc94aSkohB2EwwIF2Jfd7S03WoQLa2K2q5o1rExKr10X7cgfqV/FDfB3tqDQM52/U4DN3uArnqNvL0/8Ksv0bROSyBfYrZZFxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020549; c=relaxed/simple;
	bh=eGCFzE3FTJolIZuT03VIztGS+4PbmTrojtX2VPB4hNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByUAXC8sdMqxjLAzPd9CfqcwM2jGP9gmIFkHo3ZxZ8FY98a3R0LTmNiTdDkJY3z4OCf6LjAF5s8nb8CPnpLomQhhTJfSAhYXGS1FwcjjQBaj1NFCASlQB3+i72HqLokzZ1K4MH4cb43M9v/hf8jkFSoOTsqgh7TIjffECCpU4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MnE9TKaA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MnE9TKaA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ba488b064cbso415382a12.1
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 23:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763020547; x=1763625347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqOCdzG8TVwmmpstxldCFsocgLp9/QVeRrpBCk4yxaQ=;
        b=MnE9TKaA3HEmrHiKHYRS+t+vWPcTMrcs0rXUHkq+C2PduJ8pJS6ms53NyCH5xqwN5+
         kDDcytqHUZ74OgmVDMHsQcAwvpmYJc/HiDiuDGYb55BzpLsVtKzoEH/MAgBar9ixPH4+
         0o1O07IURmMEvcUb8mrDemOsMQ72dlWX58zDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763020547; x=1763625347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqOCdzG8TVwmmpstxldCFsocgLp9/QVeRrpBCk4yxaQ=;
        b=fzMKpMucldPK3GrIeCNbsAa2YMXpr/XJyQYpANCcZ9pHtD5XJ8Z62f8zmgbdmCGMTE
         RYdPa506f35Ozfuqe4sIt+DtLrkFhiI3SJHCuL+JdvUyH5zvayxkeu9ARX2YAXEzlmmP
         s3CTdQShZZ05wtuyB8aziFiyO6+OQKfpc0chxvk5Fd7dwI3n2kkzBGB5M/PMiJitqVIC
         doTokvbqeH84iaC5jgGk4fhMJjhCxS2RZ7UgRR1LYo5zj6ehxKe7PzEGJYLHQpx5fzVV
         h+kMaizPeIqH9bXi6PdAhaX26er+o7zhYP5a86+gfs7VXWBh8t5NFYTl+MZTLBL9x9yF
         b3yg==
X-Forwarded-Encrypted: i=1; AJvYcCUVBO1i6RvGkaybtkeHQ8N9zczuytUa9Q9aXrMbxXxY+awlpMstGH2LJdufBOgYnNr4fSC7qeO8SD69fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzshl/jZnZYdBmO86GCpSxi/ibbn0Df4j0VlyLtZ3ShYyBEB6mz
	EZgVuQYt57W4XHGxOzjYfe388x/yJ/X1Wqf1Lf9upK7ZmMCOrRLnVJ7GVPyyYxTJCA==
X-Gm-Gg: ASbGncvZBhDVJjMCXDK5Fejc3aluI3ABGjEW1fOeSWuocivkwPrzc6lGk9Pqt3SU6bH
	4q/egcVD9hP9P3bYQZ9IJ86H22OXaLheWV+c2fs/u9yB1mVTw0aFGOuVAvlPbQTpLi0Xm+ENgql
	rgXPROIfaTqbDAkhIcQ04Jqk4Z44bZiJpKSUWhX/IZ6VSPO6eNJo0kWq8spUAng7Qi9TwGZoFfx
	0twmmoK6GvMApr4VvAgoX4AjLl9DlqlLdnTead8WxjHYIpwp0tdNre7WsVg57wuqIDjr2ApCuX+
	NDi/T9NEQyaTmWb8Rsa0nHavUjrWUmBAsVPMyqakIbRCw/U005FJ3/7UdP2zDn4US7s30ZblcNt
	Pg7Row6e7o42xUCs5QYhu92V5XrHdtu0DVp6HoNq8ifNMlgbKc4awnZTVHb6yeDDYiQW3OCwL0t
	29j6W/
X-Google-Smtp-Source: AGHT+IFeFnwmYEOF77S5xrw0OtwdfxalTIPfjFUnxj2d/tiwYlK6zp64b1GatmlTBDH62gN5nOONJA==
X-Received: by 2002:a17:902:d54e:b0:297:dabf:98f9 with SMTP id d9443c01a7336-2984ec8e279mr73263485ad.0.1763020547289;
        Wed, 12 Nov 2025 23:55:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c4bsm15357275ad.62.2025.11.12.23.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:55:46 -0800 (PST)
Date: Thu, 13 Nov 2025 16:55:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <ob2qytrsog2ydftywgdxdis25c2ygboqqltbwcfuaks4iaxzct@lwx7xyklzdde>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

Just a minor side not:

> +
> +static struct zram_wb_request *zram_writeback_next_request(struct zram_wb_request *pool,
> +	int pool_cnt, int *cnt_off)
> +{

This is not in accordance with the kernel coding style.

If you use the best code editor (vim/nvim) then I'd highly
recommend the linuxsty plugin [1]

[1] https://github.com/gregkh/kernel-coding-style

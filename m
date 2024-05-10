Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07782149C43
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319220; cv=none; b=lBiiQxJHUBGG1zEVNiQISfmdVyrLWoghfmkUlToZoSdfCi31LDFTtdL+lpDX4q3+PZdtVDVI/KymdAxx24m7HMl5sUwTCne2M9YahieaZ3mY1JM00Rvv8Mf57u8+loBdv/MUA9GTqgBgfEJ4qUmv2n0/h/dVyj8CHiH4+Uqke4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319220; c=relaxed/simple;
	bh=lNJnk/IwO5G1DeyXGQQshC+4Yf6eHRgkO8qVDqyoQL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXrBpxXnY55DfeI0aM0c+7BEir8bMhm3hVCcj0N9w5x4cUW232DwdvCLVrRXnAchDUM0bvyRpJhaD1fn9e3HP/qb/xCs9o+/SBhO8EBompxbm/7dmqr8PxFeiE8iixBkvYGgfZo0ksqC17SmBLqr/YyyJhv21QU+ui4NzUAlxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FO4iuYno; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FO4iuYno"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5acf5c1a2f5so907903eaf.0
        for <linux-block@vger.kernel.org>; Thu, 09 May 2024 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715319218; x=1715924018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNJnk/IwO5G1DeyXGQQshC+4Yf6eHRgkO8qVDqyoQL4=;
        b=FO4iuYnon0XVNgwdtr+jcshFBAkubJBUSmBWMkZld5UTaoDQ7NaFkUdFWUPj7Pmuoy
         bk53A2kauc6Emz8SkVBu7H7T2JP1vf0ivHHft0wPtEQA/oS/rDh6EWdzUoSRSNq+7+Bv
         J7sb2WbftU+b1KBlD6mLPyWaj8wIpyB/aT4uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715319218; x=1715924018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNJnk/IwO5G1DeyXGQQshC+4Yf6eHRgkO8qVDqyoQL4=;
        b=NPvD8qkm8tOJh0uJ23Rpyf078hTvdI6ImCXbRYqotRfiNXZl29zlAM2Pt1LbzIOaQR
         x7el5uCN1z07KFztx+1SNAuGJqMYdrV5pgViJYANedaaH/rcwLC63gSttfnx8UfGoRxY
         +6rgJculM3Plj7Q/x6MFW7NY7GurCBK08EXtXhkBgZT+Agk5QGFVRvOGTcAu6kMumTzo
         gJo5FyABglKFDHRJ2bkjSp4CyiaMDkzIF/sSsbHcAAqR/1kVc7tMEm9lwyGDS7wDdpv0
         kxrc0bt7a3ubE0BFWng4yWEiesaq6MxLa5/iYROmDbz1uW1ulTVwktv+SjXd3FnKJ011
         jEYA==
X-Forwarded-Encrypted: i=1; AJvYcCVOWfAfzwbwVoMnskghbrJPrvG9t5kzcdDz4IfLFXujkQoYBGvVVTtNKQx4pyfgtuNLIqW8n3TB0pL2g2fKsgLJazRYhCCMIQ+nR0M=
X-Gm-Message-State: AOJu0YwIutDCJVsYVi8AsusCVUmiHRSBK9z2zTulsVmD8PcdenId22zt
	pDALrdL6b1wJ8hd/XtErL1Mcw/nwcbEYj8OkMG0IK9Y7ltJsYGgMKqJA/Q2L9A==
X-Google-Smtp-Source: AGHT+IFCQqwUjXeObeIhefjgn08J4INBR3l9e7EL0ARvLx+ZWaw2vg+uMR0UfMEm8ujEuFv/PHtCPA==
X-Received: by 2002:a4a:588e:0:b0:5ac:bdbe:10fd with SMTP id 006d021491bc7-5b281a5cfc3mr1616558eaf.9.1715319218091;
        Thu, 09 May 2024 22:33:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a6660bsm2190608b3a.8.2024.05.09.22.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 22:33:37 -0700 (PDT)
Date: Fri, 10 May 2024 14:33:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: kernel test robot <lkp@intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCHv3 02/19] zram: add lzo and lzorle compression backends
 support
Message-ID: <20240510053333.GJ8623@google.com>
References: <20240508074223.652784-3-senozhatsky@chromium.org>
 <202405091921.320BxOyE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405091921.320BxOyE-lkp@intel.com>

On (24/05/09 19:23), kernel test robot wrote:
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240509/202405091921.320BxOyE-lkp@intel.com/config)
[..]
> >> ERROR: modpost: "backend_lzorle" [drivers/block/zram/zram.ko] undefined!
> >> ERROR: modpost: "backend_lzo" [drivers/block/zram/zram.ko] undefined!

... and that's how learned that my .config has ZRAM=y

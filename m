Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFD1B85D0
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 05:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155072; cv=none; b=M5Bo/xZhP7rwwsZl0JM9S3uFydW5Jf2ii7i++RWBvMEumN5trit6Xfcob5wyLhwUcyhqm+nlFV1v2lNXuLs+7m0WJPersh+Wo3E3tr92N6niJ3c6ijEmt8RsfH7JE1faeonNOCuI5SxEk932sz6m9GH2FxzEjrhSAOBX8b8hogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155072; c=relaxed/simple;
	bh=NQSzcpbUty+aQ2mlAjS+hKqynQT1RDt1zJcw6ePLCc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvXXN6JHBzSwyLZBTSVllKQkOfweGNMDkDf5MyqA39gu5qMjbANRgfjvEh7nDY9vfcbRLtv16+axcYYo4yPfJ50nhN3IvIpvaHy2G4qOMqbIWJTlYTnPcydiiQnu+JlpZaz5F0oLFzbox36l7mqAG2irYEztK9KNsm+rdRUHjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KqbzKSGI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqbzKSGI"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo2920644a12.1
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 22:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727155069; x=1727759869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olQ3O4gKirGG0b4vMRuGYF6zh1nzrDG/7ktwTtv0X/o=;
        b=KqbzKSGIrurcX4692su1gcDTXQqR2X2Grc+5R5tkX75DA5gHW9JpTiLnRvVu6TVO6j
         HXnyktnYUM3Iw64Udp/MlJ1DTs9mSPUFltZd8VDawAxf3mA4PKBHUgtk75HzVCVPD2A3
         pTIRMyFOxeDtwqPI+u5a6GW7pL91VxxxYK//I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727155069; x=1727759869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olQ3O4gKirGG0b4vMRuGYF6zh1nzrDG/7ktwTtv0X/o=;
        b=HAm2mf2lZcZQHT+Mky+rNokJO0GEtCW4viaHOsn5wltUYF50qaoMzHB79fECRaXDNX
         k/hozsEuhH9eyb2HiGRRXqCjZ5ZM6XciXbhOi1ricVgJVCRhcPbGe2KF3h8ZBSfHo8cW
         HadN0ecJFGTv6sYYiKvadvsVL6B0x06lv6I3zDYH9ckFlOx4sv/0Phz6Gb+Xv4E1AbVF
         +XMbfuLBWB6l6IHMfzRrXIxLffTc9E1+zDCinJLTYWPu3d4ejiRcVyy5RBYaaGH08Hg+
         ARTNTLt/EuKjVRdG0p+qnsaNcDRX0BNPlhRMZt+281R+eSCSY7I/5hRuP6mUSaKk4WEk
         yxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy7TEZ3sHgtH02iPhr6CxYvLsPAcNh/GzrlQwSZ8ecyoLR+pIq0FIvUu9L5d7wYjg/t+CYhWmOeLZFTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5KT/JdQWhlNfbQ8/upsGof+3ppaWP526BpjAdDkp6g9CReK82
	MyaQo+F72DtJYPOfHCmVqAvabYWtoKOTk2ec54HHSlx9VfuzdD+Uc3zdfB9/oA==
X-Google-Smtp-Source: AGHT+IEl6WuB09CMGZFE0WBd+3Iy0PO9zjGepxVS7ZujAMPm2xHZENZLwXzoRIG6NJnwuAzO0xiwwA==
X-Received: by 2002:a05:6a21:e8f:b0:1cf:6b93:568d with SMTP id adf61e73a8af0-1d30a917855mr19506172637.12.1727155069473;
        Mon, 23 Sep 2024 22:17:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc84480esm447992b3a.73.2024.09.23.22.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:17:49 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:17:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924051745.GK38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924014241.GH38742@google.com>

On (24/09/24 10:42), Sergey Senozhatsky wrote:
> On (24/09/23 19:48), Andrey Skvortsov wrote:
> > When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
> > default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
> > so we need to make sure that we don't attempt to kfree() the
> > statically defined compressor name.
> > 
> > This is detected by KASAN.
> > 
> > ==================================================================
> >   Call trace:
> >    kfree+0x60/0x3a0
> >    zram_destroy_comps+0x98/0x198 [zram]
> >    zram_reset_device+0x22c/0x4a8 [zram]
> >    reset_store+0x1bc/0x2d8 [zram]
> >    dev_attr_store+0x44/0x80
> >    sysfs_kf_write+0xfc/0x188
> >    kernfs_fop_write_iter+0x28c/0x428
> >    vfs_write+0x4dc/0x9b8
> >    ksys_write+0x100/0x1f8
> >    __arm64_sys_write+0x74/0xb8
> >    invoke_syscall+0xd8/0x260
> >    el0_svc_common.constprop.0+0xb4/0x240
> >    do_el0_svc+0x48/0x68
> >    el0_svc+0x40/0xc8
> >    el0t_64_sync_handler+0x120/0x130
> >    el0t_64_sync+0x190/0x198
> > ==================================================================
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > Fixes: 684826f8271a ("zram: free secondary algorithms names")
> > Cc: <stable@vger.kernel.org>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

As a minor side note, I'd still prefer to drop that backtrace from
the commit message - we know that reset_store() is called from sysfs
write, there is nothing new (nor important) in that call trace.

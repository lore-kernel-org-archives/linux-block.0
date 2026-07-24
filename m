Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C5378828
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870887; cv=none; b=qKQNK4x6cTG1rQtTtsKDwflwHYy3+XOi2tgRe5brlfLdEio3FKyNUNxym1fjI85cTAAOsDqhekM8H+DF+yHL1srn9wY9KLkyAMaNsBH1PWnE0a+OFoOknBXFp/IqCPXWfSkd3098aJQ6qnst+NVVCqELYlGyfODRvmfQv40kMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870887; c=relaxed/simple;
	bh=e3eFk56qC1aswalWanSluJKLapPRIS3jOtxP1UjlQ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b65jTnpxnHkgfWgwnOFrJeaxEk1wPJ9d13nbknliJ4qCfibN0KDg3EtbzVnlQBe/QmrD92RPK/chV9WK8HfutmCyjVasXqqi9VEqqIj6Jth2z4UE3mWOxsE6/Pzk0BO4aMKuGrUDILlHrNqA55mVvirN914Qm3QpaWa97idy7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d5Oo5KkR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5Oo5KkR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848d21bbaffso26877b3a.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 22:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784870882; x=1785475682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BqdCN7np/OnzZei+qTFQX7Mqn8owBvoqzCC1D2N5rP8=;
        b=d5Oo5KkR/der0ajZm+dThvCO5vNIdqxNN2h3tHyYKApcBms5ERdO5+4JvnkLnPi229
         NUphLVqEyOu645ZjHZUpORkPN/C890ZfJ/mNd7pi2XDQ1JcP5YBIa7WX35phZMTxJZC5
         N9P9shchd2U5PQK0hJibFusIzn2llxBilvDGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784870882; x=1785475682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BqdCN7np/OnzZei+qTFQX7Mqn8owBvoqzCC1D2N5rP8=;
        b=NtVtx5IoMGcUUZpNlJ7tb9/p9OSV7a9kfBDIMqx17JNRGxIoLXUKvuaPzlJqWs03dw
         A+NQzNWQwAsw8izoc9jgGnmc8WHvCBC8Io0kV+ZF1NbfnQTExTTqj7ytChdKq4Z6w2Lh
         lgMLKl/NYiF0daLrayudcNsCtFVZD9rgbs0MfnwNBOhho6VzirSd5DNIXg3XFoODdSO7
         XANKy5yS+yMRtIJSyrs3MHT+yMYQ64CZXhjDEvuboPj9bcxtt3LEsv4XiE+y7+HefmtD
         U2659Iu5zDqfLUmcaFKocWac6tzTC9dYLeSha09qeoP/hyspoWl1qqmRfW+y56dBh5eB
         gTRw==
X-Forwarded-Encrypted: i=1; AHgh+RqYBfHAPwzA2VcZaFepso9pyEGbH8BYe4NegH7A1jUpkNkR+kgCkxBgJY/IyW81Xf4DN/bD49xJB/FfAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nbPXSfW8LQbfpCQLhagVVmw0skgtn0jF6FGi/GGXusw2XS5M
	besE0c/G7hFJtJAwB4V9sZ22faOl5Yjj0GnN1YquQ4MqCxSgmw84sEMjoQssX09b5Q==
X-Gm-Gg: AR+sD11mqK/Q2xO5ZahTg+r/gF0DKD9tIUtLYbbdSPaIy71kbJip56Qs/lFhq3jdvZv
	Gtp4A6grZBpOUsHuB40EBcIy5OblhJJj/hQ93tcTup9WUQQwvZljaUo+A4IaN9M+SscEJRIRrgm
	Int63bhuL0/xUti0rQUEXmDP1b52uQhXwvnlCRt98Qb4VVo/De1qp7mhVDaV4/SN3JLRzWttJNs
	J/K2smiScn567NHcJrvA94qSlBWjDH9Z2EMGB7EFlWR59VQeazIMENCRcO50e1AUmFRwhfbZnaE
	eLcXm2RxmfWvp/DFv2jB1vsghqnAu7MT2goxEUb7PRsskSegCyN3Rt492xraFiHABeoJKg646EG
	bNxc0oJQ5kCSE6551Gyml7Wx1BxGHTCWYxhkWdVZHvlZhllFh+LRnziw1DguVyMIN/Jhwn2Vrr2
	9ctr6VOnc8M+nUS8luvUi6ErwjO/LL9p47uZtO6NeiHQ==
X-Received: by 2002:a05:6a00:1bcc:b0:848:2f84:72c with SMTP id d2e1a72fcca58-84e2c23fd19mr6027905b3a.63.1784870881717;
        Thu, 23 Jul 2026 22:28:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1757488csm4011470b3a.33.2026.07.23.22.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 22:28:01 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:27:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	terrelln@fb.com, dsterba@suse.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH 2/3] zram: add per-backend capability flags and validate
 parameters early
Message-ID: <amL1-Q-HGLJj16rG@google.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260627070216.13511-2-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627070216.13511-2-haoqinhuang7@gmail.com>

On (26/06/27 15:02), Haoqin Huang wrote:
> Writing dict or level parameters for algorithms that don't support
> them was silently accepted but had no effect.  Out-of-range levels
> were silently clamped by the underlying library.  Dict read failures
> always lost the real error from kernel_read_file_from_path().
> 
> Add caps, level_min and level_max to zcomp_ops and validate
> user-supplied parameters in algorithm_params_store() before storing,
> giving immediate error feedback. Also fix comp_params_store() to
> read the new dict into a temporary buffer before resetting old
> parameters, making the update atomic.

I probably would prefer not to add this.  Again, zram setup is almost
always automated, you figure out what you need to put into your init
script once and you never touch it again.

The 0 i_size for CD-dict is something that simply should not happen.
If you insist on handling that then we can replace "sz < 0" with "sz <= 0",
but that 0 len dictionary case is something purely theoretical.

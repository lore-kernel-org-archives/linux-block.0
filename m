Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3726C39E
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389370; cv=none; b=Fx8h9mQ+37+wbz9lB/7AVAg33MA+wq8nmf3Xq4Aohbrd2WEh4f4hmxLzX5YUsqxLrB/E68sx201Kjk6syUQUjJjkxmBQG2aE2RhRk89SOpV8UBSZEN2av20a0MWY9wt0B2Gw/67R24XRQpkv3LXSscP+huOOxiabClW6AsGBZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389370; c=relaxed/simple;
	bh=TE/mf/xUgkmdZM7YJFPytyu8Ro/YwJlxiywwFf1ZOdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO5uHeyoACghszRrZ7JAzcisc3eX4gghHmMKrASERDAjyk1u+E+pbEiJ9oKy5GvhSGGFTRiHpnVmwXzXrBJnLg8+xSmLrPvBiJ859WWwU6NK6rOJcepN+AX67i0n0p4mqLY99HcSkxxpYx6IT6iXqarbP3yRACL/9hTpz49/Gw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OeIrCZ51; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OeIrCZ51"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747e41d5469so4545060b3a.3
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754389368; x=1754994168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aK+vYOPbG3XIxjUyHmdjrcqGqe58W1i9+QVrnP6KWXQ=;
        b=OeIrCZ51O9+lp8R1k0lM9+e6QkEfPJkjbuC3ibCCazJgLl+DQyyQJwh5vxj0VMDTWp
         K8rlq3clbcJCbcbyVfWT+0jJQQMHKmajFuMDAfBeS7ZX/Y4Kj7XJwhGzUTc+EiqRgTKe
         vnnuBSYlqKKNI2YPyOWZAkZKDKVehQMmKr6ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389368; x=1754994168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK+vYOPbG3XIxjUyHmdjrcqGqe58W1i9+QVrnP6KWXQ=;
        b=w7JgfPd4LKFEJppXP2i3ZuR4VgmYtyNZTVQdEwLXli0IZl86x4GOEv+Z7FbZvv7jO0
         0aJirdw2bhNsg3OcQqUSV1q12XALbY40gk/xyAp6GcU0gGh+ylEqCKKSp2McaErRaiM1
         f6U2YgO2rBd43NYHR4bVYTrahLahDEC4wobYhXP9Jd4no1Fnv9/VcarX4ipxOylDw95t
         JwZn0/OW+7uqeKm1N/laQM42vmwO1LK0gWvx0X3SADhPjK9mJyfXfGNb1AOiFBoGMCKZ
         F7hcrZOYrxWMxmOv2bfZaoduG0nxaHvWmeCStRqEz3OOY9UCkDd3zKAsgXTqyjFMtFZr
         /MZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUML5Q06nzIe89k1gUKPKf3b0VXUdTV7wAHbwIA9nZkCi7x1zm4IbV4setIXEBwazZMuRQmWJsagUN/LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBurMsLjq2tuh9RoqDv0fTInmwpDK9K1bj1vBfw56ajGX0LfFS
	FsL4LJJUkwmAcEd3qajJ9hBIUfS02IG/Xf2ZF/cFzrCU3ZjlYaurVqr/055t15I5jA==
X-Gm-Gg: ASbGncuwrHKxZrGmBb27sqCXsmL7TVg45Jj6Kcuq7RrQ+O3Zd6HUwpnXIEOTlzj7FKX
	T8j3LCwPGkn90+ks6ju1QqK9HXMfjuz8aY/0F8GE3B3vaEriM2d/fuGXeAhkWrtsUAeWXWXqP0X
	49+6tIqYLYC/iAYLzUydYkyYDCC6P04PlucNrKlt7fDhUxsa4douewxSp/vzXy1UQauBa9J64t+
	/f/FIo6bpNa5uJIm5UE+zjw1ApK+r9DaWU/dHNAg8DnJjcWWsfprwD0TsyDnoRJ4wFOQy+q5vuA
	ubqumuaLpRixvLzf87GFAKTl8LV29wndKdLatD1oCn8mjr5ui9bFUBcDMc1Pb09rOuMGp5Ixtox
	J1J3+/VBFnkoUEjUPVLEKUCI=
X-Google-Smtp-Source: AGHT+IEqg2uzi8SDk/PQPQmMkBFwMwZgChILpKVD9G30iLBFDUPMSm4S+KYuTmnfrxnfYcPOBaCbAg==
X-Received: by 2002:a05:6a00:4c16:b0:76b:ef0e:4912 with SMTP id d2e1a72fcca58-76bef0e4c7cmr15395822b3a.20.1754389367914;
        Tue, 05 Aug 2025 03:22:47 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf5f7sm12635441b3a.88.2025.08.05.03.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:22:47 -0700 (PDT)
Date: Tue, 5 Aug 2025 19:22:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803062519.35712-1-ImanDevel@gmail.com>

On (25/08/03 02:25), Seyediman Seyedarab wrote:
> Temporarily add a NULL check in zcomp_available_show() to prevent the
> crash. The use-after-free issue requires a more comprehensive fix using
> proper reference counting to ensure the zram structure isn't freed while
> still in use.

Not without a reproducer, sorry.  Per my limited experience, attempts
to fix syzkaller reports w/o reproducers often lead to regressions or
just more problems.

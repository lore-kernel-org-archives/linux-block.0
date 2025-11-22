Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D89224AE0
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763819038; cv=none; b=AJsloUHx9TaXXObHWHRxDE2rcwHZvn6an5VqCs1Gz0dqelhZPfc3cEhs/BJUD3bPEk2a28iBUkoIXxP7O3LqSFQEhOgyawAMspNX/RPxEr2DRpA89R+l+JC17dMoqhGaIeefH0DnX7gFKhD7KyHMor7En9FbvlYGEaSSXt6L4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763819038; c=relaxed/simple;
	bh=aBd+0zebpJp55IvtTmGEu2d8Ku6AwF+koShb3hRpOw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR99snQxohuq4Hnr4ZuiKZuoIDVNr5hXoRryHG8r23fosGb7Zl4VWX/l2w+zogxR9lDg1pUi2uLN0mqQnFRy9RQBOevvshLHwCVRZCg1j/ZMiaEGF3eZ9qt3owjd6cW2fKxQ7m/N0G0ipHDso85pnJKkpXy+Xq7ZV4Xj8AR1ANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N4fLoF6M; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N4fLoF6M"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34381ec9197so2646551a91.1
        for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763819034; x=1764423834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=skEifoSnF8Rut80XhCz/YHjVueIg7ytLGu1hExe5Elw=;
        b=N4fLoF6MfGOtCHDtM6EQmkBtxqpwu1zUND5uVsdHDF+Fm9l9sykmun9NzAM+BZnQjY
         6ranpQH84hTbPOVcDTWp0tv6mXI4pHMWzimuaDhXwY63eAWbU7zVRAH+WXZbJKM24wF2
         6XYqmGGyBEhVQ6fKiSYdcBxxNwi5Kde/D7HJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763819034; x=1764423834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skEifoSnF8Rut80XhCz/YHjVueIg7ytLGu1hExe5Elw=;
        b=FTZP3s+9QGW+IusJ8D7CcAPtXw+jaC+Z1/R1Iz3Es0F3dh/3HKxjIaTBt7SSN3UOJ+
         w6h8v6OWjI5LikKzFqjQwq3X8u3In7c7Lb635paS2ga8xCYcsqDaqlKSeUGm5fNXGGlL
         b4LeSr4q5WYLNY9HArrNwIapoGVRCw/QZhHT7Y0tNArRqqzZ8lFoOCXSdCFKOX8ar54J
         gScM0dh9fo+wWMCpEQswI4EEfXOAVj70Q5hZZiPosMsM5QavZmTttU5sugD3zljzJDOE
         L00sklGi+Jm2K/n0SGis65Xo1rcwzXD2O+guDWBkRPUNhRR4/wCAc/q7idIbctX3OkSI
         QAJw==
X-Forwarded-Encrypted: i=1; AJvYcCUUuIFKxQyBe7zt8MysN5RELi6h84RT8vFaYxfG7kye0OeRFgYicp+3pMdus51nKWgYaXbn+8QBZSzo3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3Z4s5WgrfgONM4isugtYSqUJPZXM1GRYGLcsyNnoFJaZYyBl
	M9QyUMcDbAWO+Y+O9h+NIZwXu7NW1wgFr9N6pRpmQDlYNDHsdW8OY64H1h3EOTXmwQ==
X-Gm-Gg: ASbGnctrG9Q5rQLRBb3eFHotxoLA618DOhykF0+xA9ymi7/4I3PKFLCO0NlPs/a153N
	RYM1IFcquol3HD3EIRf1T07xH/gi/equEz41VDxHDSAHJyAp25uPK38UthPHj4qqTwXzx9T4RRz
	YYaR6b8v44mrepJq+5qHmuSgKDPP6CvGXjRpY61Xy5ftFj6prDaaOWLKAc7HVEfexZFiyRIoww2
	H2WmLIB+F8vVgvfhzcn+iPxM/wxBpdqs0+hbAD+N7n7oGweXraoBYpGUh1thqRvM0j2o9a+LFld
	QgX2scylhUFnwiqtXeh4ayOf/wvJ0jFLA09X4/sVgfDQRjoT0mxrngUMCzzM/zNkN1Hptto/fHj
	EC0hl6Fy9T/8vE3GXUR3aJblSQMfbM52Mna+CuDfvVtvyNEXdPc2uAySuw2HPuiRlcNIvGmWtc4
	ZxfFRDmrQ/VCiv8ZcRQzL5Be0G7RnOrqm0R+yv8zS92fAOYM/lxh4=
X-Google-Smtp-Source: AGHT+IFEAzXxpBMN4+Cvpnq9Wz3bF/ejan4xQv2Z6/vy+0j3hfTRsuEa6ttfw6fKfrdggqzCKIk7CQ==
X-Received: by 2002:a17:90b:4ec7:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-34733f4ac35mr5395298a91.29.1763819033721;
        Sat, 22 Nov 2025 05:43:53 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b047616bsm5856992a91.9.2025.11.22.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 05:43:53 -0800 (PST)
Date: Sat, 22 Nov 2025 22:43:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Message-ID: <ztqfbzq7fwa5znw5ur45qlbnupgepaptzjaw2izsftbtth6zca@db4ruyaulqab>
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
 <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
 <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
 <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>
 <kvgy5ms2xlkcjuzuq7xx5lmjwx3frguosve7sqbp6wh3gpih5k@kjuwfbdd2cqz>
 <853796e3-fd44-4fc2-8fd2-5810342a6ebe@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <853796e3-fd44-4fc2-8fd2-5810342a6ebe@linux.alibaba.com>

On (25/11/22 20:24), Gao Xiang wrote:
> zram(ext4) means zram device itself is formated as ext4.
> 
> > 
> > > zram(ext4) -> backing ext4/btrfs
> > 
> > This is not a valid configuration, as far as I'm concerned.
> > Unless I'm missing your point.
> 
> Why it's not valid? zram can be used as a regular virtual
> block device, and format with any fs, and mount the zram
> then.

I thought you were talking about the backing device being
ext4/btrfs.  Sorry, I don't have enough context/knowledge
to understand what you're getting at.  zram has been doing
writeback for ages, I really don't know what you mean by
"to act like this".

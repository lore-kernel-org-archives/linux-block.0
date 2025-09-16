Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D7315D3B
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030018; cv=none; b=gNn1kT/ETs8/+b8uI0Z4qxY0N+zzTa4PAt6f79RhlMdSaMW9Ew4af1D6x9vYFjARGbWUoa1+H9m0emfhyXiSAYFjFTDHZx0yf5MxcMy/HssiOwdMoNBVzVQ1WaSgSTUDf7wq5HLse2sra9MG3hO1HjZm1EY+xg0DKUTjRMvQPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030018; c=relaxed/simple;
	bh=+gio5aL+IW3u8W8SSU4aBeYKAREDBl4pvtVMTW2Fww4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHvgI2JA3bGgczJ0XgrSx7MYfB96isfY/I1E7MfsMsXjoLXZSeW0++q2glKRpJ+SPKkWD7SG8SJ4ObL5+F5uQ5mSeXQQnw7d8OmBu4Mb04etKS8fs29tXKORx88+cM7ELnIKLDJr2wQBwLW+mm/+H8mUDUs4kk0IqXlsHYTRdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w11yYXx+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w11yYXx+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d44d734cabso3326714f8f.3
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758030015; x=1758634815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcfExlni0fgEhBakaF+iv8wUB2vTkCFI57QVuCuRuQI=;
        b=w11yYXx+PJ2S70aQQE6th1BIImCh6AeKdDLfGNuw5UKqoUlQg24eqiqWzz2LuG36Rr
         St7GLc6KvVp/2vysYpx1BN3l0cAXG/8+P9e80zbhvu/Kg7OAgIdQCFEeLjhmwiKxH+uf
         p7ihY0EUmz0EaHqBp8WcDF9zuLuLyQk+vBrXeBBCcAVU8+lRgrLuFbvDVAgOIpnGq/Qi
         TVC8MIaj7CrgWSh+klvGhsiNYl/1fjByc8yKuEVjD/sDV2EDFt/ZzKKNRqEpI7ky3nTm
         IhtAJC8awvvIPShrMU6xonUvljn1ALrGtZTid0edYRLBXDT+vBY0Tfbmur/QuBe+zHRM
         wSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030015; x=1758634815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcfExlni0fgEhBakaF+iv8wUB2vTkCFI57QVuCuRuQI=;
        b=tn7/wALj3bT3dPmbelj4kxz6MFjRBDy+Ot4UBJm5Hy+LLbQ72xhrAOVLQYeJSC4kMB
         TIY95JE7WdVhTmTO062l3BQAUYdjmLhgIau2bQzPJ7BhH2Nn9N8/Xmbybk4sc813Nxio
         wmp1O4grBwYPStLgAG1p9kkpmuAJIrTEOqdYNYzjxo+i2qV5k8aprsYUq0tUtwquaX7F
         eGlFfKYBHWRCdrwr67JpH0lXqLcmhlOCPlX3/O6pD26/LqGkUw916CXyLCW3Ym+tbOzB
         UvLrdKcU3/cDYXMRYzzcoq0J6P1km79Ql+Fxq6hhvo8aMPgCROqXx7xmJWZcEfm/cCXH
         RbKg==
X-Forwarded-Encrypted: i=1; AJvYcCVBnlssNTOyWBu+/zcEvv8BaYRzyPEuXCpUy8XmkuYO7tVUlT8pHIPR/JYhh0SUSbvEyvMG8t4kHsIJuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/IzSTMGoy4XX6QlVNJ5IuuFIVf4ObxJPFysXHsNlDQLKbrIYO
	7vheDTYTe+FE6CF9Tst1tmspDjawtqSX+21eKVlwKGVAG7U9qbiT8yaKSDNfhLlosGM=
X-Gm-Gg: ASbGncuX5dnBGIj4YgJWmq2LX+cczJ4Il2M8PWylu+iXdMXA/zEaUOzDHuUCgXgE4kw
	7u5RKuCqyamfZyNNThv7ASDbBq9vuWSQH1Obo4/SeSjgyRryCO/EK3C0PjHLCEo/jGBXNSHiAO3
	hi7OIPqHWQyVQm/r+06PKCXvxmFMVKjPkeYcz3plGZI/bkRR9n2TC75WDxBE4BjwkOa42I25IRq
	U/pTtUI4dQ2MHDjaISsNm24ZNhKle40GNepNv00f/4SkPSEHp+7mUvpJ1a8UbGuarMHHytfOepF
	gA1f9dKjGJic/+8GOWlffcKZcM9/o0a4Mw3ds2Hc83rrJ1abS0K19hEBqsjgvgGx/vo/IXw0QRb
	Q0wzoOUVhywC311IQTyeUZEsghzY=
X-Google-Smtp-Source: AGHT+IG8kaWPMWFHbVd4viKfQeFJBGjRKwC9gr1w5fiYvRQ3T/k+ZTU4DWIxru8SYExw4YHgKkL4Vg==
X-Received: by 2002:a05:6000:2887:b0:3ec:dbcc:8104 with SMTP id ffacd0b85a97d-3ecdbcc8195mr912496f8f.36.1758030014747;
        Tue, 16 Sep 2025 06:40:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f31c51e8dsm41553405e9.1.2025.09.16.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:40:14 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:40:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/33] block: use extensible_ioctl_valid()
Message-ID: <aMlouk_55OXZv8w5@stanley.mountain>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
 <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>

Yeah, the:

	if (extensible_ioctl_valid(cmd, FS_IOC_GETLBMD_CAP, LBMD_SIZE_VER0))
		return -ENOIOCTLCMD;

test is inverted...  It should be if (!valid) return instead of if (valid)
return;

regards,
dan carpenter


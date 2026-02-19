Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3548341062
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514684; cv=none; b=Ia5WzLtjvlGo7x45H6PUzEwFAJjEliFFIHHgjSGB92K2ZKrnxt0VFLU7gYOyKuMMtarCnjc4IDXMk3A6TpNHB7byN6lE5x1sNq8FfQ2XtQixZL9MY0UbFxU+bjtzSlgYGR24wwmaaWqgS9PXTUhRvGob8q50iEw1oX1s+wU0ypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514684; c=relaxed/simple;
	bh=lDifLTAx9n9Mk40OXQsRSz1vGqgpmvsXnNPyhYBsb2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoaTNuQVcpSJulCovDWaDGEYiRHiQOxSztyMi1EvClp1hjtJ8Pg2z3VwPTPLZycH6/hUphsqrJnVx13rfBHpTFts0L5EjnSyb8yk/k6Zn6z0etqUc13MO8f+7SrsWdy5w5bu7reP8i1nAd5UsaG2ufxqPuufzMWTj4vUyd+IP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nfweMifn; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nfweMifn"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40fb2789476so1894429fac.1
        for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771514681; x=1772119481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgHRaYW1iBhNDu18vHtaVid1O4fLAXLvbx6+OcL28Ko=;
        b=nfweMifnjHOZmoTcEy3J+1PjlBhCJxMCujx5qg+V9WHrK/hWtzTz7dSFyG/VXUArAh
         CgY6H0NmgPcqaiA5lxAHqJiaUGIehkLGoSCqSCkH5D821Pc0YtQZMS+hmYOHoVxVfHEw
         Uax4INI1Ac3q8lfAxG7CinFd8jG9XreSJyE/g3+tKUpGut7LxH4fQ/9hhFRfpxNyeqW5
         kcdCSJY7vKcg46VTk0kkoTdWsKMXusrGpf0qlSon2YpTgpecdY8B5ewRcx0SfhcIkDpm
         3gKICwk3W2OXa3BYHJc5Cxce50FFAuuFh1XswNbRUasXWB9dM1Ksdo4EHfLIPOPAAIRe
         Jszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771514681; x=1772119481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgHRaYW1iBhNDu18vHtaVid1O4fLAXLvbx6+OcL28Ko=;
        b=S4cNv1iZ3R9uVwDCcZY6RReyvetQ+ZXeUq3zMn1NHP/uRLVn4A0Yt3z/8kddT/iWqe
         VYI0IEUCAzChP0JPc9VQB4ez0jz0cm6ZZK9HkdrFqqaEncGjAzhr6LaMiKjwCz5WDmlR
         GPgxiC0DWtZCOGedm8DU84c/8mUn2ggNX/yjU5xieAqDBXKB++72ywO3R/NPiG/4C4Pe
         zb79NuXaJorSSNbE9Col8JT6v5zqx28ltivHl1EC/CkdhmFu+SdfrZO8OHsHk8zbgZIY
         tY3zICd3AbDRZTVwj4q0FEiUxEeFWDiBcsvfceTlwlW3x1Lt5TcKEImY4NAlQfmmQQ7Y
         2zcw==
X-Gm-Message-State: AOJu0YyESTqwfofvZehMYQSNZNKRO7SSqwKv+8CR8UjMDKhvwuCTgG8L
	HMy1hJ3xkWcoDrj+aZZrQBMKAaXaTQKKHrr1+Ccoiuixjehg9BOpaRsiMGsfOWoSTKA=
X-Gm-Gg: AZuq6aJc3gBZJerg2OhxPoy2Ka8+bOkCvYBsDIOGwTALlo21jXTcTokO7B1D7v5f8tZ
	v5okwDejdyLg68gNLkQzEfFHmlHHEuYyAzlEmhWikLmllupN2KnbsKXNkSfbXDISj/ccMEV7C1D
	v82pqvqbLsnj3+x2r5OPyq5Hn9FlW7q/TL51a3XwZqdqdtrcdanDzxkyfYFZ0UG6ve/lsMPSKHV
	u7HvO6fCagj6z+FOOVgQwJ7OvkSIBx1P6eTJDEfpavH8gllPaip0czXtAF/M7rP/NlxKPRGY6YZ
	7DVBCvCLyvb6frDfg/FQCUx/03cpB5CiX2ZWpRPHw6i8Aljd/bZZsvvMyxjJ5oPFICttACjc8oB
	QQ2tNXhp9CUHC775eUiDPq5/Vxt/QF3NzZLGcLQ8mMESBpAWi9qqrNM8AYi824wNunvfFAJW7jG
	7JXOK6i1097NYX4gAd18/mHMU7EYIlcKO4xz2//IEUu5IeLJ14b//ZV0XHSctCq4kYhb5t6sm+K
	sbExJkKvA8=
X-Received: by 2002:a05:6870:a0ad:b0:414:9285:c243 with SMTP id 586e51a60fabf-41545713115mr1093784fac.21.1771514681487;
        Thu, 19 Feb 2026 07:24:41 -0800 (PST)
Received: from [172.25.209.35] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40f062ee328sm17955312fac.4.2026.02.19.07.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 07:24:40 -0800 (PST)
Message-ID: <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
Date: Thu, 19 Feb 2026 08:24:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] block: enable RWF_DONTCACHE for block devices
To: Tal Zussman <tz2294@columbia.edu>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Bob Copeland <me@bobcopeland.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
References: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/26 2:13 PM, Tal Zussman wrote:
> Block device buffered reads and writes already pass through
> filemap_read() and iomap_file_buffered_write() respectively, both of
> which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
> by setting FOP_DONTCACHE in def_blk_fops.
> 
> For CONFIG_BUFFER_HEAD paths, thread the kiocb through
> block_write_begin() so that buffer_head-based I/O can use DONTCACHE
> behavior as well. Callers without a kiocb context (e.g. nilfs2 recovery)
> pass NULL, which preserves the existing behavior.
> 
> This support is useful for databases that operate on raw block devices,
> among other userspace applications.

OOO right now so I'll take a real look when I'm back, but when I
originally did this work, it's not the issue side that's the issue. It's
the pruning done from completion context, and you need to ensure that's
sane context for that (non-irq).

-- 
Jens Axboe

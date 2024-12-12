Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE952259496
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992673; cv=none; b=GxSm9Y8Wj24nLbkSKpw2ClfWP3AfjxGUOJE5lWhW1jITbVGW+nYKGO7dsEEyTDb7IozagPzO5/vij/mqJLNMGeyUZIovzMyCxqfsP6rBs29fC8QaTLwC1TuwhBTL4jhViI0S1Yqa0snyMVoJMH4JJIzSOXZzxjydSmqd4Xa3Gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992673; c=relaxed/simple;
	bh=Rbng89OmgVe8qgtyPfxV0jpcaFNkksnnhhnXCrIh8Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXmMQtHXOuvwRgJBue4PksV+scKrOoIo/fsQvl5c/y3Z5cz6q7E1q8l+VeqzSf5fBpUob97bIM9KsrbfovlDoe1wKnXJbQZ6hW29ge1gVei2wrnB+b7WuPIdJvwbxqTprSGvu0ZOhsP3g1PxX/sb09Ba52fxk0rTIZOs01nHN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HJPbpcvm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJPbpcvm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21631789fcdso10679585ad.1
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 00:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733992671; x=1734597471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/tC9INUw3nxk6MhIa6GMSnsttorIpfFHd1cjdeGL0g=;
        b=HJPbpcvmqkYE6Yw29E3L+q0D4UBpXjw7lV8CSaY826JctJ9aDYqS0iUtRqgjWQFX/7
         CX65Dw012RidftVjQYY/S5ApyQ6lef9LfXLpTLLK4mj2LRZ33BWLTe+L/cGjECc9dnf+
         ECrgVUL0IENNSwhn8P9knIIACOUn3Sj3eSMvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992671; x=1734597471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/tC9INUw3nxk6MhIa6GMSnsttorIpfFHd1cjdeGL0g=;
        b=Td70QZXk1Tyz4mTvl5aLONOW6s7cc8qphjT98tdhLEmCmr54Uygz+zPIYmLSEob3nR
         34Z6WR2/HKNJSYhFOQgzT5MhBGN/p3Z6Cyp1Sg10x7/XcAbJUVSHTBzegEbbl2rV/XWe
         MS+T32vcJIW7/XJl0Q9xr6iA8xOcjwP7vMJWpkMmwDawerOW5UIEeBSG4VH0odQcNon7
         iYADe3+MdZE7xdcPYtsHKusjfFCMrvzQrORM9d2t9+tlo9u6rNp6QstgKSb9o94QjDFf
         GP4jcybfgQzA+WNehxDwY/MizZmmcx9tY4B2kQ70erBUmkgj8HDpVhRxHLRpJax07ANb
         A+zA==
X-Forwarded-Encrypted: i=1; AJvYcCVFUkd8izej8BTRizI51+29JsAlmG8U4FSkcrjin7aCtgIAQdbIMc98a5F4dQuolgREE2muWpLSVpCcfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRLZJRyhIAPqEbr9nMBWP1uHW3FPm/8oIIdxRp9VrFm4Jbju+
	ZP+fEAuTv/XOKIUMh+ZZCzCh7vfCijmKX41ByLgZHMzAqedxiz6Yvh3L8Dfpug==
X-Gm-Gg: ASbGncvlJPRN3eSXJP2fFcZUW0JVkR8KJADYxJMy7towdXCoN9cDfZpVqlODn2n6oLE
	EV3Rw4G+tB9wgPIff3E0hUDbV+3XEX0EM26EdrZjGJFUB9Hzq/ARJN0H28y1CgCqAo/4SEdjigh
	wg08bmjb2gmEPQTmt0ohF3Ef0qzrzZU97XXUew/T5ruau3dLHKsckFX5g3AsME9nTCA18QzPo+m
	GVJuWDpmbUX3RMy+qAle01TWU4fwyGi7b5vQANDQ3WQg4k+dOLEV8B3PFQD
X-Google-Smtp-Source: AGHT+IHZ5kxa8yQScj0ArR5Wlt0n0MRtkMZZuk9KObBe61yQupsS+25xkOzCrCZr2ESPTHNTXj5SAA==
X-Received: by 2002:a17:902:da8a:b0:216:4122:ab3a with SMTP id d9443c01a7336-2178c7b6821mr38784145ad.1.1733992671086;
        Thu, 12 Dec 2024 00:37:51 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2d7e:d20a:98ca:2039])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216364e45d8sm77545115ad.175.2024.12.12.00.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:37:50 -0800 (PST)
Date: Thu, 12 Dec 2024 17:37:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	caiqingfu <baicaiaichibaicai@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <tbvkmwzy6od6xs5lsppvifo5dvv2wgaq776acwm5yytmekdlpx@7lo4nfmd4s7z>
References: <20241212035826.GH2091455@google.com>
 <20241212053739.GC1265540@mit.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212053739.GC1265540@mit.edu>

On (24/12/12 00:37), Theodore Ts'o wrote:
> The blocks which are getting modified while a write is in flight are
> ext4 metadata blocks, which are in the buffer cache.  Ext4 is
> modifying those blocks via bh->b_data, and ext4 isn't issuing the
> write; those are happenig via the buffer cache's writeback functions.
>
> Hmmm.... was the user using an ext4 file system with the journal
> disabled, by any chance?

I believe you are right, at least that's what caiqingfu said [1]:

echo 524288000 > /sys/devices/virtual/block/zram0/disksize
mkfs.ext4 -O ^has_journal -b 4096 -F -L TEMP -m 0 /dev/zram0
mkdir /tmp/zram
mount -t ext4 -o errors=continue,nosuid,nodev,noatime /dev/zram0 /tmp/zram

[1] https://lore.kernel.org/mm-commits/20241202100753.139305-1-baicaiaichibaicai@gmail.com/

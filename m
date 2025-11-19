Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021A2EFDA1
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539455; cv=none; b=NuV5uaDGRVz2lkH+3o30Zjga2c6hGMX7/CaFFcZwFdpQDDplv1zbOPAwBhnWC7bwJRZbN9bahkaCOq4mmw0aeNZvfwCVdO0mfp6SelbEJL6Rs2YGuSFowRZGzXz2pufNMTQwO7958ju3s3TMTZoT+IDcAlKoE8Pt8U3caTm1YU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539455; c=relaxed/simple;
	bh=wcX5j6kBHArhq5tdbc3vVtnEDZVFnM5hLsVJLi6v03E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YPSesJUIGu7+f+65A/g7AGQ9PLbC9y9y+3QGrhfhbuEQjbq8Zo60Bl1z+r6R7XBi18YSqoGPoMv5xf1mRxFnmYiAuxRgGZ1aZd4bNcF/Qu1y8fB8anoDsnnfj9gLM6CD6NtxbnGjm1dMO4yQ9Vyyoe+Jggf9LZ10oeIARntqybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=3PUYg0Cf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="3PUYg0Cf"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8824ce98111so87845416d6.0
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 00:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1763539452; x=1764144252; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wsu/QpI7t5MSf2fTjgE3xkQwSlroPkgW3wKRe9KD0qA=;
        b=3PUYg0Cf44M94tY2DhFBu91JXv8zgz52OyBdxWGxPrfS5FHMyUBbrtwMCK+6lr77Qk
         18uxY4AcYlhmSQ4rQ2KaHbHVyl86HSS86m3vtjFHxylAwZsz9oc3Xad0uAhGLMejjjZ9
         bjTTLlvF0TrWiQZ41r+9a07vCeBOA7KEwFCaqnm9zttf0ke+XTfPARn28sG9R7bD/sGY
         btwcJthUYKsvB37uJPDjWV70QK1t/fFzYgbz53Elkjy1k2Edig3UVfW+l/LGlpnXAabP
         WEWzM/BcqDoektrg7R0Fd7HxB9ES1oBFGPbhifHGbMg+0tJ9pVDmpEqNzn7AYfxRjYIn
         RWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539452; x=1764144252;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wsu/QpI7t5MSf2fTjgE3xkQwSlroPkgW3wKRe9KD0qA=;
        b=e2x0bIyaS6iT6soFDKwEdqHriZbGZshnpaMXzdJrIZCvVFchHDI//paz+n3TXO2aD/
         tj4GmsRx0DQzKExJSsbFCsJHIiuecw0rk/C9RNlvNUIznRWXU+y4W1PBpUfLwbSgt9Wx
         vt1Eu1lenM5T4WVoxqVQvTd+mdXSfR0tWRVk/ogFtbo25RW11288isT9N0GXKJkS/Ig1
         A8AcsW99rbpteR9d3ruCoxiIObfPOQvC7W4XllNsKJTKoFgSYoAub+vW81UfDu+EGj3T
         9n3EyKXFypaD5FUS+rE/BJHC76gDlgeK5P1yD7yV7cJWCiFc35bixGlY4mRhPnp9k1v7
         FcaQ==
X-Gm-Message-State: AOJu0YwIPhXfi1HO9YmJ3jV0PrtnwcyLUfR76aBYBDVOcSWfxOqtKoml
	JOGN6vKqn5IsBOAgurcJ1TmIU/hflPeAuwiRERWLO9PPlWo0dc4LtDdju2s77Y/pumNdx+85YGE
	zIKrh
X-Gm-Gg: ASbGncu7v3Lrt3rryDdrSKiYGvtdOs0K6kSSjQ4kPiJ8aWrzfnBj8j2mrb3NGvnlgLz
	OzPiqt9iZ/bkvY5MyzrSwST9coqVlP5du0xw2pq8VlYYPp4YHgDiDLVCAUDocQEsgMaK3qmVXD9
	ecjxOXW0/74HqocJavaFmPyrpbF/8niC6bgdtMoozZamQ2UE2Vqptd63dzaeVpRtpbaxRc0NrDG
	xRXRzZ8/Dd2SqoPOqZxYIIC+pKkt6HWVT/TNF80R+bTbt/AvrCNM2/zBPFYRl0gmUMxvuVeW+I6
	ItH3udYiO4IQUsb6wzEj72zniRbY7eeVoZ4O7NW3lS4/ID82wHEtKDtReJW7vRtvJBmikCdtdUR
	jW3KMW9eC2TM5ZcuBvGrswQrBfRkc4LgDG4ZMnkhP3ITsmzPWaMu2Nll6NSSpt5vGNF72mU+HsQ
	s7p9KEmLyzY+03SO6Rfx73/hFzgraLDndfMvtD2KEeipnYDY7EB9c=
X-Google-Smtp-Source: AGHT+IEiMyhzd+qGjTtcxcTjOLP0R9Qanx9dNGOYwrZcvV4wYdUzZw16azjZu+qw8eNfk3RnSRhkBw==
X-Received: by 2002:a05:622a:389:b0:4ee:1c10:72a3 with SMTP id d75a77b69052e-4ee1c10770emr152767231cf.45.1763539452563;
        Wed, 19 Nov 2025 00:04:12 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4ede8593c6asm123256411cf.0.2025.11.19.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 00:04:12 -0800 (PST)
Date: Wed, 19 Nov 2025 03:04:11 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: linux-block@vger.kernel.org, sparclinux@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, regressions@lists.linux.dev
Subject: PROBLEM: errors mounting /dev/fd0 on sparc64 (regression)
Message-ID: <u3aaz4bx7xwlboyppeg4y3eixzgxbcodlmw7cwqloskmg6oqw2@j437p47sfww6>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

With current kernels on my sparc64 system, I can no longer mount floppy
disks via /dev/fd0.  Mounting the specific-format device /dev/fd0u1440
works ok, and if I do that once then /dev/fd0 works afterwards.

  # mount -t vfat /dev/fd0 /mnt
  mount: mounting /dev/fd0 on /mnt failed: No such device or address

  # dmesg
  [...]
  mount: attempt to access beyond end of device
  fd0: rw=0, sector=0, nr_sectors = 16 limit=8
  floppy: error 10 while reading block 0
  /dev/fd0: Can't open blockdev

  # mount -t vfat /dev/fd0u1440 /mnt
  [works]

  # umount /mnt
  # mount -t vfat /dev/fd0 /mnt
  [works]

I bisected the failure to this old commit:

  commit 74d46992e0d9dee7f1f376de0d56d31614c8a17a
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Wed Aug 23 19:10:32 2017 +0200
  
      block: replace bi_bdev with a gendisk pointer and partitions index

And digging in a bit further, prior to this commit the maxsector value
in bio_check_eod (which prints this error) was calculated as 0, which
would seem to effectively disable the check, but now it is 8.  This 8
is coming from the set_capacity call in floppy_open, which in turn
comes from the entry in the floppy_sizes table which is initially
set to MAX_DISK_SIZE*2 (a constant 8).

Using the latest 6.18-rc6, if I change the definition of MAX_DISK_SIZE
in floppy.c from 4 to 8, then mounting /dev/fd0 works again, but I'm
unsure if this is a proper fix.

Please let me know if you need any more info.

Thanks,
  Nick

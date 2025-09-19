Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1541A9F91
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290052; cv=none; b=BzTlIZePzVzMHhsu6fusS/Fx5DVzWCQMR3XV0u4S4xuUPNzKh1jRRFYIh/5xD0YuFu9mTcaiVpyLkUthnpDmtMGIpCqK7EKWcLpvsga5P/KCl05KlnKd/SELYgZlHg4UcNL9TK2cpUTOtyw+6zJnH2BkRv8mRZ10nBKRexdwu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290052; c=relaxed/simple;
	bh=W+iMtBx+Pw/QACrmUXyLP1XErGIDc0F8tT6+HAkmK4U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wh2HVkUZipVqgFPBOm7bOfLI4elEIogEkGBydNpVF+KPiPL843U2wzE9zTiM4bBY7qbLHaw+5Q7cs8Lbc0YVzLdISn5yu+6wHn9ZLImILfilHDjmNF4ltQI4ChF42ijSCIq606T5Sfk+bXMqMH9u3wZmuWNFUVn8wn661dZcy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eHiOnPvU; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eHiOnPvU"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42408762dc3so11198005ab.2
        for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758290049; x=1758894849; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diucNIJ/1ZiGYpJAc4leBBh3itBpoCfbinGePStvVxE=;
        b=eHiOnPvUPzxCRYlWO09jQU0SvJgHsWRdmWbz/nRf1RVhc+2cN9vXV3IB6/zXSkPu7l
         7SH8q3XleCuctY1nCOGI6XXsb9aeUVrK9UCAF1n70ptcr4fD+lYF2MoSqhuOLCVQRG7W
         4lUsLq99AS/KsGYl3OVFtOkdA570gbsowOM6qUKKuCiBDnG5XNxHcM+M2mJqaKZQ7RjL
         f1/DFbyvvl3HKL6qCIv5LFDpgN1Nrw7U4ujuZa6BERL3DFuDRIoPRrJjd/bbTCXgTJxh
         BuFIBJlhKlMCf93pQTlQvPwTVIYDXbTLlp12e6IOyNBl2xbMNZ8zYA/dsOBnJhsj31I4
         uSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758290049; x=1758894849;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=diucNIJ/1ZiGYpJAc4leBBh3itBpoCfbinGePStvVxE=;
        b=GSZSyF9O4DReW8rasHnKessQ78zc1cDvW4CcOdcg7WXakVgm28F2f1SVRbU2ZvZP4s
         l5rVhwgf6MGtYAgF0+zGIczFxD2OuLHgPOr+s1a47NZz6hYvGNMAdU4B1a1Nh/29noFR
         z+OffAtACzEG7CllzTMENp+QbBboFcWbbwU63V3lu4mZ1ba7sV3ooVTtGf94DgCqoZdd
         HwAnQ3d+1mqzORpOoa12riso2muatLHllWnwrhm5Abh7LPQgpGhd/Udw1cftDSQXaVGf
         f/Hmt9WqtxeIXHUo8P+XdmZCSEBMSLT2nwhjMjwij2l9k0tbav1tBYCN5q0QjhotKL00
         xC0g==
X-Gm-Message-State: AOJu0YwXZm2S2wwN4RYfRVzZJ25bZn6v4LQ5gyNJEXPqqXk1uG1Evebr
	RUAJ0dSK/GyR2vfuh2HkFd5V7dY4dkVnX3Kf62e0/E0Wm0mrK//5TcA7YPG7LIwm8gqHdCkzudt
	uGrVn
X-Gm-Gg: ASbGncvKHJgG+SiSn3Iz1rFevwpqAYE8kMhhxVzKAj3KageXnhMtRw9qDk++LUZxSnp
	Tkg4MMtedmBxFSV36bzT4iN1IF0zGTdlcVtzp95bhVtFMUWKXlhsQBx4XWtZAfw3xhSWjO2zHjx
	MTqe7uQowSHCkOm0g/Ik7dhadclPmo8kZUIIA7HtDN5XUE0CWfqHaz/VAFmJLUrmzYE2Mrud0w9
	WBKsXjfnxVFO5x6QQhxS5ZYfDKsOhU9Ks5B50W6R0T0jSvJ9BG831FVLTAV8PGeOY4jaqSymW9f
	ctw57d+X7GqwmUMDZXT7Z+3OQv//utCV/X/Cl2QQjdHY3EiObw2j7bHks41E/iIITE7Y+LjHEkY
	H7BbcO4YVgsZK8pfQ7N8=
X-Google-Smtp-Source: AGHT+IF1sDtRoMMmHJ5jynp4XXWFak3oreFJBFMTsoMb/E5f/AG9ayJQbtuIqg2c1rFyEaZPojyk1g==
X-Received: by 2002:a05:6e02:174e:b0:424:74f:3eeb with SMTP id e9e14a558f8ab-424819961d2mr50177895ab.15.1758290048976;
        Fri, 19 Sep 2025 06:54:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3b015dd8sm2144748173.13.2025.09.19.06.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 06:54:08 -0700 (PDT)
Message-ID: <74923ab7-080c-49de-9aee-faa8c0fb3444@kernel.dk>
Date: Fri, 19 Sep 2025 07:54:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.17-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are a set of fixes for block that should go into the 6.17 kernel
release, fixing an issue with md array assembly and drbd for devices
supporting write zeros.

Pleasse pull!

The following changes since commit 743bf030947169c413a711f60cebe73f837e649f:

  Merge tag 'md-6.17-20250905' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.17 (2025-09-05 05:08:27 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.17-20250918

for you to fetch changes up to 027a7a9c07d0d759ab496a7509990aa33a4b689c:

  drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter (2025-09-17 08:20:49 -0600)

----------------------------------------------------------------
block-6.17-20250918

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'md-6.17-20250917' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.17

Zhang Yi (2):
      md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
      drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter

 drivers/block/drbd/drbd_nl.c | 1 +
 drivers/md/md-linear.c       | 1 +
 drivers/md/raid0.c           | 1 +
 drivers/md/raid1.c           | 1 +
 drivers/md/raid10.c          | 1 +
 drivers/md/raid5.c           | 1 +
 6 files changed, 6 insertions(+)

-- 
Jens Axboe


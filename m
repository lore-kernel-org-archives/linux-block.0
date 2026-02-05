Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12E330651
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330282; cv=none; b=PabO6aFeBp+bP6iKF8ZUsM49W3L1b+QRR3dlTM3nK88+KIZeq28fR1b9UzBNlAV2JXEcbZ4JxTZMqHvZZbRXLzbOdYxiKwdePJEcU5cGF73rEzjNqbbC2O0LmKrBR2FDPkn7rKw3Cs6N7IQebaNFIpeD8L0FmjrPqDNVFciu1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330282; c=relaxed/simple;
	bh=LeV7Ofd1y3udHIif51VvhVaSrvl1sIp1k8Hy7VBI3qM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=V+xBJKl6F7euOCmifT/aEt1hFEE6phlYukvpgNDvpZgGIj2iNh4DmEEJjH/YoQLrGdm2jl/JG8BOnLhe2ofVokgm38CBBMjnmHUqh69aQiM5LERJ5W1wpubMqoW2+aVoseSlf11Mrp2zKFOhPYOSn7GquvA1poaFuPnHDSXECas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YdATRVcR; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YdATRVcR"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-45efde72438so961436b6e.3
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 14:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770330281; x=1770935081; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9btrYPri2+1D2V4vwZPE5w57zIcF5FOD4pzNVjYxAR8=;
        b=YdATRVcRSpUyP95vxbx/GMRQQBZoQmfwIi7t4jJWi+tyPS3zqJpOeAd5u3A2EdfohP
         pvqIALJMcsxqz/RzBDQUPrG12WgyeWxdx89SpAzXiRHdYlqUroOoi0ZVfSc6DoHrQaje
         h+zKgn/q9gSdThSJ8hgVdgCmg2R7PdYdMN7pIl7sWn4FyiGc7wizZPpmorrEwnLmYoMz
         YOOiouSHtWVl2K5NbL8gj9mH4c53X4cc4C7k9iOVTTDmAv7bee4qUCUr58pXh6gBhC9V
         mgDJZ0bZ9p8qqmKBZWy+01aHLA4eZZFUVsGHenMrMzl0Bu/kH/MzDjaRoKhnHBejnNUK
         KbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330281; x=1770935081;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9btrYPri2+1D2V4vwZPE5w57zIcF5FOD4pzNVjYxAR8=;
        b=sLeBagGzWR1z6ptHDigqzPEkDw5WyYAZIkeDYgmyEzUliWWIAfbs6zFNLPSv9LWSSB
         684uXqclrTIFPijmPJP1/P5ODALAU2zPQ511rM8Rld44J/Jp56zljFmuEBApaorTVyGE
         UrtPsY+DKvw5gALK6x4t/UWeuGdGRIzGeDzxEQdkfN+avxqK9/P+VtOO4/4ZiDRmsxSS
         KIxpKdZJ4zR05++LVF291KMj/pylF985YUL/m3TG8Bker4IRtNxxZXZ4Lqe4Yk/BZZCL
         K5+kaGrW+7KUoAqaSidDERyeq3MJWyjzi8/Mrl1x3/cDw18fripHS5vMHmkDwHAQc+Li
         9EiA==
X-Gm-Message-State: AOJu0Yxcv4p7uQbpYnF0vxSfSkiPyhnlbSrkFH2FoTjHL43e1j7z5ECb
	IxOrYo8IhLfywHNKXA0sLKYJKnDOgXlWmKCeMZkZatvwkAOBQMyAig1nKjjdrwDlfE0=
X-Gm-Gg: AZuq6aKtYjL40KFiMnX7hPoN8Y4ZCtPznc9b4hvDIUZH+N4BvKRG5Tj9RFEldWyIrkf
	CFSaqvrBuCMSrl+lgdJDo/ldLsyGRZ2SRy0BoT16kbyv6sDiciPHCheLrQoAFL03eHRCo91o8jH
	RkdpxJl35ja9o8k7guRx7n5/NT7BjjOvNOSpt4FeAGMtLGGY1NYjxs0ss3ONFxnkdJMWaMvPe10
	paTGvjqEz7PJzovFLb5XV7wRKd+wnY7ZTESIt3SOt2ebgJAq2ArxXJjIDPX3ky6xPv621M08dFA
	QWIT2DThfnpH1K9CnpnIcL3PJQH2c6XWHfBzYHXTixaplWAsBskXwIUUnWRarBhQcqgnl7QNhN/
	lBjyonpo3qIQnAqc7uCioLj91P764GVudNwYbkF5gIfozIt2cKBKYTZdhBIrXa89nqRIcm4rH43
	uXVsRV4Mde6iwJk+dd44CDp6uElYgfNY0jGVpbmbGj9Mu1QAq7oLK/FaP5SJE4rH7HkjnR2fEIz
	GoNHQzs
X-Received: by 2002:a05:6808:1444:b0:462:dae0:193b with SMTP id 5614622812f47-462fca075c2mr377852b6e.17.1770330280728;
        Thu, 05 Feb 2026 14:24:40 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feb53cb6sm169429b6e.19.2026.02.05.14.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 14:24:40 -0800 (PST)
Message-ID: <88a6cbc7-19ed-40dd-a382-3efef7d24ba9@kernel.dk>
Date: Thu, 5 Feb 2026 15:24:39 -0700
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
Subject: [GIT PULL] Block fixes for 6.19-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A couple of fixes for block, that should go into the 6.19 kernel
release. This pull request contains:

- Revert of a change for loop, which caused regressions for some users.
  Actually revert of two commits, where one is just an existing fix for
  the offending commit.

- NVMe pull via Keith
	- Fix NULL pointer access setting up dma mappings
	- Fix invalid memory access from malformed TCP PDU

Please pull!

The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:

  bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260205

for you to fetch changes up to a6abd64e145ca3084b6a567e06517a7c2dbfd38d:

  loop: revert exclusive opener loop status change (2026-02-05 09:26:53 -0700)

----------------------------------------------------------------
block-6.19-20260205

----------------------------------------------------------------
Jens Axboe (2):
      Merge tag 'nvme-6.19-2026-02-05' of git://git.infradead.org/nvme into block-6.19
      loop: revert exclusive opener loop status change

Keith Busch (1):
      nvme-pci: handle changing device dma map requirements

YunJe Shin (1):
      nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

 drivers/block/loop.c      | 45 ++++++++++++---------------------------------
 drivers/nvme/host/pci.c   | 45 ++++++++++++++++++++++++++++++---------------
 drivers/nvme/target/tcp.c | 17 +++++++++++++++++
 3 files changed, 59 insertions(+), 48 deletions(-)

-- 
Jens Axboe


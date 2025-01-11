Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA29190059
	for <linux-block@vger.kernel.org>; Sat, 11 Jan 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612385; cv=none; b=W2UKdsyJh60+6EmxsaJlD2JD0KIWx+Nboy1bfdh27d+sPmeLg/c1EoCFGCCwxOtv9W7IxS6OqZ8XbI8oBKbMJf4v5WZLbOMsRkFQE2mUc18Jw+ZOxPosHwrt9bKhH0Ue3HIkraeGiLsPNDdh71ieqhn2tdvBdEqe/eho2GfTPWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612385; c=relaxed/simple;
	bh=p9RbMyk2aHge/NMu4YrPSM2Yb4yebWp+9nam0A8yJR8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XIsj+uwuSHH23gTKN+ZbNJLTqwPedp9BGf+P4pmuSi6mI6SStF89F8Zo147l9/2YUK1r+Fzfm3t8VKIeXQdaClWIxc+2cVVqqJCeuSJtX5pomFYdsJgVB5rvmDAGJrOfEQBpLBDIrfkjYIMqmIJrXV3cGVnx2B4DXsnVnQSDh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3YKTnV+j; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3YKTnV+j"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so102422939f.2
        for <linux-block@vger.kernel.org>; Sat, 11 Jan 2025 08:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736612382; x=1737217182; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcHX/08zilpmViev4xCeK1fvu86rTyO6UFUJZwksaWk=;
        b=3YKTnV+jtGqPK5bYiCzVvNQ5BHsnlcFw1JjAIvxUe5ig1eYzml8bY/RgoLoJhy5WWV
         iBvHU+1w5R1zoLDd8/XZyX8F86vRyS4xAzaVeJjXvLEQ1ZhTCqTkN/6UOK1OWcVze7xP
         m45/iHna2TEwKS9lVI43P4PfdhQ0mqoW9g/9FccX8u98AEteT8/PBnt50pVTLjqSYwiG
         OwMHL3TbS9xODFlhJPEybW6Ud7ZcgRIGoOqMc33A/QQHmdW33k/Nr0u4mdbcLgAwgFeN
         temqENqKIX8wiyjBMGFjZhY0u7Jq7BqHWOAFcnViMop4SufgionmhXEHahEscQDuL8wM
         DVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736612382; x=1737217182;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LcHX/08zilpmViev4xCeK1fvu86rTyO6UFUJZwksaWk=;
        b=rIwpfzyUpMXlMJVEzFPopL7s63H+L4at0Z/DLPevK/7Sez0dxOv3xIfAc6wBl9i7nc
         CjcJRHuzvZJ/fo7RqNHWKBmRbayXE7H5+3RnKI2o58RKG7Fc9Jnk2W0FFJUlFeHoE8yn
         VIgVZCbs+EssStEsyUWiX7BEh6DLkqCzp6d2MOqCDcZZAu/7Qeyz6qza0h3DfdQhzEsU
         N+B6HE3zgtW7/3KzdYFJPDJDxbjosQgyDHprRmUMeW9P/YGWpLu2Y1L0+EOlqGUEcWAs
         zou2b5tGyNLTve6uVd4NT5S4BDYEoG2ilQ8xpa9hZ3aincL27T9hMiLdQbdNGYYjhQOP
         jS0A==
X-Gm-Message-State: AOJu0YzULmlptXWsvVaNcoQKnBIQsGykG/1YOXEaFdNLK9BB8oML9xTl
	5kSkSTw+hpIIChQeYdjh/d9Ov6Q84M31zWS6XVeckuzIKk9wTnyYUpMGoI+6BteLONqabYkffKX
	F
X-Gm-Gg: ASbGncuC0FpzITZBOgn/DsUieEGo7EVeXMJq9H8yfIM+7feTzY0lKMlE+aO/pzykjyj
	VskM6OIkmoDDJ22nVYrrjhnHAWT9apNANAwYDUd9ORHNG+Fhz1E+UCGxH348ZTkZZKtS0aN6vlO
	4rAddp5InEaYQjgtGcS546yzrAjChsnXIt01/rTFKBi5zn7DVOrspomkMQrhtlEsBay/XrjpXXB
	L0JZMKoRVbVYrCJXqaIqdxbc6p/uORW0VpVKVuHhKMotRQLACr4qA==
X-Google-Smtp-Source: AGHT+IFAIFtb0MZ7W/nR/vA5DVzDsPG+f+K2tEGdDD80eM3RzmSRfB6LH10rn0u7wGXw6lCVaQMbYA==
X-Received: by 2002:a05:6602:720f:b0:83a:a305:d9ee with SMTP id ca18e2360f4ac-84ce0162dfbmr1449227539f.12.1736612382549;
        Sat, 11 Jan 2025 08:19:42 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b718bafsm1602219173.96.2025.01.11.08.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 08:19:41 -0800 (PST)
Message-ID: <7f932dbd-f009-4df8-8d8e-618ec036a004@kernel.dk>
Date: Sat, 11 Jan 2025 09:19:41 -0700
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
Subject: [GIT PULL] Block fix for 6.13-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a single fix for a use-after-free in the BFQ IO scheduler. Please
pull!


The following changes since commit cc0331e29fce4c3c2eaedeb7029360be6ed1185c:

  Merge tag 'nvme-6.13-2024-12-31' of git://git.infradead.org/nvme into block-6.13 (2024-12-31 10:41:58 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.13-20250111

for you to fetch changes up to fcede1f0a043ccefe9bc6ad57f12718e42f63f1d:

  block, bfq: fix waker_bfqq UAF after bfq_split_bfqq() (2025-01-09 06:52:46 -0700)

----------------------------------------------------------------
block-6.13-20250111

----------------------------------------------------------------
Yu Kuai (1):
      block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()

 block/bfq-iosched.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
Jens Axboe


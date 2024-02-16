Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9F1350F5
	for <linux-block@vger.kernel.org>; Fri, 16 Feb 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110770; cv=none; b=gyGuYD9egYSTc19mzp8aJVnLl5ehgYz+k1XEfiBWYcmdjwDdY2WVNDC+YZvzOsF9Y0Fbyig3EoaBecxjbYN0QVTxadf0uaYy9XhPkVN6j11sJHPcw1W4LfQTDzSFmuN2aTBQLgBAo7JgFAdq9nRA/uXNrFWdE6IR0zKCpMriJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110770; c=relaxed/simple;
	bh=gFhexWa370DZXTLtwLeywIL7He2NnppyhkVLALaAecQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hzZ0Rrwsog3z444S9s8CpCXFgkyyCw9kFR4/COCDNBD/qVS1NHVFbWnUrdNl9EFYJELlysqv0isNnZM0uRlUF4YjL/9WKUvwzUbOBkLCBxqfutBW/4+ERrQETUYN1yXTt+BdstoEw7SG1M53zV+Nl7ut+3UP0Yj/4KGITce/GRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WIWx4Lhg; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WIWx4Lhg"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso35378539f.1
        for <linux-block@vger.kernel.org>; Fri, 16 Feb 2024 11:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708110766; x=1708715566; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlqODGShaW3Qe9nqb53eHTKJOf3of0mOBNSuXQlDSP8=;
        b=WIWx4LhgnY2vTjmyKevw2USD35PSbCBcSnXb8OfnYfWsDER/58Roo8lBSI+uUkrnfY
         g5k8/wfW0OIscdE8qi9F4alME2ezJKJTGIVkoQ3WrOfOlN/GzuJ6yM6Sw0p8SW6rjR0R
         rK0JCE9fEhUT0VqzpHtBvvgz97V3Oy6fVbdhq8iPLRtlsq3Gr8zBfvcPGQ86RD/HzDbq
         WcQuGYevcjSQI5Of4ueY7c0HyzoC41tmDZGNp83M3yNNJMAp8FXzrfEa0buFGpExSeh5
         +Oh/3bGkd8Po47V6gk/brnv17XDWtBnQPyczVo1gkGuyB48/CZtFJw1z4odFjaflR8yU
         ogrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708110766; x=1708715566;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wlqODGShaW3Qe9nqb53eHTKJOf3of0mOBNSuXQlDSP8=;
        b=v2LL/zgQFxylmuTfJy0ceLOzjMZpCU9Y2VOfdbpgiHm4dRYsqFRzFHAl9brvgc45IG
         QXwc/Ekh9Yqamu3sMexrUxh34Bg9ix8OPmNnnR2UF6P6v/GONc3UbcYn63ekTjcybh2F
         6UvG2knHSH/konHXHKEHk6mohB+jpWp2tOtynCkOZpy126pKdyms/t93xqmFi4jeBH+2
         VvwzFYJCb3B+dpGSyOhbCMJKRiraP6TrtQXb/i+MXzlgUYU4esANMSGm/vquwaT4y4fo
         h50Kb8pkmdeOsl5L4hVm8+R6ErwPxIBiWRMvAVijpWaK0U7c7q1KV52GLCJpWy+/s9Q7
         x1KQ==
X-Gm-Message-State: AOJu0YzWdT2BbAJ2mB9jgp08NRxRBNNDaOhoYPWcKlt25QptISesl5Af
	PJ6yrNMOxBJeD/AOdV8HmK1OGbgphiqwnC4qST+Su17lzwKaiXnUA2SzWWrYT0Tt7io7aoGpY6t
	+
X-Google-Smtp-Source: AGHT+IFXassR9GPmm5dhZFtu7G/i/hEoZ6Xahgp/Vq3KuiFySc8WT+RivA0inkyRccZXEF/1e+WzjQ==
X-Received: by 2002:a05:6e02:1c84:b0:363:ac1d:ae0f with SMTP id w4-20020a056e021c8400b00363ac1dae0fmr5872312ill.2.1708110766194;
        Fri, 16 Feb 2024 11:12:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cd4-20020a056e02320400b00363797f6b00sm650283ilb.8.2024.02.16.11.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 11:12:45 -0800 (PST)
Message-ID: <c055359e-c84e-4b38-94bf-aae964abc093@kernel.dk>
Date: Fri, 16 Feb 2024 12:12:45 -0700
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
Subject: [GIT PULL] Block fixes for 6.8-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just an nvme pull request via Keith:

- Fabrics connection error handling (Chaitanya)
- Use relaxed effects to reduce unnecessary queue freezes (Keith)

Please pull!


The following changes since commit 5f63a493b99c848ad5200402bebe26211e00025a:

  Merge tag 'nvme-6.8-2023-02-08' of git://git.infradead.org/nvme into block-6.8 (2024-02-08 15:05:18 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.8-2024-02-16

for you to fetch changes up to 9c10f2b172eb26007e9b641271798234911d24c2:

  Merge tag 'nvme-6.8-2024-02-15' of git://git.infradead.org/nvme into block-6.8 (2024-02-15 09:42:03 -0700)

----------------------------------------------------------------
block-6.8-2024-02-16

----------------------------------------------------------------
Chaitanya Kulkarni (2):
      nvme-fabrics: fix I/O connect error handling
      nvmet: remove superfluous initialization

Jens Axboe (1):
      Merge tag 'nvme-6.8-2024-02-15' of git://git.infradead.org/nvme into block-6.8

Keith Busch (1):
      nvme: implement support for relaxed effects

 drivers/nvme/host/core.c          | 4 ++++
 drivers/nvme/host/fabrics.c       | 1 +
 drivers/nvme/target/fabrics-cmd.c | 4 ++--
 include/linux/nvme.h              | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

-- 
Jens Axboe


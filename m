Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FBDF43
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713626903; cv=none; b=CGObMt+ODQ4YnHrkeI8vo7kA7abuHl+G+WeeINvxcQZPP0ET5smU7tFrtYL5NS8nQOykwMKzZJuXHrvbSB4gEuYUzhqzpXSou5K6XAU1l9bPXTtUBYXjhuLlX4uRhERJbl0uFEDv1WdfSIDp0sVN+jvFrLpnYS8QSj14BMv1+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713626903; c=relaxed/simple;
	bh=kqwxwr8lhGIBarP6yXHThjWf/eXdjVdTxyTxUaMZocM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KbDxC70F96KdnfOqL7rimRhRlFDOUmcHrLCMMje5M+ptunoC98JTy3H64yO5C1fR5IdJbSz3pMF1uAPhutvI0pm2aim1LqK45sih2HoIid7aj6e2aKkWejgFlOXaJmtxMH4ewvj4CKXp/wKrNNoDmsALVt3qzuYtfQDTyn0QkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lBwvhog2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lBwvhog2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e45f339708so3740785ad.0
        for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713626900; x=1714231700; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUia4dqOR/YS9n55gIhyP76XMs3k0eQSUBs1x7S1i7A=;
        b=lBwvhog2tZKoGqVVo8vZQ3tuY0J0ALpXju7q4Koq013kR8Ci5I6hsvs2ACVDJTewJs
         QoknuO1VFQfOYDCVfn4xwuuBI7N6Iz8dmpwMbrTpQ6eZH+kNfXBxcOiWjcfL2E7lnSmS
         J8Br3l6cTE66M/LSVOgdWvFQsWatJ91e4vQcFWeMxJsMMpcA402/NWWHXv5jhooKDOP3
         pt6IPZ6mfdhATBim2hJx63zG5kDIBusPQpjLtMSOffBX0i2m714+nRkfgo8ZdnstMrrb
         dMGACc0zCC/C+iM1o2qQXZn+Fqc5HnbkJy2zxsjflnAzfrq97XfGamw9LvFdBpUJkCcx
         f66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713626900; x=1714231700;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mUia4dqOR/YS9n55gIhyP76XMs3k0eQSUBs1x7S1i7A=;
        b=J38LFdty+L7QZ9S+oBsAFWeWym+XRZsw1j3w7VvgmGC4ZOzNXMCz2bAO/+OOgYqqUo
         quZaMgeiLnlTp9PiMLpFcbZMPJF4tWEyzg/oHrLfUhnXa9hkVhrFL1sBWKDzQULcxj0I
         VKuy/unk787wIcXyclj+meU0TdPOdmEA6uwDduRj+wz/vvWIkA9IbCqT5xjN0KqTeTGo
         pn84yj0CpKNoO7zaXrihyNAaVqGPI+dAURY9tLKQ5HMo+jMCjaBRSgzN6scmycoTZZyC
         cKuXwoh5t42SBqmBkJg9pyExNCF0dq6YA4wjJKumJAUoCYs533IN1BfFjnp8s76EAKnp
         bMXA==
X-Gm-Message-State: AOJu0YwSUBbgeESGkXGAGggkq4TB/SjJs99EjF098iuULMwb43wzytQF
	oms0PjGoD9r2EWC6LEa6VHSOVmbx//7QWghhPr9u1KskSW4B7hsSS60bWmcIG7g2z+Zy1roKuqQ
	t
X-Google-Smtp-Source: AGHT+IHP3UqdIIthzAxo+X18sxLzHmrXvHLLYZwSW+fwlc9fB56Nv47QEqIMO+eIHoxz7DbvF9XGZA==
X-Received: by 2002:a05:6a20:3202:b0:1ac:3efb:2889 with SMTP id hl2-20020a056a20320200b001ac3efb2889mr5614459pzc.0.1713626899726;
        Sat, 20 Apr 2024 08:28:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id t8-20020a056a0021c800b006ecffb316ccsm4986850pfj.202.2024.04.20.08.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 08:28:18 -0700 (PDT)
Message-ID: <b3c34e74-a86c-4595-954d-e73ef31e8cb8@kernel.dk>
Date: Sat, 20 Apr 2024 09:28:17 -0600
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
Subject: [GIT PULL] Block fixes for 6.9-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just two minor fixes that should go into the 6.9 kernel release, one
fixing a regression with partition scanning errors, and one fixing a
WARN_ON() that can get triggered if we race with a timer.

Please pull!


The following changes since commit 3ec4848913d695245716ea45ca4872d9dff097a5:

  block: fix that blk_time_get_ns() doesn't update time after schedule (2024-04-12 08:31:54 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.9-20240420

for you to fetch changes up to 01bc4fda9ea0a6b52f12326486f07a4910666cf6:

  blk-iocost: do not WARN if iocg was already offlined (2024-04-19 08:06:24 -0600)

----------------------------------------------------------------
block-6.9-20240420

----------------------------------------------------------------
Christoph Hellwig (1):
      block: propagate partition scanning errors to the BLKRRPART ioctl

Li Nan (1):
      blk-iocost: do not WARN if iocg was already offlined

 block/bdev.c           | 29 +++++++++++++++++++----------
 block/blk-iocost.c     |  7 +++++--
 block/ioctl.c          |  3 ++-
 include/linux/blkdev.h |  2 ++
 4 files changed, 28 insertions(+), 13 deletions(-)

-- 
Jens Axboe


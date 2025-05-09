Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798331F03D5
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804852; cv=none; b=CYjxTAVcy3tVdj/bnITFwioJl3++HKMYzlxitI4rrexnQjc07niLD9EJTXEx54MahaOVjN8rTIgRde+Xq2SdenHxv/aRoA2B6lsT6IYM0HRT1rOoy/5HsAIOupM8lyNmKRx3V3zImYxLLVIHnlCy2ahdHeseaUhnrmdf+YHoO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804852; c=relaxed/simple;
	bh=D25K3raHQjo/BIpCagai5usJgD+Xp9L5J3oF8QLzBLc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ks4GcMeB2hrCtvC8EQcJMrua0SsNQ2eyND73lwxk2BpFVpEuVnDhVjmy2MOPIqadOfOaKi8gU664hTV/NPRCr+3akR1kdAzmFJuK4Nns9aKM8rGDv5M9570OzT2QhLSIUWFuj3jH2ZvnitL4A2dCnrNhA/ezkQCp0p+zOy2XHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0wLKZfqI; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0wLKZfqI"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d96836c1bcso7932775ab.3
        for <linux-block@vger.kernel.org>; Fri, 09 May 2025 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746804848; x=1747409648; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxY6gpQ0zkMr7IO2fT1ctpzYGdY0TqymDmigfbJQrS8=;
        b=0wLKZfqILdi/qUVDW9oZEbgqZApw8hhjQ+WSmljWIBI8nwPm9JK/KkXJHTQsSc5I+/
         dHjN0FSO7RLKtwVGxu5+HKXBSEBpHZlNgF/ijDyQHxNqwsYVCbtZcKXsMb4uBBP0mQye
         RoIJUy1KU3rzNEoKtPTRVzLgQdkEEp7L+olTI5ROnEoiBSFn3Ouo6BXGb+sH8/Fyj2ka
         xn//N8P1UQKn1SggWa9zEZBkUYxVIgf5hUXFtdJ2an4UeQb+IFaVdhL1MErghtyyP72B
         KZikFt4WeI7fD3+MALY4SKefZCH2dO4wbjhsEZyug6xYt6tI/UwhE2XZWD/Go3kE3CoS
         5c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746804848; x=1747409648;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxY6gpQ0zkMr7IO2fT1ctpzYGdY0TqymDmigfbJQrS8=;
        b=ZuEUf8s7RMn4NlOee1351o+TQ6SGD+4kjeAKDNP7/JK3TT9vqfliQb3m0/5ZKsotD6
         y8APrj+K4CqjmwI5sEkpRwLdj99LS48C54dWmJyDwym51Raw9evKyGrjyVEQyKBNl4CM
         Uo/ydnwKVtEh/a1GIF12KDlGtAMJ/2cGHTlYEDLxGTtPg4wHhrv85RfbhDDF93VtPp+B
         4PTr3wnuRLmTd8mD5CGBQgL+7kNiqm9w7ugwQythGYDuI87AtL8vXZ2olMA4wn5o4In+
         tmrEDKOMBnJO2ArGR0H1/Ls9QretvllEXvur/YW+sikHGzEFiyjUHfRx31ParDGLdOlF
         jI1A==
X-Gm-Message-State: AOJu0Yz32KQ5fxP0xh1+/hFLbb9we6wI8LosDqwS9UxyM/apBf7fwK3b
	14eZo+2pFlYLqZBkQKMLz3V6lGee9qlS193z0m8HzOdOlKEvVn8Sahlj6nLlUAc/EqT57FBVsea
	6
X-Gm-Gg: ASbGncuNt0oLzjc/O8GBCvTiIBepHB7dtJF7jwSt/jdO7ynl9RGo48Z4tGXB5Kv86La
	Lf/qWf9XFwDyGM/5gnCZPgE1Ekn+O3BtNpzKq8/WSVtoNswrjfoFmHmnHxfhcmTwYXM496DHFVx
	H7j2QxxghdwEGIA/ha6rAo1d9MPWiOf/2ktMNk+rBJtanDUA8Wnfh/Gdz69nLLSExWoPnD+qiN5
	0opZ3JQgKorikGB9+f/HCi/hyNWHonOOE+EaFP7UEqnW2DdyCDaVoaYOhxK2cUrfctH6VairvJF
	DLzSNHcd7ehfPvPBZ63C/IivJNyNRvShNn+z
X-Google-Smtp-Source: AGHT+IHAoiLa29azW0J2cvVt0g6stwf4zUiOV6rCfJzGRxcRGBtcKJHiUgVdC/Kr9jE9Q+r+f63w0Q==
X-Received: by 2002:a05:6e02:17cc:b0:3da:734c:42e0 with SMTP id e9e14a558f8ab-3da7e217ebfmr54515605ab.22.1746804848332;
        Fri, 09 May 2025 08:34:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa225258c4sm442772173.67.2025.05.09.08.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 08:34:07 -0700 (PDT)
Message-ID: <10083b7c-4ea7-4494-a6a4-764a700516c8@kernel.dk>
Date: Fri, 9 May 2025 09:34:07 -0600
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
Subject: [GIT PULL] Block fixes for 6.15-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for the block area that should go into the 6.15 kernel
release. This pull request contains:

- Fix for a regression in this series for loop and read/write iterator
  handling.

- zone append block update tweak.

- Remove a broken IO priority test.

- NVMe pull request via Christoph
	- unblock ctrl state transition for firmware update (Daniel
	  Wagner)

Please pull!


The following changes since commit 6d732e8d1e6ddc27bbdebbee48fa5825203fb4a9:

  Merge tag 'nvme-6.15-2025-05-01' of git://git.infradead.org/nvme into block-6.15 (2025-05-01 07:56:02 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250509

for you to fetch changes up to dd90905d5a8a15a6d4594d15fc8ed626587187ca:

  Merge tag 'nvme-6.15-2025-05-08' of git://git.infradead.org/nvme into block-6.15 (2025-05-08 09:08:23 -0600)

----------------------------------------------------------------
block-6.15-20250509

----------------------------------------------------------------
Aaron Lu (1):
      block: remove test of incorrect io priority level

Daniel Wagner (1):
      nvme: unblock ctrl state transition for firmware update

Jens Axboe (1):
      Merge tag 'nvme-6.15-2025-05-08' of git://git.infradead.org/nvme into block-6.15

Johannes Thumshirn (1):
      block: only update request sector if needed

Lizhi Xu (1):
      loop: Add sanity check for read/write_iter

 block/blk.h              |  3 ++-
 block/ioprio.c           |  6 +-----
 drivers/block/loop.c     | 23 +++++++++++++++++++++++
 drivers/nvme/host/core.c |  3 ++-
 4 files changed, 28 insertions(+), 7 deletions(-)

-- 
Jens Axboe


Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB835B123
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314304; cv=none; b=OQlwWTQPlQwy1iVD5/wNDO69IUC6GDkT3HAFEiF6BW8hwM8WcOr+nJvDBGW3C9YpR9aKxT+hZsS0MY4GQQY4H5/w1GHD2yDJ7ToFcqLDUZPqGkw9JB8c97db8RRM9tO12rvutw0PpSx8w4dkIciIIvqABDRNM3uzGR3vniILPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314304; c=relaxed/simple;
	bh=Mzbdre8rsdkuT0SR3rjJqqm82wh/BB6kCooRmPzxAfc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=lAiqj6ScW7bZV0lTE6/H3ohc9FGnPAcgZrL3IMCvGS27YG52FkvrNIKa3GKhE3EDw1BgZR8BghMUgzL41rDAriVnXKE65FKYpo0vO/He9BehepoQHXI+uW+dna/Hh1lwe8x9UpLK0fIJJqZry4k8uwusAQY+f9U6g0zuPE2yb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JPkBUhd3; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JPkBUhd3"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so87126639f.2
        for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761314301; x=1761919101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BjXHR74LmdVG1fG6pUioWYfFN+1U+EVzvmR7T2bp3M=;
        b=JPkBUhd3LcFnOCk87psPdPi6vxt1KVly1MebsVFp1e9sKR0zieYBFBCo5vHlU4aDNA
         DqWi3kBc4OInH/CAkJpsJPTAKWgv/Sr9IPMxh62PYcDw8jJoW6E+2ojA5k/RseV3T45h
         C+vEEmWWLXb7rNzbKV3sscgnLmpmk3JjDjKlyWf6iTNsnVQ5Klw6TX+C3S3MINRynpXw
         v9s/fJvtM2ClZR7f+Uf8sNIGW+Bt9mp4HzODcaNODSeei0HzJ3jLSPsGvNBJUE8yATwe
         TX19w/sb37ESgK9pyBu1Jq7aQj22djQv3xCoox7O7v0lyS/aURy90uioNhZ98xRg86t9
         hOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314301; x=1761919101;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+BjXHR74LmdVG1fG6pUioWYfFN+1U+EVzvmR7T2bp3M=;
        b=TmWLQyLL8KRFB/ripTVVvDnl96xFfyL/R/0VdLZ8eBO2WeM47/u8b/qJ4f76hx4miK
         aZpEL+mzq9x04OFbuTqKPvaorGIEwu2rEDNGrBCyICB7MQl4oC0TT5Kdm8xWwxL+gxQ0
         NbnHQVM6RY7Jf3A6dUGfQk1GzbeaGqeovIIx3Ur0Bx9Vg5hICi8c/Av5iFxky6jgDrNK
         cjp6tOQ/igpTNMgpU04sr7oxLoX+uUmJceLw+NBsWv7PTsf6UlY2km4UGdH/RNVpImlK
         wlTKV1Ws1s9rgbjjQ5M9Eq/v1aJ/w2a63YN2NYh6o6h+QF5vrOrI3pmDGVvN2C91MgqF
         nccA==
X-Gm-Message-State: AOJu0YxdTm/auyOSWRQiWgcJslojUnx4b6qgq2DxovxpmDbo61jih76O
	F9383G7rcWeAsKNisV2mF5HEEwzBU76MJAiwGTFlGKyHMXk1Ve4oxY98bML6wSiha3sL/rCXcgx
	2VP2mtg0=
X-Gm-Gg: ASbGnctZqpTkASK5vKQ3TmDkFU5dXa43TkdprUN4OJTeuMNYyJdfLA4RP9tGqNEQozV
	QPqZjKRz8TfMwQg3r8sofr+0JSCzJgEIAvdReZI4wAhqrhQrDqitgWDnBNrs9q8DwKxipMw3MUm
	MWJENTEJUhYnH0ZkYxT4/qWTHnZbAQzMfWlAitEnzBLKrCIbQpVqfAcvG7dtSxnBhMR9K6MPqFu
	0JkAg37D6meSWfOCkAJTWgh98OZLdaxYQGQFBKCQLwNV3lHZj4OXlnQCDrGXrDiwb439oeqgHZx
	HHJNtO6twW8msvpeVCufVd/khai/mtwJRww/hvoWJnn//Yew/q4pDsLhKR5MLgywgGeAEmRtO8O
	N+67EFo2U34DhnxUzb5vFTWjO6u8Cg5F1BzgkMc+mcOupKpoIFRhLKhL+njvryLHGDN16rX+4i6
	rGQjUcJUFb
X-Google-Smtp-Source: AGHT+IGSexZuehi60seXxUL05GYCO14mNr9GG190w4tuktuibACn04hg7fxFdMyyrDWuUyIGXIVp2w==
X-Received: by 2002:a05:6602:1645:b0:940:8158:a385 with SMTP id ca18e2360f4ac-9408158bfb8mr3088630239f.18.1761314301203;
        Fri, 24 Oct 2025 06:58:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94102f840f0sm177941039f.17.2025.10.24.06.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 06:58:20 -0700 (PDT)
Message-ID: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
Date: Fri, 24 Oct 2025 07:58:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.18-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for block that should go into the 6.18-rc3 kernel release.
This pull request contains:

- Fix dma alignment for PI

- Fix some selinux bogosity with nbd, where sendmsg would get rejected

Please pull!


The following changes since commit f0624c6646435c1b56652193cce3e34062d50e3f:

  Merge tag 'nvme-6.18-2025-10-16' of git://git.infradead.org/nvme into block-6.18 (2025-10-16 13:25:40 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251023

for you to fetch changes up to 4c8cf6bd28d6fea23819f082ddc8063fd6fa963a:

  block: require LBA dma_alignment when using PI (2025-10-22 10:02:54 -0600)

----------------------------------------------------------------
block-6.18-20251023

----------------------------------------------------------------
Christoph Hellwig (1):
      block: require LBA dma_alignment when using PI

Ondrej Mosnacek (1):
      nbd: override creds to kernel when calling sock_{send,recv}msg()

 block/blk-settings.c | 10 ++++++++++
 drivers/block/nbd.c  | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

-- 
Jens Axboe


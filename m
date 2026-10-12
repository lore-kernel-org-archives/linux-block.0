Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C434E9C13
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836190; cv=none; b=o0XvMZ04m4R/SDdkF1FvcxKoTMiKlng7kvrTlDuAtk5hepmWnh8KWUvguuGeDVJHW4+js4Sdm88NDH2fD21vW5nX1q7LH6hLUJpZJhR8ua2Uc9CP9Bic9UuaYZUz7EGsIvN0+ZV9mIMBdvfEaD4LR2evwjaZ6N5rb+dBgPJLJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836190; c=relaxed/simple;
	bh=E/5MB9DmrAPZDxIzNkf5ZDQX8eOZAjHFk1n9mFFTl2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=So/q+L2hjkXoFg7SbvvDEGpwX+B9ntp84ooVsXifcdV2qzU8XIy0sEoiAL8ZM4y/9bCskUtDxvC+mx+G4qmLEF6PE7j8HPFW9vWgFbVIYLiwH8fnVCMOIaRoYl0hTf3XqAb+jSjgcv2fguWKTgBpGHMSbkVg8r0MF2erWOCe01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ezThKuKF; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ezThKuKF"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-82503732024so1150035a34.3
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836186; x=1792440986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=;
        b=ezThKuKF8wDokh9LV126CqDkq7P34XkK2Biiu+wFZl4Jqu5AOH3ohzQx+ZNa09FM86
         lLei/mQ/hyy8kog9HVR2FUVEJe1pyM9H1I1c5b+/N5csUF9CIa3j4UWCn+8cP5LZIoVQ
         q3hcv7E6lpGLnA1dKzIJieWJUq5XQAocUCz3cqnts6ArMOCF+CWPUN7dN1tfRWurC296
         ChWyKVASsA2SD4Fqw67KHcvAwaOBQqZszVCKij7Z64plVx5bYb8Dt/PsdtxmUmDR7Rtd
         3Vezv+IAle+KoE0wT/2yoWe26a+qYPgY0eum1UwO9HZ+1zUasYuivhbyy8SaMI2HjRMH
         naQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836186; x=1792440986;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wg1Ux0hl2+pwA4qVaI3hvIFFByPMMzuli4I/B5ITH7M=;
        b=EVwy+xuApfh/7JGgB/SNpT2IffRPPNtoUqw0Kwwqv9MDKJE0kFNKGeEhPZhrqaB1HP
         /AfiiPyGf/rXYHwfEq0KmfUi/wD/xc+lXGvvc2gKCnaJcZvzwCxEPhU4QTKIEX05C/23
         ZuMmNae91FuZCiQ7k1/nI7uQiZuRXs0E0HL0KCOrvlWOcQ8wYS7k+BvaKlZ0JT5vufEt
         GMw+9p0Ez3I0ArCOrKZFz6w8zjcqFD4q2+CU7VQbS4vRd/wQSB3Obx7ZUgw+a5UFBwxV
         pzIF9lZGgXdltAy58cjtC7VIZmZbLGeSzcscrZDXqcUEqzHDX5437yzXjPYbmPqqXaOm
         jMRw==
X-Gm-Message-State: AFq9FYL9TgfkxGRzhTB+AmmrgZ8rQ3z/HXKOYOlwSXZCFj1fVfyRlcgt
	RkgcTOHEUuLmNjqWmAwHpeqNIhWKlrNUAyjO1DPq3f1J0gn1PsW6ETgfX1w9lvplF60=
X-Gm-Gg: AYBFou2pGhuN2tpbI0LjLs8ip2PW2sw8qrWsOPze4/v+O7fmDMpSmfEe3x+AQWUrqRF
	hjImON1BsxAj9LYk+KYQy9p9DTbMWE8xeMGY9LD8/uk25wVMkSfAoT49+DqVAlwNsYk3cqxj4PB
	8CjwxQPvHC9vl/GyK/wX0gKBdmNVFt6nnyctXc8YWcaipr7pzR7APEzcF3UuPFtTH6FcwT1OTyl
	kiz+vtRF0emBN4sMdhgkIG5uKHY/1VLfX1jIS4kv4vIVstslPsF5xgIvXGIDm+ikejZfrStbiu+
	T/LIyOE9HBvODYMoq4y42Th97UbRvjAi4F8T9rMDoMLHQR7x7/lgB43VDeEr6eszeeX9kysxZB+
	Jod0X0S/W3+J4C7odIEX8WWGuVvw/truXgzVmr1xYEeLITJ6Roo23WHwtg0/66RE+/u0h2RwMXk
	ocKn3xpdpbUSwqed88MzAVvxmjbwID//Yeb/Z61y2CD4WoY3F7w/jslcLA+ol4B5GqObG8mSnbX
	ehg+XMpkoR2oFwJzt1TnbqXKs0RzkKYei7UqvtE11J3d1gX47m/Wakuvn4PRee9u48r
X-Received: by 2002:a05:6830:4104:b0:81f:92c9:1f80 with SMTP id 46e09a7af769-83095b2dcfdmr13038337a34.16.1791836185941;
        Mon, 12 Oct 2026 13:16:25 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039076d72sm10441653a34.12.2026.10.12.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:16:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
Message-Id: <179183618332.250226.7412463798702866633.b4-ty@b4>
Date: Mon, 12 Oct 2026 14:16:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 07 Oct 2026 02:42:43 +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.
> 
> [...]

Applied, thanks!

[01/13] dma-buf: introduce initial file I/O infrastructure
        commit: b899f5d8a9594f3e5be7c481e4631521f0a6e42d
[02/13] iov_iter: add iterator type for dmabuf maps
        commit: f41f84796a1129838524d2aa542598c22822a2ec
[03/13] block: always adjust bi_offset on bio_advance_iter
        commit: dda48c57e1484f967727d827923d3fb47d6b8aa3
[04/13] block: introduce dma map backed bio type
        commit: dfc9cc23122deeffcbf562a0989c695e8505d54e
[05/13] block: add dma-buf support for raw bdev
        commit: 738881239a914b2d92cafdf1030c382f1614a293
[06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        commit: db93ee31780323044eb5d6279d89f6ae49493f39
[07/13] nvme-pci: implement dma-buf backed requests
        commit: bb3e58f540e95ad55bc7ba6a6f713f79b4e79e7e
[08/13] nvme-pci: add SGL support for the dmabuf path
        commit: 3676bad01d84421fbf8567edafac63bef9f648cc
[09/13] io_uring/rsrc: introduce buf registration structure
        commit: fa1925e901c00b00695edd29d053564a6de63d9c
[10/13] io_uring/rsrc: extend buffer update
        commit: b497df80ba7536cffb2c5364e725c0812135886c
[11/13] io_uring/rsrc: add uncloneable regbuf flag
        commit: 10b6521fae14c5941b3fd77d1a48eb7a424ee487
[12/13] io_uring/rsrc: add regbuf import flags
        commit: b5a1e426d22fa059eaac1106292ad60c8da52d17
[13/13] io_uring/rsrc: add dmabuf backed registered buffers
        commit: 4bb797852328975051b001189f3e3840cfaad2d7

Best regards,
-- 
Jens Axboe




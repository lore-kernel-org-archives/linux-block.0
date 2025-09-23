Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04E189
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626421; cv=none; b=NATnd/6udGvPJSbSASgHn76QPqaAo8wB6PZe9Idhats0GQR99l3r1pUOdHBOYmmmP4TqRcl9SsA7lNFsbHTHzLnk7STjo6SSCsPQuUgBWcjfxh1J7k3Zu8nhzG71lJTW2bgYQ1vqd1OTytDtynXTm3Nvl/ncrc6GLUGnoJSl6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626421; c=relaxed/simple;
	bh=CDLUtdg1++IYB5is5xWT44UO8ZbSBYCtHUBusnyX+74=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TGKGP10mgfOlV/V/UphdPN090gM6Lo+EpQVctV4EAJncSobug+Ymju6+703BMe2a0lJxtbaRabJ/PDsSVNxcaYxEktH8lGvLVyUjVrBw4IUGIqA4p2nbr/zh3lBwgSsuVdGaI3IUoTpImpRuetzC9ZX24IqAZ0P+ERBDSRKxzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kDptxoNx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kDptxoNx"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea5ca8dbd37so3495909276.2
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758626416; x=1759231216; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOcnwNe6KzOBfJ3ggl8ff5csjmkNzU4hGeAOXIjD1SQ=;
        b=kDptxoNxdB/CO0J4IUBD3p6TzcVgW45gxjYqpDfz58qV2rp54/gRSM/8j499LY5y6h
         nl2IPC2+J8ncHCjdAlJarsH44hziSZA8uL6bqEZSTfmsTMJF+MmqDHKVgxTaZ02Qyssb
         cjO6VgjSXQW7p5xwZ/s9KkNQEbuWAkdBc6FOo/4L17H1AYahXIyxpRqUmQOVG9DWFv4/
         zTy9r7/SGI3rFG0JFfIQAYgjankwE1mJCG1oWWmIRNgKfI0VploxxbFpeK+kO9yOK0Rw
         6SWXHFxCRckk5tALd8n/2GA2OmGkAwgpUT41+nLVhTzSMCWzMTJbXSbLVagHRltwP/ua
         9YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626416; x=1759231216;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mOcnwNe6KzOBfJ3ggl8ff5csjmkNzU4hGeAOXIjD1SQ=;
        b=nJ+sTTs2jeMgIEq0f66711HzkNjjOQGmDI5hjycYY/cc0MaJOekECvKo623ljEacQt
         CZ0Hp+pySTu/UQIPobzEBWC3nU/KKEodjBpWJl5jsojkBpFm3sBwLGUj5fxABqywlAMh
         IwSQ00XOoelHjbYestdW/bdmiuxa9eaxJIK0AmLgIk50Pxp6+56xY9xaFgVQe9h+Zi2+
         d7fDVWblxQa46EBtzw6oLoDFM6HPGSh9CLVxm3d/LsxFP2g8acVDFgsJSIkVg5KBE0j2
         1AVzz8m41azsFmYJnytevQ7nCq15TEwMX3vBXGEP98dL+/iFoe/r2kuKBG3iYJ1vru4s
         9yZg==
X-Gm-Message-State: AOJu0Yzo8Szm11GXAj73dxeeQjju+kZCl809z5bToYOpu/qGXtTu89Ol
	NS2zLg4msZpeBbnno2M8zyoCZ8EpcId3SJYzhHb7Ry+I2qkDVHqW3U8AkzCtiULhr5OFLswGr+N
	H/5vqOiw=
X-Gm-Gg: ASbGncttkj2/9ZxQLUeYq7UN/81GMuz16v6OaJ/guaRywx9dc0XVUGxYNUS0HMqt19S
	Or2rFtSFPKmfBVnY6ln119kADW3+LL3XiOq3DpKiAlF9Xce0UknNTO3nXUyuJykp46RBKplNiPx
	Q1KctBHV9z6PfmPjP1M9ku4EkA9xviZ2lKCIu+o/G4rKh6fWo0LH72rMGw/B6x7o4a5Ci/uQHnX
	Q/OCA0DvFR7decZHFPIMUAKMT9wgMXHYMSPNnfol9wQHPXqShG0xXFlrdsSmmzWeKuGZSLlwULs
	qnjqaOh2GUdRQvFCrBAd0FYphhBDy7/9nvmXFI/BGPtp7suvjRO+U4Y/MoUmSaWrLNGOqwSX3FM
	19WzhjJiYQ+y4hEkpWiC9Zqdtsp/lP4sdHjNkCwy5eU87t+noI6EVQY/TV/BYF9Lz/z8ka6+hax
	LM
X-Google-Smtp-Source: AGHT+IEwf7oTyQoyneaX8qG4OfnoaUbbna7rF1nDXdsPzrZjGVBgPs9Hsyp5zyyJAmPeZA+tPNuuOw==
X-Received: by 2002:a05:6902:6d14:b0:e9d:75c1:7584 with SMTP id 3f1490d57ef6-eb32de6bc43mr1348182276.15.1758626416433;
        Tue, 23 Sep 2025 04:20:16 -0700 (PDT)
Received: from ?IPV6:2600:380:527c:43cf:9b4f:680a:1ae0:9de3? ([2600:380:527c:43cf:9b4f:680a:1ae0:9de3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce7275ddsm4960655276.8.2025.09.23.04.20.15
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 04:20:15 -0700 (PDT)
Message-ID: <4d23b2b2-c723-461f-94a8-a90c60982bcc@kernel.dk>
Date: Tue, 23 Sep 2025 05:20:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] MAINTAINERS: update io_uring and block tree git trees
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Move to using the git.kernel.org trees as the canonical trees for both
the block and io_uring tree.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index b47daf498a97..60d29ff64a55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6224,7 +6224,7 @@ M:	Josef Bacik <josef@toxicpanda.com>
 M:	Jens Axboe <axboe@kernel.dk>
 L:	cgroups@vger.kernel.org
 L:	linux-block@vger.kernel.org
-T:	git git://git.kernel.dk/linux-block
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
 F:	Documentation/admin-guide/cgroup-v1/blkio-controller.rst
 F:	block/bfq-cgroup.c
 F:	block/blk-cgroup.c
@@ -12860,8 +12860,8 @@ IO_URING
 M:	Jens Axboe <axboe@kernel.dk>
 L:	io-uring@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.dk/linux-block
-T:	git git://git.kernel.dk/liburing
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/liburing.git
 F:	include/linux/io_uring/
 F:	include/linux/io_uring.h
 F:	include/linux/io_uring_types.h

-- 
Jens Axboe


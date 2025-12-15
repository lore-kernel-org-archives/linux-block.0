Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753F270ED7
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770273; cv=none; b=bxTFjOg5cBRY7aUlcSw/ltPDLHYWmM04LhKbK2YOU5bJYigAY+UZ4Gc4JcoQOe7qkTjTGEu8Sfk5gtN9zjlv8Rt7juM729NQZyzFvkqHb9BPxd4nRrlVEBiLJDVwnbb/D2gz1frGeENSGcIRb6cWouVzA20SS+qgtEKkzCm9Exc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770273; c=relaxed/simple;
	bh=yfnOLKJF3bDUZS3NzhyjG4miJQUxfoEJkn0wrbpkfdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMppZ/3BXeQ5uJsTLhxE7APPC+wggTGk9fAIEb7CVneK+f1UK0IibZCjnL9HsuMbf2tZ77Yw9wa9pRCsc3nXlvS2g6FPjjPiQ+jM9VWHqVer+yfhbjRtF7PAC6ozFXtuiWhS5ObKGN2XTay8DwtpdrS/BsGv7gAXSCyz2qNqpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpSyZySp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpSyZySp"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc0d7255434so1907157a12.0
        for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 19:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765770269; x=1766375069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57GeelsZDMHG/yu8fM79YFz+luZM294/w5AcyTPupag=;
        b=WpSyZySpInGmCviDGX/5QbSUzYoHhHqdfq+FavclnTk7cGuSEL7BT12O50EPA2O1VQ
         j8MVJ1WWvKnlQS6uxfEgVHCbYWM2OWrtVJgay+Okh3h2nCpG+CIYWlrMrI4/j/alC0Zv
         PyUmknKYENP33vjtTXqadTAM5nMMIeXdXSrAHC4EnIFNEA7ILkfgKEMcT9mGNMItrgeD
         aHMqIl1s/w7nWwTvIF5N97UdZGb1QxksJHqRnmKAmCL2HCKug3I90fufKwfuGLSadl4S
         p5u2i87kzDk9AnD+xeIbMurWFHSuJatdBXYV5uHPdkBK19UlzldybU1MNfj/WRfMV8Ew
         yhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765770269; x=1766375069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57GeelsZDMHG/yu8fM79YFz+luZM294/w5AcyTPupag=;
        b=eKJlj4Or1BZKlVzVQ52SSJUm6E7SFGx4l0GE21FRTYVNOtt2wS125Wago0IoCHqDdQ
         cUmio4f36byTBjpiWTJRRJprLXSUB0nceAR+ltJvMYQmC5VSjwnWZ4KUpuSEss2M/wCv
         li2yyQfmtDVnDNGxgi0EleMz777zTRA/zLEhpVhq6AdtBh3mjLvN6E5j2sLAQPjtcsyy
         i6Cw3cvyALa/DwLllZDeu3MRgPpnLtnKSNkhNrAWfu1nCuKcRYbckyrDvFimFVXvETOT
         C3e7UEKHWTAnRf7s7gm/2w2wkels13eFyGpKsFeGVbR8G1Nf24+RwzNSatDaDMZcVAe7
         NYpA==
X-Forwarded-Encrypted: i=1; AJvYcCUcvUvNaA79ZgC5vcq5STseyH6GvS4zO1cwaug/luUtaoB5tixiwnXGsYy1SfzDLBcgf05KhoQ4Z2gECg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Raqlcq6f1RMq3rQKgdOCR2/lu3E7O3V4u+E0geoSR+hDDz9z
	m2NXSSPj3UfQq3xXgESwV6Cjp5dqI3TgaWVVtdKjWYNQ4GQpVEYPOctC
X-Gm-Gg: AY/fxX7UPwWpB5sypXD6k3uKpOAJcMDE4DILouRGtZB3K6IcWscaOwXVbYTtwXEDfEB
	fhuS645/pBPpP4si+MA+1S7XzSLsmL0WVH/KSYRpjOps3Ud+TkI7TmKJbdtDlfD9WS1qk7S0Smj
	Qwmo9amLRRdXIJybYNF1p6Bgcqhd6v36KVqdOpcI6W/wZY/H8n+q7zHM3vhmvDFpN1SlamK8IFd
	8umiFEb49ivrB3G8Ww0PjzL4dxp6a+q0tx13RYA2Vlwk2okYbf0iYhI4R9ua3vbRVqycIGuthEQ
	CHj5GvZanC5Cj9rrSijQtHlf3Qim2du4NjFCb0U13WTOqRCt+ycc08CCkxCwGQ2VQyKPxvh4DaK
	1EFrI6fYk5qk6q7hg+oT/mnkLI2cAJBjhS4nA1TahH6i/5LrkCaEJUxOrbDBYc2RkW4kHHFBWY2
	D0FwURhtQAAUTb70gf65SDWwD6pCYEM6WxWjBvzUiOr0jGuKNwn+mo4y7MUiwhF4Ev
X-Google-Smtp-Source: AGHT+IHtX257iwl90uElpBrUJZRVMjG2XPgwkYlJRTHebfpWp69rDMIJUAS9W36qS9uR/lfZo5dQsA==
X-Received: by 2002:a05:701b:2612:b0:11b:9386:a38c with SMTP id a92af1059eb24-11f34c71819mr4989481c88.47.1765770268909;
        Sun, 14 Dec 2025 19:44:28 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:a625:a605:cb9a:d5e1? ([2600:8802:b00:9ce0:a625:a605:cb9a:d5e1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb45csm42007893c88.1.2025.12.14.19.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 19:44:28 -0800 (PST)
Message-ID: <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com>
Date: Sun, 14 Dec 2025 19:44:27 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>, Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/25 07:40, Yi Zhang wrote:
> Hi
> The following kmemleak was observed during blktests nvme/fc, please
> help check it and let me know if you need any info/test for it,
> thanks.
>
> commit d678712ead7318d5650158aa00113f63ccd4e210
> Merge: 95ed689e9f30 a0750fae73c5
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Dec 10 13:41:17 2025 -0700
>
>      Merge branch 'block-6.19' into for-next
>
>      * block-6.19:
>        blk-mq-dma: always initialize dma state
>
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff88826cab51c0 (size 2488):
>    comm "nvme", pid 84134, jiffies 4304631753
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      60 1a be c1 ff ff ff ff c0 2b 05 73 77 60 00 00  `........+.sw`..
>    backtrace (crc 155ec6c5):
>      kmem_cache_alloc_node_noprof+0x5e4/0x830
>      blk_alloc_queue+0x30/0x700
>      blk_mq_alloc_queue+0x14b/0x230
>      nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
>      0xffffffffc11de07f
>      0xffffffffc11dfc28
>      nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
>      nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
>      vfs_write+0x1d0/0xfd0
>      ksys_write+0xf9/0x1d0
>      do_syscall_64+0x95/0x520
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e


Can you try following ? FYI : - Potential fix, only compile tested.

 From b3c2e350ae741b18c04abe489dcf9d325537c01c Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date: Sun, 14 Dec 2025 19:29:24 -0800
Subject: [PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset if init fails

nvme_fabrics creates an NVMe/FC controller in following path:

     nvmf_dev_write()
       -> nvmf_create_ctrl()
         -> nvme_fc_create_ctrl()
           -> nvme_fc_init_ctrl()

Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
nvme_remove_admin_tag_set() to release the resources.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
  drivers/nvme/host/fc.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index bc455fa98246..6948de3f438a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3587,6 +3587,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
  
  	ctrl->ctrl.opts = NULL;
  
+	if (ctrl->ctrl.admin_tagset)
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
  	/* initiate nvme ctrl ref counting teardown */
  	nvme_uninit_ctrl(&ctrl->ctrl);
  
-- 
2.40.0

-ck



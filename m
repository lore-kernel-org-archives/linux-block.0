Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD852FA0F3
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345229; cv=none; b=V5Wh3PpfkjRJNjtNo2IaYwD62tVPtzq7ic7kbPNj5F0dd4iYtnzy3cEnCqPqoFYKzdMp8TyURvYicpoTczgkWGuMocPQWqehX/t6Ce4uRdegHgR06eU4EG850V/uiZIy4WMcQlCzANE4kuhVaD8sCp2t28mmJ7KXO/bnNGzRAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345229; c=relaxed/simple;
	bh=6le6OQ8epL+jMQ5N4bnB/5a2+J6M0RilzV7rzr9sKXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDauBnFbPgg4A0LpKxMK5LjAti7kC5FLcuYrrX8WMmMk59y7i9hIv/apCbNZCbvK9dWfhJq7Fkus0xxX6PSETDFG739wF08S7WzlK/fImMu2mYV89hsUE9edh9qaO47I9ckDwNMRALA5hbbw2yyI4vB6ww3++rPwp47k5hDzl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZQp3ta/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZQp3ta/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-791c287c10dso3396092b3a.1
        for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345224; x=1760950024; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ly+HQRkobfn8QZ0F7iorzNkMZ8hHSqdbvWQJzpHPzWg=;
        b=mZQp3ta/w+jpSTGgaPSYSj4A2YLyC5b7HH2THkgk9Vs2T6szxs33EBMXwT8eTCpjkk
         b9WRfQi6eQhdkJihDqHkz05ASZisiJlnplUkHqWk4yEQ7UqGCSofORFdPIbyV7YDFmGN
         nkBGlJEE5DJYb/H5JD3xuFBFzejqKZLvSt2SulQwShs4zIXqxqil68F0nLGCKV5l7mqr
         /N42SEB0bO+CTDSq3hLY1zqV/bUCLvZE8tbY2t58FO0NvMXCpFUoMd8bppeFjKStOVJ6
         i3VUfcbJcbylDIH5E4lxqLkc+Vhiza4MspoHBMfEgN9pJSBo0pFc91pl+QznWxaTZAGW
         jiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345224; x=1760950024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly+HQRkobfn8QZ0F7iorzNkMZ8hHSqdbvWQJzpHPzWg=;
        b=o55BWB3X8ACul6ywXePPRzaSiMXn4rM7EkSvBiLnU9gk4qXMKCFYLs2W9UquqPaNzQ
         YcmGpCJ2tmKMd8XLUNlyP3D8DN+0KjEQc4YOf6lkpj4YoUvpJjFK7OKyYa3wufW+5dot
         prn/qo6aK9kYgnOrpFsyVHjqQ+W+608tRZ7e68JMaXxUe/O60Eyea2HlTKwKlmjGmGhz
         9ut+HmKNqxK8hO4KkibK2MnCvCbi9/HBlzAnXHUVjGYgHu0NR1o7mL+ypICxCD+kIjZS
         yTgphc5vtNDzaKRvKyffMI267MwyjT7o+fINBveY3ix7F5MEYc5yzUKF257sTuoHiC30
         oZuw==
X-Forwarded-Encrypted: i=1; AJvYcCWzuDc7ZPhNNIRQ05xPkM9drbWBwx/yhLw22jD44FAEqT8DOMHkXMcNLl62QETfZRc14fafB0LT6JX9Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9MxxbwhrspsOOh/QrcjV0i1dJ6hc2b9UPW8OA6asNBr8WHpiL
	/pYzJYMU1tmxzPaUJB88wXFl9AtKzI6aTNlwBB8eK+VfjzXw2WrOj5yt
X-Gm-Gg: ASbGncsIzLyvQ812ZOsKIr2iEHcSDILm4yA7GhNX1H60MiKtBI4c3uM2jpcCqESqcoG
	PkDpsOD0TKJiKqlbARBfzeokUhe1VjLlZgKMDJ/nUYoco81xWVTzCPhlgL0QLk2S6VRBtrgzpCP
	0/Gwkn8nedy9JOlQ1flhI+t2ACMgR6EZp+EtjBxQSBbAElWZGGdua6EcviHlAmcbRKs1fnDMFdo
	BXuS0xrLbOw+R6e4QpHe0q+aR2c8Mk2/WgGNYqHsBIMz9scL7AqVt0wunu0TH7F+fiapN0hpLa5
	iYRmBMg9LpQ92dsBOsptIMpgFdWq8AcZqZEYIBHw5BohSj9bZAZ+TehAuRNjjRYWVnx9L1zSMJ1
	Hj6d3/CIt9kUpR6DviMWg3+shr8jdFegerZ8oGnfhJNybQzvCwlg=
X-Google-Smtp-Source: AGHT+IF7w1EIeSODUr5AIUsDNw48vbrBIgBhYBiRRyhl8w2rgyXTNwbHm6KkbxbA5Bn+oLw+XAdTJw==
X-Received: by 2002:a17:902:e550:b0:25f:fe5f:c927 with SMTP id d9443c01a7336-290272c0a06mr273302795ad.31.1760345224148;
        Mon, 13 Oct 2025 01:47:04 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034de9febsm127921165ad.7.2025.10.13.01.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:47:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:46:18 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Genes Lists <lists@sapience.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Subject: Re: mainline boot fail nvme/block? [BISECTED]
Message-ID: <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
 <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>

On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > Mainline fails to boot - 6.17.1 works fine.
> > > Same kernel on an older laptop without any nvme works just fine.
> > > 
> > > It seems to get stuck enumerating disks within the initramfs
> > > created by
> > > dracut.
> > > 
> > > ,,,
> > > 
> > > Machine is dell xps 9320 laptop (firmware 2.23.0) with nvme
> > > partitioned:
> > > 
> > >     # lsblk -f
> > >     NAME        FSTYPE      FSVER LABEL FSAVAIL FSUSE%
> > > MOUNTPOINTS    
> > >     sr0
> > >     nvme0n1
> > >     ├─nvme0n1p1 vfat        FAT32 ESP   2.6G    12% /boot
> > >     ├─nvme0n1p2 ext4        1.0   root  77.7G    42% / 
> > >     └─nvme0n1p3 crypto_LUKS 2                          
> > >       └─home    btrfs             home  1.3T    26% /opt
> > >                                                    
> > > /home             
> > > 
> > > 
> > > 
> > > Will try do bisect over the weekend.
> > 
> > That'd be great, because there's really not much to glean from this
> > bug
> > report.
> 
> Bisect landed here. (cc linux-pci@vger.kernel.org)
> Hopefully it is helpful, even though I don't see MSI in lspci output
> (which is provided below).
> 
> gene
> 
> 
> 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> Author: Inochi Amaoto <inochiama@gmail.com>
> Date:   Thu Aug 14 07:28:32 2025 +0800
> 
>     PCI/MSI: Add startup/shutdown for per device domains
> 
>     As the RISC-V PLIC cannot apply affinity settings without invoking
>     irq_enable(), it will make the interrupt unavailble when used as an
>     underlying interrupt chip for the MSI controller.
> 
>     Implement the irq_startup() and irq_shutdown() callbacks for the
> PCI MSI
>     and MSI-X templates.
> 
>     For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the parent
> startup
>     and shutdown functions are invoked. That allows the interrupt on
> the parent
>     chip to be enabled if the interrupt has not been enabled during
>     allocation. This is necessary for MSI controllers which use PLIC as
>     underlying parent interrupt chip.
> 
>     Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
>     Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>     Link: https://lore.kernel.org/all/20250813232835.43458-3-
> inochiama@gmail.com
> 
>  drivers/pci/msi/irqdomain.c | 52
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h         |  2 ++
>  2 files changed, 54 insertions(+)
> 
> 
> ----------------------------------------- lspci output ----------------
> In case helpful here's lspci output:
> 
> 0000:00:00.0 Host bridge: Intel Corporation Raptor Lake-P/U 4p+8e cores
> Host Bridge/DRAM Controller
> 0000:00:02.0 VGA compatible controller: Intel Corporation Raptor Lake-P
> [Iris Xe Graphics] (rev 04)
> 0000:00:04.0 Signal processing controller: Intel Corporation Raptor
> Lake Dynamic Platform and Thermal Framework Processor Participant
> 0000:00:05.0 Multimedia controller: Intel Corporation Raptor Lake IPU
> 0000:00:06.0 System peripheral: Intel Corporation RST VMD Managed
> Controller
> 0000:00:07.0 PCI bridge: Intel Corporation Raptor Lake-P Thunderbolt 4
> PCI Express Root Port #0
> 0000:00:07.2 PCI bridge: Intel Corporation Raptor Lake-P Thunderbolt 4
> PCI Express Root Port #2
> 0000:00:08.0 System peripheral: Intel Corporation GNA Scoring
> Accelerator module
> 0000:00:0a.0 Signal processing controller: Intel Corporation Raptor
> Lake Crashlog and Telemetry (rev 01)
> 0000:00:0d.0 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 USB Controller
> 0000:00:0d.2 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 NHI #0
> 0000:00:0d.3 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 NHI #1
> 0000:00:0e.0 RAID bus controller: Intel Corporation Volume Management
> Device NVMe RAID Controller Intel Corporation
> 0000:00:12.0 Serial controller: Intel Corporation Alder Lake-P
> Integrated Sensor Hub (rev 01)
> 0000:00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2
> xHCI Host Controller (rev 01)
> 0000:00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM
> (rev 01)
> 0000:00:14.3 Network controller: Intel Corporation Raptor Lake PCH CNVi
> WiFi (rev 01)
> 0000:00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH
> Serial IO I2C Controller #0 (rev 01)
> 0000:00:15.1 Serial bus controller: Intel Corporation Alder Lake PCH
> Serial IO I2C Controller #1 (rev 01)
> 0000:00:16.0 Communication controller: Intel Corporation Alder Lake PCH
> HECI Controller (rev 01)
> 0000:00:1e.0 Communication controller: Intel Corporation Alder Lake PCH
> UART #0 (rev 01)
> 0000:00:1e.3 Serial bus controller: Intel Corporation Alder Lake SPI
> Controller (rev 01)
> 0000:00:1f.0 ISA bridge: Intel Corporation Raptor Lake LPC/eSPI
> Controller (rev 01)
> 0000:00:1f.3 Multimedia audio controller: Intel Corporation Raptor
> Lake-P/U/H cAVS (rev 01)
> 0000:00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host
> Controller (rev 01)
> 0000:00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH
> SPI Controller (rev 01)
> 0000:01:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:01.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:02.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:03.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:04.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 10000:e0:06.0 PCI bridge: Intel Corporation Raptor Lake PCIe 4.0
> Graphics Port
> 10000:e1:00.0 Non-Volatile memory controller: SK hynix Platinum
> P41/PC801 NVMe Solid State Drive
> 
> 
> -- 
> Gene

I think this is caused by VMD device, which I have a temporary solution
here [1]. Since I have no idea about how VMD works, I hope if anyone
can help to convert this as an formal fix.

[1] https://lore.kernel.org/all/qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzogihz5oplw@gsvgn75lib6t/

Regards,
Inochi

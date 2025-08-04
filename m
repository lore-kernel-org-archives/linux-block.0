Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE91FDE31
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319448; cv=none; b=i5HbXUBytLwEN8G93jfZh2TLFgL/xuD1oFRnzIMnbT6lgJr0TTILFyN0qBpjfRDcabcxYoZkndUT29BfyOLdHOCBjk/cMMuviDmQOtNknWUY9TUfBRQu21LinbIlFALzuohQd8HWwwsI2QJeJgwsyhyqWs/hGBuEWENOeVy0e/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319448; c=relaxed/simple;
	bh=WD4rPRrF9PNETZvw9dGZ2NYXOpiDKFQZnlh6gwFiUeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0GAPpJCqZhY88DVk8Ihi0WRCjTyqnnD+ZTP0y4ma8wuBtknpcllFo8REJI8H4i19linmRTtts/MuLDXSiBKkBEj1ty3FbLowDpipGNrzO+XM3TV7hLfWqxd4/L4P5l4qmkBqzjLnlTnjvWvJe3rv3MZ2vjnCsVfjVFEx1CFIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHXyK8C+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHXyK8C+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78a034f17so2982070f8f.2
        for <linux-block@vger.kernel.org>; Mon, 04 Aug 2025 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754319444; x=1754924244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWy/dRkuyqHtMLkzo0aj79tMC2PsGztysX7VOS/VH8M=;
        b=LHXyK8C+1+U0hse2yDWbWctLwLZ3pFcnCm0sm/u+knMk/9iloowz/yc81nuRwjxzCV
         HPffa5w3KcTKmjj0xRRXZZtXTpnWdQfJvnPknp3/1NW1epvPvoEi+Nm2FSWTkzcE1b/o
         CThJ/UL50afopXd10ZW/zLIRvbYhw1RTj4tVgDgIhw7DLnaGH4+Awgsxk007oZMlgbo6
         amIOkrZMPBTVrAP0dYuqnccs1tvvSmIL7Xoc6FGmOD6H4P/tmG0KYJAUHoE9k5rZPSe/
         NHq0RPYvbT869V+NiG358b07+vi+lWC0WV6ZLuhLtARk20Y2ySfugsj+LZsP7wFehhDh
         LSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319444; x=1754924244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWy/dRkuyqHtMLkzo0aj79tMC2PsGztysX7VOS/VH8M=;
        b=Jd5Y3YvJgZH4DtrFbU4r330Arxu3NjKK9mzS3li1nJ0GakufNQJppMGHlCTmqt7ud9
         t9ZEo4DhFQ+PQxxeN6ItlpCNmJMHaukH7BCZXcoqSmwdF9rl2olGs9ULw2Ara+qc3R0D
         4qJ7dFBq0H4iyNp4/Htg5e6LxrGznmsmSe/eyUuqJfQrjY9fyD89MRKJ+wy+6t3G2YJy
         tjQikAInCWrlER7ujjofZJyVBRfhdwqMY0LFtLtEplwbhDLDrWzer5S+ZE1GYJeF9Kqj
         n/hmn8yytFz2phPPXXNerGyZHXiLEFiuGoWJjjdQ1LuiebrhCy12VhbkB6lIxL1b1Yn3
         6lLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbQ2Pu9GI6TN/pJJgCBixSsdWL3i7jZioaLpplRPEfrtnfN9Z0E8IHu708gAIrx9k6GEO29/20JcN9iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymO8RS0E609POsQNJJwdnaleQ01AzhLWDbhNIS901KybJJNH+1
	CCiSMAJ2PFKBnOX7sogdapjEcYXxgfrouxEZVHq1aUOYUqMEGKfDRIxGqXDfYqUQtmsh7l2zsBa
	DQ2On
X-Gm-Gg: ASbGncsKASAGQoDRmyEMSx4tfTVd4wKeQADa/sK2O4bOetpS4ZqWaVeBhToERTC2Gaj
	bu+p2JdUJmwXcPGLqsYq3BfJaWweyRBW2LMNPDmAztt2xf9fVvqMT0bcJSvr6qYvomSFD3RC0rB
	bwidP+q3WSPpmFTNYqoNNDfBLofC4LaCnEtGt5wZci8QluzMbGuS+/kFWtw6gs8q0+T2nBValuI
	mWL8qUfsLKeampeTp3CCzSqPPZiOQRp/wK9rjtPY8XcZ9bRK/v2ayNMb4h0+qwBHeLg13UcYA+m
	wxriHaWaEHvptEpTKygD2n7CMui0oIib+DSwtiRGHPikgdPggEt3D2UCyewxVp6D05y05Ipiyj0
	7O020Wqy1Vs8WEqM/RhhTK4SYXpY=
X-Google-Smtp-Source: AGHT+IFBSQjd7GrN3vHaieQbp8tLemMW2ODmKLpx7Wr7bNzMiCgZpwNOOH29qiMwqvVsg4rJZoLGEA==
X-Received: by 2002:a05:6000:22c2:b0:3b7:9141:f044 with SMTP id ffacd0b85a97d-3b8d947507bmr7576626f8f.21.1754319444497;
        Mon, 04 Aug 2025 07:57:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c470102sm15695200f8f.53.2025.08.04.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:57:23 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:57:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-nfs@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, linux-mm <linux-mm@kvack.org>,
	Netdev <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250717: arm64: rk3399-rock-pi-4b: NFS mount failure with
 64K page size
Message-ID: <54178266-64e5-4869-8359-26f1c8cd14bc@suswa.mountain>
References: <CA+G9fYupPsQoBrtF=-WT0nSy6m+yG1p9m68Z18Bp-Y=QMFD_tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYupPsQoBrtF=-WT0nSy6m+yG1p9m68Z18Bp-Y=QMFD_tQ@mail.gmail.com>

This is an ongoing issue still in the latest linux-next.  It's
quite a strange bug because why would it only affect rk3399-rock-pi-4b?

The only thing I see which touched fs/nfs between next-20250716 and
next-20250717 is commit e9d8e2bf2320 ("fs: change write_begin/write_end
interface to take struct kiocb *").  That patch is pretty straight
forward and wouldn't have caused something like this.  Let me add
linux-block to the CC list as well to see if they have any ideas.

regards,
dan carpenter

On Tue, Jul 22, 2025 at 07:59:11PM +0530, Naresh Kamboju wrote:
> The rk3399-rock-pi-4b device fails to mount the root filesystem over
> NFS when the kernel is built with 64K page size.
> CONFIG_ARM64_64K_PAGES=y
> 
> This regression was first observed with the Linux next-20250717 tag
> and continues to persist through next-20250722.
> 
> Device: rk3399-rock-pi-4b
> Build Configuration: lkftconfig-64k_page_size
> 
> Regression Window:
> 
>  Good: next-20250716
>  Bad: next-20250717.. Still Bad: next-20250722
> 
> Kernel Config Impact:
> CONFIG_ARM64_64K_PAGES=y  - NFS mount fails
> CONFIG_ARM64_4K_PAGES=y  - NFS mount works as expected
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
> 
> Boot regression:  next-20250717 arm64 rk3399-rock-pi-4b NFS mount
> failure with 64K page size
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Boot log
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 6.16.0-rc6-next-20250717
> (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-16) 13.3.0,
> GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT @1752747461
> [    0.000000] KASLR disabled due to lack of seed
> [    0.000000] Machine model: Radxa ROCK Pi 4B
> [    0.000000] efi: UEFI not found.
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000ff1a0000 (options
> '1500000n8')
> [    0.000000] printk: legacy bootconsole [uart0] enabled
> [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory
> node in the DT
> [    0.000000] NUMA: Faking a node at [mem
> 0x0000000000200000-0x00000000f7ffffff]
> 
> <trim>
> 
> [    6.520442] Sending DHCP requests ..
> [   13.295867] platform sdio-pwrseq: deferred probe pending:
> pwrseq_simple: reset control not ready
> [   13.295887] dwmmc_rockchip fe310000.mmc: IDMAC supports 32-bit address mode.
> [   13.296260] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to fe310000.mmc
> [   13.296278] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff650000.video-codec
> [   13.297085] dwmmc_rockchip fe310000.mmc: Using internal DMA controller.
> [   13.297660] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff660000.video-codec
> [   13.298653] dwmmc_rockchip fe310000.mmc: Version ID is 270a
> [   13.299536] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff680000.rga
> [   13.300164] dwmmc_rockchip fe310000.mmc: DW MMC controller at irq
> 49,32 bit host data width,256 deep fifo
> [   13.301117] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff880000.i2s
> [   13.304227] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff8a0000.i2s
> [   13.305148] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff8f0000.vop
> [   13.306071] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff900000.vop
> [   13.307009] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff940000.hdmi
> [   13.307937] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff9a0000.gpu
> [   14.620509] ., OK
> [   14.636949] IP-Config: Got DHCP answer from 10.66.16.15, my address
> is 10.66.30.7
> [   14.637647] IP-Config: Complete:
> [   14.637955]      device=eth0, hwaddr=0a:fb:82:cd:ed:a8,
> ipaddr=10.66.30.7, mask=255.255.240.0, gw=10.66.16.1
> [   14.638845]      host=10.66.30.7, domain=lkftlab, nis-domain=(none)
> [   14.639417]      bootserver=0.0.0.0, rootserver=10.66.16.116, rootpath=
> [   14.639440]      nameserver0=10.66.16.15
> [   14.641679] clk: Disabling unused clocks
> [   14.646347] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
> [   14.647091] check access for rdinit=/init failed: -2, ignoring
> [   14.762496] VFS: Mounted root (nfs filesystem) on device 0:22.
> [   14.763768] devtmpfs: mounted
> [   14.775761] Freeing unused kernel memory: 4928K
> [   14.776566] Run /sbin/init as init process
> [   95.816464] random: crng init done
> [  195.556677] nfs: server 10.66.16.116 not responding, still trying
> ..
> [  195.556703] nfs: server 10.66.16.116 not responding, still trying
> [  195.556869] nfs: server 10.66.16.116 not responding, still trying
> [  195.557010] nfs: server 10.66.16.116 not responding, still trying
> [  195.557055] nfs: server 10.66.16.116 not responding, still trying
> [  195.557114] nfs: server 10.66.16.116 not responding, still trying
> [  195.557166] nfs: server 10.66.16.116 not responding, still trying
> [  195.557217] nfs: server 10.66.16.116 not responding, still trying
> [  195.557269] nfs: server 10.66.16.116 not responding, still trying
> [  195.557304] nfs: server 10.66.16.116 not responding, still trying
> [  227.459759] nfs: server 10.66.16.116 OK
> [  227.459868] nfs: server 10.66.16.116 OK
> [  227.681008] nfs: server 10.66.16.116 OK
> [  319.645474] nfs: server 10.66.16.116 OK
> [  407.677657] nfs: server 10.66.16.116 OK
> [  499.834818] nfs: server 10.66.16.116 OK
> [  587.895692] nfs: server 10.66.16.116 OK
> [  680.052774] nfs: server 10.66.16.116 OK
> [  768.113810] nfs: server 10.66.16.116 OK
> [  860.270785] nfs: server 10.66.16.116 OK
> #
> [  948.331418] nfs: server 10.66.16.116 OK
> #
> [ 1096.679211] nfs: server 10.66.16.116 OK
> #
> [ 1274.856436] nfs: server 10.66.16.116 OK
> #
> [ 1488.985700] nfs: server 10.66.16.116 OK
> 
> 
> ## Source
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250717/
> * Git sha: 024e09e444bd2b06aee9d1f3fe7b313c7a2df1bb
> * Git describe: 6.16.0-rc6-next-20250717
> * kernel version: next-20250717
> * Architectures: arm64 (rock-pi-4b)
> * Toolchains: gcc-13
> * Kconfigs: defconfig+64K page size
> 
> ## Test
> * Test log: https://qa-reports.linaro.org/api/testruns/29168904/log_file/
> * Test LAVA: https://lkft.validation.linaro.org/scheduler/job/8364278#L924
> * Test run: https://regressions.linaro.org/lkft/linux-next-master/next-20250717/testruns/1662101/
> * Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2zzwHDuV3xvZBKkAtqlmroSxuIS
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zzwEbz0aS3AtluE2oRQ9gMvFTY/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2zzwEbz0aS3AtluE2oRQ9gMvFTY/config
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

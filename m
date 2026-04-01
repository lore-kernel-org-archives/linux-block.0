Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD6392C48
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076923; cv=none; b=SVtAC7gG0P7iSchkbyayMpLh28/1Bgr9Xz2Prw6E/sFy3KzWoZ2QQ7flqE9qs2OFBpuXpnGRHJZmREjxXI5gF+qbLm5So+jcvM1J8ItD6x8BXHKGU5cf10Q4dtFScbCm5RvJE2qQ3HDTeZRnIAfmHJyGBTwz6ye0KP17sWWnFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076923; c=relaxed/simple;
	bh=OKVgG852q3ujQZEUo1nRtMJit5jhHS8BtGKv51/s1mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6H1Pn5jL1336lHq0KydXP+W/yTx24yw8EplJZhYm82bSL+s/LSfLNZIgepYLJdn2vbFcfdNHwllOssyFFAeeAl4B216SkaKQf039iGImfrzqafZL1sfwrv6TsSt/UgSzblWWCK7veB3m3pYXxwPSWys4Rss8lFOvgG0o4JVfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq9gfJn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq9gfJn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAF3C4CEF7;
	Wed,  1 Apr 2026 20:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775076923;
	bh=OKVgG852q3ujQZEUo1nRtMJit5jhHS8BtGKv51/s1mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rq9gfJn95DY57dXauMjvKr9PQB1BEUtnrSk+qcLWqJXN4HFdg6gHloC5x1wbf/poH
	 XO1vuBGaNN29XNSIc2SfIEcMTQV7ClLjSK3VuraVd3/QQYcbxFweEpD2jMGc8voISM
	 3tb5wFiRsO/X5/EGAQJb07Q3fTDCtpGmhERHz4DrvvQM/N8P8F2lM9mj7aXIFGaE23
	 /SzsfNfFMmNclUGcDXfqybKaq3L4PZvhOa9GTC8YQ5aIOcSiMmvt3u3Xj9ZgKpBotw
	 ahe8JpkTzAgoG40/E31Oa7kdfL2tg46tcEwXiiI7U+1ensq13dbAmsFvmZ8XtqPrTI
	 +BoA58pysG6rg==
Date: Wed, 1 Apr 2026 14:55:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mira Limbeck <m.limbeck@proxmox.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	Friedrich Weber <f.weber@proxmox.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <ac2GOOLzui0U0BTJ@kbusch-mbp>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
 <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
 <ac2256a0-25ce-4453-8c47-04cb7716d46a@proxmox.com>
 <7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org>

On Thu, Apr 02, 2026 at 05:02:22AM +0900, Damien Le Moal wrote:
> On 4/1/26 19:32, Mira Limbeck wrote:
> > 
> > Apr 01 11:41:19 pve-test-hba kernel: sd 9:2:2:0: [sdc] tag#3962 page boundary curr_buff: 0x00000000f4d7cfce
> > Apr 01 11:41:19 pve-test-hba kernel: BUG: unable to handle page fault for address: ff3a241243d70000
> > Apr 01 11:41:19 pve-test-hba kernel: #PF: supervisor write access in kernel mode
> > Apr 01 11:41:19 pve-test-hba kernel: #PF: error_code(0x0002) - not-present page
> > Apr 01 11:41:19 pve-test-hba kernel: PGD 100010067 P4D 10066d067 PUD 10066e067 PMD 11f0fa067 PTE 0
> > Apr 01 11:41:19 pve-test-hba kernel: Oops: Oops: 0002 [#3] SMP NOPTI
> > Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs Tainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
> > Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=DIE, [W]=WARN, [E]=UNSIGNED_MODULE
> > Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
> > Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0x478/0x590 [mpt3sas]
> 
> There may be an issue with the mpt3sas driver with large commands.
> 
> However, I am using that driver all day long and doing lots of testing with
> gigantic read/write commands all the time. I have never seen any issues.
> The difference is that I am using the SAS-SATA FW for the Broadcom HBA, so no
> NVMe support, and my target devices are SAS or SATA HDDs, not SSDs.

It's only the NVMe attached ones that use base_make_prp_nvme, and it
looks like the ioc->pcie_sgl_dma_pool that provides the buffer for the
entries is too small for a transfer larger than 2MB. So it's overrunning
the allocated buffer.

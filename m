Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DED82D7DEF
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073746; cv=none; b=d4vwvZeeenGiI8Yupf9KKDs7j1v30Xo4mbnPvU0nBwVwrr3eFUpzhLefWAjSq55RuSDxmipl95NGPU6Ny2RQ1/HvjAetLJZ2+MjjmsEktxoFkQGk3Ye7ffjK13XqvHGHzumwxTMqrAMo4FD6nktLhcrqgM+rC3MMXKqxjieH8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073746; c=relaxed/simple;
	bh=RraedbUMjsBfljOYrKy9mlz9B6TOhLSN7UW42ZAHVfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5AaXyEzH6Fbep8zink6SXfIl84GQ1mDWQ+6Zno+LkuE1nY7lKakR9Zy3urk1i+sAPpIZa5aiXBIbabMzIxkUXxAI/wc0V1dS+5a8HTKFcq7gzQK05GTlUtfHyhVuHEuLHS/CQ5FySM6rlCfvNAkm5ixzZ2furlvo/HPoVANG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmWHw3PN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmWHw3PN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B2DC4CEF7;
	Wed,  1 Apr 2026 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775073745;
	bh=RraedbUMjsBfljOYrKy9mlz9B6TOhLSN7UW42ZAHVfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nmWHw3PNZ04QPbcsrPyo8Mkd0h3vThYd1CpyGO0Hamnd4RSlRbAyE+CRRUmdkHKfq
	 sqE4DRscHM+nJiOVNLfeqtNsS/awAcKW5K7S4QliQKIMBSoPgFwpfz4dkHm27UjE5m
	 eZJrnPUzL0pXap7EQlZO+IFC6k3XbKWPdmQTRpp6O829j0hbrCpz17prRrvFdW9mnR
	 LIkxDoD1+9bchAS3mFCRD2y4tsq4WcxYXB5/LrLY5uwPEY08WpxYoUewQCWNKWaZ1s
	 oGY815q9qQM7igQQyT+nhczOKZvN/7X3g0nTpCRbOKPG7AwHdaJK9/AnvV9a4pTX+4
	 PmbY+bJoMTD/w==
Message-ID: <7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org>
Date: Thu, 2 Apr 2026 05:02:22 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Mira Limbeck <m.limbeck@proxmox.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 martin.petersen@oracle.com, Friedrich Weber <f.weber@proxmox.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
 <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
 <ac2256a0-25ce-4453-8c47-04cb7716d46a@proxmox.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ac2256a0-25ce-4453-8c47-04cb7716d46a@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/26 19:32, Mira Limbeck wrote:
> Sorry if I wasn't clear enough, we did test the following mainline
> kernels without any downstream patches (git tags):
> v6.16 (unaffected)
> v6.17 (affected)
> v7.0-rc5 (affected)
> 
> Afterwards we started to bisect between mainline 6.16
> (038d61fd642278bab63ee8ef722c50d10ab01e8f) and mainline 6.17
> (e5f0a698b34ed76002dc5cff3804a61c80233a7a) without any downstream
> patches, which led us to this commit as the first bad one:
> 9b8b84879d4adc506b0d3944e20b28d9f3f6994b

Note: the proper way to reference a patch is to use 12-digits commit ID and
patch title:

9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")

as that make it easier to know what one is talking about without having to go
look what patch that ID references.

> Building our downstream kernel 6.17 with this commit reverted, fixed it.

Nope, this is likely not fixing anything but rather hiding the issue. With this
patch reverted, the default max_sectors_kb will be 1280, so all requests will be
chunked to that size at most, and your devices will not see large commands.
However, simply doing something like:

echo 4096 > /sys/block/<dev>/queue/max_sectors_kb

will put your system in a state that is equivalent to the patch being applied
and you will likely see the issue again. Try.

> To make sure that's also the case for the current mainline kernel, we've
> tried 7.0-rc6 today (v7.0-rc6, 7aaa8047eafd0bd628065b15757d9b48c5f9c07d,
> affected), and again with this commit reverted (unaffected).

Same comment as above.

> Here the logs from 7.0-rc6:
> 
> Apr 01 11:41:19 pve-test-hba kernel: sd 9:2:2:0: [sdc] tag#3962 page boundary curr_buff: 0x00000000f4d7cfce
> Apr 01 11:41:19 pve-test-hba kernel: BUG: unable to handle page fault for address: ff3a241243d70000
> Apr 01 11:41:19 pve-test-hba kernel: #PF: supervisor write access in kernel mode
> Apr 01 11:41:19 pve-test-hba kernel: #PF: error_code(0x0002) - not-present page
> Apr 01 11:41:19 pve-test-hba kernel: PGD 100010067 P4D 10066d067 PUD 10066e067 PMD 11f0fa067 PTE 0
> Apr 01 11:41:19 pve-test-hba kernel: Oops: Oops: 0002 [#3] SMP NOPTI
> Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs Tainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
> Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=DIE, [W]=WARN, [E]=UNSIGNED_MODULE
> Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
> Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0x478/0x590 [mpt3sas]

There may be an issue with the mpt3sas driver with large commands.

However, I am using that driver all day long and doing lots of testing with
gigantic read/write commands all the time. I have never seen any issues.
The difference is that I am using the SAS-SATA FW for the Broadcom HBA, so no
NVMe support, and my target devices are SAS or SATA HDDs, not SSDs.

Something may be wrong with the NVMe support in that HBA, or, your SSDs do not
like large commands and cause issues. That is easy to test: try connecting your
SSDs directly to PCI and test them by issuing large read/write commands with fio
(you will need to use iomem=mmaphuge option to use hugepages for the IO buffers
to ensure that you do not get the IOs chunked into small commands due to memory
fragmentation).

At least from my point of view and my tests, that commit is perfectly fine. As
mentioned above, it is only changing the default value, and that's something
that can be done manually even without this patch. So this is definitely not the
root cause and it is simply exposing a problem that already existed.
We have seen that for several devices in the ata subsystem and had to quirk many
drives that are choking on large commands.

We just need to figure out where the problem is (HBA and/or SSD) and can then
look into how to avoid that problem.

-- 
Damien Le Moal
Western Digital Research

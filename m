Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCCD31714F
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086327; cv=none; b=jPr+Z5gQySV/tIElsdLj9sl6XhU7sbAc5g7UFoGTWmH/ZnVfqkLMvs0Ri5DVnWdZL6hod5tEOkYZct4rBK6VG/f3AuU05F+A+du4YkJvWqtW/oe6cAV6m+5bOQVN3j/oH2H/7ZGsikQL5q+9kuHC9HuAReGhBUhHRLmnWIYvltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086327; c=relaxed/simple;
	bh=8Km389EKYA/nHLJ6fv7aemC2MSc1lXxEjR15aLz7mjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOS+HLsWlZyIrLDw40kfOf9o53TMfiqETPRfwZ/6RNjNEvTea8g5ypB09KVFYc8hEJKNrYhOVsBNqjT2NPAnTNiAHveDgHxp5C3U101Liiqk6HxCzd64yuINNbbJIyg90lA7BH0Uoq8bN6r1oiAB8zxM0OZeggquw8y2R5ESBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRU9QQma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRU9QQma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952BBC4CEF7;
	Wed,  1 Apr 2026 23:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775086326;
	bh=8Km389EKYA/nHLJ6fv7aemC2MSc1lXxEjR15aLz7mjY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cRU9QQmaBZ+aDB8piqTOUOIZYBJF92yEvcYQXX3ZEBOsDnWyywU/B4stxs8VkKuhH
	 kQAGyCrsOsc0AEbxtMMyBk49TlayL5w5B/aNAiCbDdA8aEU9UTMXb5P7ngl3d+O9m9
	 03EcfbDPyFjZPoZOEl6DykXwtWfx1CGxz+Avb96hKJ1MzYX/XIo+OySJObBvJiVkx2
	 nCct0BDOfTwZ9zGy1nCchF/sAggho6pVCCBjVvCdDBQGfXKPhv1T/+oGeLb7ogOH/V
	 nr5RZE87mQ405Jht/CJcIZHQg0cHNLFcV1nw3tk1VZsNmKXVvujsJCFWirW+iUbIa/
	 NQkKUpp6nzb4Q==
Message-ID: <4473917f-c8e8-4679-a762-f7518a43b1d0@kernel.org>
Date: Thu, 2 Apr 2026 08:31:58 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Keith Busch <kbusch@kernel.org>
Cc: Mira Limbeck <m.limbeck@proxmox.com>, axboe@kernel.dk, hch@lst.de,
 linux-block@vger.kernel.org, martin.petersen@oracle.com,
 Friedrich Weber <f.weber@proxmox.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
 <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
 <ac2256a0-25ce-4453-8c47-04cb7716d46a@proxmox.com>
 <7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org>
 <ac2GOOLzui0U0BTJ@kbusch-mbp>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ac2GOOLzui0U0BTJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/04/02 5:55, Keith Busch wrote:
> On Thu, Apr 02, 2026 at 05:02:22AM +0900, Damien Le Moal wrote:
>> On 4/1/26 19:32, Mira Limbeck wrote:
>>>
>>> Apr 01 11:41:19 pve-test-hba kernel: sd 9:2:2:0: [sdc] tag#3962 page boundary curr_buff: 0x00000000f4d7cfce
>>> Apr 01 11:41:19 pve-test-hba kernel: BUG: unable to handle page fault for address: ff3a241243d70000
>>> Apr 01 11:41:19 pve-test-hba kernel: #PF: supervisor write access in kernel mode
>>> Apr 01 11:41:19 pve-test-hba kernel: #PF: error_code(0x0002) - not-present page
>>> Apr 01 11:41:19 pve-test-hba kernel: PGD 100010067 P4D 10066d067 PUD 10066e067 PMD 11f0fa067 PTE 0
>>> Apr 01 11:41:19 pve-test-hba kernel: Oops: Oops: 0002 [#3] SMP NOPTI
>>> Apr 01 11:41:19 pve-test-hba kernel: CPU: 15 UID: 0 PID: 6695 Comm: vgs Tainted: G      D W   E       7.0.0-rc6 #19 PREEMPT(full)
>>> Apr 01 11:41:19 pve-test-hba kernel: Tainted: [D]=DIE, [W]=WARN, [E]=UNSIGNED_MODULE
>>> Apr 01 11:41:19 pve-test-hba kernel: Hardware name: <snip>
>>> Apr 01 11:41:19 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0x478/0x590 [mpt3sas]
>>
>> There may be an issue with the mpt3sas driver with large commands.
>>
>> However, I am using that driver all day long and doing lots of testing with
>> gigantic read/write commands all the time. I have never seen any issues.
>> The difference is that I am using the SAS-SATA FW for the Broadcom HBA, so no
>> NVMe support, and my target devices are SAS or SATA HDDs, not SSDs.
> 
> It's only the NVMe attached ones that use base_make_prp_nvme, and it
> looks like the ioc->pcie_sgl_dma_pool that provides the buffer for the
> entries is too small for a transfer larger than 2MB. So it's overrunning
> the allocated buffer.

Keith,

Thanks for checking. I had not look at the code yet. Given this, this should be
fairly straightforward to fix. I will have a look and send a patch.


-- 
Damien Le Moal
Western Digital Research

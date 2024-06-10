Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993982871;
	Mon, 10 Jun 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033074; cv=none; b=pds4yPT+8FiHBIRpHD39MzqLx12vAZ5/2AiiJbxbZjiM/1rqhDzEr+O1wYe2f+nyvvrz6XDZdPPUJDfmkoIqyI4+D/FZVWhJ2TtC+OTjzLpaSRD9j9n4WjSRnXrZ7LZhT/MJSLfVG/rcrBJzR+lVcyb8MjAlZGtuN2tUgzO7zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033074; c=relaxed/simple;
	bh=c+9tcVpryK4i0tWGtMFCJFNSadZ6QzJfj6WWubKCwGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRP89lpXYeU1kzxSglqXNrN3wmAjKzbZsy/ksu+yRUYjmppXB76VZ7Jlnyj+vqpN85PVDmn9493G03ZJ8RFhpH3dufQgQMRuMjuEHdj0jFx9dt2fPfBjKQhbH1DWIbyzHjllKPdKkYu3zxHDCCmLSNhRUV80JmnZqKpLuKhBEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/nWUu4h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/nWUu4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594F5C2BBFC;
	Mon, 10 Jun 2024 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718033073;
	bh=c+9tcVpryK4i0tWGtMFCJFNSadZ6QzJfj6WWubKCwGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/nWUu4hZHsmtMj7BwbWmxTDIpaGKacW5pGjV1FwnnGC4DMq6Eynz6PmWgVLlU/Ka
	 pP/srzoz+rurgOkuM9Ou4J75djzS11vJTZ3Ols3pXmPsfY2NsyO2rJFWkYAfItQQJ7
	 fjKi1WGNJN99lia7LYw+vzMCKf7ASqcOAyG3PUQPpPyE8hugC5dU/jnln+W0drTqRv
	 fjL8Xin3RePaFeXq6isQtQam/I3E62Mhlzcxo0lq09qAVcrWb97CrZStbwKla5gFxz
	 Xv7l88tQVS36GhF2hQjqLmGURkQU/U8XUtATAzoUiLbzIEm/lLnLgz4yg4cZzxXmEE
	 ktMuIkZ6OX69w==
Date: Mon, 10 Jun 2024 09:24:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Message-ID: <Zmcar50yXDJW9_Ho@kbusch-mbp.dhcp.thefacebook.com>
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <2285ff6e-533f-41dc-90d0-e8ca538da152@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2285ff6e-533f-41dc-90d0-e8ca538da152@grimberg.me>

On Mon, Jun 10, 2024 at 12:57:02PM +0300, Sagi Grimberg wrote:
> On 10/06/2024 10:51, Venkat Rao Bagalkote wrote:
> > 
> > [  140.209777] BUG: Unable to handle kernel data access at 0x18d7003065646fee
> > [  140.209792] Faulting instruction address: 0xc00000000023b45c
> > [  140.209798] Oops: Kernel access of bad area, sig: 11 [#1]
> > [  140.209802] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=8192 NUMA pSeries
> > [  140.209864] CPU: 2 PID: 129 Comm: kworker/u65:3 Kdump: loaded Not tainted 6.10.0-rc3 #2
> > [  140.209870] Hardware name: IBM,9009-42A POWER9 (raw) 0x4e0202 0xf000005 of:IBM,FW950.A0 (VL950_141) hv:phyp pSeries
> > [  140.209876] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> > [  140.209889] NIP:  c00000000023b45c LR: c008000006a96b20 CTR: c00000000023b42c
> > [  140.209894] REGS: c0000000506078a0 TRAP: 0380   Not tainted (6.10.0-rc3)
> > [  140.209899] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000244  XER: 00000000
> > [  140.209975] NIP [c00000000023b45c] synchronize_srcu+0x30/0x1c0
> > [  140.209984] LR [c008000006a96b20] nvme_ns_remove+0x80/0x2d8 [nvme_core]
> > [  140.209994] Call Trace:
> > [  140.209997] [c000000050607b90] [c008000006a96b20] nvme_ns_remove+0x80/0x2d8 [nvme_core]
> > [  140.210008] [c000000050607bd0] [c008000006a972b4] nvme_remove_invalid_namespaces+0x144/0x1ac [nvme_core]
> > [  140.210020] [c000000050607c60] [c008000006a9dbd4] nvme_scan_ns_list+0x19c/0x370 [nvme_core]
> > [  140.210032] [c000000050607d70] [c008000006a9dfc8] nvme_scan_work+0xc8/0x278 [nvme_core]
> > [  140.210043] [c000000050607e40] [c00000000019414c] process_one_work+0x20c/0x4f4
> > [  140.210051] [c000000050607ef0] [c0000000001950cc] worker_thread+0x378/0x544
> > [  140.210058] [c000000050607f90] [c0000000001a164c] kthread+0x138/0x140
> > [  140.210065] [c000000050607fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
> > [  140.210072] Code: 3c4c0134 384282d4 7c0802a6 60000000 7c0802a6 fbc1fff0 fba1ffe8 fbe1fff8 7c7e1b78 f8010010 f821ffb1 e9230010 e9290080> 7c2004ac 71290003 41820008
> > [  140.210093] ---[ end trace 0000000000000000 ]---
> > 
> > Issue is introduced by the patch:
> > be647e2c76b27f409cdd520f66c95be888b553a3.
> 
> Exactly this was the concern when introducing a behavior change in a
> sensitive area of the code
> to silence lockdep...

No risk, no reward. :)

If we really can't figure this out, we can always revert and revisit for
the next merge.

> I'm assuming that the bad dereference is:
>         synchronize_srcu(&ns->ctrl->srcu);

That would have to be it based on the report. Not sure what the problem
could be, though, the ns->ctrl must have been valid or we would have
failed earlier, and the srcu struct can't be released while the
controller is still in use by any namespace.

Anyway, I tested this path quite a bit, but I'll revisit with dynamic
attachments instead and see if that helps.

> btw, looking at the code again, I'm assuming that synchronizing srcu in
> every ns remove
> slows down batch removal of many namespaces greatly...

I may need to test this out, but I thought srcu sync was pretty quick if
there were no active readers, which there shouldn't be here outside
unusual cases.

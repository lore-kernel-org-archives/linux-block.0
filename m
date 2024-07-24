Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AD5695
	for <linux-block@vger.kernel.org>; Wed, 24 Jul 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721822142; cv=none; b=Kcx+SYfyhSJ/ngdZ0N9BqI2qVdVx3WhueH7hEtyTY/uRslkM4solhZQ1YB9ssAbOod11BI0Q0lr0xEVzduY8KvFFT6haHQ9OK+Si6A+0sa0SVORIhZg9VtB4olbECiP5D2fk2LjVc5+0erBRg4CpcN8NwuxLiDeVrUVAUhSt/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721822142; c=relaxed/simple;
	bh=pvCuWS2e6WMCTT/KoT+u7/Gc2w7cf5j2rkJkrqCIhi0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G3wXO9mks/Msfd3iPbj4NJEw1AZMM/WktUhNNhYkcFIDApkPVlrTPTEXfUZcZRv0yY+xi8RRMQPcMp9ykhNbTgMmKoTGCWzlRz5FyXTYsHsDxY3LxknKJHqfVAOZ9rIYr9dX+eQ+QtGf4rg2JoOSa7zXIJch7bA8RvP3Ivxcjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from W388ANL (10.12.12.26) by S035ANL.actianordic.se (10.12.31.116)
 with Microsoft SMTP Server id 15.1.2507.39; Wed, 24 Jul 2024 13:40:25 +0200
Date: Wed, 24 Jul 2024 13:40:21 +0200
From: Jonas Blixt <jonas.blixt@actia.se>
To: <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>
CC: <john.ernberg@actia.se>
Subject: xen: arm64: Poor block device performance
Message-ID: <ZqDoJQ+HTfjc0SZO@W388ANL>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-EsetResult: clean, is OK
X-EsetId: 37303A2956B14454677361

Hello,

I'm investigating a block device performance issue on our system.

Our setup is as follows:
SoC: NXP IMX8DXP (arm64), Dual core Cortex A35
Flash: eMMC, HS400
Xen 4.18.1
Dom0 kernel: 6.1.55
DomU kernel: 6.1.14

Dom0 has two vcpu's and domU has one. We're using the xen-blkfront/back drivers to expose block devices to domU.

We measure the following using a simple 'dd' -test (echo 3 > /proc/sys/vm/drop_caches && time dd if=/dev/XXX  of=/dev/null bs=1M count=64):

Directly on the eMMC block device in dom 0: 160 MByte/s
On xvd device in domU: 9.5 MByte/s

Ram block device in dom0: 460 MByte/s
On xvd device in domU: 246 MByte/s

The difference between the ram block device and the eMMC might suggest that there is some interaction between the xenblk driver and the mmc driver that causes this performance degradation. I'm not sure what to expect with the ram device but it at least does not have the same penalty.

I would appreciate any help or suggestions on how to debug this. Is 'blktrace' the right tool for this job and what should I look for?

Best Regards
Jonas

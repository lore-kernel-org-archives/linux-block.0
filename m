Received: from zproxy2.enst.fr (zproxy2.enst.fr [137.194.2.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079231DA31E
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=137.194.2.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991124; cv=none; b=QVhQXwtQhz55XcPauezGhWq2ZrbNflxuUMeGYj7JlGU/5VUroaYdm8yoIUZGzO9dKgatVdtIxibZv7Xv50ugOBaljiuwmGe9t011LTS1ET3JnbA/yu5oCVr4V4Rhf/IMuEuO/SpOuGcEv9sSPljInjIjJrIFsuKqMGovkeXla5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991124; c=relaxed/simple;
	bh=dVhJa9aNCNejn6YP6pBA+SqbhKaz0MUEUD38Bs/AiXY=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=DimsF3TLL+F/tYchUlpB2zWGFs8NLqC9t4ONp5rfov7B9e53Ss6SSplIj4rFM3MX9rXUN9r/Hh/K9H8n+6GFlJNXZqMwHtNqDWex2DJXXTHAl2SOHzor5wa0YyKU4CIeeGjUQnZgGQ1hgjSrYqL3+xfRlwQ7IjcM4q/9yYS/KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imt-atlantique.fr; spf=pass smtp.mailfrom=imt-atlantique.fr; dkim=pass (1024-bit key) header.d=imt-atlantique.fr header.i=@imt-atlantique.fr header.b=GlMK9qx1; arc=none smtp.client-ip=137.194.2.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imt-atlantique.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imt-atlantique.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=imt-atlantique.fr header.i=@imt-atlantique.fr header.b="GlMK9qx1"
Received: from localhost (localhost [IPv6:::1])
	by zproxy2.enst.fr (Postfix) with ESMTP id 1DFA780780
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:11:28 +0200 (CEST)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id rhx--dt7dP5R for <linux-block@vger.kernel.org>;
 Wed,  3 Jul 2024 09:11:27 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by zproxy2.enst.fr (Postfix) with ESMTP id DBB8A806DA
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:11:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr DBB8A806DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imt-atlantique.fr;
	s=50EA75E8-DE22-11E6-A6DE-0662BA474D24; t=1719990687;
	bh=dVhJa9aNCNejn6YP6pBA+SqbhKaz0MUEUD38Bs/AiXY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=GlMK9qx1CVE5zwGZO8C9H1K66ixsL1XYl90WgnckxMdjCbxdfkCFzQRR6KC/VYaLG
	 MJbQD8hpJfZxtbosn6S/cotEh39ujkRYcrUtMx9Gyf+5HijkYN1qHVlUqqUsI6xuqw
	 Rndfcbl4unrkOCaZj1q0n4VXRp3eDx/Ds8haFTjI=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id K_i729HoORts for <linux-block@vger.kernel.org>;
 Wed,  3 Jul 2024 09:11:27 +0200 (CEST)
Received: from zmail-imta1.enst.fr (zmail-imta1.enst.fr [137.194.2.216])
	by zproxy2.enst.fr (Postfix) with ESMTP id C14AB80780
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:11:27 +0200 (CEST)
Date: Wed, 3 Jul 2024 09:11:27 +0200 (CEST)
From: Jamaleddine AMGHAR <jamaleddine.amghar@imt-atlantique.fr>
To: linux-block@vger.kernel.org
Message-ID: <696912362.9230882.1719990687531.JavaMail.zimbra@imt-atlantique.fr>
Subject: request for information on using NVMe under linux
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - GC126 (Win)/9.0.0_GA_4612)
Thread-Index: GwvnhWL7KarA/cYHWfpUGTvz11A73w==
Thread-Topic: request for information on using NVMe under linux

Hello,

I am experiencing an abnormal performance issue with my Samsung SSD 970 EVO Plus 1TB (2B2QEXM7) on my Ubuntu 24.04 LTS system. My setup includes a 12th Gen Intel Core i7-12700 x 20 processor, and the SSD is connected to an M.2 M-key, type-2280 slot (PCIe Gen.3 x4 interface) that supports NVMe on the motherboard.

Specifically, I have noticed a significantly low write speed of around 700MB/s on my Ubuntu system. After some research, it appears that many users face similar issues when using NVMe drives on Linux. In contrast, when I tested the same SSD on the same motherboard using a portable Windows OS, the write speed was approximately 3GB/s.

Could you provide any methods to optimize the performance of my NVMe drive on Linux? Additionally, how can I update the NVMe driver on Linux using "nvme-cli"? Any advice or recommendations you have to address this issue would be greatly appreciated.

Thank you for your assistance.

Best regards,

Jamaleddine AMGHAR

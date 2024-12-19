Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C3217722
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594708; cv=none; b=pselvI4Ahg/+3aH48e6kE005FfLlvr6h97lreYAKKg5Z+uufOe4vDxsNGX4+u6Ho270G/1z2sKqFRT55hL+yNVMK8itNS7FajVm1OYfmxifSgBv104PJtJGKfOlIMBHLaBp2mJWX6xZ4FwctKi5tewZCDz3jsEgoOhLo5PIun5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594708; c=relaxed/simple;
	bh=cxF36KdhaoPLy1OtO7ZkW/HO4NVt5BPOjnHrtwP0dpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VgQBQYNu3nU6154SlxNXjquh/+IDEyySYYXu9b5XDGIVqIDo00yiq6ddOY909Ls0I3donKDWCDFX03g3Br/orQk7UBhsrgA0ep6n9C287ihF6sDR/PDxwMVUlaqUN7zG3vNwdixWSJ0BSES6chD5064ZENPQ+hoiQ6FhRALR4dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOBJu-0004D5-4s; Thu, 19 Dec 2024 08:51:42 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOBJs-004AWx-1E;
	Thu, 19 Dec 2024 08:51:41 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOBJt-00GmXj-0I;
	Thu, 19 Dec 2024 08:51:41 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:51:30 +0100
Subject: [PATCH RFC] docs: ABI: replace mcroce@microsoft.com with new Meta
 address
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-fix-mcroce-mail-bounce-v1-1-4912116b6060@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAIHQY2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0NL3bTMCt3c5KL85FTd3MTMHN2k/NI8INvYyMLSwMDQzNLEwFQJqLm
 gKBWoEmxwtFKQm7NSbG0tABtKRYptAAAA
X-Change-ID: 20241219-fix-mcroce-mail-bounce-328900169405
To: Matteo Croce <teknoraver@meta.com>, 
 Matteo Croce <technoboy85@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-block@vger.kernel.org

The Microsoft email address is bouncing:

    550 5.4.1 Recipient address rejected: Access denied.

So let's replace it with the address Matteo last used to sign off
patches two months ago.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
@Matteo, is this ok for you or would you prefer another address (whether
your own or someone else's?)

I ran into this while submitting a series[1] touching sysfs-kernel-reboot
and b4/get_maintainers.pl picked off the stale address from the file.

[1]: https://lore.kernel.org/all/20241219-hw_protection-reboot-v1-6-263a0c1df802@pengutronix.de/
---
 Documentation/ABI/stable/sysfs-block          |  2 +-
 Documentation/ABI/testing/sysfs-kernel-reboot | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0cceb2badc836b8cbdade543deff71edef0e3da1..ee1bbb4dfd4ea65fc0aa13c03a5205b8d5816ecf 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -77,7 +77,7 @@ Description:
 
 What:		/sys/block/<disk>/diskseq
 Date:		February 2021
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:
 		The /sys/block/<disk>/diskseq files reports the disk
 		sequence number, which is a monotonically increasing
diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
index 837330fb251134ffdf29cd68f0b2a845b088e5a0..fb2d21acc6627ee340a3c8327261d5727ad63e15 100644
--- a/Documentation/ABI/testing/sysfs-kernel-reboot
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot
@@ -1,7 +1,7 @@
 What:		/sys/kernel/reboot
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	Interface to set the kernel reboot behavior, similarly to
 		what can be done via the reboot= cmdline option.
 		(see Documentation/admin-guide/kernel-parameters.txt)
@@ -9,24 +9,24 @@ Description:	Interface to set the kernel reboot behavior, similarly to
 What:		/sys/kernel/reboot/mode
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	Reboot mode. Valid values are: cold warm hard soft gpio
 
 What:		/sys/kernel/reboot/type
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	Reboot type. Valid values are: bios acpi kbd triple efi pci
 
 What:		/sys/kernel/reboot/cpu
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	CPU number to use to reboot.
 
 What:		/sys/kernel/reboot/force
 Date:		November 2020
 KernelVersion:	5.11
-Contact:	Matteo Croce <mcroce@microsoft.com>
+Contact:	Matteo Croce <teknoraver@meta.com>
 Description:	Don't wait for any other CPUs on reboot and
 		avoid anything that could hang.

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241219-fix-mcroce-mail-bounce-328900169405

Best regards,
-- 
Ahmad Fatoum <a.fatoum@pengutronix.de>


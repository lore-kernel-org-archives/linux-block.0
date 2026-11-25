Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631401;
	b=svHqzj7/DIlFQbuDsr//eWb8G7bl4y/LAgHJNVy519+IhLwjY3WkYnlFQgX8oEZ9TIKb
	 iJREX4wPQpEqy83xgyMQydbZSlPj2EyMacSHgiN/My6vUetE0MjEG9KdXys3P9r3hS7Us
	 DMWh+HqsQKTQV38giFFoRZ0YJl4JlUCmBKVzCKz3NTlWYEonuPNzZCwUB1oyU3s/qE9+i
	 D21+Z6sDHZQQ1/z3zfDyQ37rkOl1T7qrOqUuk7SVSRq7uNQJU7749D7cz8WowL5Pc2qPy
	 W1sxCmMMtv6mQLH45FhjHWcCSvcLnrms6Ww89N8hOaWETsHRaVJiJuy5EhT64Hgu78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=thRt5lrTBHxA5kWjyhVc/0X4QbDWjOzyTASo1GnS3q4=;
	b=ytIU68Q+O6InTaCRyNTJcc5mGi6p1ZDbuibLG4VQMKkPumQCGcReUPGd5V4186cd+N3s
	 FzPcpIR+VaDy8kWyC1ZweotgkqR0FF8iZjDw+h95VwGh0BCVslBcE3BOmJt8/1N1dI6ii
	 nVdJW2jNjUymnoKl8NoONP+GZVoQNCwZIu16Kh5uCxr3e8O4wDit3xoa/nZsuTi4bXzc9
	 0dXP/UV9CVludjXSCfRx7gX43XalC9vLP1wFLhDKBzFelpkrhu7huXrhYXqtD6JQOosJs
	 yKpvSXdodamSkE5WBWdBHJ/kytxVlk1y1Sla8Fo4FgcaSYb/NUaqSF/U1PL+zlsedmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hel+7fhM;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87CC606A323;
	Wed, 25 Nov 2026 18:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B87CC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hel+7fhM
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jZSs413Jwzlfcpr;
	Wed, 25 Nov 2026 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795631391; x=1798223392; bh=thRt5lrTBHxA5kWjyhVc/0X4
	QbDWjOzyTASo1GnS3q4=; b=hel+7fhMgAhDpO9lwN3vQjdkpPRQrMNgfcBdIYk7
	Zym/OZdROp3JG3JHpJMLGxC0mmVte9UVjvSJaixDzEVLbtNGgVMTnjofBT3tindB
	GqsVOF7E4qZHAWSVGKW6Z6crfPq3eTUiUdn41wuZ8gP0d6nmyX+RXuLrVdcNACoB
	CI0fL6arkDFbUhOwaGnibDuLOEaxhxwUhWHQX6cZD7NCHnUzbLpaw9BhLVgntxL8
	7fXBdqo+vOq51+jBwyxV2q6MImdGAZgTynFgJOiYu+nFYA7dP9l3i11slgsySrOt
	MdUwqbzLXa12iVgZR0TRB6vyxTGVh9h06EMUCfv59gpGGQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7EqdZkBp2pxE; Wed, 25 Nov 2026 18:29:51 +0000 (UTC)
Received: from [192.168.0.215] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jZSrt62HMzlfvpT;
	Wed, 25 Nov 2026 18:29:50 +0000 (UTC)
Message-ID: <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
Date: Wed, 25 Nov 2026 10:29:49 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Tobias Laas <tobias.laas@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 regressions@lists.linux.dev, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 70sp <70sp@protonmail.com>, Laurence Oberman <loberman@redhat.com>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen> <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
 <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/25/26 12:52 AM, Thorsten Leemhuis wrote:
> For completeness, =C5=A0imon Posp=C3=ADchal (now CCed) shared findings =
and a WIP
> fix (both with the help of a LLM) meanwhile here:
>=20
> https://lore.kernel.org/all/QISmXFlpPMgvFUKmdIBDwqn4JHHXt2NZeJzerMLHF_5=
icLo0lPKVlN0Ig9v8Vb52NmCeSFdyrao4x8KoN1DCXtDlnZS7eRIClC6vZyu-hPU%3D@proto=
nmail.com/

Thanks Thorsten for having shared that link. The LLM I'm using doesn't
like that patch and came up with the patch shown below. Untested.

Bart.


Subject: [PATCH] iommu/vt-d: Disable superpages on Haswell with=20
integrated graphics

Disable Intel VT-d superpages on bare-metal Haswell client systems when
integrated graphics (0000:00:02.0) is enabled and an active remapping
unit advertises superpage support (CAP.SLLPS).

Per the 4th Generation Intel Core Processor Family datasheets (document
328897, section 3.1.2), the integrated graphics VT-d engine does not
support super-pages and BIOS must disable super-pages in the default
VT-d engine when integrated graphics is enabled. Several Haswell BIOSes
leave CAP.SLLPS set on the default engine (dmar1). Whenever Linux install=
s
a 2 MiB or 1 GiB leaf entry (PS=3D1) on dmar1, hardware aborts DMA with
fault reason 0x0c ("non-zero reserved fields in PTE"), breaking VFIO
passthrough, discrete GPUs, audio, and AHCI storage (exposed by default
once BLK_DEF_MAX_SECTORS_CAP increased to 4 MiB in v6.17).

Prior to commit c376a3456d8b ("iommu/vt-d: Remove
domain_update_iommu_cap()"), domain_update_iommu_superpage() intersected
superpage support across all active IOMMUs, so the IGD unit (SLLPS=3D0)
masked off superpages on dmar1. After that commit, dmar1 domains started
honoring dmar1's advertised CAP.SLLPS.

Detect bare-metal Haswell client CPUs (INTEL_HASWELL, INTEL_HASWELL_L,
INTEL_HASWELL_G), verify that the Intel integrated graphics device at
0000:00:02.0 is present and not on an untrusted PCI link, and clear
intel_iommu_superpage during intel_iommu_init() before allocating any
paging domains if an active IOMMU advertises CAP.SLLPS.

Fixes: c376a3456d8b ("iommu/vt-d: Remove domain_update_iommu_cap()")
Reported-by: Tobias Laas <tobias.laas@posteo.de>
Closes:=20
https://lore.kernel.org/linux-block/5ad27a97aafbc08a8702d5b90d09cd59@post=
eo.de/
Reported-by: =C5=A0imon Posp=C3=ADchal <70sp@protonmail.com>
Closes:=20
https://lore.kernel.org/r/HYhMd0Klo0XE_yiVY7XmsgyKKFDwKHfKRy22KrycLcYd0V_=
ykA4xdbBMJXkA07YX3os6qK-NhMIVi6ITo-CkNIIF0e-GcI0UwwZmdDhAJ0I=3D@protonmai=
l.com
Cc: stable@vger.kernel.org
---
  drivers/iommu/intel/iommu.c | 53 +++++++++++++++++++++++++++++++++++++
  1 file changed, 53 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..dd37aa25e287 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -24,6 +24,8 @@
  #include <linux/tboot.h>
  #include <uapi/linux/iommufd.h>

+#include <asm/cpu_device_id.h>
+
  #include "iommu.h"
  #include "../dma-iommu.h"
  #include "../irq_remapping.h"
@@ -43,6 +45,7 @@

  #define DEFAULT_DOMAIN_ADDRESS_WIDTH 57

+static void __init check_haswell_igfx_superpage(void);
  static void __init check_tylersburg_isoch(void);
  static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
  					  bool enable);
@@ -2762,6 +2765,7 @@ int __init intel_iommu_init(void)
  		pr_info("No SATC found\n");

  	init_no_remapping_devices();
+	check_haswell_igfx_superpage();

  	ret =3D init_dmars();
  	if (ret) {
@@ -4266,6 +4270,55 @@ static void __init check_tylersburg_isoch(void)
  	       vtisochctrl);
  }

+static const struct x86_cpu_id haswell_cpu_ids[] __initconst =3D {
+	X86_MATCH_VFM(INTEL_HASWELL, NULL),
+	X86_MATCH_VFM(INTEL_HASWELL_L, NULL),
+	X86_MATCH_VFM(INTEL_HASWELL_G, NULL),
+	{}
+};
+
+/*
+ * Per the 4th Generation Intel Core Processor Family datasheets (e.g.
+ * document 328897, section 3.1.2), the integrated graphics VT-d engine
+ * does not support super-pages and BIOS must disable super-pages in the
+ * default VT-d engine when integrated graphics is enabled. Some Haswell
+ * BIOSes leave CAP.SLLPS set on the default engine, causing fault reaso=
n
+ * 0x0c (non-zero reserved fields in PTE) when a 2 MiB or 1 GiB superpag=
e
+ * mapping is used.
+ */
+static void __init check_haswell_igfx_superpage(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	struct pci_dev *pdev;
+
+	if (!intel_iommu_superpage)
+		return;
+
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) ||
+	    !x86_match_cpu(haswell_cpu_ids))
+		return;
+
+	pdev =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(2, 0));
+	if (!pdev)
+		return;
+
+	if (pdev->vendor !=3D PCI_VENDOR_ID_INTEL || !IS_GFX_DEVICE(pdev) ||
+	    risky_device(pdev)) {
+		pci_dev_put(pdev);
+		return;
+	}
+	pci_dev_put(pdev);
+
+	for_each_active_iommu(iommu, drhd) {
+		if (cap_super_page_val(iommu->cap)) {
+			intel_iommu_superpage =3D 0;
+			pr_info("Disabling superpages on Haswell with integrated graphics\n")=
;
+			break;
+		}
+	}
+}
+
  /*
   * Here we deal with a device TLB defect where device may=20
inadvertently issue ATS
   * invalidation completion before posted writes initiated with=20
translated address


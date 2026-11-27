Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794989;
	b=ld49pSBmWE9UALVOxoPhj0X2dyB0MB9l6U2nq+Rzbrl3aGJoaTibRMvEVnKaFLk/WcW2
	 q/arzAfEKYW3GflpdTvsJn/K0pYUtsYaM8sAdcnhQiQAGz+8W76Q8F6cbndzWNdmkBLPs
	 wjMfL88cZ/mjkypTH2QW+VnZJxd9bS0N3PCUpaCM9TIjtD72b/pB/q0mhh69k9fV21U/7
	 p1tO4TNrWzcnom/8alWd/EdrCwrpjqGHXzocVHhvbVxM2bjrKkThlVHb2KIij7f5PonAD
	 1NmYhU3tME4jGkk5ok11MO7LwTFMKeJIZfjrZnClohDYQ6QDBWWJQHBwxDHw/LOj2vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VOQN32mWBtipXbp6LOeA3aYHzW7Pgb5jWELRRzRROro=;
	b=HjlxTU0apXvdWDx6ewWfLvg/G0v9hbqWvXIz6D6jY36SS3p3sEcx2t9kGo0VO3gKAWxf
	 o/y9mYGwh7sxtV58UqcEOCloPuU9bTzR8ml/gu157bYlKikbK9pLHvNL4uROPhWdscIkL
	 L9pvmMu8T+YtxE6htREaxaP1B08UjuYdPI5Nr6/09lewSKAJialXUhpluf/cysIYsmlgv
	 O3GqrIdUe0mDurmkl63HZoglPaaVdtUAXkP8xQJgEujSJuzcT0kH6qByy8Qnibx5nLw0D
	 +itn1AfhXqBJgWiDq28uu/3ys8ZHGBzZAB0NSmNjxlJCu+bmRMUM+6aopnQnoBPFshQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=lxW+x7Td;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD924606A31E;
	Fri, 27 Nov 2026 15:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD924606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=lxW+x7Td
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jbdM01DD5z1XMFvk;
	Fri, 27 Nov 2026 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795794976; x=1798386977; bh=VOQN32mWBtipXbp6LOeA3aYH
	zW7Pgb5jWELRRzRROro=; b=lxW+x7TdBhEc0hBbqI700ZHNzHN9FN6P35FAzd/s
	o+BQp9a9ZikoufRQXDBrnYyL+uJq55LWEk//rnuppkEgIDWslrm2BCyRReKj9zVx
	d7gc44cL6dGwVkcMzXWWBgpverh2360D3TMM+jWF29R2dwJi6sbzvo8MKPXUGxic
	Naxz8g6J70yGHO0U9fcV/DjrGz8xJulosVSnaPofaVFuvl3JGchbgQLTXXr3kwsJ
	28Bt42PPyj50ZpX71vc7flSNaqGXCTId0oD0zhf0/iArJLphACuIAiE1tw1GL7Dh
	xuwh8IFDKzQXjD7alLKDKsMcGKqFA6yXm91vYAopjrBMWg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id M3PTvbKtweB6; Fri, 27 Nov 2026 15:56:16 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jbdLl5Rd6z1XLyhd;
	Fri, 27 Nov 2026 15:56:15 +0000 (UTC)
Message-ID: <0318408a-20b8-4237-85b2-e522883f5436@acm.org>
Date: Fri, 27 Nov 2026 07:56:14 -0800
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
To: 70sp <70sp@protonmail.com>, Laurence Oberman <loberman@redhat.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Tobias Laas <tobias.laas@posteo.de>,
 Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 regressions@lists.linux.dev, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Will Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen> <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
 <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
 <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
 <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
 <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com>
 <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
 <f323c3d62265dfe90fa71514028af4d35f6e2420.camel@redhat.com>
 <e_efhbm0Vxq0FxO3-QqPkyhGrjzTvBDYmUOsGgmebVSyd0qsXXxYFXwC9sSjRAP06gcpsttHunBLtc0Mmt0cIjEI_0sDXL61lnxHhmuaxWs=@protonmail.com>
 <l7ImnFzOgVkMzGhZoxCBcI1dAbMnO2NlsstuK-4sh3CyOpWhWAC1RqFIr4CW82iTy3FZe2r1k4EFFtecv5PClmy_mvh10vI9W_W5Z5p-jlo=@protonmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <l7ImnFzOgVkMzGhZoxCBcI1dAbMnO2NlsstuK-4sh3CyOpWhWAC1RqFIr4CW82iTy3FZe2r1k4EFFtecv5PClmy_mvh10vI9W_W5Z5p-jlo=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 11/27/26 5:57 AM, 70sp wrote:
> I have taken a look at the patches and the entire problem much more
> in depth, and there probably isn't a significantly better variant to
> do this.
>=20
> In the state before the regression, the kernel was assigning smaller
> page sizes for some cases, so it wasn't ideal as I thought. I also
> haven't found a better place for the quirk to belong as there are
> already exemptions for specific platforms in the code (I thought
> there weren't). This one is probably fine.
>=20
> I am sorry to Bart and Laurence who had to handle this. I thought my
> patch was bad, so I thought the same about Barts, but it looks like
> it's the correct way to approach it.
>=20
> I was told to repost my patch formally by Lu Baolu ( https://
> lore.kernel.org/regressions/d931a389-c143-4a6a-931c-
> bc7025bcefb9@linux.intel.com/ ), probably because it fixes at least
> my case.
>=20
> I think we should wait for confirmation from Tobias and if it's
> positive, we can send out the final patch closing both cases.
My LLM came up with the (entirely untested) patch below after I asked
it to generalize an earlier patch:

Subject: [PATCH] iommu/vt-d: Disable superpages when legacy IGD engine=20
lacks them

Disable Intel VT-d superpages on bare-metal systems when the Intel
integrated graphics device (0000:00:02.0) is behind a dedicated legacy
(non-scalable-mode) VT-d engine that reports CAP.SLLPS =3D=3D 0 while an
active remapping unit advertises superpage support.

Per Intel Core processor datasheets (e.g. document 328897, section 3.1.2
for 4th Generation Core / Haswell), the integrated graphics VT-d engine
does not support super-pages and BIOS must disable super-pages in the
default VT-d engine while integrated graphics is enabled. Several BIOSes
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

Check the hardware capability directly instead of matching hardcoded CPU
model IDs. During intel_iommu_init(), look up the Intel integrated
graphics device at 0000:00:02.0, find its matched non-INCLUDE_ALL DRHD
unit, and clear intel_iommu_superpage before allocating any paging
domains if that unit is a legacy engine (ECAP.SMTS =3D=3D 0) without
superpage support (CAP.SLLPS =3D=3D 0) while an active IOMMU advertises
CAP.SLLPS. Skip virtualized guests, untrusted PCI devices, systems
without integrated graphics, and newer generations whose IGD VT-d engine
supports superpages or scalable mode.

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
  drivers/iommu/intel/iommu.c | 48 +++++++++++++++++++++++++++++++++++++
  1 file changed, 48 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..d2c03bec22e9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -43,6 +43,7 @@

  #define DEFAULT_DOMAIN_ADDRESS_WIDTH 57

+static void __init check_igfx_superpage(void);
  static void __init check_tylersburg_isoch(void);
  static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
  					  bool enable);
@@ -2762,6 +2763,7 @@ int __init intel_iommu_init(void)
  		pr_info("No SATC found\n");

  	init_no_remapping_devices();
+	check_igfx_superpage();

  	ret =3D init_dmars();
  	if (ret) {
@@ -4266,6 +4268,52 @@ static void __init check_tylersburg_isoch(void)
  	       vtisochctrl);
  }

+/*
+ * Per Intel Core processor datasheets (e.g. document 328897, section=20
3.1.2),
+ * when the integrated graphics VT-d engine does not support super-pages
+ * (CAP.SLLPS =3D=3D 0), BIOS must disable super-pages in the default VT=
-d=20
engine
+ * while integrated graphics is enabled. Some BIOSes leave CAP.SLLPS set=
 on
+ * the default engine, causing fault reason 0x0c (non-zero reserved=20
fields in
+ * PTE) when a 2 MiB or 1 GiB superpage mapping is used.
+ */
+static void __init check_igfx_superpage(void)
+{
+	struct dmar_drhd_unit *drhd, *igfx_drhd;
+	struct intel_iommu *iommu;
+	struct pci_dev *pdev;
+
+	if (!intel_iommu_superpage ||
+	    cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
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
+
+	igfx_drhd =3D dmar_find_matched_drhd_unit(pdev);
+	pci_dev_put(pdev);
+	if (!igfx_drhd || !igfx_drhd->iommu || igfx_drhd->include_all)
+		return;
+
+	if (ecap_smts(igfx_drhd->iommu->ecap) ||
+	    cap_super_page_val(igfx_drhd->iommu->cap))
+		return;
+
+	for_each_active_iommu(iommu, drhd) {
+		if (cap_super_page_val(iommu->cap)) {
+			intel_iommu_superpage =3D 0;
+			pr_info("Disabling superpages because integrated graphics VT-d=20
engine lacks superpage support\n");
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


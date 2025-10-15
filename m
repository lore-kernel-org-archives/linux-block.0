Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A342628D
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562916; cv=none; b=vELn2eEDrRaMUnyuZ/hpgNzeWdrjee1EJpfx7qkAzBPS8EhB0Pv/yImgg4oWnR2R/oGxJi4vgkEiHal6SuwTfWtylkJDqm/fOc5+IWARzDuvEoRNglR9NikHd8XJjBlqCsglQ6AbeUbIqPkfYR2KuIILEKcAqEsP+iGHBrlOlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562916; c=relaxed/simple;
	bh=Q+1BO1yrQbpbekct0/R8PymDIyk4aa589en7FVolgIc=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=qMpX+F2eszzjlUuBA0DCfdRKCF3jWBSBfNLof9tXwcg8/ffTLZ9Cu904AKxzR6W85u/J0vMdLRhyRZgCcPuQRdkCSno0H3Sjgp1xpn8vuiuHzt8Yph+Zbmm+L+AaltBim/Q8mU56ELewL/AzEDspIUgkaXcXUTfzjq/bkzUsD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VNXhv0P3; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VNXhv0P3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760562914; x=1792098914;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=Q+1BO1yrQbpbekct0/R8PymDIyk4aa589en7FVolgIc=;
  b=VNXhv0P39MHGC70RY/FeVU9K4mAutI860uhsnsZZzeqaf8t+8t37L3rc
   psDtfRzI2sYA6/DqziVczpaop17pVd+iWDz+rEpG7xEDcL7wLAShVBKzH
   Djkdu7QTEsQzWVdqZRZlZDLyToiG+6kva9pFzAn+G9yKyCtaImvhY+y/x
   Qeyhiw7DufQ8w8jbelCp2r5WL6fBl7e26L6F3LplkL0pVZNPLrnUx0KgS
   gQTN8+Hk+0c2sE4dCZxprDDyv6JZRrJlLJY8Xrqtmmjbd00FVX/lqKfab
   hX7mof37zvWKrIWrjLwLak0gEnaX0aSw4e4veqSLIf2zJkRbCFVStHlXh
   A==;
X-CSE-ConnectionGUID: wviVRxEPRF2s/ipkYKmRvw==
X-CSE-MsgGUID: IlrpH5muT02wGYKucDmp8g==
X-IronPort-AV: E=Sophos;i="6.19,232,1754928000"; 
   d="scan'208";a="134534449"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 05:15:08 +0800
IronPort-SDR: 68f00edc_DSvSVI1cQiG/c0qm8jVL5/Fvf2bMhfGctq1XssJoRELsZwR
 65Elxx8Lsa9Oz2XKKo9vpyLwDLilNRYEfD/UO6A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 14:15:09 -0700
Date: 15 Oct 2025 14:15:07 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 14:15:07 -0700
Content-Type: multipart/mixed; boundary="===============4812578870460036147=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11be80fec2fd6bf66e82904ed79f4164171dae38f62e9e53151c22b193aff4d5@mailrelay.wdc.com>
In-Reply-To: <cover.1760368250.git.leon@kernel.org>
References: <cover.1760368250.git.leon@kernel.org>
Subject: Re: [PATCH v5 0/9] vfio/pci: Allow MMIO regions to be exported through dma-buf
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============4812578870460036147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [v5,0/9] vfio/pci: Allow MMIO regions to be exported through dma-buf
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1010803&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18524773591


Failed test cases: nvme/057



--===============4812578870460036147==--

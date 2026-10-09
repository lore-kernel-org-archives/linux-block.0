Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E9175A74
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513181; cv=none; b=MI1+bWdf3KiONOp4+bAXadTSKKM8TjgbDQaeNzXzBjwtUeLhDv5D9OEb3tOsHvNc0dusCd4hHCqxx4ozkkepWbEJ3cTYWy52nk+QL5jZ8LwYZ4BIunfc8njt1JT3vKAYP/QSTMFAt2A4kHJdlXGdgV6UarixKEMjDh8phGaZ1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513181; c=relaxed/simple;
	bh=2UDSRshdfMAn0ym0C1sfJVH+j5wJB2oVO9MnQt811hM=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=puI2J72rP08qM+3+yF6Y1ws0ni2HtxWL3bw0wAkHSoFcMdAG13EjRQL61+zdFz8iMBobksU7WB3ekTNB+EGE1dav+pU/HLSdyJqViT0dWpqtx5GG5qwG4oPMoYi0Fryj9bg7aI9PFraCZYvE9g23L8eGUaoDioaEiWvf/Pr+Dnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hpkvYSKI; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hpkvYSKI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791513180; x=1823049180;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=2UDSRshdfMAn0ym0C1sfJVH+j5wJB2oVO9MnQt811hM=;
  b=hpkvYSKI/buH44x6Ci7sYoJjDfDR0IdyxnlcY5ILPEJyT5+UX1SdTR+9
   sMJuwwxdacL73+ZGdCcA9Q11Ss8V3L+b8zD4T6ydYBue+4gSvGTLRdXVC
   sz6I1K5ParscMbvVA7eAMNIeGRKobDeaoCwRwKAothXihCKsxXtJlnLjJ
   NuCIy+Jvw9hXNBebiqu9FrYQ9BU38ZgxU/dgmPpDnwofF/e9BsDL/Pxmv
   g8LJn4ZZTsE0Z0e8ygBCoHKPU0ABsekK4M87J+zEgzstaMDDtTikMwq7I
   h7pyFxv4CCo8ZJISPkAQaZ/wcCjni2N3U7Rr4OpgiyRhUC/QAEqJj5cGm
   Q==;
X-CSE-ConnectionGUID: G6yb9PYrSEOkBWkeidV2hw==
X-CSE-MsgGUID: 9JHGLhw/QQ2hKDGW+0/wAw==
X-IronPort-AV: E=Sophos;i="6.27,147,1786982400"; 
   d="scan'208";a="153453057"
Received: from h199-255-45-14.hgst.com (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2026 10:32:53 +0800
X-CSE-ConnectionGUID: jSP0JERyQeedQmPa73Qlwg==
X-CSE-MsgGUID: 4IjzLz8aQMmW8cbiFATyJQ==
IronPort-SDR: 6ac85255_h0zPl/7PwRnnovwio150Fl/4wvLqPTU6rLo+O39ngixD6sT
 8SkRAmI6/Y8l7cAHvgmf4jSZYs08Q9Hd3XHsBag==
Received: from uls-op-esai3-o.wdc.com ([10.248.3.41])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2026 19:32:53 -0700
X-CSE-ConnectionGUID: yZfagQLwRI2utQVE1jbW/w==
X-CSE-MsgGUID: vfbYjnG5Qam1uCF+jP6lYA==
Date: 08 Oct 2026 19:32:53 -0700
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai3-o.wdc.com with ESMTP; 08 Oct 2026 19:32:53 -0700
Content-Type: multipart/mixed; boundary="===============8888216248260521241=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e4fffa0bafa64446846b2a520cf8a96808da89c50cdf22606fbfc91048cb036@mailrelay.wdc.com>
In-Reply-To: <20260921132058.2091567-1-usama.arif@linux.dev>
References: <20260921132058.2091567-1-usama.arif@linux.dev>
Subject: Re: [PATCH v2] blk-cgroup: skip rstat flush for cgroups without blkgs
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============8888216248260521241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [v2] blk-cgroup: skip rstat flush for cgroups without blkgs
Patchwork:  https://patchwork.kernel.org/series/1170402/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/37647078673


Failed test cases: block/034



--===============8888216248260521241==--

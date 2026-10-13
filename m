Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213C52BE3C
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932598; cv=none; b=PwGXuvYYg3hEEN4rltScbVTXTumvoD7at0cVYwEvJ2jeeqU25caJb7Zd4NQdajtAnwrQi9gKWIm5ChaagUHhJbY2YCD4mLNorH2Ymhtjw0ohx6lUIrpHb7Tqo2FrgCzeKJH6IO+iMRMsWbRCWzLfxjKoahLWKHH0KvUp4kHiIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932598; c=relaxed/simple;
	bh=3f3HvxZbeQGjfrjgTKQGyLAbRby4CrdhQHmxw9RBQrM=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=MHo5+KIG1RJ/EANziUKK2k5ilZAPhsx5f+hQDBIs/xsC1uiMUutW0vJhs2JdMgan0Ouuc//7IaqkBnH63TuV8pesme1fcLxgIxh2Om+3c51M94tNKku/Nn707NrlKY3viA6IxzPrc7q5AIigAOQs+BVZ012yOM2IUMvMEEjTTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RpcDc5kf; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RpcDc5kf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791932597; x=1823468597;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=3f3HvxZbeQGjfrjgTKQGyLAbRby4CrdhQHmxw9RBQrM=;
  b=RpcDc5kfASUwN5BnJOnlM4TCOMLwdyrrBS+7pTMBse8Tt91Tpyyf/Daf
   8ecvZoVKbySZAYbnxMZzMs3EbFiLugmZnChI9wT95goZ49KPran5l9L+s
   zY6e3UW3QIrx2tjGyEu36khrBrO6l9UHB7HwuTjBfUAFeKDHyAq8anTR6
   SlA3j1Ac2Efbd2LHQRJygnD+oXhvZrMc1CtMcs3+ZZIhxgBGbCE8KXc5C
   Hltge5GixbP5TUotZpVw6ueJC7HKnH02e4j0QhMpnjwM2SEpHFODemMQf
   gBFmgSdGYBTjoZhmi5ytsYvI0ZDkw21IQkWhAClnTFKmcq3NoNGgVFR1T
   w==;
X-CSE-ConnectionGUID: +u5nYiYoQf+HneB+Ih36YQ==
X-CSE-MsgGUID: DulRbio+TpmXahDp9QXsxA==
X-IronPort-AV: E=Sophos;i="6.27,156,1786982400"; 
   d="scan'208";a="156421530"
Received: from h199-255-45-15.hgst.com (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2026 07:03:17 +0800
X-CSE-ConnectionGUID: P0FZy9vERqCHUJgHG3P83w==
X-CSE-MsgGUID: 4XaGv8U4QlGKqvujhgxjXA==
IronPort-SDR: 6aceb8b4_4ixx3ktdluVFdnlerOO7tJ97rswHj0KHWI78O+TcBqr0CLh
 oi0fmlg2p7MgyNBM7oIDcHKC35TIw+2BQJg5sDg==
Received: from uls-op-esai3-o.wdc.com ([10.248.3.41])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2026 16:03:16 -0700
X-CSE-ConnectionGUID: NZPnVAA/SIOWwom1xvNn6Q==
X-CSE-MsgGUID: XZusrfoJRP2QgdiS5p2Zyg==
Date: 13 Oct 2026 16:03:17 -0700
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai3-o.wdc.com with ESMTP; 13 Oct 2026 16:03:17 -0700
Content-Type: multipart/mixed; boundary="===============7536622329613070507=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <49a2d2f1d44a018dbe2a3da155b5fedea30cf98ea484bdc19da2f9cf97c4e0da@mailrelay.wdc.com>
In-Reply-To: <20261012-work-loop-change_fd-v1-1-3cf4ec349bbb@kernel.org>
References: <20261012-work-loop-change_fd-v1-1-3cf4ec349bbb@kernel.org>
Subject: Re: [PATCH] loop: remove support for swapping loop fds
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============7536622329613070507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       loop: remove support for swapping loop fds
Patchwork:  https://patchwork.kernel.org/series/1183887/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/38278109458


Failed test cases: loop/006



--===============7536622329613070507==--

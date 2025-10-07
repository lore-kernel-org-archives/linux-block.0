Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC82E7F27
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862911; cv=none; b=rPF4KJbgBbcWRV3isf94jsmZZyT9apkC2JtTbkIp8QFoUNHwJAVtOnuE8sDmwUduxiElsop4/QT4v0wj/w+XVuijEYJfYCOMbSSRWjX5ZHGAbFWUdhNjTKK/4Fu9/RhBWJp7RIQG0O72dSfdN81qvstsfLlhwgbPc2d1jd6kjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862911; c=relaxed/simple;
	bh=xXXHNreeWq3FHdEmNyZL6cJnDKzcaDwlkxuQXGnlC8U=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=BbkleGGm27rSngKWKTEaFtStgWB9k8CGwlbEc4gyGTKvZaaXVdCgtRJzFycBCxa9BmSjJW0N0/B9EtnwGW55s4oAGpurcTG2kZYDwMBHrQ/ZL80QgUEKoSrvrVHXgj9AbhG+ZfmnFKKA43fRyBqzqId7jyCOadiJNGryoegmnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KPgt4lIW; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KPgt4lIW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759862909; x=1791398909;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=xXXHNreeWq3FHdEmNyZL6cJnDKzcaDwlkxuQXGnlC8U=;
  b=KPgt4lIWkkeGCUHWNaAxoXf9eJQ6OoiWbBLvnNkkZdPydBNbkudq/cdw
   9Scdjtku/EOBjh/ROcWV5yskn6qtNv5Fs8EFJyuj7ZprJ+hH2693p/5iu
   WjUZLrWBzZgO4IXUHrMCM7iP38aazD559DdoKUABwxM4r6RYgENpczHKS
   isCCOQ1scaFpmDJnOENPoR2d68xYqMwbLb/+OIrHyU3ywkqenmVCfmOab
   wZL89bFCN2K/1afIYj00Bzo5FgisxSxyRiIyTxEE8N58xYihdTw9e5kWC
   n0brSllk6CEFaO3+13AnmrxO29/lsNlpE1S72viyVR96LTfAsOn/bZpT4
   g==;
X-CSE-ConnectionGUID: lFEbKtktQe2WCCTAUAvEzQ==
X-CSE-MsgGUID: 3i1TJPoISh6DTVetueCydg==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132648485"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2025 02:48:29 +0800
IronPort-SDR: 68e5607d_v3VIAX5AcHjTIOR3w7lBez+rSgPv1HftqgwltLByLydQhIB
 +fzAFp2AZQFgpYixQJPC30/OmGSKQMdi8E+4yQA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 11:48:29 -0700
Date: 07 Oct 2025 11:48:29 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2025 11:48:29 -0700
Content-Type: multipart/mixed; boundary="===============7656614369181123940=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1eca34a8a5bd6f4032035b92666e32f4c1cd9bf77becbf517cb85261b20fa3f0@mailrelay.wdc.com>
In-Reply-To: <20251007181205.228473-1-pedrodemargomes@gmail.com>
References: <20251007181205.228473-1-pedrodemargomes@gmail.com>
Subject: Re: [PATCH] loop: remove redundant __GFP_NOWARN flag
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============7656614369181123940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       loop: remove redundant __GFP_NOWARN flag
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1009147&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18322242115


No failure



--===============7656614369181123940==--

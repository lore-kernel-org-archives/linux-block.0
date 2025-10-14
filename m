Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A630FF24
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441218; cv=none; b=et5Jvo3O0exXvHvyFVZ8ETEjq2/O28j786/tRpR0Z+Ich3eN/+8CSHsfMQfOVl5vElhiFwwc4QYXTHOLHYfGxYdyLC21t6dJ7cQ+hfeTxgstxN4L40fLakCVNBs00GtR4OsADsagyDAkXTcxmIdosq/7TUDgQ1HwIEiP0jqBa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441218; c=relaxed/simple;
	bh=RX04lZA7cnPq4Su+qcbmjH3vqsm/DlyYGiGrBOnJHjA=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=mtXbxxQscphABfZhuLCSplLJB97+KbQ00rozUp/qNmGDRpz2X26imMXMWfq2hj0/iZ/jXdeEu7kiqKb+tXJ9oBQ6wEFg2gN+CG55KeWS7yJ+kSQZiuKkAVGWnP/4xB9IxZzfrXmkOQuHa+UiPfop43mpnjoA5njGMKFn0KWOdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ng+m3UWN; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ng+m3UWN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760441216; x=1791977216;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=RX04lZA7cnPq4Su+qcbmjH3vqsm/DlyYGiGrBOnJHjA=;
  b=ng+m3UWN2BQBvTX1XQgM8/xekUuIYaXPgh0RpI/Q2nYYOvxgYy+gAaQV
   MFx4he65z/G4P4jNDRTWS8UXawZlE4j6rY0Cnt/weIj71EWGkxBrbnUQy
   F0LUQTQLYTkhbi6ZkWbTLMcn9pGt4NrFvzsux3/Cf/xLTZnj11kXZCfrj
   ZmDR/DMhlJBhglwyIOwQbk6koFWBWzvxLvJ7vnElmgrsOeZ7Ov/3bGesR
   nHvM4KNI/muOmRr2SbCC2qrsf2KKqh1wcQPQUZIXXXVtypA4IUSaix0+I
   BpyoHE65w/+BoaTBud8lddCTKnJd0AQYA0nGcf5jx/lTdyirN3eV/bJuF
   A==;
X-CSE-ConnectionGUID: 9uGxlmx/QTGEnOVm2vIqIA==
X-CSE-MsgGUID: dZIYOpHUSWeRAodwixCILg==
X-IronPort-AV: E=Sophos;i="6.19,228,1754928000"; 
   d="scan'208";a="133078385"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 19:26:56 +0800
IronPort-SDR: 68ee3380_rorXSmiyN94qhQLytSzO22XRx+yVSD1Mrf7+qtJh1UvP2eb
 iT5VXsZakeICoXpmOBiazzlqqOQ63fJ7Oj5jnkQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2025 04:26:56 -0700
Date: 14 Oct 2025 04:26:55 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Oct 2025 04:26:55 -0700
Content-Type: multipart/mixed; boundary="===============1710410251409656615=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bc165392fe16366c431922bb4d76119f9597dfd4efdb14c1f169eeacabef0e3e@mailrelay.wdc.com>
In-Reply-To: <cover.1760369219.git.leon@kernel.org>
References: <cover.1760369219.git.leon@kernel.org>
Subject: Re: [PATCH 0/4] Properly take MMIO path
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============1710410251409656615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [0/4] Properly take MMIO path
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1010816&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18488572174


Failed test cases: nvme/005



--===============1710410251409656615==--

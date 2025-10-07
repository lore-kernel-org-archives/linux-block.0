Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B235972
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838022; cv=none; b=uW32yte9rrqVeeE1Kykq+a0PHnuxujZivorwHcxoM812c1oqOiuvLb82XAqeCqVBaiPtZR7pD1wGofp/5XzyNzE+4zup2ZAGZPMdsKleVOHt+UDbscoOeMtF8kjdXbDrgPWAZ4zvNcjzY+cH8ixzGr5kpEQsQydFx4h1s2dLzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838022; c=relaxed/simple;
	bh=OEH/q/HjcCEpXVt9oJ0GiqIfh/FJJ/RzPjbbBLRaM2M=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=U2k5QMIZw5zh71qoJVh8iNuGVCGA0pwHyXjSJ8Kps5colDxckQDrw2TFuGj0KWnS6y6EgzakR1urB57IG7b2AXom3wf4OcmQJVtBP25X9UAeC67gVMH480+NW00+8GArP67WmNYI44OX4hAL7DLGz+ZngcxxbUzidXnGd/SgAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=opLJc60I; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="opLJc60I"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759838020; x=1791374020;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=OEH/q/HjcCEpXVt9oJ0GiqIfh/FJJ/RzPjbbBLRaM2M=;
  b=opLJc60IeoQ5MIaI1rrKV0K3MMMpIp31lWZjFgjNol85gelg/TofIFMJ
   pztJOogu5Pr6ofg3KnN30ZGlNKJZ2iMlb6/OLgYwvNY/4LMYcdVG0HFIG
   F3Kid+UcbHp11pEINzZQWfp1I5B7FWqZ1COIkdv/Dze7TuezlyMTMwZWs
   5EQETkgWZMf9xG6krXs8I7p70Q9c+AfO3hX5GmQHQ7QWtfHVyHcPmIQQD
   nh7hQHV8cpIMgmDCL2yoZSG+81MdGaeceX050V71pfgAuIDHu23IdLcAQ
   TTB+DbTUiE0ej9r6v+1xnjgG7E6O+GSkH4cCqBpksh0WgrjAYt8PhEjeK
   Q==;
X-CSE-ConnectionGUID: 0XqVPJQdR8ufTU8LUxTtgA==
X-CSE-MsgGUID: R4XAC2YUTl+wAW6RqaEaBA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132743638"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 19:52:32 +0800
IronPort-SDR: 68e4ff00_9QesUhlEalihSNzY2xnwcAJrwD+XkUISF1YtqjEGgdspaB9
 XjS+Pg1OefAOezJYC/GkFbkltl/rkAEBvnh5mxQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 04:52:32 -0700
Date: 07 Oct 2025 04:52:32 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2025 04:52:32 -0700
Content-Type: multipart/mixed; boundary="===============7060421112220489450=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62966b69556552ffa80f605ffe4f75cf26aeac3d11bd4658dd31d6ee5e85fd15@mailrelay.wdc.com>
In-Reply-To: <418310b3-2b77-4534-b2fd-27dcc11e333c@kernel.dk>
References: <418310b3-2b77-4534-b2fd-27dcc11e333c@kernel.dk>
Subject: Re: [PATCH] sunvdc: fix -EIO issue due to lack of retries
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============7060421112220489450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       sunvdc: fix -EIO issue due to lack of retries
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1008721&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18285324490


No failure



--===============7060421112220489450==--

Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259E21ABDC
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861748; cv=none; b=FtyzAfWNFYunx4/emIw13COlbYYzwtUg7+yPFqS3BsiwUcjRY3lnVoBvrffgUmRV/B11dRaVeocp3oTlxmh+sW/JShP4YayJdIyLcaeu+0AckqlnKDAa/GvUN9C2sQ8gsx2x+P+obSvzNN/qkSBoEXCALsEnyQi0jj5d8vdo6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861748; c=relaxed/simple;
	bh=aH3c2gR5gkrxo2efuCv3PPuDZraGKTJymEtUMSI6ij0=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=TOXdd4Wbqz6xhtXpRCltZL0r7cEj1YznHHt00snKWsTgbLOWw9ZrpLK59HEROvxBEIJH+z5nr33almNL+FQoQ40XXKrAHDJbpjif/wT/h0Dqs4LdKqHQfs63tZid8mDA6U3OmgWX/ISpF3ITYyk4ac446LC09rShIAIPKyb7OmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KwUjPZsf; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KwUjPZsf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759861747; x=1791397747;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=aH3c2gR5gkrxo2efuCv3PPuDZraGKTJymEtUMSI6ij0=;
  b=KwUjPZsfPiRZ7877xW+UgJXLLKeXzlWfEgRALcv1W8AcCdNZWJCoYN7i
   0aKBlsfGaWAQne0WGwYvZ1TKDTyLoXR1ganwMoXRohc+w+bI+wtrmDS1R
   g1ishvnGAfbYCsCPgFJ5lRycCcTjcn4gETUpCt0r2jk/XStjbS1FyxjIE
   q+upDYR/RlDQHdZ743D1PGK25q4hTFfwSECU3XSh4kcRFxVq9MIFUgSWT
   YZ/1si0peNGEQecOGX9rR66WDb6oqEoPwI5oXEvU2wanlCJQ0JAyZBSdQ
   DEfEHNp9hiXIw3n5WBtXOTJercKn0BzaugEsoYaAuUhKdrpWUOURR0W77
   w==;
X-CSE-ConnectionGUID: TQOL7axyQZ6gtzpOCjD8cw==
X-CSE-MsgGUID: ZLyVUZZBTk2x5QFw6LgLRQ==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="133704437"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2025 02:29:07 +0800
IronPort-SDR: 68e55bf2_M9nZZ5eZyAxApp5s+Hss5T02gD6bWN2XsxIEWGArOBt+eWh
 oHNxOG2qtYmuiiMhfsRB1vT5t22Tr3isoSeaFaw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 11:29:07 -0700
Date: 07 Oct 2025 11:29:06 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Oct 2025 11:29:06 -0700
Content-Type: multipart/mixed; boundary="===============8515728400542976700=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e8d0cd981d7ca84536aef16c696edaba560e97a0bf41693686f9a88b0783c11@mailrelay.wdc.com>
In-Reply-To: <20251007175245.3898972-1-kbusch@meta.com>
References: <20251007175245.3898972-1-kbusch@meta.com>
Subject: Re: [PATCHv4 0/2] block+nvme: removing virtual boundary mask reliance
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============8515728400542976700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [PATCHv4,0/2] block+nvme: removing virtual boundary mask reliance
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1009141&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18321729743


No failure



--===============8515728400542976700==--

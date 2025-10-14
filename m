Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAA30FC31
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441246; cv=none; b=qCRF4CQl9iPw7MXJruKfQwoykeXffXokIYgSp9umn34O3O3a7Hg7PkHRr3zOx3Bzy3TyphFsNkMF/npY1ZMOuexmwRdxnraftBbLA91kvpKdAgERZs7FNf/wPcDVCyXm8ZlnGhDW4BI+6Pj9VVSYAN4a1LTYvEIAFSWqJlaBOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441246; c=relaxed/simple;
	bh=YSGTuctmrEelgnDBej/WxyoVvOahUvkOcxi4MD1rGVg=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=XmCaey8A1BoZoDMON5apdiln0oVsSk9lufko+KWM4ACalzQ3P+5HwAWCVPtWsn4gFQKp1syk52MZn6VrTXRdGbglqKy7Ek07V9h+yWSAnL52SI3S1ovYTiZwdPxJX0N//eYD6pR2JY6usazOdarIqfhQ0vzcmOWNuWDq3CcOryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r6R6p14D; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r6R6p14D"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760441244; x=1791977244;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=YSGTuctmrEelgnDBej/WxyoVvOahUvkOcxi4MD1rGVg=;
  b=r6R6p14DsrcV/6UsJhstFDAPji8myqyXkh2NYceCLvNNTerEgPtkDjJf
   GIhbhg0vFL1rzdSKlxbF5WvdYpmNEIXX9VRMO4aihCmmkiWZd/zT0JFs0
   SXB31Ypaxq47hEeYLOiCrITrjwayMOekLSPD0LzE1JliOjfidpjyLLap+
   /Cz0hQ1w72Cbxo9C83gq+R97LNIcPRWwveJJcJ0O5k0ZLwZU/Y2cnl0p6
   wtCgcHrOf2hELBXHqJEYIKUNvYCnOEqu0qNSKgonOxxaT/lAFpIGpswKO
   kUNY7abzp9jCAgdiEfjqyTK2ev4WuLdtrwBd5gaBfndTOrHgL65bWIU4m
   A==;
X-CSE-ConnectionGUID: ltT8h2H7Tra4Zk/CD9zgSA==
X-CSE-MsgGUID: wBDqPhZ9Sf28UEyL+XV1CA==
X-IronPort-AV: E=Sophos;i="6.19,228,1754928000"; 
   d="scan'208";a="133187096"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 19:27:23 +0800
IronPort-SDR: 68ee339b_mJ1EOvY7N+bUXO9fEpMryLy0xZJkyhR1DPZqyCcA108hEM4
 92hC9FJL/FDDgV/yX0x3uU0htJ+TKHbjub9v35A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2025 04:27:23 -0700
Date: 14 Oct 2025 04:27:23 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Oct 2025 04:27:23 -0700
Content-Type: multipart/mixed; boundary="===============2576719401713814780=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <720e46cccdc88a111ba7e93c9de457ed20d7a8fedef8852db292adb63d114d4b@mailrelay.wdc.com>
In-Reply-To: <20251013203146.10162-1-frederic@kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
Subject: Re: [PATCH 00/33 v3] cpuset/isolation: Honour kthreads preferred affinity
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============2576719401713814780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [00/33,v3] cpuset/isolation: Honour kthreads preferred affinity
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1010948&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18488587693


Failed test cases: nvme/005



--===============2576719401713814780==--

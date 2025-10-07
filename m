Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD92DC789
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838331; cv=none; b=lLqNOpRiDXUNvTn7Huz4p2m/yuH7bsOkVWGQqk5Yoa0qDWOOE5Xj8WilxM77lfXei4NDV9M5K96j/a+87K9758Fd16HAXlRBW3eZ0vhhMLT8ZM/uNyTokN7SvBqZPAPo9+8gMwD4ux6w5jRggwdfxGh9t04OV3eJ65sZLs9IdQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838331; c=relaxed/simple;
	bh=tG/uH/McMWnhyAikgXQmgbJj7Qz+St7aveJaXybFpBU=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=i8kqXxSFH5APkPEaDIJtVuBLi0EwPuBbA/cGuqtJbuUPq0EeSFeh4wNNjjme7TAAFNRb77nb/7id/QIDpJi9cwRqnpRoVGjpmVlgt8DUXo1wQQR4HA72oJJF03lwyGmOHzoDkf1caLOAEKHRmFSFlQq5n0Se+zEY3V8mJpOk09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bNNcMRzD; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bNNcMRzD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759838329; x=1791374329;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=tG/uH/McMWnhyAikgXQmgbJj7Qz+St7aveJaXybFpBU=;
  b=bNNcMRzDa+RWbxo+LJuHh6UTTd07Ly5HWYUIse4dTgyuhA6wWjHYu8GP
   hSkweYMiMDMILRTHO4ofIfO0kePV2HB9TiJSQem8/KB1R0nMU6KWqF1Dt
   9JqXG7kgotpt1WfK5wU+Rb/WTGYhVTNG5tuAc1DpKTs2k/GZtOQGgeXcU
   8bS+ldqKB6tppP9u9DRHy9UKbHmHn4ZkP7cepncgvGBr+PbFu+JieqjIg
   uFSE3bIL/yLRuRsjS9FRAK/MJic2NntbLQpl2p+5W+CXjHz4YJ0Ic14Ud
   zgE/nVVCqJYXPurHLhHDJ9bC5GBnhuWAvvoSiATNG4A9yaOWIcbOMjTyJ
   g==;
X-CSE-ConnectionGUID: 8h2ieRd8TlySVv4i+FwisQ==
X-CSE-MsgGUID: dmo/cBXATsWB8NnI5z0paA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132420145"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 19:57:40 +0800
IronPort-SDR: 68e50034_sFA6T679T7ieBuHNLx6OxsU84zgYMmpKG6YsNvlXMZ0WP1F
 FLNTNpdcpp42cTcbo/RKxJFUS01AKSLyw2xbcgw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 04:57:41 -0700
Date: 07 Oct 2025 04:57:40 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Oct 2025 04:57:40 -0700
Content-Type: multipart/mixed; boundary="===============0213381295277237563=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2daafdb7aa00cc3b007e68ba146ba7ded2a2f7ca77422111d0f81eca6c751436@mailrelay.wdc.com>
In-Reply-To: <20251007090642.3251548-5-hch@lst.de>
References: <20251007090642.3251548-5-hch@lst.de>
Subject: Re: [PATCH 4/4] block: move bio_iov_iter_get_bdev_pages to block/fops.c
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============0213381295277237563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [4/4] block: move bio_iov_iter_get_bdev_pages to block/fops.c
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1008963&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18307874888


No failure



--===============0213381295277237563==--

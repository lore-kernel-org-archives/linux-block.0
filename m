Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64339FD9
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838295; cv=none; b=tcwexxjkZ0VztJsPyFP9ed1sEUYdZpqv0AeejRARWc2z8tb/0mZVPAbZEhHWrw/5PcgKTiuVE9D9a4WjdQaY45fFpiB43XjKTR5U8B67OZ5O+2SrKkJsoUiINaluzB4YF3dosIsOaIMCGZmwoK7vp6CrB10sloTzVDtjyL//Vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838295; c=relaxed/simple;
	bh=CbeFt6TnMZw2hsKFbNmStXxPbMWTwYCtbFI3N9oTPG8=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=L07zeMOMH1ogU3M+3+3lEqGkVFQsV9Pdws/Yb81/7264XE06/Jcq6yFbC2n5iajBunc8UjK4Vgvt+YSbH8bxeB/f7u3qIikjJQAQPJsMB5q08hbPkCsf8RLAg5di4uwKgBmTt90QU2JlXCYKBvpfJbdw9mHau7fLvYN4d1rh86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oEdFdSeU; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oEdFdSeU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759838294; x=1791374294;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=CbeFt6TnMZw2hsKFbNmStXxPbMWTwYCtbFI3N9oTPG8=;
  b=oEdFdSeUDCAAqKk7aMX0OBnQVIUkJePby3IyBpRg7rbn0oyhWcdU9+bD
   hx0DfuBZ9u2lQpRkx3Gn8eOqhYvkF/dSosh92G+MF7YDLqmNOa0Mvln5R
   sRxvhbmZo/iyArrSUX2RlaAv9LHtaqSLhxykGEeLoXtXCkXiuuPKDEa9J
   9wgLvhJwm/jksWyVdKF+esj1hZVEmxyibnDtQFPvQ8vmgNprHXOluq7E7
   9ZL6eiyWB5e23QhqcsxGmRJH1MBvPrKSrAI3wA4cE2NJAu0tkPJO3r5vp
   /ux74ZDLKL8cwvKQPUP7OmkYYPcv7u6oWTQg4W7+nsAXQXIuf+6kZ2Z5s
   A==;
X-CSE-ConnectionGUID: x7SXNG3AQiG3fAf6w0GmEQ==
X-CSE-MsgGUID: TvLwsj1TTN+kqztIsBGfRg==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132743807"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 19:58:13 +0800
IronPort-SDR: 68e50055_XW+OxwsXfe0bh1S9e6LFmQZe66Yx+INEn3GRWjpZ5ZQu3fr
 cwwnqyd8R1cMSVoe4nVZGVrxiHMBko/jbgMpoNw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 04:58:14 -0700
Date: 07 Oct 2025 04:58:13 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2025 04:58:13 -0700
Content-Type: multipart/mixed; boundary="===============0260743180542730483=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2e42d6bc2dd8011caa2fc7fb8d5d49ecc2a42afb0a61656f316eb6a288b21eb3@mailrelay.wdc.com>
In-Reply-To: <20251006130542.3174-2-glaubitz@physik.fu-berlin.de>
References: <20251006130542.3174-2-glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v3] Revert "sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN"
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============0260743180542730483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [v3] Revert "sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN"
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1008688&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18282059850


No failure



--===============0260743180542730483==--

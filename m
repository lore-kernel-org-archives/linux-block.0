Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B29408624
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687247; cv=none; b=TFMbxgNNsNRtOVDHTIPa1qlnv2JI8+z7p1Y0f++6/BCkzNWc66wRveXBf6WCsjHAhWFj6gfOAb3D06aloV4OqGRxylVHGCaR+4+qeC24OMJRjOJLNJkqCKwRwY9iwz9B06Fl9dooEjYUUDyKQO3FxBT/fAkIhx2fo3xsz6ATLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687247; c=relaxed/simple;
	bh=rR/fg73jIYCXU/rAVYvRrSONDY20SEpG5jSon+xqKU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajxyFON57gM1lOnMiGju8Z0Aqs45+GRjP8wojVkCRuuNeyUGbnOioF1TFuqDonFrT6dW/UsMd0OC/umAtVZnD0I4JyDI78Ca8BoFdzAOLleXXvlZ/Yb647KRvJpmDfpwPJbGw7z/7S9jkVW6y/HZGOKNUoaHXmnN/GeoIe1KK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tk3jMojt; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tk3jMojt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783687246; x=1815223246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rR/fg73jIYCXU/rAVYvRrSONDY20SEpG5jSon+xqKU4=;
  b=Tk3jMojt0MU2ajM5jPm/1tzdrBPQQ1oV1y8wrQgi1qeejQQjZcA6zpqX
   PWTqRwoKK8HWxsshOAGRgINHQD8nkXfxFMkMg8A4TUnKavAqtY11XYZhh
   dHnr2fzeVU2HaRlYpEP+smL+dro1gpLdgs2Ne/ZkunAm7Oqno/zmCNmUr
   XCxUjYR6BYGabROLpwCZ51r/qM3i0Na5o/+WRuHf67N7+L8MDeKVI5Fo9
   X9eBmpaj3vYzSMbSjba5EsmVQ+ceCJ4l15gN4PcZjEzr0ZvP+6IQJQ6cs
   hDx18zGWO1fQZYeP3C1smyq86wcKVWOkeuYRGmP+oG/g2jDDs5X5Xe5kE
   g==;
X-CSE-ConnectionGUID: l8we0fKSQ8eneDlYRKhJ6w==
X-CSE-MsgGUID: f1G/A9HtSvWtaPUYDiRBnA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23427860"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:40:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:20383]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525] with esmtp (Farcaster)
 id d3536e9c-303d-4039-ade3-04aff470219f; Fri, 10 Jul 2026 12:40:43 +0000 (UTC)
X-Farcaster-Flow-ID: d3536e9c-303d-4039-ade3-04aff470219f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 10 Jul 2026 12:40:43 +0000
Received: from dev-dsk-connordw-1a-43da851f.eu-west-1.amazon.com
 (172.19.98.255) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Fri, 10 Jul 2026
 12:40:42 +0000
From: Connor Williamson <connordw@amazon.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove redundant GD_NEED_PART_SCAN in add_disk_final()
Date: Fri, 10 Jul 2026 12:40:38 +0000
Message-ID: <20260710124038.95584-1-connordw@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615130715.53693-1-connordw@amazon.com>
References: <20260615130715.53693-1-connordw@amazon.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Jens,

Have you had a chance to look at this patch?

Thanks,
Connor


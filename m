Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29495277037;
	Mon, 24 Nov 2025 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763949801; cv=none; b=M8UTMmiXTlbP2M+6IW2kOPv9fyd5GwufVBf+oatAGW6KUZB/4/yLFHSdpJthE0lhzatUxw/EuhhBfkluG16dEwq/ItWDaVTDoaE97e2rjtp/c8hDSG5CZtlyoLP6+RLpOQRmDjlFaBQRyGvTruPNkA29FWM+k5etR+8OpwMC220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763949801; c=relaxed/simple;
	bh=Du8TDVSR3uXaRMIul2rK/XAvTiHr00/eQ89wxlkyQO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7XkiJe57Q5ukBWT3CnyDZbaTbANTZgDMb6kCdCNMs2pSol/lua0r5tn6u6/h5P4tWxj3KlJkpZdtg/arbN0qKMMVivaOROEy4kwkjjwvCd+FAZCD0iwgcBe1cPvTrOnu9DOTXFuri8JOqLI3yIqmoO+Y1tcgSRWcnpu7quhrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4dF8D019sfzB9bJb;
	Mon, 24 Nov 2025 10:00:16 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Mon, 24 Nov 2025 10:03:08 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <axboe@kernel.dk>, <hch@infradead.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kch@nvidia.com>, <stone.xulei@xfusion.com>, <chenjialong@xfusion.com>,
	shechenglong <shechenglong@xfusion.com>
Subject: [RESEND PATCH v2 0/1] block: fix typos in comments and strings in blk-core
Date: Mon, 24 Nov 2025 10:02:57 +0800
Message-ID: <20251124020258.1022-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20251104123500.1330-2-shechenglong@xfusion.com>
References: <20251104123500.1330-2-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03047.xfusion.com (10.32.141.63) To
 wuxpheds03048.xfusion.com (10.32.143.30)

> This now adds an overly long line.

Hi Christoph,

Thank you for your review and feedback.I've fixed the overly long line
by splitting it as you suggested.

shechenglong (1):
  block: fix typos in comments and strings in blk-core

 block/blk-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.33.0


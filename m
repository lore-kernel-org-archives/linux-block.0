Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8362E5438;
	Tue,  4 Nov 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259726; cv=none; b=le9Q+R7ocJnq0bC455jqPq0CIEKDNOHjSmpihvjWVCZrt/AEMscF96t3RF5zU4w6946n9fNUm3IoRQTOQXmwcmaBD1zfj9wDrA8kxXLkcCbto36lz+HsXpoOft0dYF7APy6SSZd9n8gIl/tMvS9YxiIIbpbfLRYgihxnQbxRZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259726; c=relaxed/simple;
	bh=Du8TDVSR3uXaRMIul2rK/XAvTiHr00/eQ89wxlkyQO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzTKchW7HjVe7t4a7aZLPjTVIbZIMT572Tr1zTC9qmUn+yBN6G7OvqmHrn1vxcVCWGdmwwMSucP032KlZEVSvVRmGZwJJyOZfdh/rKKvch0fXjjpcyEIIZ/lPYV0SKdcSygEPiqAuP1mqz1x34ix5rTUSTKZOqep7v2PxgXeJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4d17F261HjzBBvWL;
	Tue,  4 Nov 2025 20:34:30 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Tue, 4 Nov 2025 20:35:11 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <hch@infradead.org>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>, shechenglong
	<shechenglong@xfusion.com>
Subject: [PATCH v2 0/1] block: fix typos in comments and strings in blk-core
Date: Tue, 4 Nov 2025 20:34:59 +0800
Message-ID: <20251104123500.1330-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <aQneZipPwoRsoeeA@infradead.org>
References: <aQneZipPwoRsoeeA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03048.xfusion.com (10.32.143.30) To
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


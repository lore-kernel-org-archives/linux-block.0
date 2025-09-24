Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C66158DAC
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695226; cv=none; b=n1Z4i25eyDvZdT0XoyzTHmphz6LOwUNX97uD0Tb8IkARLlZ5woFVTML5vVqXEqB3ngZ1dxZoZkvnnAzjo1TCKQzHzwuwJB7CQSsUcNP16bXEG5/zKsf9WeGvb3tfrSLRfF+2cJsFpJZhgvCS1QHBOimJVFy0o/Li4SnDw6jAbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695226; c=relaxed/simple;
	bh=CtDoVNuCt2dgjEBklHk/vS3W8nz/d1Lb9H3rcbN2X/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=CoSMijWk5qEQK+mk1wBVW47PyOkT1xPyqA0meuQUvFl+dzkz5/3BXVYPccLco7f1audjs/9ix6fGNf+mfF4xyfW8JuFlZdHxvNoS6zKMNdJ26BHW7WTWpS3wsVPNHuqNpWIY0mSEgKQTIOMwkTJWEf/5++FB5rxPfgqtUFGr3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U0klF5SM; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U0klF5SM"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250924062701epoutp040b69665f69dab5efcc7db7936e83d404~oI-yGEPyk2299422994epoutp04V
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 06:27:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250924062701epoutp040b69665f69dab5efcc7db7936e83d404~oI-yGEPyk2299422994epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758695222;
	bh=tFiz2qKymegCmU3KAJXS92gA8qxJpSW/XCaFAqkGYJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0klF5SMRVTVTKS6CVdeLUbdYZMMgwiLyLtJyOjLlwHwzi5PXA4bc8BWLA79JhCD8
	 zH1leWPRKhoJoO5vSO3ZagVGqPSSYTysvrAq+6kKyRjxZN9HKZOZ3hJqWOCXRuBlFe
	 RGyfRP3h9YpPlspiF509vxVTmWKPgH8kkw2gO6Vk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250924062701epcas5p3274ca705441ec4d046da3ef775f71d62~oI-xnpNfO0263202632epcas5p3Y;
	Wed, 24 Sep 2025 06:27:01 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cWn1w2rYrz3hhT8; Wed, 24 Sep
	2025 06:27:00 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250924053907epcas5p10c550389234cb8feff8e5625d1d3d2a1~oIV9KP83-1605616056epcas5p1e;
	Wed, 24 Sep 2025 05:39:07 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250924053907epsmtip297dd6d82a24a96f46bb8aa8dd6891ad7~oIV8oZcGs1377713777epsmtip2G;
	Wed, 24 Sep 2025 05:39:06 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: akpm@linux-foundation.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
Date: Wed, 24 Sep 2025 05:34:36 +0000
Message-Id: <20250924053436.10919-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918075511.8197-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250924053907epcas5p10c550389234cb8feff8e5625d1d3d2a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250924053907epcas5p10c550389234cb8feff8e5625d1d3d2a1
References: <20250918075511.8197-1-xue01.he@samsung.com>
	<CGME20250924053907epcas5p10c550389234cb8feff8e5625d1d3d2a1@epcas5p1.samsung.com>

>+		if (val == (1UL << (map_depth - 1)) - 1) {
>+			if (!sbitmap_deferred_clear(map, map_depth, 0, 0))
>+				goto next;
>+		}
> 
> 		nr = find_first_zero_bit(&val, map_depth);
> 		if (nr + nr_tags <= map_depth) {

Hi, just a kindly ping...

Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01432313530
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457620; cv=none; b=eZz4xKQwsq+jqemVz3H7CZwNoUGqtVpnlUs+stu9A1eUPBYnDDvVxVNUlTAw+UlkRvJvMqmKnSTHOYyKJyG12NBcaogSvpXW9SoY20oPvhTh9eL5VkAmLG00xwXrzqT8eUb9N7tFZ9WW9hyp03ET+k9H/GFFhgd5fOUSWMXPrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457620; c=relaxed/simple;
	bh=C0Q7qF9E1LpKOgGd7xBp3qMorrebg2wkrsHauplX3Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=mOVm8SREYbkOuVP4DjO6Cip82kwr5puMrfiFsCgGDNC01oauER6Cs3Ap/EuxQS/UzqXtanNxn9Rod0JfsEhq31mfIDc35VOh5pYmJ/wHOX+kglT6ZN9OLlFeVlfkvV2WAgLcSL2nfQz3jWzG0TDb9ugW+CtRO+7lMfGvuZfoKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y8nUOZMz; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y8nUOZMz"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251118092014epoutp04d9992896a4f12046cca85a940cb3c6b3~5D1tyYkpJ1969619696epoutp04V
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 09:20:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251118092014epoutp04d9992896a4f12046cca85a940cb3c6b3~5D1tyYkpJ1969619696epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763457614;
	bh=C0Q7qF9E1LpKOgGd7xBp3qMorrebg2wkrsHauplX3Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8nUOZMzaalxLC1/euc4VPj1R75QCRprLbkj31A2N8kMv73aWLJmdIGKuTiCOkm38
	 WzuZIWWgUYfV01BFVcjpPSgvH8kue4GlspMm+LeKPqlzLEucua4gh+dGKM5skbjTJj
	 XDXkYU9hLWmhFoq/YLDti0GGqADC7Q+cccKjJlI8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251118092014epcas5p420878cbfe5f956002da64d80d8d94dc7~5D1tYgfGs1716017160epcas5p4B;
	Tue, 18 Nov 2025 09:20:14 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d9fGP4x85z3hhT3; Tue, 18 Nov
	2025 09:20:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251118084423epcas5p30acae09ecb0f5d6baea59f2a866abdbc~5DWaEYTTR0588205882epcas5p3U;
	Tue, 18 Nov 2025 08:44:23 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251118084422epsmtip2c72c88944df9a4e273d874f9df3bdc0a~5DWZbZsxV3227032270epsmtip2j;
	Tue, 18 Nov 2025 08:44:22 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: akpm@linux-foundation.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: Re: [PATCH] lib/sbitmap: add an helper of sbitmap_find_bits_in_word
Date: Tue, 18 Nov 2025 08:39:46 +0000
Message-Id: <20251118083946.262032-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107054243.42628-1-xue01.he@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251118084423epcas5p30acae09ecb0f5d6baea59f2a866abdbc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251118084423epcas5p30acae09ecb0f5d6baea59f2a866abdbc
References: <20251107054243.42628-1-xue01.he@samsung.com>
	<CGME20251118084423epcas5p30acae09ecb0f5d6baea59f2a866abdbc@epcas5p3.samsung.com>

Hi, any comments here...?

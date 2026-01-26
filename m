Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42822A4EB
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451706; cv=none; b=dFnmGI9TO9xwIMBHM2zJAUfVrHyWDwTaGEaAvs/MizWAnP6rcbHlY8cHHkajkQVpgnfhYhO7mVSlAy2KN9HBd1xx6JV1G14cK8Wzp7tMmiPW7NaU3M8BAVZFyez+RDxF23oEP2/a6nj+Iq/EuGSNN2b9O7u4kGvY4WGCHLW3w2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451706; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rAOC91GOYo7q8SZzWHMX82SILYxNu03+/jDLeCiho14PHIUZUfXuHKE6oeV6pY/6NYj7p+EEXwzsyFh0bIYq2SPncabz1jXaS+yPLQmj7+ZOKAmYwuYSQzvhGiY8OZ4arLnKuhaWvgMaxwwGmVFJeYhxVyZsmVOlniEkbWPuocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ASe3WSOH; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ASe3WSOH"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260126182140epoutp0487023a27540a27d03111a3c9880013a4~OWvJem0uU2067720677epoutp04z
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 18:21:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260126182140epoutp0487023a27540a27d03111a3c9880013a4~OWvJem0uU2067720677epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769451700;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ASe3WSOHYehyjCbK0x/X6/k1XoD63oPAhIKhFt184mioE8PmfvPbrY83Y1cbA0eUn
	 VGZT70pbTlskGdIMUkF+Fm/kSFSPMOzQ+VsT2/CR+QH6WHtq1GMrnxtB5RFQMfnRgK
	 NTrvE9/TXa5xXAo7SMAT2n5ApCL1gQ83cN33pXoU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260126182140epcas5p4b0dd85ffbca8bbbee5b8cbf577c38703~OWvI97B0a2924229242epcas5p4p;
	Mon, 26 Jan 2026 18:21:40 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4f0H1H2lr4z6B9m4; Mon, 26 Jan
	2026 18:21:39 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260126182138epcas5p39bc22dfb15187c2e4bc1a9d8f982ccfb~OWvHol_vO2156921569epcas5p33;
	Mon, 26 Jan 2026 18:21:38 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260126182136epsmtip2a827c5688c88af924cac2c500140ec58~OWvF8rlJf1201112011epsmtip2J;
	Mon, 26 Jan 2026 18:21:36 +0000 (GMT)
Message-ID: <a73770f9-46e6-483a-9869-1239eba04d2f@samsung.com>
Date: Mon, 26 Jan 2026 23:51:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove bio_last_bvec_all
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260126162724.1864652-1-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260126182138epcas5p39bc22dfb15187c2e4bc1a9d8f982ccfb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260126162956epcas5p4a1bf26f1c991f84e0a76ad7a04498ebe
References: <CGME20260126162956epcas5p4a1bf26f1c991f84e0a76ad7a04498ebe@epcas5p4.samsung.com>
	<20260126162724.1864652-1-kbusch@meta.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

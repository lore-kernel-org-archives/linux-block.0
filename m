Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491681;
	b=IJND0XSYDAnPfAjCpvZauU02wUGXVmxNxCLHq9EXy+AKzzh9QLmPTqeKMGu3/N4YtTg5
	 zCs+30bwMf6zTE0Fvo9eQ93qGjtEwj7C5eQnW93q8unBLbZudc6/Do+e6sKYvs34DbdHV
	 Mzv7fmRorsg3qz/tZrC8sEQVEeRD5tzQ4hUcRRc03sRcqoCK109cN9KiUi2wPz1Jyzdiy
	 iK6wrpHLGPSZsQLEFm1XZUoYXhh5VptM3V73fnpnSuCB/cYTHsn6My8SLe1Lval8K8/Xk
	 6qf8dPqT/Z3Liaagyz1whXp46HhliZRIncSgaZh3xmhZOre8DlS3dgjDOqk04ezUlqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491681;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=NpswCMotmQ4zyRRSJBvk2RuTb90oC2OlBSqTVTRXMLRGtMmUp7zaxLVm0XGM/B1yAQ7o
	 rH3X7T5eZnB9QsL6U1nenAaRBXbcUtGUOxlUN91nB+bZnJZTEw9usuCsOcRx9yOW6HzYi
	 tKSeMCdTOG/TMpYNiBSOOoTqCLMyWr+QslEfBwOmxi8K3sDW7A0ZNPjSDcVTC438J4OGp
	 TclvFYm7SZ62qW3lngH2Mx2eT0egm5tktHk+V/gzFwg5xcqjPXWnL0jsqEHO4sjTuUYly
	 Vek3rasr6yn53d0/JI+yFhWaOrrcEO5vd3C8gtacHF3HxwdAr3ulp7bUzVqZltDsMIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9C606A323;
	Thu, 12 Nov 2026 13:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E9C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0175C68D05; Thu, 12 Nov 2026 14:54:37 +0100 (CET)
Date: Thu, 12 Nov 2026 14:54:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v4 3/3] Documentation: block: document error injection delay
 feature
Message-ID: <20261112135437.GC24065@lst.de>
References: <20261111215838.103356-1-haris.iqbal@linux.dev> <20261111215838.103356-4-haris.iqbal@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111215838.103356-4-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


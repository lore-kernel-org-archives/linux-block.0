Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693480;
	b=N3MdWtPEyCuDxUedCDX6TQwVBj6SW/LeRlE9tQjj57a+73Fzqlp8Fh0ANSg+KyVnalrf
	 t+xumaiAjI/lM26Yr59XzqOPVhQrH+exKNgc+Wd/0CeC2vYk5D1mB5FrVD6eX5enCEpb/
	 DRCUDGI9tQsHvrMWnl4mWDZnMf27GzGW3KvVrejB5zcDURBNLPKPo9AusCDQPFP3KI3WW
	 3x0Pupy5FbvttI9G+6ybPfkthcxRVKEBQ1ETeqQsAxS8IPCvfvub4yKdP3R8WtW9Q2NK2
	 /Znc7al/XH4Fq92X7UE4XDl/S+6RXMQfLCMsKemTmtLcG945qO3vUpJ6j81rw6MbSqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693480;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=tBkGuLA5F2sq/7xbxeyAdTHIoWQvqGkLsNR9mnQWoDwJLIApQMNzXpkW086QUmjBfxFI
	 qgOODDNavuAETgpbEn/Nb/x5OoMGPewo38ulQ+GVkA8NDDU7d6yCgRqFAbvWzqlghnaIl
	 f9qAVqsfYYMk2W+UE/Qw7fG2iQNw7hr0mrfo+x8B1twZGrABbGmuMjQJUXDfrWdb9SntK
	 qk6BTNhkrOgX9u2b2K+BiguLwuVYhIrI9937iHGv/heo7hNwNohKzttCb3DgcWUd1uqmJ
	 jfzC6eHq6ZvqBx/OeRVnxMJcDMpA5wDr/W15Kh4nHCLZmrsiDd8JK3mCGIAc0xlIVrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C02606A324;
	Tue,  3 Nov 2026 08:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C02606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C05168BEB; Tue,  3 Nov 2026 09:11:16 +0100 (CET)
Date: Tue, 3 Nov 2026 09:11:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2] nvme: remove namespaces in parallel
Message-ID: <20261103081116.GA4301@lst.de>
References: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
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
In-Reply-To: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

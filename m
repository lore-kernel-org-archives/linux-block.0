Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285125B0AB
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557851; cv=none; b=hEDB26hEualEND3Qfyxsuax3Ksu3TnsZG2RCSJwKjZje9L3LSzFWrubqPcilqhg5Ww5gNQVGbnIu9qKXglCAkkUhq28tgyChRmPUE9qo1/lzTHvUm56o1B7LcxGkydcQuYlrIE1nc+c6j9Puap9jU7UJjhmq3D3Ruv1Tdmy1tkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557851; c=relaxed/simple;
	bh=10aN/Ry7QwOTOnvVS5PMuJNqG1TnpT1rqrJ5nSE+Sdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1Hp9gZm+5/5ohzlSU0ouVXG99kUuoVSO53apwBW0ex4hQOe06/eNx/CQE4x5wIapubdWf6hJZmeJa5/i0NEetFgi9LIASddLaRktrNVJ1q8K24rfpn69/slkI88OO+sUZqtCtMinYcICqDUydUZASt3ly8sRgFa5xjFsTel3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8CEA368C4E; Mon, 24 Aug 2026 09:50:44 +0200 (CEST)
Date: Mon, 24 Aug 2026 09:50:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Li Zhijian <lizhijian@fujitsu.com>,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH blktests] block/{029,030,031}: relicense from GPL-2.0
 to GPL-3.0+
Message-ID: <20260824075044.GA32710@lst.de>
References: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Acked-by: Christoph Hellwig <hch@lst.de>

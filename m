Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556333AA4E1
	for <linux-block@vger.kernel.org>; Wed,  8 Jul 2026 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497988; cv=none; b=VKMudd0MUiHC70QWGp87zh7Mt4madYf6xO3VSMXdbpOA8FxvkVQiCxzg78KAlwPNPqOOCdf30CYLXhnz9uldNsWVKdltJ9sKJA/TOvsSyZykIhy+wTfG+FCvAdfBnNjPhX8QCxwoGozMl8fkqgqT3F1Ya7bBiNzNlMRbNa2XzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497988; c=relaxed/simple;
	bh=REc4zJDzzZir7c9NwoqSmmJEmxJSGYt18dl1PP1dAAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOmWu6qIi9MQn3Gvfs7lYJcICT7ZzLxydLjcBSwfrhmlkRhoVyjKaph82Kfw3RWkli450KQJtava659Am/DyYGvaDDy7WvWh4gSW3dOtY0iDrEoEnsthJsnBcQigfb21JmlNaQufU/W1tH/pYMqOXIH5E9yrssyI+QLHl9LY0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0698C68B05; Wed,  8 Jul 2026 10:06:17 +0200 (CEST)
Date: Wed, 8 Jul 2026 10:06:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Li Zhijian <lizhijian@fujitsu.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	John Pittman <jpittman@redhat.com>
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
Message-ID: <20260708080616.GA1198@lst.de>
References: <akyeX0hlcrnOC0nT@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akyeX0hlcrnOC0nT@shinmob>
User-Agent: Mutt/1.5.17 (2007-11-01)

As a contributor I'm fine with all the specified options.


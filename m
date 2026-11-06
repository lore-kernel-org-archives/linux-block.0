Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981439;
	b=q9H6QBI85WCq9WxEbOJK+tMA6/fRNqsRAvxYyx6wL19i7bz5NFxxBiffoVZWNZdScAbr
	 fTD1q2rjnl+ezjDjHUbC2PCrB/VKvaoz3QK/LdaEtaVYq9Inn8be4FiIs7rpA40Ccdyvd
	 Ey4BAyYgKE3pyy+UkhlA3+buP66Hscy3dsEB9YB1SGU5bWv5SB8vRKLinnED0TZqhNnzB
	 /x4zk/5TR1BtFwxifT6PdTedL7MjEqs4aSgPYBmKqr46NcREdai5bFKK/IVxNOH1tsC9J
	 quJe/5hpXFtmQ0vAenLCdMX/0uqmymYi+h7U/F96gPdMAt7Gh0NZ/TAU4k6OWagdfVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981439;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=C/tYE/cS2pUzT3ikhsWcozhvxTKW+aM33C5bzTIW5TNU/1+AFOAsBvUEgiTEm+jjgKsT
	 84AU5cW/Ff2FBxQmexEsk02PJ897Hs5fZrsnl35ZcMzwH8p5Wue5xlEBOr5DnspnC9GIz
	 69BGq629ivWhGWJnWBJqN9hNsM6/tP257QjHPnSjp0HM1fqOpGQ3uzBvxszuGAX4BISbC
	 ZIindiURYi+tHWLVU7BJW/VmNm9c2OF1Oz5xMcT6bBG8bP1QwzdDb3f7l/TQR7CI/NAkN
	 LKlR2Pc5OstrYN7+PUv1hJJMtiOOL/y7yhDoGOdYfuhk/qsudCVPKNAk8pPWQHXFxpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D35606A326;
	Fri,  6 Nov 2026 16:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D35606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5BD2368BEB; Fri,  6 Nov 2026 17:10:34 +0100 (CET)
Date: Fri, 6 Nov 2026 17:10:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Changyul Lee <lcy8047@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zloop: remove the device ID after del_gendisk()
Message-ID: <20261106161034.GA9701@lst.de>
References: <20261106160638.2385495-1-lcy8047@gmail.com>
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
In-Reply-To: <20261106160638.2385495-1-lcy8047@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


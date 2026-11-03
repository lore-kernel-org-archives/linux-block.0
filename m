Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683893;
	b=O36aEYkv47+Rcb+FCWJDe/qxai4Xdo6t+QdKPEAkhu4380Dub0bfGU4qTRBE1CmUzxvJ
	 +k9Tj6s3zXg3GtsSuMeyCuc1jHXbpyFsChYE3GRWdBNt7/06TfJcLz8fRxGTj56mHHcHF
	 xk2xamfWjM99ot7F2GqSfC7CX014MLJzAZtS7OXKwRQj4hk0szGwN4X6LMWp8Oc+/sw5C
	 VC73wJUohyQa+qlvcgxMP+fF/nojTACxs2nKq9peaY5gu/6vRS1jr35uB9ZE+O4SPHAN7
	 BYwIO3OBl4yL3jtj5Pu5jBKHD8zk30iQ9uXRBgDE+uB8T2xx5ut3wFS69KbZb00BO2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683893;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=1jYMASp2DQ8PgxtaIq6J4n0iEQa+n48x0W+D/V+Quaj92Hz6tC0uM3W0zDgQlpsa2Duh
	 xjGyolaLAq+ShvIjBkoBqPzteFDG8KsgxelECSf301NiTQD/P0Q68KC+w3iOcI0dXZ4rX
	 CoKl/Ngq1RuRJCbmRB0sw0SxJ2wh3AjNknTA2MhAMet9xgQasKCCU9rWyTYftNCH1U9Ef
	 tNXYoeZs+YMgi/y2w8YTuQSBdQ2pgLGGssHCOkogZNHumR6HMnTpLKv2BHRYTZwJVX9qp
	 QgcwJfMguaoFGKB0QLcoR6YQzzqzvtpYdhXGyOiI6UzW6bHNRVNh35GxQvmC77sICDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C4606A324;
	Tue,  3 Nov 2026 05:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131C4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD40568AFE; Tue,  3 Nov 2026 06:31:28 +0100 (CET)
Date: Tue, 3 Nov 2026 06:31:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
	mkp@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: report the correct discard alignment in sysfs
Message-ID: <20261103053127.GD1184@lst.de>
References: <20261031102023.3644494-2-thnkslprpt@gmail.com>
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
In-Reply-To: <20261031102023.3644494-2-thnkslprpt@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


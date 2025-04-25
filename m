Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363041BD9D0
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606331; cv=none; b=c0hN30YmU8rhXiZ2kIlt0gsFK1M/KG6J+XD5/iQ8XL5exJZF8DvqqN6JfbeLmsmcBbflW6lzGIDyGNSTTvL1umX1CuQLCYOFLMU66su3r/+/WeS8t6vrySL+WOlc2UsJh81wCe2kcBCcaFjcYi/0grplzJin78l3kdyF6uAzTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606331; c=relaxed/simple;
	bh=gXTHrYIxt0xIlJzX1YmY6bhBSPjqdHfSq0Y2z8ssf1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhZhc6hrunKYN8NaaW68dsEUlMf0KhqsIa4j30eKxCGxmx724sAB+q3h6Jw4K/CRs4I36iMf4pgBzVdNy5yn5geX9TqI55V1aEwdlrOWIwyEkxhaS0rLpfk84aXN3EXAJleGPWHgrGmR6CReSO01imHmv61J1Wz8+6mQrobw0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6856E68BEB; Fri, 25 Apr 2025 20:38:45 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:38:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 18/20] block: remove several ->elevator_lock
Message-ID: <20250425183845.GD26393@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-19-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-19-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

This is missing a "critial section: or similar in the Subject line
for the grammar to make sense.


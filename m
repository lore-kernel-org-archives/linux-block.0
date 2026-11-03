Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688958;
	b=khv5PPjUcrdGf8q5uy5mVx3sJvRP6HJbvg5FFR8H9cJKAR8+Enq0vcU9Eh00sxl8x9fy
	 psfXfE1nCh4wEAKh9K+74L8BR29p+O0Zu1NRn07F9rDtMnS6TLb7VcNm2VKvF8b0UIn6A
	 la2hNYc2ZigiWtn83keVklWVhVv+9Ew0hLD4QaguH8hY8TOC6qC2WA20kL39R2esCFkIO
	 H13Ros/rU7fUzY9+YOqyGG+q9cY0g+8ikA1wd93zLSNPRNxkROSGpaOELTxMDBHtYyD7E
	 KOSYLF3jK77z9v/KnKc36+Nz5/4ZIWHgT50/C9VYsuPRtwRAjJIDasDekPiOHdMvs8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688958;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=UuHC6yRfKUqHHpF0guB57cYayYzN0UM0YJkO/oRXObE=;
	b=PXXqZt7YqBNm0Gb6W+BYjvAKhZf0TkZwKnWqoRcdE5nuY4xtDaqUuL37tMRB6ndJ4msl
	 eoEZaNkJmuf+cDJ1HF/rs6+E3cFVe94tp/RKlvhO1cS04SWVZY8y/5K11fWh/aLVaV+c3
	 7xXW0Ylpfr/dJMK9XCYs8k/fh3C9dXIgZOadxgz3kzw1RW/35wQIBFxewtNj3BgSNoOnu
	 mYTmBezX2p4K2xJ4FhOcMbidNU/UTx3S4PJJ5FUgixAkuhq6z8aZWKUcPmuOOYPpT7+vU
	 nZOZyWgoMZUNt5QjzVEEffhBgt4w45p2JQeFH2E0CiPiifiRFL0BC7ZI44wN7pSd1Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E846606A324;
	Tue,  3 Nov 2026 06:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E846606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3206B68AFE; Tue,  3 Nov 2026 07:55:53 +0100 (CET)
Date: Tue, 3 Nov 2026 07:55:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, bvanassche@acm.org,
	yukuai@fygo.io, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	chengzhihao1@huawei.com
Subject: Re: [PATCH] block: partitions: reject GPT entries with
 starting_lba > ending_lba
Message-ID: <20261103065553.GA2779@lst.de>
References: <20261102080442.3775061-1-wozizhi@huaweicloud.com> <20261103053418.GB1382@lst.de> <4851c5b8-7522-4ff8-b6e7-d69f5d9a7557@huaweicloud.com>
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
In-Reply-To: <4851c5b8-7522-4ff8-b6e7-d69f5d9a7557@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Ok.  Looks good then:

Reviewed-by: Christoph Hellwig <hch@lst.de>


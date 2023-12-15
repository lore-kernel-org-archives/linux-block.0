Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913CCEBB
	for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW2DnDd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E03C433C8;
	Fri, 15 Dec 2023 02:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702606824;
	bh=DfV0YjqU42mbtKk14KLLCh7KWIPdC4L6UaNBDmqWy4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rW2DnDd02IBDMdy4HprDZt+AHWu78WqltBJnqCjqssFbpdhAThBNEduZfhyGN0CwX
	 WMZtWao4O+s2N8J2QqE6X7ZR3sIY5RutqHzbdwd7Si8qxuv5Bhtzyg/8wUUH24cia6
	 rd8jiRpDRfyxitQ4nnEDscBpl0I5rMKXYlkcyWl3rsL5PgvbpbXk6HiknlEMYGQxGN
	 4aCWE1FDeoZpRjJKfVLNye1UKj2QsEtP4rxarj6k9iDKf7sYG4lidObEEiSe7FdY+K
	 Ys0d9CuhyPMWVTmn+0Kw5/7vVDcqbtq7k2cQqiwWbpnwMqBjuTZmR7cOuOACk2fR6B
	 cJkT++2q5JpxQ==
Date: Thu, 14 Dec 2023 18:20:16 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <ZXu3vJHhJLFhQMYn@kbusch-mbp>
References: <20231212181304.GA32666@lst.de>
 <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
 <20231212182613.GA1216@lst.de>
 <ZXiual-UkUY4OWY2@google.com>
 <20231213155606.GA8748@lst.de>
 <ZXnevBo4eIZEXbhK@google.com>
 <20231214085729.GA9099@lst.de>
 <ZXs563M66THrUw50@google.com>
 <168ed2f4-cf58-4ee9-bfbb-449f06f7348d@kernel.org>
 <ZXuz36STuYajyccm@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXuz36STuYajyccm@google.com>

On Thu, Dec 14, 2023 at 06:03:11PM -0800, Jaegeuk Kim wrote:
> 
> Okay, it seems there's first disconnect here, which fails to explain all the
> below gaps. Do you think the device supporting zone_append keeps LBAs inline
> with PBAs within a zone? E.g., LBA#n guarantees to map to PBA#n in a zone.
> If LBA order is exactly matching to the PBA order all the time, the mapping
> granularity is zone. Otherwise, it should be page.

Yah, you're describing how 'zone append' works.

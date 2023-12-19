Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F04171AF
	for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1AC368BFE; Tue, 19 Dec 2023 13:10:10 +0100 (CET)
Date: Tue, 19 Dec 2023 13:10:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prevent zoned write
 reordering due to I/O prioritization
Message-ID: <20231219121010.GA21240@lst.de>
References: <20231218211342.2179689-1-bvanassche@acm.org> <20231218211342.2179689-5-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218211342.2179689-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 01:13:42PM -0800, Bart Van Assche wrote:
> Assigning I/O priorities with the ioprio cgroup policy may cause
> different I/O priorities to be assigned to write requests for the same
> zone. Prevent that this causes unaligned write errors by adding zoned
> writes for the same zone in the same priority queue as prior zoned
> writes.

I still think this is fundamentally the wrong thing to do.  If you set
different priorities, you want I/O to be reordered, so ignoring that
is a bad thing.


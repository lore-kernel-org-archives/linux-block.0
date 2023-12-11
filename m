Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE50BD
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 08:55:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6289E68B05; Mon, 11 Dec 2023 17:55:37 +0100 (CET)
Date: Mon, 11 Dec 2023 17:55:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/3] block/mq-deadline: Introduce dd_bio_ioclass()
Message-ID: <20231211165537.GB26039@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205053213.522772-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 04, 2023 at 09:32:12PM -0800, Bart Van Assche wrote:
> Prepare for disabling I/O prioritization in certain cases.

On it's own this looks pretty useless to be honest, an with just a
single caller it can't really make future patches significantly
simpler either.


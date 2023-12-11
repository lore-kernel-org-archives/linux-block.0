Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B008E
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 09:02:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C3B4868BFE; Mon, 11 Dec 2023 18:01:59 +0100 (CET)
Date: Mon, 11 Dec 2023 18:01:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: fix bio_add_hw_page for larger folios / compound pages
Message-ID: <20231211170159.GA26999@lst.de>
References: <20231204173419.782378-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204173419.782378-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Jens,

does this looks good to you, or do you want any tweaks to it.

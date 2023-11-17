Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B355D50
	for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 05:26:56 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39F836732D; Fri, 17 Nov 2023 14:26:52 +0100 (CET)
Date: Fri, 17 Nov 2023 14:26:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] blk-mq: make sure active queue usage is held for
 bio_integrity_prep()
Message-ID: <20231117132652.GA7867@lst.de>
References: <20231113035231.2708053-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113035231.2708053-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Only processing my travel back log now.  I obviously like the patch,
but given I only did a bunch of cleanups and a trivial fix, I think
this should have still been attributed to you.


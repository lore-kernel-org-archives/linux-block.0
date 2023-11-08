Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC4D520;
	Wed,  8 Nov 2023 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F90F0;
	Wed,  8 Nov 2023 00:05:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FBF967373; Wed,  8 Nov 2023 09:05:19 +0100 (CET)
Date: Wed, 8 Nov 2023 09:05:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: add and use a per-mapping stable writes flag v2
Message-ID: <20231108080518.GA6374@lst.de>
References: <20231025141020.192413-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025141020.192413-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can we get at least patches 1 and 2 queued for for 6.7 given that
they fix a regression?


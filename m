Return-Path: <BATV+8132ee8c7e24eb087ca3+5055+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 26 Jun 2017 02:59:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme: add support for streams and directives
Message-ID: <20170626095907.GG14057@infradead.org>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498004526-4543-10-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Looks mostly good,

but two nit-picks:

 - can we keep a module option to disable streams, or in fact for
   now maybe to explicitly enable it?  I expect this to be interesting
   at least for the first devices that implement it.  Also given that
   it needs to be explicitly enabled I would expect some overhead of
   just enabling it when never used
 - do we even need the < 4 streams fallback now that they are global
   instead of per-ns instead of just disabling the feature for now?

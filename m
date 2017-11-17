Return-Path: <hch@lst.de>
Date: Fri, 17 Nov 2017 16:08:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Lyle <mlyle@lyle.org>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: Re: [PATCH] bio: ensure __bio_clone_fast copies bi_partno
Message-ID: <20171117150842.GB24694@lst.de>
References: <20171117074725.22536-1-mlyle@lyle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117074725.22536-1-mlyle@lyle.org>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

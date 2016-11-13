Return-Path: <hch@lst.de>
Date: Sun, 13 Nov 2016 16:13:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] irq-poll: micro optimize some branch predictions
Message-ID: <20161113151312.GC7578@lst.de>
References: <1478991755-28153-1-git-send-email-sagi@grimberg.me> <1478991755-28153-3-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478991755-28153-3-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Are they really that unlikely?  I don't like these annotations unless
it's clearly an error path or they have a high, demonstrable benefit.

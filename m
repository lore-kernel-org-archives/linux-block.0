Return-Path: <hch@lst.de>
Date: Thu, 6 Jul 2017 01:06:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	James Smart <james.smart@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 5/8] nvme: kick requeue list when requeueing a
	request instead of when starting the queues
Message-ID: <20170705230621.GA12043@lst.de>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me> <1499274037-17438-6-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499274037-17438-6-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

I wonder if we should simply always kick the list and remove the
parameter and blk_mq_kick_requeue_list.  It seems like this split
has caused a lot more harm then good, and the other drivers using
it that way are probably having issues as well.

Return-Path: <hch@lst.de>
Date: Thu, 19 Jul 2018 16:50:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix silent data corruption in blkdev_direct_IO()
Message-ID: <20180719145044.GB21000@lst.de>
References: <20180718075440.GA15254@ming.t460p> <20180719093918.28876-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719093918.28876-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

Martin,

please NEVER send a patch series as a reply to a previous thread.
That makes it complete hell to find in the inbox.

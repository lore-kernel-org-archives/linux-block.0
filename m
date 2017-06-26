Return-Path: <BATV+8132ee8c7e24eb087ca3+5055+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 26 Jun 2017 02:51:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
Message-ID: <20170626095148.GB14057@infradead.org>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-2-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498004526-4543-2-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Please document the userspace API (added linux-api and linux-man
to CC for sugestions), especially including the odd effects of the
per-inode settings.

Also I would highly recommend to use different fcntl commands
for the file vs inode hints to avoid any strange behavior.

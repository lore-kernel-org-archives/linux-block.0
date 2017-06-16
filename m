Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 16 Jun 2017 11:00:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170616180049.GB27996@infradead.org>
References: <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
 <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
 <20170616073339.GC8682@infradead.org>
 <0ac0bb7e-ce8d-cb63-985c-ab2d1f3402f1@kernel.dk>
 <20170616155206.GB27209@infradead.org>
 <ed334779-20b6-3fef-d66d-cd63a493a92f@kernel.dk>
 <943e8057-bb9a-5c92-16cf-4d5ee6979586@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <943e8057-bb9a-5c92-16cf-4d5ee6979586@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 16, 2017 at 10:14:01AM -0600, Jens Axboe wrote:
> So that would look like the below change on top of the current v5. I
> skipped the callers, since those are all easy
> s/bio_op_write_hint/write_hint_to_opf changes.

That's better.  But my idead was to actually go back to req_hints and
bi_hints fields.  Especially as we now have various little holes due
to the size reduction from bi_error to bi_status (and the request
equivalent).  But this mostly makes sense if we're planning for more
hints.

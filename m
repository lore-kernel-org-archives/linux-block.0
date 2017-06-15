Return-Path: <BATV+bef0da5e94eb3b03931e+5044+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 15 Jun 2017 01:19:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170615081914.GD10599@infradead.org>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

I think Darrick has a very valid concern here - using RWF_* flags
to affect inode or fd-wide state is extremely counter productive.

Combined with the fact that the streams need a special setup in NVMe
I'm tempted to say that the interface really should be fadvise or
similar, which would keep the setup out of the I/O path and make clear
it's a sticky interface.  For direct I/O RWF_* would make some sense,
but we'd still have to deal with the setup issue.

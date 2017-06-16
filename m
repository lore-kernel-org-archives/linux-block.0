Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 16 Jun 2017 00:30:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, martin.petersen@oracle.com
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
Message-ID: <20170616073031.GB8682@infradead.org>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
 <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
 <bb49b5a3-ac8e-84ce-1886-62deab29a3a4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bb49b5a3-ac8e-84ce-1886-62deab29a3a4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 15, 2017 at 09:23:02AM -0600, Jens Axboe wrote:
> And then I remembered why fadvise _sucks_. It returns the error value
> directly. So 0 is success > 0 is some error. That does not work well
> for adding a set/get interface. Additionally, with fadvise, we have
> to overload either 'offset' or 'length' for the write hint for the
> set operation. Not super pretty.
> 
> Any objections to making the auxiliary interface fcntl(2) based?
> That would be a cleaner fit, imho.

fcntl sounds fine to me.

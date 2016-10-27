Return-Path: <BATV+5a9af4245aa9ea14ad45+4813+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 27 Oct 2016 12:45:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hannes Reinecke <hare@suse.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
Message-ID: <20161027194548.GA30332@infradead.org>
References: <12386463.fJy0cVexVD@wuerfel>
 <20161026152955.GA21262@infradead.org>
 <3ebadbb8-9ac2-851a-66f9-c9db25713695@kernel.dk>
 <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <20161027194127.GT25322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161027194127.GT25322@sirena.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 27, 2016 at 08:41:27PM +0100, Mark Brown wrote:
> Plus the benchmarking to verify that it works well of course, especially
> initially where it'll also be a new queue infrastructure as well as the
> blk-mq conversion itself.  It does feel like something that's going to
> take at least a couple of kernel releases to get through.

Or to put it the other way around:  it could have been long done
if people had started it the first it was suggestead.  Instead you guys
keep arguing and nothing gets done.  Get started now, waiting won't
make anything go faster.

> I think there's also value in having improvements there for people who
> benefit from them while queue infrastructure for blk-mq is being worked
> on.  

Well, apply it to you vendor tree then and maintain it yourself if you
disagree with our direction.

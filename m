Return-Path: <BATV+faca7f9bbb46c1dfe59d+5073+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 14 Jul 2017 05:44:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tomi Sarvela <tomi.p.sarvela@intel.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: linux-next scsi-mq hang in suspend-resume
Message-ID: <20170714124424.GA28150@infradead.org>
References: <21128504.iYAzanzLsA@fractal.fi.intel.com>
 <dd9daa92-0c9c-51dd-95b5-961cfd1fca36@kernel.dk>
 <20170713071220.GA19972@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713071220.GA19972@infradead.org>
List-ID: <linux-block@vger.kernel.org>


Tomi,

can you please report what hardware this is one (e.g. libata or
real scsi, which driver), a kernel config and the actual command
used to suspend the system (to ram, to disk?) so that I an try to
reproduce it?

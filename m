Return-Path: <ming.lei@redhat.com>
Date: Mon, 23 Oct 2017 18:43:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: fix peeking requests during PM
Message-ID: <20171023104315.GA30252@ming.t460p>
References: <20171020144523.4585-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171020144523.4585-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 20, 2017 at 04:45:23PM +0200, Christoph Hellwig wrote:
> We need to look for an active PM request until the next softbarrier
> instead of looking for the first non-PM request.  Otherwise any cause
> of request reordering might starve the PM request(s).

Hi Christoph,

Could you share us how the starve is caused? Looks all PM
request is run via scsi_execute(), and the caller is always
waiting for the completion of PM request.

Especially PM request is run after SCSI device is in quiesce
state, during that time, no normal(non-preempt) request can
enter queue after the making quiesce safe patchset is merged.

--
Ming

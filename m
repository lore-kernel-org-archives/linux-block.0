Return-Path: <scott.bauer@intel.com>
Date: Wed, 15 Feb 2017 14:09:26 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Rafael Antognolli <rafael.antognolli@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 3/4] block/sed: Check received header lengths
Message-ID: <20170215210926.GB2178@sbauer-Z170X-UD5>
References: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
 <1487187731-10293-4-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487187731-10293-4-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 15, 2017 at 12:42:08PM -0700, Jon Derrick wrote:
> Add a buffer size check against discovery and response header lengths
> before we loop over their buffers.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>

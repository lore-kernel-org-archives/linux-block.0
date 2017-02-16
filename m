Return-Path: <hch@lst.de>
Date: Thu, 16 Feb 2017 15:33:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Scott Bauer <scott.bauer@intel.com>,
	Rafael Antognolli <rafael.antognolli@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv4 1/4] block/sed: Use ssize_t on atom parsers to return
	errors
Message-ID: <20170216143348.GD32058@lst.de>
References: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com> <1487195159-12599-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487195159-12599-2-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 15, 2017 at 02:45:54PM -0700, Jon Derrick wrote:
> The short atom parser can return an errno from decoding but does not
> currently return the error as a signed value. Convert all of the parsers
> to ssize_t.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> Reviewed-by: Scott Bauer <scott.bauer@intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 20:54:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 02/11] block: sed-opal: unify space check in
	add_token_*
Message-ID: <20180319195421.GD3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <955fd10854ed68f6925612ae73cdaa4637cfb5e4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <955fd10854ed68f6925612ae73cdaa4637cfb5e4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 07:36:44PM +0100, Jonas Rabenstein wrote:
> All add_token_* functions have a common set of conditions that have to
> be checked. Use a common function for those checks in order to avoid
> different behaviour as well as code duplication.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

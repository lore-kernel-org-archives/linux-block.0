Return-Path: <scott.bauer@intel.com>
Date: Wed, 20 Jun 2018 11:28:00 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block: sed-opal: Fix a couple off by one bugs
Message-ID: <20180620172759.GA1900@sbauer-Z170X-UD5>
References: <20180620104151.yhvcgbcbkkwj4cuk@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620104151.yhvcgbcbkkwj4cuk@kili.mountain>
List-ID: <linux-block@vger.kernel.org>

nOn Wed, Jun 20, 2018 at 01:41:51PM +0300, Dan Carpenter wrote:
> resp->num is the number of tokens in resp->tok[].  It gets set in
> response_parse().  So if n == resp->num then we're reading beyond the
> end of the data.
> 
> Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
Tested-by: Scott Bauer <scott.bauer@intel.com>




> Static analysis.  Not tested.  This matches the checking in
> response_get_token().
> 
> My other concern is that there isn't checking in response_parse() to
> ensure that we don't go over MAX_TOKS (64) entries.  If the firmware
> is buggy we're probably very screwed already, so it doesn't necessarily
> make a lot of difference at runtime but it might make static analysis
> easier if we knew the value of resp->num was in the 1-64 range.

Do you want to send this patch or do you want me todo it? Im all for never
trusting firmware... I've seen it. 

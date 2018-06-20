Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: sed-opal: Fix a couple off by one bugs
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Scott Bauer <scott.bauer@intel.com>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
 linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180620104151.yhvcgbcbkkwj4cuk@kili.mountain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c0ca9f14-8edc-65c0-5bab-481265c69863@kernel.dk>
Date: Wed, 20 Jun 2018 12:04:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180620104151.yhvcgbcbkkwj4cuk@kili.mountain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/20/18 4:41 AM, Dan Carpenter wrote:
> resp->num is the number of tokens in resp->tok[].  It gets set in
> response_parse().  So if n == resp->num then we're reading beyond the
> end of the data.

Applied, thanks Dan.

-- 
Jens Axboe

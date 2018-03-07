Return-Path: <scott.bauer@intel.com>
Date: Wed, 7 Mar 2018 16:24:29 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: sed-opal: fix u64 short atom length
Message-ID: <20180307232428.hv3zkcxldbu5w3tx@sbauer-Z170X-UD5>
References: <1520379912.4178.83.camel@intel.com>
 <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 07, 2018 at 05:55:56PM +0100, Jonas Rabenstein wrote:
> The length must be given as bytes and not as 4 bit tuples.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
> v2:
>   - use fls64
>   - shorten loop body
> ---
>  block/sed-opal.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 

Reviewed-by: Scott Bauer <scott.bauer@intel.com>

Your two patches should be sent to stable for 4.14. I can queue those up and do it,
or if you want to you can do it as well. Let me know what you prefer!

Date: Thu, 20 Apr 2017 08:19:44 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Colin King <colin.king@canonical.com>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][-next] block, bfq: don't dereference bic before null
 checking it
Message-ID: <20170420141944.GB10057@kernel.dk>
References: <20170420140718.19694-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170420140718.19694-1-colin.king@canonical.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20 2017, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to bfq_check_ioprio_change will dereference bic, however,
> the null check for bic is after this call.  Move the the null
> check on bic to before the call to avoid any potential null
> pointer dereference issues.

Thanks, added.

-- 
Jens Axboe

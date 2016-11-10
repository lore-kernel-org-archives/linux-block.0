Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: cfq_cpd_alloc() should use @gfp
To: Tejun Heo <tj@kernel.org>
References: <20161110161637.GB26105@htj.duckdns.org>
Cc: linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 linux-kernel@vger.kernel.org, kernel-team@fb.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <58e4eab7-2d0e-d168-f1e5-3ed09c00e345@kernel.dk>
Date: Thu, 10 Nov 2016 10:10:27 -0700
MIME-Version: 1.0
In-Reply-To: <20161110161637.GB26105@htj.duckdns.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/10/2016 09:16 AM, Tejun Heo wrote:
> Re: [bug report] blkcg: replace blkcg_policy->cpd_size with
>  ->cpd_alloc/free_fn() methods
> Reply-To:
> In-Reply-To: <20161110133426.GA30610@mwanda>
>
> cfq_cpd_alloc() which is the cpd_alloc_fn implementation for cfq was
> incorrectly hard coding GFP_KERNEL instead of using the mask specified
> through the @gfp parameter.  This currently doesn't cause any actual
> issues because all current callers specify GFP_KERNEL.  Fix it.

Thanks Tejun, applied for 4.10.

-- 
Jens Axboe

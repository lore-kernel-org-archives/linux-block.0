Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] elevator: eliminate unused result build warning
To: Firo Yang <firogm@gmail.com>
References: <20170510152935.24968-1-yongming.yang@windriver.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Firo Yang <yongming.yang@windriver.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <532727bf-934b-cf7b-0294-7fcee66ff5af@kernel.dk>
Date: Wed, 10 May 2017 09:30:19 -0600
MIME-Version: 1.0
In-Reply-To: <20170510152935.24968-1-yongming.yang@windriver.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/10/2017 09:29 AM, Firo Yang wrote:
> Gcc complains about ignoring return value of ‘strstrip’; Fix it by
> just using the strstrip() as the function parameter.

This has already been fixed up.

-- 
Jens Axboe

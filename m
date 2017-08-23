Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] skd: Uninitialized variable in
 skd_isr_completion_posted()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20170823104048.w4vdvlp72ug5ackq@mwanda>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ed05cb0e-4dd8-fdbe-3a9c-6edcb5e5f9d2@kernel.dk>
Date: Wed, 23 Aug 2017 08:36:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170823104048.w4vdvlp72ug5ackq@mwanda>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/23/2017 04:44 AM, Dan Carpenter wrote:
> Someone got too agressive about removing initializations and
> accidentally removed the "rc = 0;" which is required.

Thanks Dan, applied.

-- 
Jens Axboe

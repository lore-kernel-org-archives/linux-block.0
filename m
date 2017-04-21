Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] lightnvm: don't print a warning for ADDR_EMPTY
To: Dan Carpenter <dan.carpenter@oracle.com>, Matias Bjorling
 <mb@lightnvm.io>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <20170421205437.fom72nbe3rfngdra@mwanda>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7db94fa9-302e-50fb-14cc-f8917cfeed5e@kernel.dk>
Date: Fri, 21 Apr 2017 16:50:55 -0600
MIME-Version: 1.0
In-Reply-To: <20170421205437.fom72nbe3rfngdra@mwanda>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/21/2017 02:54 PM, Dan Carpenter wrote:
> Reading from ADDR_EMPTY is out of bounds.  The current code generates a
> static checker warning because we check for out of bounds "lba" before
> we check for ADDR_EMPTY, so the second check is always false.  It looks
> like we intended ADDR_EMPTY to be a no-op without printing a warning.
> 
> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Added, thanks Dan.

-- 
Jens Axboe

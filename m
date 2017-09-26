Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix a build error
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: kbuild test robot <fengguang.wu@intel.com>
References: <c729033f4073c8dd324d74ad02e4426e89f6ee8c.1506448764.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <71f4e0a0-ea37-a90b-5c96-fcce8732811c@kernel.dk>
Date: Tue, 26 Sep 2017 20:07:56 +0200
MIME-Version: 1.0
In-Reply-To: <c729033f4073c8dd324d74ad02e4426e89f6ee8c.1506448764.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/26/2017 08:02 PM, Shaohua Li wrote:
> The code is only for blkcg not for all cgroups

Added, thanks.

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] brd: fix overflow in __brd_direct_access
To: Mikulas Patocka <mpatocka@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.LRH.2.02.1709130909570.1354@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fb12beef-6c0e-5c13-ab95-29683243f095@kernel.dk>
Date: Wed, 13 Sep 2017 11:18:18 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1709130909570.1354@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/13/2017 07:17 AM, Mikulas Patocka wrote:
> The code in __brd_direct_access multiplies the pgoff variable by page size
> and divides it by 512. It can cause overflow on 32-bit architectures. The
> overflow happens if we create ramdisk larger than 4G and use it as a
> sparse device.
> 
> This patch replaces multiplication and division with multiplication by the
> number of sectors per page.

Thanks, applied with Dan's ack.

-- 
Jens Axboe

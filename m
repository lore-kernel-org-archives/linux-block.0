Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove useless assignment in bio_split
To: Mikulas Patocka <mpatocka@redhat.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
References: <alpine.LRH.2.02.1711221312020.21196@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c647eafa-dce6-883e-a4c7-ec93f6a1b44f@kernel.dk>
Date: Wed, 22 Nov 2017 11:26:14 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1711221312020.21196@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/22/2017 11:18 AM, Mikulas Patocka wrote:
> Remove useless assignment to the variable "split" because the variable is
> unconditionally assigned later.

Thanks, applied.

-- 
Jens Axboe

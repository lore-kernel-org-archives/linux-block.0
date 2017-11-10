Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] brd: remove unused brd_mutex
To: Mikulas Patocka <mpatocka@redhat.com>, linux-block@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 dm-devel@redhat.com
References: <alpine.LRH.2.02.1711101228030.15978@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0f7fd0e5-985c-f17a-de0b-92003c316738@kernel.dk>
Date: Fri, 10 Nov 2017 11:18:42 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1711101228030.15978@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/10/2017 10:29 AM, Mikulas Patocka wrote:
> Remove unused mutex brd_mutex. It is unused since the commit ff26956875c2
> ("brd: remove support for BLKFLSBUF").

Thanks, applied.

-- 
Jens Axboe

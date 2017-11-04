Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4] blkcg: add sanity check for blkcg policy operations
To: jthumshirn@suse.de, linux-block@vger.kernel.org
References: <20171017155621.GA38911@bogon.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e7b26ccf-74db-3cc5-9557-e4581b34ea5e@kernel.dk>
Date: Sat, 4 Nov 2017 10:10:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171017155621.GA38911@bogon.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/2017 09:56 AM, weiping zhang wrote:
> blkcg policy should keep cpd/pd's alloc_fn and free_fn in pairs,
> otherwise policy would register fail.

Added, thanks.

-- 
Jens Axboe

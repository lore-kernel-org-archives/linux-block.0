Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: respect virtual boundary mask in bvecs
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
 Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
References: <20181107135814.15727-1-jthumshirn@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <756f1630-f875-4a7c-26cf-9cce7b850ca1@kernel.dk>
Date: Wed, 7 Nov 2018 13:05:01 -0700
MIME-Version: 1.0
In-Reply-To: <20181107135814.15727-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/7/18 6:58 AM, Johannes Thumshirn wrote:
> With drivers that are settting a virtual boundary constrain, we are
> seeing a lot of bio splitting and smaller I/Os being submitted to the
> driver.
> 
> This happens because the bio gap detection code does not account cases
> where PAGE_SIZE - 1 is bigger than queue_virt_boundary() and thus will
> split the bio unnecessarily.

Thanks, applied.

-- 
Jens Axboe

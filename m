Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] null_blk: zone support
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 bart.vanassche@wdc.com, damien.lemoal@wdc.com
References: <20180706173839.28355-1-mb@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dcfcc786-5023-8817-e6fe-26e04099d0a2@kernel.dk>
Date: Fri, 6 Jul 2018 20:54:35 -0600
MIME-Version: 1.0
In-Reply-To: <20180706173839.28355-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/6/18 11:38 AM, Matias Bjørling wrote:
> This series adds support for exposing a zone block device using the
> null_blk device driver.
> 
> The first patch moves core null_blk data structures to a shared header
> file. The second implements the actual zone support. The patchset adds
> two new options. One to enable the zone interface, and another to
> define the size of the zones to expose.

Thanks, should be useful for verifying write pointer violations.
Applied for 4.19.

-- 
Jens Axboe

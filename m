Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] clean_bdev_aliases: Prevent cleaning blocks that are not
 in block range
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>, jack@suse.cz
References: <1482672663-17122-1-git-send-email-chandan@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <852af9b4-e0f9-7c5d-61f0-8f6783904a03@kernel.dk>
Date: Mon, 2 Jan 2017 09:35:35 -0700
MIME-Version: 1.0
In-Reply-To: <1482672663-17122-1-git-send-email-chandan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/25/2016 06:31 AM, Chandan Rajendra wrote:
> The first block to be cleaned may start at a non-zero page offset. In
> such a scenario clean_bdev_aliases() will end up cleaning blocks that
> do not fall in the range of blocks to be cleaned. This commit fixes the
> issue by skipping blocks that do not fall in valid block range.

Queued up, thanks.

-- 
Jens Axboe

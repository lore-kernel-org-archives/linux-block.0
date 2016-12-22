Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] genhd: remove dead and duplicated scsi code
To: Jon Derrick <jonathan.derrick@intel.com>
References: <1482269894-14034-1-git-send-email-jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0b5dc1da-91e0-312f-eb7c-0570c377f8dc@kernel.dk>
Date: Thu, 22 Dec 2016 11:24:27 -0700
MIME-Version: 1.0
In-Reply-To: <1482269894-14034-1-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/20/2016 02:38 PM, Jon Derrick wrote:
> blk_scsi_cmd_filter use was deprecated by 4beab5c6 and the SCSI macros
> are duplicated in blkdev.h, both likely reintroduced by a bad merge from
> 540eed56.

Wow, 2008! Applied, thanks.

-- 
Jens Axboe

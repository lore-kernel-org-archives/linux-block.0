Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] nvme: untangle 0 and BLK_MQ_RQ_QUEUE_OK
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <ec8930a71efdc30f9d5e5c69954f5b10cfab9927.1479236597.git.osandov@fb.com>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 kernel-team@fb.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <96ea1cf1-3d84-5e08-e55f-5d903070fed2@kernel.dk>
Date: Tue, 15 Nov 2016 12:51:01 -0700
MIME-Version: 1.0
In-Reply-To: <ec8930a71efdc30f9d5e5c69954f5b10cfab9927.1479236597.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/15/2016 12:11 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> Let's not depend on any of the BLK_MQ_RQ_QUEUE_* constants having
> specific values. No functional change.

Thanks Omar, applied both for 4.10.

-- 
Jens Axboe

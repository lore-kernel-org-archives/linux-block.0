Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix transfer when chuck sectors exceeds max
To: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
 Jitendra Bhivare <jitendra.bhivare@broadcom.com>, stable@vger.kernel.org
References: <20180626151458.6675-1-keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <599a0ffd-66dc-9604-856e-cfa0210ebc51@kernel.dk>
Date: Tue, 26 Jun 2018 12:18:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180626151458.6675-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/26/18 9:14 AM, Keith Busch wrote:
> A device may have boundary restrictions where the number of sectors
> between boundaries exceeds its max transfer size. In this case, we need
> to cap the max size to the smaller of the two limits.

Applied, with the subject typo fixed.

-- 
Jens Axboe

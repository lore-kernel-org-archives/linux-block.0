Return-Path: <martin.petersen@oracle.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix transfer when chuck sectors exceeds max
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180626151458.6675-1-keith.busch@intel.com>
Date: Tue, 26 Jun 2018 11:54:18 -0400
In-Reply-To: <20180626151458.6675-1-keith.busch@intel.com> (Keith Busch's
	message of "Tue, 26 Jun 2018 09:14:58 -0600")
Message-ID: <yq160255ys5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Keith,

> A device may have boundary restrictions where the number of sectors
> between boundaries exceeds its max transfer size. In this case, we need
> to cap the max size to the smaller of the two limits.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

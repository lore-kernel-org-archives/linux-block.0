Return-Path: <martin.petersen@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCHSET v9] Add support for write life time hints
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
Date: Tue, 20 Jun 2017 21:30:57 -0400
In-Reply-To: <1498004526-4543-1-git-send-email-axboe@kernel.dk> (Jens Axboe's
	message of "Tue, 20 Jun 2017 18:21:57 -0600")
Message-ID: <yq11sqejfe6.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Jens,

> A new iteration of this patchset, previously known as write streams.
> As before, this patchset aims at enabling applications split up
> writes into separate streams, based on the perceived life time
> of the data written. This is useful for a variety of reasons:

The grep-wielding streams police noticed several occurrences of the
string "stream" in patches 1-3 and 5. Please fix.

Otherwise OK as a baseline.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

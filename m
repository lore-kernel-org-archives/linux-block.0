Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, mpatocka@redhat.com, gmazyland@gmail.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: integrity regression fixes for 4.13-rc
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170809154727.2085-1-hch@lst.de>
Date: Wed, 09 Aug 2017 12:21:50 -0400
In-Reply-To: <20170809154727.2085-1-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 9 Aug 2017 17:47:25 +0200")
Message-ID: <yq1d18467a9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> this series fixes regressions in the integrity handling update in
> 4.13-rc.
>
> The first one was sent earlier by Milan and while both Martin and I
> aren't exactly happy about the way dm uses the integrity code to cause
> this regression this minimal fix gets us back to the status quo.
>
> The second one makes sure that we only verify the DIF checksums on the
> lowest layer where we attach the integrity information.

These look OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

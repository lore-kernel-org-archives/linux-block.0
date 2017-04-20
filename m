Return-Path: <martin.petersen@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com, agk@redhat.com, snitzer@redhat.com,
        shli@kernel.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        drbd-dev@lists.linbit.com, dm-devel@redhat.com,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 26/27] scsi: sd: Separate zeroout and discard command choices
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170405172125.22600-1-hch@lst.de>
	<20170405172125.22600-27-hch@lst.de>
	<58c3d6a6-924e-cc86-1907-a9fd02a39c0e@redhat.com>
Date: Wed, 19 Apr 2017 21:34:18 -0400
In-Reply-To: <58c3d6a6-924e-cc86-1907-a9fd02a39c0e@redhat.com> (Paolo
	Bonzini's message of "Wed, 19 Apr 2017 16:56:31 +0200")
Message-ID: <yq1a87bsvz9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Paolo,

> Should this be conditional on lbprz, lbpws, lbpws10 and max_ws_blocks?

It is intentional that things can be overridden from userland for
devices that report the "wrong" thing. We do the same for discard so
people can set up udev rules.

-- 
Martin K. Petersen	Oracle Linux Engineering

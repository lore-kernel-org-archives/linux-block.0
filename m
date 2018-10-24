Return-Path: <martin.petersen@oracle.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH v4 00/11] Zoned block device support improvements
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
	<78778e22-9c5e-99d0-ef5c-85e04d03a4b7@kernel.dk>
	<yq1o9bkf5av.fsf@oracle.com> <20181024150344.GB13487@redhat.com>
Date: Wed, 24 Oct 2018 11:37:53 -0400
In-Reply-To: <20181024150344.GB13487@redhat.com> (Mike Snitzer's message of
	"Wed, 24 Oct 2018 11:03:44 -0400")
Message-ID: <yq1zhv3e4oe.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Mike,

>> You keep mentioning this, but I don't recall ever seeing anything to
>> that effect. The rest of the kernel appears to be either arbitrary
>> ordering or favoring author SoB as the first tag.
>
> I've always felt the proper order is how Jens likes it too (all dm
> commits from me follow that order).

That's fine, I don't have any particular preference. And I don't have
any issue with you guys sticking to a certain ordering in your
respective subsystems. I occasionally shuffle tags when I commit things
in SCSI too.

I just think it should be properly documented if there is a preferred
way to order things...

-- 
Martin K. Petersen	Oracle Linux Engineering

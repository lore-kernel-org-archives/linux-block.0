Return-Path: <martin.petersen@oracle.com>
To: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCHv6 0/3] Deprecate DAC960 driver
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20181017152513.136526-1-hare@suse.de>
	<yq1lg6wkqe9.fsf@oracle.com>
	<d9f916e8-3a7a-f768-72ba-fcadc8e34ec0@suse.de>
Date: Fri, 19 Oct 2018 18:26:19 -0400
In-Reply-To: <d9f916e8-3a7a-f768-72ba-fcadc8e34ec0@suse.de> (Hannes Reinecke's
	message of "Thu, 18 Oct 2018 07:54:32 +0200")
Message-ID: <yq1in1xinec.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Hannes,

> No, I haven't, but I should probably do it. Should I fix up the patch
> or send an additional one?

Additional, please.

>> Also, does MODULE_ALIAS do the right thing when a driver is split
>> into two distinct modules?
>>
> Well, it does; half of the time :-)

Is this a qualified guess or have you actually tried?

> Personally, I don't think there'll be many users around so I've just
> added if for completions sake.

Yeah, I agree it's less critical than mpt[23]sas. However, I'm sure
we'll break something for someone somewhere.

-- 
Martin K. Petersen	Oracle Linux Engineering

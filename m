Return-Path: <hch@lst.de>
Date: Wed, 10 Oct 2018 07:56:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCHv4 0/3] Deprecate DAC960 driver
Message-ID: <20181010055637.GA12844@lst.de>
References: <20181009152701.5542-1-hare@suse.de> <5fc78ab4-37c5-b80a-9f23-b9c4c00ba2d9@acm.org> <9c44c367-6854-f74d-8317-f0ce5ad64cca@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9c44c367-6854-f74d-8317-f0ce5ad64cca@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 10, 2018 at 07:49:03AM +0200, Hannes Reinecke wrote:
> On 10/10/18 4:03 AM, Bart Van Assche wrote:
>> On 10/9/18 8:26 AM, Hannes Reinecke wrote:
>>> as we're trying to get rid of the remaining request_fn drivers here's
>>> a patchset to move the DAC960 driver to the SCSI stack.
>>> As per request from hch I've split up the driver into two new SCSI
>>> drivers called 'myrb' and 'myrs'.
>>
>> Hi Hannes,
>>
>> It seems like only patches 1/3 and 2/3 but not 3/3 made it to the list?
>> See e.g. https://marc.info/?a=105878808800002&r=1.
>>
> Hmm.
>
> I have them in my inbox, and all patches have the same recipients.
> Care to re-check?

I got them all, but 1 had a major, major delay in my inbox.

In my linux-scsi box 3/3 is missing.

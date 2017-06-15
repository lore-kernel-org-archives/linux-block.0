Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v4] Add support for write life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <20170615081244.GA10342@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <97cd3890-8a56-b8a2-49cd-47c60c95cede@kernel.dk>
Date: Thu, 15 Jun 2017 08:23:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170615081244.GA10342@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/15/2017 02:12 AM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2017 at 09:45:01PM -0600, Jens Axboe wrote:
>> A new iteration of this patchset, previously known as write streams.
>> As before, this patchset aims at enabling applications split up
>> writes into separate streams, based on the perceived life time
>> of the data written. This is useful for a variety of reasons:
>>
>> - With NVMe 1.3 compliant devices, the device can expose multiple
>>   streams.
> 
> Nitpick: while the feature is introduce in NVMe 1.3, the NVMe versioning
> rules also allow devices that claim conformance with any older spec
> version to implement the feature.

Yes, that's true. I'll make that change, to not offend any of the NVMe
members.

-- 
Jens Axboe

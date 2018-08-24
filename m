Return-Path: <jgross@suse.com>
Subject: Re: [PATCH v3 0/5] xen/blk: persistent grant rework
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, konrad.wilk@oracle.com, axboe@kernel.dk,
 boris.ostrovsky@oracle.com
References: <20180813140114.20126-1-jgross@suse.com>
 <20180817155909.4cwiy6bhhgiala5m@mac>
From: Juergen Gross <jgross@suse.com>
Message-ID: <8aaf02b1-999d-81fc-2732-ed556b959a8a@suse.com>
Date: Fri, 24 Aug 2018 15:52:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180817155909.4cwiy6bhhgiala5m@mac>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 17/08/18 17:59, Roger Pau Monné wrote:
> On Mon, Aug 13, 2018 at 04:01:09PM +0200, Juergen Gross wrote:
>> Persistent grants are used in the Xen's blkfront/blkback drivers to
>> avoid mapping/unmapping of I/O buffers in the backend for each I/O.
>>
>> While this speeds up processing quite a bit there are problems related
>> to persistent grants in some configurations: domains with multiple
>> block devices making use of persistent grants might suffer from a lack
>> of grants if each of the block devices experienced a high I/O load at
>> some time. This is due to the number of persistent grants per device
>> only to be limited by a rather high maximum value, but never being
>> released even in case of longer times without any I/O.
>>
>> This series modifies xen-blkback to unmap any domU page mapped via a
>> persistent grant after a timeout (default: 60 seconds). The timeout
>> is set to its default value again when a persistent grant has been
>> used for an I/O.
>>
>> xen-blkfront is modified to scan every 10 seconds for persistent grants
>> not in use by blkback any more and to remove such grants.
>>
>> The last 3 patches are small cleanups of blkfront and blkback drivers.
>>
>> V3:
>> - patch 1: make timeout parameter static
> 
> Konrad if you are OK with this series, could you please send a pull
> request to Jens?

Ping?


Juergen

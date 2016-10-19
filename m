Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>,
        Damien Le Moal <damien.lemoal@hgst.com>
Subject: Re: [PATCH v8 6/7] sd: Implement support for ZBC devices
References: <1476772835-18541-1-git-send-email-damien.lemoal@wdc.com>
	<1476772835-18541-7-git-send-email-damien.lemoal@wdc.com>
	<x498ttlvbks.fsf@segfault.boston.devel.redhat.com>
	<CAJVOszBUe2BoCWoKLXXi9DUgk7Mg08uX6a-+LcEdho63nQzOWQ@mail.gmail.com>
Date: Wed, 19 Oct 2016 09:23:04 -0400
In-Reply-To: <CAJVOszBUe2BoCWoKLXXi9DUgk7Mg08uX6a-+LcEdho63nQzOWQ@mail.gmail.com>
	(Shaun Tancheff's message of "Tue, 18 Oct 2016 13:22:11 -0500")
Message-ID: <x4937jsscav.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Shaun Tancheff <shaun.tancheff@seagate.com> writes:

> On Tue, Oct 18, 2016 at 11:58 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
>> Damien Le Moal <damien.lemoal@wdc.com> writes:
>>
>>> +     if (!is_power_of_2(zone_blocks)) {
>>> +             if (sdkp->first_scan)
>>> +                     sd_printk(KERN_NOTICE, sdkp,
>>> +                               "Devices with non power of 2 zone "
>>> +                               "size are not supported\n");
>>> +             return -ENODEV;
>>> +     }
>>
>> Are power of 2 zone sizes required by the standard?  I see why you've
>> done this, but I wonder if we're artificially limiting the
>> implementation, and whether there will be valid devices on the market
>> that simply won't work with Linux because of this.
>
> The standard does not require power of 2 zones.
> That said, I am not aware of any current (or planned) devices other
> than a power of 2.
> Common zone sizes I am aware of: 256MiB, 128MiB and 1GiB.
>
> Also note that we are excluding the runt zone from the power of 2 expectation.
>
> So conforming devices should (excluding a runt zone):
>   - Have zones of the same size.
>   - Choose a zone size that is a power of 2.

OK, thanks for following up.  As long as the drive vendors are on board,
I guess we're okay.  :)

-Jeff

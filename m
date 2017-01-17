Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@ml01.01.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
References: <20170114002008.GA25379@linux.intel.com>
        <20170114082621.GC10498@birch.djwong.org>
        <x49wpduzseu.fsf@dhcp-25-115.bos.redhat.com>
        <20170117015033.GD10498@birch.djwong.org>
        <20170117075735.GB19654@infradead.org>
        <x49mvep4tzw.fsf@segfault.boston.devel.redhat.com>
        <20170117150638.GA3747@infradead.org>
Date: Tue, 17 Jan 2017 11:07:14 -0500
In-Reply-To: <20170117150638.GA3747@infradead.org> (Christoph Hellwig's
        message of "Tue, 17 Jan 2017 07:06:38 -0800")
Message-ID: <x49r3411xhp.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Jan 17, 2017 at 09:54:27AM -0500, Jeff Moyer wrote:
>> I spoke with Dave before the holidays, and he indicated that
>> PMEM_IMMUTABLE would be an acceptable solution to allowing applications
>> to flush data completely from userspace.  I know this subject has been
>> beaten to death, but would you mind just summarizing your opinion on
>> this one more time?  I'm guessing this will be something more easily
>> hashed out at LSF, though.
>
> Come up with a prototype that doesn't suck and allows all fs features to
> actually work.

OK, I'll take this to mean that PMEM_IMMUTABLE is a non-starter.
Perhaps synchronous page faults (or whatever you want to call it) would
work, but...

> And show an application that actually cares and shows benefits on
> publicly available real hardware.

This is the crux of the issue.

> Until then go away and stop wasting everyones time.

Fair enough.  It seems fairly likely that this sort of functionality
would provide a big benefit.  But I agree we should have a real-world
use case as proof.

Thanks,
Jeff

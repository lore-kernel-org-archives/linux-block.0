Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33823 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbcEIUkF (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2016 16:40:05 -0400
Received: by mail-oi0-f48.google.com with SMTP id k142so224900458oib.1
        for <linux-block@vger.kernel.org>; Mon, 09 May 2016 13:40:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160509125735.GA4476@infradead.org>
References: <146274690999.10891.10714722986208180484.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20160509125735.GA4476@infradead.org>
Date: Mon, 9 May 2016 13:40:03 -0700
Message-ID: <CAPcyv4gskZwMBMoW6pW=0U71kmxFMpC+QWaJQhFkFbdGac6EdA@mail.gmail.com>
Subject: Re: [PATCH 0/7] "Device DAX" for persistent memory
From: Dan Williams <dan.j.williams@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvdimm <linux-nvdimm@ml01.01.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Chinner <david@fromorbit.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
	Jan Kara <jack@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ross Zwisler <ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 9, 2016 at 5:57 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sun, May 08, 2016 at 03:35:10PM -0700, Dan Williams wrote:
>> Device DAX is the device-centric analogue of Filesystem DAX
>> (CONFIG_FS_DAX).  It allows memory ranges to be allocated and mapped
>> without need of an intervening file system or being bound to block
>> device semantics.  Device DAX is strict and predictable.  Specifically
>> this interface:
>
> Can you explain the "why" a little more?

1/ As I mentioned at LSF [1] we're starting to see platforms with
performance and feature differentiated memory ranges.  Environments
like high-performance-computing and usages like in-memory databases
want 100% exclusive allocation of a memory range with zero conflicting
kernel/metadata allocations.  For dedicated applications of high
bandwidth or low latency memory device-DAX provides a predictable
direct map mechanism.

Note that this is only for the small number of "crazy" applications
that are willing to re-write to get every bit of performance.  For
everyone else we, Dave Hansen and I, are looking to add a mechanism to
hot-plug device-DAX ranges into the mm to get general memory
management services (oversubscribe / migration, etc) with the
understanding that it may sacrifice some predictability.

2/ For persistent memory there are similar applications that are
willing to re-write to take full advantage of byte-addressable
persistence.  This mechanism satisfies those usages that only need a
pre-allocated file to mmap.

3/ It answers Dave Chinner's call to start thinking about pmem-native
solutions.  Device DAX specifically avoids block-device and file
system conflicts.

> And please, if you decide to Cc me on some of the patches do it for the
> whole series or none of it, but never just for some patches as that make
> the cc pretty pointless.

Sorry, you've told me this before.  I'll update my scripts to
auto-include you on the whole series if you ever appear in the cc of
any patch in the set.

[1]: https://lwn.net/Articles/685107/

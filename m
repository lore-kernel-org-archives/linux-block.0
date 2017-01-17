Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Mon, 16 Jan 2017 23:57:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Jeff Moyer <jmoyer@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@ml01.01.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
Message-ID: <20170117075735.GB19654@infradead.org>
References: <20170114002008.GA25379@linux.intel.com>
 <20170114082621.GC10498@birch.djwong.org>
 <x49wpduzseu.fsf@dhcp-25-115.bos.redhat.com>
 <20170117015033.GD10498@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170117015033.GD10498@birch.djwong.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 16, 2017 at 05:50:33PM -0800, Darrick J. Wong wrote:
> I wouldn't consider it a barrier in general (since ext4 also prints
> EXPERIMENTAL warnings for DAX), merely one for XFS.  I don't even think
> it's that big of a hurdle -- afaict XFS ought to be able to achieve this
> by modifying iomap_begin to allocate new pmem blocks, memcpy the
> contents, and update the memory mappings.  I think.

Yes, and I have a working prototype for that.  I'm just way to busy
with lots of bugfixing at the moment but I plan to get to it in this
merge window.  I also agree that we can't mark a feature as fully
supported until it doesn't conflict with other features.

And I'm not going to get start on the PMEM_IMMUTABLE bullshit, please
don't even go there folks, it's a dead end.


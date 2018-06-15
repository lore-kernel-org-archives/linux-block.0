Return-Path: <mgorman@novell.com>
Date: Fri, 15 Jun 2018 10:23:05 +0100
From: Mel Gorman <mgorman@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Adam Manzanares <Adam.Manzanares@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA node
Message-ID: <20180615092305.e3k3fvqhkspbrba3@novell.com>
References: <20180614133832.110947-1-hare@suse.de>
 <08318d74-d81c-29e5-5350-525df96eaacb@kernel.dk>
 <20180614172954.79965d13@pentland.suse.de>
 <656e4ab7-7c5c-41af-5596-2e155ffb28e4@kernel.dk>
 <20180614180937.591bb361@pentland.suse.de>
 <eca17002-e8dc-1a8b-6cc3-5eaf49031636@wdc.com>
 <bb90d333-fe4d-aa97-6c1c-66fb5b88dd6b@kernel.dk>
 <53893c29-febc-14ff-314d-818ac79aa559@wdc.com>
 <5f21f241-0ae0-ed7a-6935-3ef6e65d0950@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <5f21f241-0ae0-ed7a-6935-3ef6e65d0950@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 14, 2018 at 02:47:39PM -0600, Jens Axboe wrote:
> >>> Will numactl ... modprobe brd ... solve this problem?
> >>
> >> It won't, pages are allocated as needed.
> >>
> > 
> > Then how about a numactl ... dd /dev/ram ... after the modprobe.
> 
> Yes of course, or you could do that for every application that ends
> up in the path of the doing IO to it. The point of the option is to
> just make it explicit, and not have to either NUMA pin each task,
> or prefill all possible pages.
> 

It's certainly possible from userspace using dd and numactl setting the
desired memory policy. mmtests has the following snippet when setting
up a benchmark using brd to deal with both NUMA artifacts and variable
performance due to first faults early in the lifetime of a benchmark.

                modprobe brd rd_size=$((TESTDISK_RD_SIZE/1024))
                if [ "$TESTDISK_RD_PREALLOC" == "yes" ]; then
                        if [ "$TESTDISK_RD_PREALLOC_NODE" != "" ]; then
                                tmp_prealloc_cmd="numactl -N $TESTDISK_RD_PREALLOC_NODE"
                        else
                                tmp_prealloc_cmd="numactl -i all"
                        fi
                        $tmp_prealloc_cmd dd if=/dev/zero of=/dev/ram0 bs=1M &>/dev/null
                fi

(Haven't actually validated this in a long time but it worked at some point)

First option allocates just from one node, the other interleaves between
everything. Any combination of nodes or policies can be used and this was
very simple, but it's what was needed at the time. The question is how
far do you want to go with supporting policies within the module?

One option would be to keep this very simple like the patch suggests so users
get the hint that it's even worth considering and then point at a document
on how to do more complex policies from userspace at device creation time.
Another is simply to document the hazard that the locality of memory is
controlled by the memory policy of the first task that touches it.

-- 
Mel Gorman
SUSE Labs

Return-Path: <jgg@ziepe.ca>
Return-Path: <jgg@ziepe.ca>
Date: Tue, 22 May 2018 10:45:06 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Swapnil Ingle <swapnil.ingle@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: Re: [PATCH v2 00/26] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Message-ID: <20180522164506.GC3311@ziepe.ca>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 03:03:47PM +0200, Roman Pen wrote:
> Hi all,
> 
> This is v2 of series, which introduces IBNBD/IBTRS modules.
> 
> This cover letter is split on three parts:
> 
> 1. Introduction, which almost repeats everything from previous cover
>    letters.
> 2. Changelog.
> 3. Performance measurements on linux-4.17.0-rc2 and on two different
>    Mellanox cards: ConnectX-2 and ConnectX-3 and CPUs: Intel and AMD.
> 
> 
>  Introduction
> 
> IBTRS (InfiniBand Transport) is a reliable high speed transport library
> which allows for establishing connection between client and server
> machines via RDMA. It is optimized to transfer (read/write) IO blocks
> in the sense that it follows the BIO semantics of providing the
> possibility to either write data from a scatter-gather list to the
> remote side or to request ("read") data transfer from the remote side
> into a given set of buffers.
> 
> IBTRS is multipath capalbdke and provides I/O fail-over and load-balancing
> functionality, i.e. in IBTRS terminology, an IBTRS path is a set of RDMA
> CMs and particular path is selected according to the load-balancing policy.
> 
> IBNBD (InfiniBand Network Block Device) is a pair of kernel modules
> (client and server) that allow for remote access of a block device on
> the server over IBTRS protocol. After being mapped, the remote block
> devices can be accessed on the client side as local block devices.
> Internally IBNBD uses IBTRS as an RDMA transport library.
> 
> Why?
> 
>    - IBNBD/IBTRS is developed in order to map thin provisioned volumes,
>      thus internal protocol is simple.
>    - IBTRS was developed as an independent RDMA transport library, which
>      supports fail-over and load-balancing policies using multipath, thus
>      it can be used for any other IO needs rather than only for block
>      device.
>    - IBNBD/IBTRS is faster than NVME over RDMA.
>      Old comparison results:
>      https://www.spinics.net/lists/linux-rdma/msg48799.html
>      New comparison results: see performance measurements section below.
> 
> Key features of IBTRS transport library and IBNBD block device:
> 
> o High throughput and low latency due to:
>    - Only two RDMA messages per IO.
>    - IMM InfiniBand messages on responses to reduce round trip latency.
>    - Simplified memory management: memory allocation happens once on
>      server side when IBTRS session is established.
> 
> o IO fail-over and load-balancing by using multipath.  According to
>   our test loads additional path brings ~20% of bandwidth.  
> 
> o Simple configuration of IBNBD:
>    - Server side is completely passive: volumes do not need to be
>      explicitly exported.
>    - Only IB port GID and device path needed on client side to map
>      a block device.
>    - A device is remapped automatically i.e. after storage reboot.
> 
> Commits for kernel can be found here:
>    https://github.com/profitbricks/ibnbd/commits/linux-4.17-rc2
> 
> The out-of-tree modules are here:
>    https://github.com/profitbricks/ibnbd/
> 
> Vault 2017 presentation:
>    http://events.linuxfoundation.org/sites/events/files/slides/IBNBD-Vault-2017.pdf

I think from the RDMA side, before we accept something like this, I'd
like to hear from Christoph, Chuck or Sagi that the dataplane
implementation of this is correct, eg it uses the MRs properly and
invalidates at the right time, sequences with dma_ops as required,
etc.

They all have done this work on their ULPs and it was tricky, I don't
want to see another ULP implement this wrong..

I'm skeptical here already due to the performance numbers - they are
not really what I'd expects and we may find that invalidate changes
will bring the performance down further.

Jason

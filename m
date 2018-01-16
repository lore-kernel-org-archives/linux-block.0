Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "tytso@mit.edu" <tytso@mit.edu>,
	"willy@infradead.org" <willy@infradead.org>
Date: Tue, 16 Jan 2018 23:57:45 +0000
Message-ID: <1516147064.2844.66.camel@wdc.com>
References: <20180116145240.GD30073@bombadil.infradead.org>
	<20180116232335.GM8249@thunk.org>
	<1516145316.14734.11.camel@HansenPartnership.com>
In-Reply-To: <1516145316.14734.11.camel@HansenPartnership.com>
MIME-Version: 1.0
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] A high-performance userspace block
	driver
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-01-16 at 15:28 -0800, James Bottomley wrote:
> On Tue, 2018-01-16 at 18:23 -0500, Theodore Ts'o wrote:
> > On Tue, Jan 16, 2018 at 06:52:40AM -0800, Matthew Wilcox wrote:
> > > 
> > > 
> > > I see the improvements that Facebook have been making to the nbd
> > > driver, and I think that's a wonderful thing.  Maybe the outcome of
> > > this topic is simply: "Shut up, Matthew, this is good enough".
> > > 
> > > It's clear that there's an appetite for userspace block devices;
> > > not for swap devices or the root device, but for accessing data
> > > that's stored in that silo over there, and I really don't want to
> > > bring that entire mess of CORBA / Go / Rust / whatever into the
> > > kernel to get to it, but it would be really handy to present it as
> > > a block device.
> > 
> > ... and using iSCSI was too painful and heavyweight.
> 
> From what I've seen a reasonable number of storage over IP cloud
> implementations are actually using AoE.  The argument goes that the
> protocol is about ideal (at least as compared to iSCSI or FCoE) and the
> company behind it doesn't seem to want to add any more features that
> would bloat it.

Has anyone already looked into iSER, SRP or NVMeOF over rdma_rxe over the
loopback network driver? I think all three driver stacks support zero-copy
receiving, something that is not possible with iSCSI/TCP nor with AoE.

Bart.
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc

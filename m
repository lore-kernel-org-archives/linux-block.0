Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Tue, 16 Jan 2018 18:23:35 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20180116232335.GM8249@thunk.org>
References: <20180116145240.GD30073@bombadil.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20180116145240.GD30073@bombadil.infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
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

On Tue, Jan 16, 2018 at 06:52:40AM -0800, Matthew Wilcox wrote:
> 
> I see the improvements that Facebook have been making to the nbd driver,
> and I think that's a wonderful thing.  Maybe the outcome of this topic
> is simply: "Shut up, Matthew, this is good enough".
> 
> It's clear that there's an appetite for userspace block devices; not for
> swap devices or the root device, but for accessing data that's stored
> in that silo over there, and I really don't want to bring that entire
> mess of CORBA / Go / Rust / whatever into the kernel to get to it,
> but it would be really handy to present it as a block device.

... and using iSCSI was too painful and heavyweight.

Google has an iblock device implementation, so you can use that as
confirmation that there certainly has been a desire for such a thing.
In fact, we're happily using it in production even as we speak.

We have been (tentatively) planning on presenting it at OSS North
America later in the year, since the Vault conference is no longer
with us, but we could probably put together a quick presentation for
LSF/MM if there is interest.

There were plans to do something using page cache tricks (what we were
calling the "zero copy" option), but we decided to start with
something simpler, more reliable, so long as it was less overhead and
pain than iSCSI (which was simply an over-engineered solution for our
use case), it was all upside.

						- Ted
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc

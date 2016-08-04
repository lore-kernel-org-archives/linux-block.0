Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Thu, 4 Aug 2016 08:46:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Mike Christie <mchristi@redhat.com>, philipp.reisner@linbit.com,
	dm-devel@redhat.com, target-devel@vger.kernel.org,
	linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
	linux-scsi@vger.kernel.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>, konrad.wilk@oracle.com,
	XFS Developers <xfs@oss.sgi.com>, linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
	osd-dev@open-osd.org, Ross Zwisler <zwisler@gmail.com>,
	Jens Axboe <axboe@fb.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lars.ellenberg@linbit.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 37/45] drivers: use req op accessor
Message-ID: <20160804154622.GB15656@infradead.org>
References: <1465155145-10812-1-git-send-email-mchristi@redhat.com>
 <1465155145-10812-38-git-send-email-mchristi@redhat.com>
 <CAOxpaSUMsgfTYsL0bL6VCnwxz7bpgpKO-ZfC5J8dFG9PN-hzvg@mail.gmail.com>
 <87fbe31f-27b3-ff7a-e381-34fc1aad337e@redhat.com>
 <CAJVOszAd9Eu88P2=QoNVArd0jwDH7KRe=OB82tCNMpjfv9B4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJVOszAd9Eu88P2=QoNVArd0jwDH7KRe=OB82tCNMpjfv9B4KA@mail.gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 03, 2016 at 07:30:29PM -0500, Shaun Tancheff wrote:
> I think the translation in loop.c is suspicious here:
> 
>     "if use DIO && not (a flush_flag or discard_flag)"
> should translate to:
>     "if use DIO && not ((a flush_flag) || op == discard)"
> 
> But in the patch I read:
>     "if use DIO && ((not a flush_flag) || op == discard)
> 
> Which would have DIO && discards follow the AIO path?

Indeed.  Sorry for missing out on your patch, I just sent a fix
in reply to Dave's other report earlier which is pretty similar to
yours.

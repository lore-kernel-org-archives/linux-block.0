Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17226 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161516AbcFBQ7J (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 2 Jun 2016 12:59:09 -0400
Date: Thu, 2 Jun 2016 09:58:13 -0700
From: Shaohua Li <shli@fb.com>
To: Sitsofe Wheeler <sitsofe@gmail.com>, <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<snitzer@redhat.com>, <axboe@fb.com>, <martin.petersen@oracle.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH] block: correctly fallback for zeroout
Message-ID: <20160602165813.GA18527@shli-mbp.local>
References: <20160527054918.GA9521@sucs.org>
 <20160528092755.GB938@sucs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160528092755.GB938@sucs.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, May 28, 2016 at 10:27:55AM +0100, Sitsofe Wheeler wrote:
> On Sat, May 28, 2016 at 08:55:43AM +0000, Sitsofe Wheeler wrote:
> > On Thu, May 26, 2016 at 11:08:14AM -0700, Shaohua Li wrote:
> > > blkdev_issue_zeroout try discard/writesame first, if they fail, zeroout
> > > fallback to regular write. The problem is discard/writesame doesn't
> > > return error for -EOPNOTSUPP, then zeroout can't do fallback and leave
> > > disk data not changed. zeroout should have guaranteed zero-fill
> > > behavior.
> > 
> > It sounds like at least this patch should go in so BLKZEROOUT can always
> > fall back (since those zeros are essential) but it would still be nice
> > to see the disabling of write same being copied up to md device's
> > write_same_max_bytes so everyone knows not to try using it in the future
> > but perhaps someone will say "what if I re-enable it on the device
> > below?" etc.
> 
> I've tested Shaohua's original patch on top of Linus' tree and even
> without the suggested changes (above and below) it at least resolves the
> success being returned but data not being zeroed (with both PVSCSI and
> scsi_debug underlying devices) issue so:
> 
> Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>

Jens,

any chance you could merge this one? I'll fix the MD part later and make sure
write_same_max_bytes sets to 0 after IO failure.

Thanks,
Shaohua

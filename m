Return-Path: <wim@djo.tudelft.nl>
Date: Mon, 25 Jul 2016 20:09:03 +0200
From: Wim Osterholt <wim@djo.tudelft.nl>
To: Jiri Kosina <jikos@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
  linux-block@vger.kernel.org, Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
Message-ID: <20160725180903.GA7065@djo.tudelft.nl>
Reply-To: wim@djo.tudelft.nl
References: <20160610230255.GA27770@djo.tudelft.nl>
 <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm>
 <20160614184308.GA6188@djo.tudelft.nl>
 <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm>
 <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm>
 <20160615224722.GA9545@djo.tudelft.nl>
 <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 30, 2016 at 01:18:00PM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Commit 09954bad4 ("floppy: refactor open() flags handling"), as a 
> side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that 
> this is being used setfdprm userspace for ioctl-only open().
> 
> Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE) 
> modes, while still keeping the original O_NDELAY bug fixed.
> 
> Cc: stable@vger.kernel.org # v4.5+
> Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
> Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
> Jens, this should preferably go into 4.7-rcX and to -stable as well.
> 

How come this patch is still not in the recent release of 4.7 ?



Regards, Wim.

Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
To: Jiri Kosina <jikos@kernel.org>
References: <20160610230255.GA27770@djo.tudelft.nl>
 <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm>
 <20160614184308.GA6188@djo.tudelft.nl>
 <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm>
 <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm>
 <20160615224722.GA9545@djo.tudelft.nl>
 <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Wim Osterholt <wim@djo.tudelft.nl>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
Date: Mon, 25 Jul 2016 14:48:54 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/30/2016 05:18 AM, Jiri Kosina wrote:
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

Added for this series, thanks.

-- 
Jens Axboe

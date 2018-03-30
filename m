Return-Path: <linux-ide-owner@vger.kernel.org>
Date: Fri, 30 Mar 2018 11:47:24 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: 4.16-rc2+git: pata_serverworks: hanging ata detection thread on
 HP DL380G3
In-Reply-To: <1597679.yzYZqmDdA5@amdc3058>
Message-ID: <alpine.LRH.2.21.1803301144380.11026@math.ut.ee>
References: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee> <alpine.LRH.2.21.1803291153070.12825@math.ut.ee> <CGME20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f@epcas2p2.samsung.com> <1597679.yzYZqmDdA5@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Added CC-s, start of the thread is at 
https://lkml.org/lkml/2018/2/26/165

> > > 4.16 git bootup on HP Proliant DL380 G3 pauses for a a minute or two and 
> > > then continues with "blocked for more than 120 seconds" message with 
> > > libata detection functions in ther stack - 
> > > async_synchronize_cookie_domain() as the last. It seems to happen during 
> > > IDE CD-ROM detection (detected before but registered as sr0 after the 
> > > warning). After detection, the eject button on the drive did not work.
> > > 
> > > 
> > > pata_serverworks is the libata driver in use.
> 
> There were no changes to pata_serverworks since 2014 and libata changes
> in v4.16 look obviously correct..
> 
> > This is still the same in 4.16.0-rc7-00062-g0b412605ef5f.
> 
> Any chance that you could bisect this issue?

Bisected to the following commit:

358f70da49d77c43f2ca11b5da584213b2add29c is the first bad commit
commit 358f70da49d77c43f2ca11b5da584213b2add29c
Author: Tejun Heo <tj@kernel.org>
Date:   Tue Jan 9 08:29:50 2018 -0800

    blk-mq: make blk_abort_request() trigger timeout path
    
    With issue/complete and timeout paths now using the generation number
    and state based synchronization, blk_abort_request() is the only one
    which depends on REQ_ATOM_COMPLETE for arbitrating completion.
    
    There's no reason for blk_abort_request() to be a completely separate
    path.  This patch makes blk_abort_request() piggyback on the timeout
    path instead of trying to terminate the request directly.
    
    This removes the last dependency on REQ_ATOM_COMPLETE in blk-mq.
    
    Note that this makes blk_abort_request() asynchronous - it initiates
    abortion but the actual termination will happen after a short while,
    even when the caller owns the request.  AFAICS, SCSI and ATA should be
    fine with that and I think mtip32xx and dasd should be safe but not
    completely sure.  It'd be great if people who know the drivers take a
    look.
    
    v2: - Add comment explaining the lack of synchronization around
          ->deadline update as requested by Bart.
    
    Signed-off-by: Tejun Heo <tj@kernel.org>
    Cc: Asai Thambi SP <asamymuthupa@micron.com>
    Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
    Cc: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
    Cc: Bart Van Assche <Bart.VanAssche@wdc.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

:040000 040000 b5c8c2fd69850021865071f9641d54ab4fd20a15 e2dbd2a15a6baeec1332cc1416e51d537ff5040a M      block


-- 
Meelis Roos (mroos@linux.ee)

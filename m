Return-Path: <prvs=781eb9476=roger.pau@citrix.com>
Date: Fri, 7 Sep 2018 09:54:55 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe
	<axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <drbd-user@lists.linbit.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
Message-ID: <20180907075455.szxahgevvlmfjvwy@mac.bytemobile.com>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
 <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
 <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
 <20180907072319.GA26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180907072319.GA26705@gavran.carpriv.carnet.hr>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 09:23:19AM +0200, Valentin Vidic wrote:
> On Fri, Sep 07, 2018 at 09:15:30AM +0200, Roger Pau Monn� wrote:
> > I'm not sure that's a good idea, there are a lot of backends (apart
> > from blkback), and the tools won't know whether a specific backend
> > supports such state or not. Also the current protocol and states are
> > shared between all the Xen PV devices, so new additions should be
> > considered very carefully.
> 
> Sure, I understand.
> 
> > IMO the best options are either calling vbd_free/vbd_create at proper
> > stages in blkback or changing the hotplug script so it waits for the
> > device to have no open clients.
> 
> Changing the block-drbd script would be ideal for me too, but I don't
> think that piece of DRBD state is exposed at the moment.

Then I'm afraid you will have to look into the vbd_free/create fix.

Thanks, Roger.

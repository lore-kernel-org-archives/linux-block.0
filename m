Return-Path: <Valentin.Vidic@carnet.hr>
Date: Fri, 7 Sep 2018 09:23:19 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180907072319.GA26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
 <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
 <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 09:15:30AM +0200, Roger Pau Monn� wrote:
> I'm not sure that's a good idea, there are a lot of backends (apart
> from blkback), and the tools won't know whether a specific backend
> supports such state or not. Also the current protocol and states are
> shared between all the Xen PV devices, so new additions should be
> considered very carefully.

Sure, I understand.

> IMO the best options are either calling vbd_free/vbd_create at proper
> stages in blkback or changing the hotplug script so it waits for the
> device to have no open clients.

Changing the block-drbd script would be ideal for me too, but I don't
think that piece of DRBD state is exposed at the moment.

-- 
Valentin

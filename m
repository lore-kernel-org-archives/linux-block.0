Return-Path: <jgross@suse.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe
 <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <1701ccef-3ebb-973b-de32-059a8816d31c@suse.com>
 <20180829082731.GX26705@gavran.carpriv.carnet.hr>
 <b67866fc-13b7-ef88-c8db-2745127e5f6a@suse.com>
 <20180829092329.GY26705@gavran.carpriv.carnet.hr>
From: Juergen Gross <jgross@suse.com>
Message-ID: <7afb803f-a2d2-73c8-f2d3-8b866dc89e87@suse.com>
Date: Wed, 29 Aug 2018 11:29:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180829092329.GY26705@gavran.carpriv.carnet.hr>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 29/08/18 11:23, Valentin Vidic wrote:
> On Wed, Aug 29, 2018 at 10:43:48AM +0200, Juergen Gross wrote:
>> I think this should be an action triggered by the frontend, not by dom0
>> (xen tools will always set "online" to 0 when removing a device, AFAIK).
>>
>> I'm not sure this is relevant, but I realized this behavior is changed
>> by your patch.
> 
> Can't find any place in xen-blkfront.c (or the rest of the kernel) where
> the "online" value gets set, so it seems xen tools in dom0 is the only
> thing that modifies this Xenbus node?
> 

I think so, yes.

It will be set to "1" at device creation and to "0" when removing the
device, both times by Xen tools.


Juergen

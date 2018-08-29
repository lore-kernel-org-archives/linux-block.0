Return-Path: <Valentin.Vidic@carnet.hr>
Date: Wed, 29 Aug 2018 10:27:31 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Juergen Gross <jgross@suse.com>
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Message-ID: <20180829082731.GX26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <1701ccef-3ebb-973b-de32-059a8816d31c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1701ccef-3ebb-973b-de32-059a8816d31c@suse.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 29, 2018 at 10:16:09AM +0200, Juergen Gross wrote:
> Did you test whether it is okay to not change state in case the device
> is still online?

Not sure how to simulate that. Maybe using xl block-detach or something else?

-- 
Valentin

Return-Path: <axboe@kernel.dk>
Date: Mon, 16 Apr 2018 21:50:43 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Laurent Vivier <lvivier@redhat.com>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/10] SWIM driver fixes
Message-ID: <20180417035041.GA19502@kernel.dk>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1804160904530.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.21.1804160904530.8@nippy.intranet>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 17 2018, Finn Thain wrote:
> On Wed, 11 Apr 2018, I wrote:
> 
> > This patch series has fixes for bugs in the SWIM floppy disk controller 
> > driver, including an oops and a soft lockup.
> > 
> 
> Apparently no-one is authorized to push this series intact.
> 
> Geert, would you please take just the first two patches?
> 
> Jens, would you please take the remaining 8 patches?
> 
> I have confirmed that no merge conflicts or bisection issues arise from 
> splitting up this series in this way. However, I can re-send these patches 
> as separate submission(s) if need be...

I've picked up 3-10, thanks.

-- 
Jens Axboe

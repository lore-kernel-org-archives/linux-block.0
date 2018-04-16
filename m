Return-Path: <fthain@telegraphics.com.au>
Date: Tue, 17 Apr 2018 09:27:03 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
cc: Laurent Vivier <lvivier@redhat.com>, linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH v2 00/10] SWIM driver fixes
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.21.1804160904530.8@nippy.intranet>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 11 Apr 2018, I wrote:

> This patch series has fixes for bugs in the SWIM floppy disk controller 
> driver, including an oops and a soft lockup.
> 

Apparently no-one is authorized to push this series intact.

Geert, would you please take just the first two patches?

Jens, would you please take the remaining 8 patches?

I have confirmed that no merge conflicts or bisection issues arise from 
splitting up this series in this way. However, I can re-send these patches 
as separate submission(s) if need be...

-- 

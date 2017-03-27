Return-Path: <prvs=425928092f=shli@fb.com>
Date: Mon, 27 Mar 2017 12:00:44 -0700
From: Shaohua Li <shli@fb.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, <jmoyer@redhat.com>,
        <Kernel-team@fb.com>
Subject: Re: [PATCH V7 00/18] blk-throttle: add .low limit
Message-ID: <20170327190043.GA96008@dhcp-172-20-189-90.dhcp.thefacebook.com>
References: <cover.1490634565.git.shli@fb.com>
 <dfc4078b-a130-2997-9c44-20d3d17db9cc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <dfc4078b-a130-2997-9c44-20d3d17db9cc@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 27, 2017 at 12:15:29PM -0600, Jens Axboe wrote:
> On 03/27/2017 11:51 AM, Shaohua Li wrote:
> > V6->V7:
> > - Don't overload blk stat, which will simplify the code. This will add extra
> >   space in bio/request though with the low interface configure option on.
> 
> Hmm, why? As far as I can see, it just makes things worse.

Part of the reason is the new callback based blk stat makes enabling stat less
straightforward. I probably can create a fake callback and enalbing the stat
though. Only the last 3 patches depend on this, if you prefer, I can resend
them and add the overload back.

Thanks,
Shaohua

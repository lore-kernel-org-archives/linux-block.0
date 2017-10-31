Return-Path: <zhangweiping@didichuxing.com>
Date: Tue, 31 Oct 2017 18:30:06 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Jan Kara <jack@suse.cz>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/4] bdi: add check for bdi_debug_root
Message-ID: <20171031103006.GA1616@source.didichuxing.com>
References: <cover.1509038624.git.zhangweiping@didichuxing.com>
 <883f8bb529fbde0d4adc2b78ba3bbda81e1ce6a0.1509038624.git.zhangweiping@didichuxing.com>
 <20171030130028.GG23278@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20171030130028.GG23278@quack2.suse.cz>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 30, 2017 at 02:00:28PM +0100, Jan Kara wrote:
> On Fri 27-10-17 01:35:36, weiping zhang wrote:
> > this patch add a check for bdi_debug_root and do error handle for it.
> > we should make sure it was created success, otherwise when add new
> > block device's bdi folder(eg, 8:0) will be create a debugfs root directory.
> > 
> > Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> > ---
> >  mm/backing-dev.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> These functions get called only on system boot - ENOMEM in those cases is
> generally considered fatal and oopsing is acceptable result. So I don't
> think this patch is needed.
> 
OK, I drop this patch.

Thanks a ton.

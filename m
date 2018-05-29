Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754646AbeE2Goa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 May 2018 02:44:30 -0400
Date: Tue, 29 May 2018 08:44:28 +0200
From: Hannes Reinecke <hare@suse.de>
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/4] bcache: Move couple of string arrays to sysfs.c
Message-ID: <20180529084428.3a84957f@pentland.suse.de>
In-Reply-To: <20180528073744.71258-3-colyli@suse.de>
References: <20180528073744.71258-1-colyli@suse.de>
        <20180528073744.71258-3-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 28 May 2018 15:37:42 +0800
Coly Li <colyli@suse.de> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> There is couple of string arrays that are used exclusively in sysfs.c.
> Move it to there and make them static.
> 
> Besides above, it will allow further clean up.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/bcache.h |  2 --
>  drivers/md/bcache/super.c  | 18 ------------------
>  drivers/md/bcache/sysfs.c  | 18 ++++++++++++++++++
>  3 files changed, 18 insertions(+), 20 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

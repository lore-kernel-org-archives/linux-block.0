Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32773 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754646AbeE2GpK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 May 2018 02:45:10 -0400
Date: Tue, 29 May 2018 08:45:09 +0200
From: Hannes Reinecke <hare@suse.de>
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/4] bcache: Move couple of functions to sysfs.c
Message-ID: <20180529084509.27a79e02@pentland.suse.de>
In-Reply-To: <20180528073744.71258-4-colyli@suse.de>
References: <20180528073744.71258-1-colyli@suse.de>
        <20180528073744.71258-4-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 28 May 2018 15:37:43 +0800
Coly Li <colyli@suse.de> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> There is couple of functions that are used exclusively in sysfs.c.
> Move it to there and make them static.
> 
> Besides above, it will allow further clean up.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/sysfs.c | 35 +++++++++++++++++++++++++++++++++++
>  drivers/md/bcache/util.c  | 35 -----------------------------------
>  drivers/md/bcache/util.h  |  5 -----
>  3 files changed, 35 insertions(+), 40 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

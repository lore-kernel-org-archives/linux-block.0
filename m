Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754466AbeE2GqC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 May 2018 02:46:02 -0400
Date: Tue, 29 May 2018 08:45:58 +0200
From: Hannes Reinecke <hare@suse.de>
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/4] bcache: Replace bch_read_string_list() by
 __sysfs_match_string()
Message-ID: <20180529084558.6b1e46d2@pentland.suse.de>
In-Reply-To: <20180528073744.71258-5-colyli@suse.de>
References: <20180528073744.71258-1-colyli@suse.de>
        <20180528073744.71258-5-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 28 May 2018 15:37:44 +0800
Coly Li <colyli@suse.de> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Kernel library has a common function to match user input from sysfs
> against an array of strings. Thus, replace bch_read_string_list() by
> __sysfs_match_string().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/sysfs.c | 44
> ++++++++------------------------------- 1 file changed, 9
> insertions(+), 35 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

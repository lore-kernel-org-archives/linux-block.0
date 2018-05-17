Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35559 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEQOsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 May 2018 10:48:32 -0400
Date: Thu, 17 May 2018 10:48:28 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] bcache: return 0 from bch_debug_init() if
 CONFIG_DEBUG_FS=n
Message-ID: <20180517144828.GA8223@kmo-pixel>
References: <20180517143254.48670-1-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180517143254.48670-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 17, 2018 at 10:32:54PM +0800, Coly Li wrote:
> Commit 539d39eb2708 ("bcache: fix wrong return value in bch_debug_init()")
> returns the return value of debugfs_create_dir() to bcache_init(). When
> CONFIG_DEBUG_FS=n, bch_debug_init() always returns 1 and makes
> bcache_init() failedi.
> 
> This patch makes bch_debug_init() always returns 0 if CONFIG_DEBUG_FS=n,
> so bcache can continue to work for the kernels which don't have debugfs
> enanbled.
> 
> Fixes: Commit 539d39eb2708 ("bcache: fix wrong return value in bch_debug_init()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Coly Li <colyli@suse.de>
> Reported-by: Massimo B. <massimo.b@gmx.net>
> Reported-by: Kai Krakow <kai@kaishome.de>
> Tested-by: Kai Krakow <kai@kaishome.de>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>

Acked-by: Kent Overstreet <kent.overstreet@gmail.com>

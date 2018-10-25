Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f172.google.com ([209.85.214.172]:34512 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeJZFwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Oct 2018 01:52:22 -0400
Received: by mail-pl1-f172.google.com with SMTP id f10-v6so4468661plr.1
        for <linux-block@vger.kernel.org>; Thu, 25 Oct 2018 14:18:03 -0700 (PDT)
Date: Thu, 25 Oct 2018 14:18:01 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 0/2] blktests: New loop tests
Message-ID: <20181025211801.GB29982@vader>
References: <20181018103147.3567-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018103147.3567-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 18, 2018 at 12:31:45PM +0200, Jan Kara wrote:
> 
> Hello,
> 
> these two patches create two new tests for blktests as regression tests
> for my recently posted loopback device fixes. More details in individual
> patches.

Thanks, Jan, I applied 007 renamed to 006.

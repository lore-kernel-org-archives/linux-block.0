Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41140 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWHQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Oct 2018 03:16:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5-v6so4825176plq.8
        for <linux-block@vger.kernel.org>; Mon, 22 Oct 2018 15:55:59 -0700 (PDT)
Date: Mon, 22 Oct 2018 15:55:56 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 2/2] loop/007: Add test for oops during backing file
 verification
Message-ID: <20181022225556.GC10074@vader>
References: <20181018103147.3567-1-jack@suse.cz>
 <20181018103147.3567-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018103147.3567-3-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Oct 18, 2018 at 12:31:47PM +0200, Jan Kara wrote:
> Add regression test for patch "block/loop: Use global lock for ioctl()
> operation." where we can oops while traversing list of loop devices
> backing newly created device.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good, sans a missing addition to src/.gitignore. I can fix that
and apply this once I hear back regarding the other test.

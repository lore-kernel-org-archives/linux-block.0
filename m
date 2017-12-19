Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44346 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdLSXmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 18:42:21 -0500
Received: by mail-pl0-f68.google.com with SMTP id n13so7930557plp.11
        for <linux-block@vger.kernel.org>; Tue, 19 Dec 2017 15:42:21 -0800 (PST)
Date: Tue, 19 Dec 2017 15:42:19 -0800
From: Omar Sandoval <osandov@osandov.com>
To: xiao yang <yangx.jy@cn.fujitsu.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/013: Add test for BLKRRPART ioctl
Message-ID: <20171219234219.GA10242@vader.DHCP.thefacebook.com>
References: <20171204182953.GA16308@vader.DHCP.thefacebook.com>
 <1513679423-13067-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513679423-13067-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 19, 2017 at 06:30:23PM +0800, xiao yang wrote:
> If the entire block device is formatted with a filesystem and
> mounted, running "blockdev --rereadpt" should fail and return
> EBUSY instead of pass.
> 
> Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>

Thanks, applied (with some slight modifications to make it easier to
diagnose a failure).

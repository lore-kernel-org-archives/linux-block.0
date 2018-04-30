Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59701 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751304AbeD3WEG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 18:04:06 -0400
Date: Mon, 30 Apr 2018 22:04:04 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH dm-zoned-tools 2/2] README: fix example script
Message-ID: <20180430220404.GY27853@wotan.suse.de>
References: <20180430194520.9065-1-mcgrof@kernel.org>
 <20180430194520.9065-2-mcgrof@kernel.org>
 <9d60b721-6ca4-62cb-d801-a2fe901f4c72@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d60b721-6ca4-62cb-d801-a2fe901f4c72@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 30, 2018 at 08:36:09PM +0000, Damien Le Moal wrote:
> On 2018/04/30 12:45, Luis R. Rodriguez wrote:
> > The target type should be "zoned", not "dm-zoned".
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  README | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > The README does note explain if one should use dmzadm to format a drive
> > if using dm zone or only if one is to use a filesystem which supports
> > zones, such as f2fs. Or if we should *always* use dmzadm format regardless
> > of the circumstance.
> 
> dmzadm is only for dm-zoned device mapper. If the file system natively support
> zoned block devices, it is the FS problem to format the drive accordingly to
> ZBC/ZAC constraints.

The README could be update to reflect this then, just to be sure. Only now
that I realize it has the dm prefix did I realize this was an obvious
requirement :P

> And for these files systems, dm-zoned is useless.

Sure, make sense.

  Luis

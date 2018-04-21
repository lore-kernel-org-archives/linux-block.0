Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37699 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752629AbeDUACo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Apr 2018 20:02:44 -0400
Date: Sat, 21 Apr 2018 02:02:42 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bart.vanassche@wdc.com, ming.lei@redhat.com,
        rjw@rjwysocki.net, mguzik@redhat.com, linux-pm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: minor fs thaw fixes and adjustments
Message-ID: <20180421000242.GG14440@wotan.suse.de>
References: <20180420235904.27496-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180420235904.27496-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 20, 2018 at 04:59:01PM -0700, Luis R. Rodriguez wrote:
> Here's a few minor fs thaw fixes and adjustments I ran accross
> as I started to refresh my development for to use freeze_fs on
> suspend/hibernation [0]. These are just prep commits for the real
> work, I'm still reviewing feedback and adjusting the code for
> that.

And I forgot to provide the URL, for those that missed the old series
I was working on:

[0] https://lkml.kernel.org/r/20171129232356.28296-1-mcgrof@kernel.org

  Luis
> 
> I've tested the patches with generic/085 on xfs and found no regressions.
> 
> Luis R. Rodriguez (3):
>   fs: move documentation for thaw_super() where appropriate
>   fs: make thaw_super_locked() really just a helper
>   fs: fix corner case race on freeze_bdev() when sb disappears
> 
>  fs/block_dev.c |  4 +++-
>  fs/super.c     | 39 ++++++++++++++++++++++++++-------------
>  2 files changed, 29 insertions(+), 14 deletions(-)
> 
> -- 
> 2.16.3
> 
> 

-- 
Do not panic

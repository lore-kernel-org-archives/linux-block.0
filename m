Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37663 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbdHUQp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 12:45:29 -0400
Received: by mail-pg0-f43.google.com with SMTP id y129so102969329pgy.4
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2017 09:45:29 -0700 (PDT)
Date: Mon, 21 Aug 2017 09:45:07 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 2/3] loop: use queue limit instead of private
 lo_logical_blocksize
Message-ID: <20170821164507.GA7079@vader.DHCP.thefacebook.com>
References: <cover.1503084216.git.osandov@fb.com>
 <561f8505816afb6d0dacd4697087141c95566225.1503084216.git.osandov@fb.com>
 <645c909a-4f93-30d2-4d10-28b131b686df@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <645c909a-4f93-30d2-4d10-28b131b686df@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 21, 2017 at 07:58:52AM +0200, Hannes Reinecke wrote:
> On 08/18/2017 09:27 PM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > There's no reason to track this separately; just use the
> > logical_block_size queue limit.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  drivers/block/loop.c | 44 ++++++++++++++++++--------------------------
> >  drivers/block/loop.h |  1 -
> >  2 files changed, 18 insertions(+), 27 deletions(-)
> > 
> 
> Curiously enough, this is what I attempted initially.
> But that got shut down due to incompability.
> In the hope that you'll succeed:

Is that thread archived anywhere? I don't see how this would be a
compatability problem, it doesn't change the behavior if you're not
using the new option, and if you are using the new option then there's
no compatability to speak of.

> Reviewed-by: Hannes Reinecke <hare@suse.com>

Thanks!

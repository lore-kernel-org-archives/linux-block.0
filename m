Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:60899 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752040AbcIIUPm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Sep 2016 16:15:42 -0400
Date: Fri, 9 Sep 2016 22:02:03 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mpa@pengutronix.de,
        nbd-general@lists.sourceforge.net
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160909200203.phhvodsfs7ymukfp@grep.be>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473369130-22986-1-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Josef,

On Thu, Sep 08, 2016 at 05:12:05PM -0400, Josef Bacik wrote:
> Apologies if you are getting this a second time, it appears vger ate my last
> submission.
> 
> ----------------------------------------------------------------------
> 
> This is a patch series aimed at bringing NBD into 2016.  The two big components
> of this series is converting nbd over to using blkmq and then allowing us to
> provide more than one connection for a nbd device.  The NBD user space server
> doesn't care about how many connections it has to a particular device, so we can
> easily open multiple connections to the server and allow blkmq to handle
> multi-plexing over the different connections.

I see some practical problems with this:
- You removed the pid attribute from sysfs (unless you added it back and
  I didn't notice, in which case just ignore this part). This kills
  userspace in two ways:
  - systemd/udev mark an NBD device as "not active" if the sysfs pid
    attribute is absent. Removing that attribute causes the new nbd
    systemd unit to stop working.
  - nbd-client -check relies on this attribute too, which means that
    even if people don't use systemd, their init scripts will still
    break, and vigilant sysadmins (who check before trying to connect
    something) will be surprised.
- What happens if userspace tries to connect an already-connected device
  to some other server? Currently that can't happen (you get EBUSY);
  with this patch, I believe it can, and data corruption would be the
  result (on *two* nbd devices). Additionally, with the loss of the pid
  attribute (as above) and the ensuing loss of the -check functionality,
  this might actually be a somewhat likely scenario.
- What happens if one of the multiple connections drop but the others do
  not?
- This all has the downside that userspace now has to predict how many
  parallel connections will be necessary and/or useful. If the initial
  guess was wrong, we don't have a way to correct later on.

My suggestion is to reject an additional connection unless it comes from
the same userspace process as the previous connections, and to retain
the pid attribute (since it is now guaranteed to be the same for all the
connections). That should fix the first two issues (while unfortunately
reinforcing the last one). The third would also need to have clearly
defined semantics, at the very least.

A better way, long term, would presumably be to modify the protocol to
allow multiplexing several requests in one NBD session. This would deal
with what you're trying to fix too[1], while it would not pull in all of
the above problems.

[1] after all, we have to serialize all traffic anyway, just before it
    heads into the NIC.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:60461 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933829AbcI2Qld (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 12:41:33 -0400
Date: Thu, 29 Sep 2016 18:41:00 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: axboe@fb.com, linux-block@vger.kernel.org, kernel-team@fb.com,
        nbd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20160929164100.akytbkbtvziwaqqj@grep.be>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
 <20160929095204.mexr6wpypo3bl6mx@grep.be>
 <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 29, 2016 at 10:03:50AM -0400, Josef Bacik wrote:
> So think of it like normal disks with multiple channels.  We don't send flushes 
> down all the hwq's to make sure they are clear, we leave that decision up to the 
> application (usually a FS of course).

Well, when I asked earlier, Christoph said[1] that blk-mq assumes that
when a FLUSH is sent over one channel, and the reply comes in, that all
commands which have been received, regardless of which channel they were
received over, have reched disk.

[1] Message-ID: <20160915122304.GA15501@infradead.org>

It is impossible for nbd to make such a guarantee, due to head-of-line
blocking on TCP.

[...]
> perhaps we could add a flag later that says send all the flushes down
> all the connections for the paranoid, it should be relatively
> straightforward to do.  Thanks,

That's not an unreasonable approach, I guess.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12

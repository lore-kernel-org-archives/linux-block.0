Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:48267 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754596AbcIIUI2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Sep 2016 16:08:28 -0400
Date: Fri, 9 Sep 2016 22:08:16 +0200
From: Wouter Verhelst <w@uter.be>
To: Jens Axboe <axboe@fb.com>
Cc: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        mpa@pengutronix.de, nbd-general@lists.sourceforge.net
Subject: Re: [Nbd] [PATCH 0/5] nbd improvements
Message-ID: <20160909200816.spdbyericjehvmcq@grep.be>
References: <1473363221-142264-1-git-send-email-jbacik@fb.com>
 <aee66977-c8f2-dab7-0649-f4e71fdc31f8@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aee66977-c8f2-dab7-0649-f4e71fdc31f8@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

On Thu, Sep 08, 2016 at 02:13:46PM -0600, Jens Axboe wrote:
> Not only are these nice performance improvements, it also cleans up the
> code a lot and kills crufty old driver code in favor of using the proper
> APIs instead. I have applied the series for 4.9.

Please ensure that the comments I made in my other mail are addressed
before you push this to Linus; otherwise this will result in significant
problems for userspace (that it would then be my responsibility to deal
with).

Thanks,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12

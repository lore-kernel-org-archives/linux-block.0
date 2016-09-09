Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:50580 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751008AbcIIQPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Sep 2016 12:15:05 -0400
Message-ID: <1473437700.13672.43.camel@perches.com>
Subject: Re: [PATCH 3/5] nbd: use flags instead of bool
From: Joe Perches <joe@perches.com>
To: Jens Axboe <axboe@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mpa@pengutronix.de,
        nbd-general@lists.sourceforge.net
Date: Fri, 09 Sep 2016 09:15:00 -0700
In-Reply-To: <9ddc6c54-72cd-b3d4-d7f3-f96dc33164fc@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
         <1473369130-22986-4-git-send-email-jbacik@fb.com>
         <1473384038.13672.23.camel@perches.com>
         <bda72452-8a5f-8a6a-2409-145585ea41f5@fb.com>
         <1473437068.13672.41.camel@perches.com>
         <9ddc6c54-72cd-b3d4-d7f3-f96dc33164fc@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2016-09-09 at 10:11 -0600, Jens Axboe wrote:
> The variable is called 'runtime_flags' - if that doesn't already tell
> the reader how it's used, then I'd suggest the reader go read something
> else.
> 
> I'm all for using established APIs where it makes sense. Declaring a
> bitmap for a few fields isn't that.

Deviating from established APIs makes no sense.



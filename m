Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A2EC433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 20:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E12611BD
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 20:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhESUVv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 16:21:51 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:45611 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhESUVq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 16:21:46 -0400
Received: by mail-pl1-f180.google.com with SMTP id s4so6145747plg.12;
        Wed, 19 May 2021 13:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7pIVQq0PnktpSK+lfLROl6H6C/pzsbZBvrItiTclLY=;
        b=oBj4eCnv6yrihUX5AsiUXEvlxbqeY28SBsP8csIuj3W1vHbEOUodEFzQz5WBD+seSY
         xKQ3E4OcEuhDzn9tKfub81R23RBTrkGGcjnfe2m6TXgJB4+a0it2DkVPQo/zPXuojEHW
         7ZbkdWEA3lriinTnWdJEONZudQCD3RvyPChjHa8XdMtqFlt+gLuqqAm1qXpSn6FdOBfH
         Or1xS9CrtSNk3hDrLkYi/4/I9S4qNh9tN5bk4ivySj5t6ZRJuY3XrQ2Mbv7Wg7BaqRes
         tOAKwN8DUQ3OexwIvOkmvlxCyeyoaQNe6S/D8D0V+uFRcJ8jPlkyosYLEH/1bic3J3+9
         xcug==
X-Gm-Message-State: AOAM533LxPUGp4Werpa5YKoHZiyoWRS3WyYVZZGMetUEL/gxk9hTqpbF
        TXs0BLeUB7/MZLdgwz6RjHU=
X-Google-Smtp-Source: ABdhPJxM/U4TCGgtxjcCaOQo0b0hukqDOiRHuf7ZbAmq+/PbvuDjkIuXHmqAWMEVcaQF7USSNnT66A==
X-Received: by 2002:a17:90b:70c:: with SMTP id s12mr770606pjz.98.1621455625777;
        Wed, 19 May 2021 13:20:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n23sm210960pff.93.2021.05.19.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:20:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 69C7A40321; Wed, 19 May 2021 20:20:23 +0000 (UTC)
Date:   Wed, 19 May 2021 20:20:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <20210519202023.GU4332@42.do-not-panic.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKVwZVcbZBNXUpKm@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greg,

your feedback would be appreciated here.

On Wed, May 19, 2021 at 01:09:09PM -0700, Minchan Kim wrote:
> On Fri, Apr 23, 2021 at 01:11:04AM +0000, Luis Chamberlain wrote:
> > This 2nd series documents the fixes better and includes a bdgrab() fix
> > for the issue noted by Minchan. A general fix has been proposed for two
> > of these issues however they are not yet deemed required upstream and so
> > we just open code individual solutions on the driver.
> > 
> > Luis Chamberlain (4):
> >   zram: fix crashes due to use of cpu hotplug multistate
> >   zram: avoid disksize setting when device is being claimed
> >   zram: fix deadlock with sysfs attribute usage and driver removal
> >   zram: fix possible races between sysfs use and bdev access
> > 
> >  drivers/block/zram/zram_drv.c | 473 +++++++++++++++++++++++++++++-----
> >  1 file changed, 414 insertions(+), 59 deletions(-)
> 
> Hi Luis,
> 
> First of all, I am sorry too late review. Now I see [3/4] and [4/4] would
> be not only zram issue since you shed a light in the descriptions.
> Yeah, that would be helpful if it could be deal with under general
> layer but looks like arguable or would take some times at least, IIUC.
> 
> On the case, yeah, we could fix it for zram first until the issue will
> bring up further. Anyway, I'd like to see some wrapper rather than annotating
> for every sysfs files for maintainance point of view.
> At least, could you introduce one more patch "introduce zram sysfs wrapper"
> on top of this series to centralize the work?
> 
> Thanks for your works!

Since I did the work for a general fix as an alternative proof of
concept to the ugliness reflected on those two last patches, I'd like
instead for Greg to re-consider merging a general fix.

Greg, can you comment on technical levels why a general core fix is not
desirable upstream for those two issues?

Based on feedback from folks, it does not seem the argument that we
don't support rmmod holds water.  Specially given we are now even
discussing using live patching to suport error injection as a strategy
to not incur more code / boiler plate code even on the block layer [0].
The live patching approach would mean for testing purposes we'd
temporarily use error injection via live patching and then remove the
module after done testing.

[0] http://lkml.kernel.org/r/989175a7-5533-02ef-c096-b24b2769c9cf@suse.de

  Luis

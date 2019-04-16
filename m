Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A9C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDF720872
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZY6AAPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfDPRIu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:08:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46369 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 13:08:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so10620474pll.13
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2019 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qVk2Hbf5CAhCXzTP7UUpKL5VCnc73vFnFLLFJ4eq7X4=;
        b=kZY6AAPmOvbd4UqymoQDsUqhuXdIOh/6yg4WfR1oUv/oIJyTzHEYdehtq5fb1uAUmq
         AGc57zqt29G+xZhyRt2IIfGWCDzouMuUxU0qkO972C1DiNOQ6UDTaic3CDG7c2I/a5nk
         emEmIgGp4qw1nUcJk7xncCWW6jx1a1H7duvqPICevUQ8izSof4uiNwVwMltjehUPElE+
         Qyzii4fLvj7y7EcrirE7+u+RjfP2LDsWuvI8+tkzHnwyEWl0rZbqxBWqePQrLwTGVi6c
         Gdk0TayoCV1GSDPTEirP9v6fwekko6DzcD+DbimvezYyGxb6d3XXRi0toWkmynIm+W3A
         MObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qVk2Hbf5CAhCXzTP7UUpKL5VCnc73vFnFLLFJ4eq7X4=;
        b=ITzFEPXlbuKpzSGFiqbyHDCwohVfCu6hugt2CEgH6IwPGtqIiT56nYStAHnwsG7Z1P
         N4bwBXGBSNrzFYXGerTWpU3bu/05w0VpK96ZZ7C5ZkOcuyMFdCGsBkQLt0ScgjfJ1Qp5
         CACepB2gXjPxsAVyyonWNqOt3DAJYSvRwJBnu7bWeLTxe7jmLAbqeGBzihzTAIMnJMdY
         N0lDQ9Wvuvi6o+XxGvnM5SWOaaEfxcSS0I4UWtgZnxyzuGNG1tbuX6JfinkhiF4ml9r8
         OljlPeYkP0qGID5t0LRgmTlMgUJGj5LL+tbxZz5X8FpeTLSBTgPL4RpSSn5m62hdweZq
         Mptg==
X-Gm-Message-State: APjAAAVK/odTqVkgKRmnrxdIusP942wJXrMEtGA9stiHDb6jZV+03z3z
        Fop2ciwcHNm/uHGzF84bnFg=
X-Google-Smtp-Source: APXvYqyWa330kZVVCCnMHdQsbd3YSIUEPbZAUggDFYuLw1Sa39Tet6x6m0SLoDgyfaCNyfQcgkkiSQ==
X-Received: by 2002:a17:902:bd0c:: with SMTP id p12mr56746456pls.50.1555434529603;
        Tue, 16 Apr 2019 10:08:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4sm101428979pfh.146.2019.04.16.10.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:08:48 -0700 (PDT)
Date:   Tue, 16 Apr 2019 10:08:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190416170847.GA5531@roeck-us.net>
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-2-hch@lst.de>
 <20190415194435.GA23676@roeck-us.net>
 <20190415205242.GA6380@lst.de>
 <20190415210731.GA32723@roeck-us.net>
 <20190416063356.GA25763@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416063356.GA25763@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 16, 2019 at 08:33:56AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 15, 2019 at 02:07:31PM -0700, Guenter Roeck wrote:
> > On Mon, Apr 15, 2019 at 10:52:42PM +0200, Christoph Hellwig wrote:
> > > On Mon, Apr 15, 2019 at 12:44:35PM -0700, Guenter Roeck wrote:
> > > > This patch causes crashes with various boot tests. Most sparc tests crash, as
> > > > well as several arm tests. Bisect results in both cases point to this patch.
> > > 
> > > That just means we trigger an existing bug more easily now.  I'll see
> > > if I can help with the issues.
> > 
> > Code which previously worked reliably no longer does. I would be quite
> > hesitant to call this "trigger an existing bug more easily". "Regression"
> > seems to be a more appropriate term - even more so as it seems to cause
> > 'init' crashes, at least on arm.
> 
> Well, we have these sgls in the wild already, it just is that they

That is besides the point. Your code changes an internal API to be more
stringent and less forgiving. This causes failures, presumably because
callers of that API took advantage (on purpose or not) of it.
When changing an API, you are responsible for both ends. You can not claim
that the callers of that API are buggy. Taking advangage of a forgiving
API is not a bug. If you change an API, and that change causes a failure,
that is a regression, not a bug on the side of the caller.

On top of that, an API change causing roughly 4% of my boot tests to fail
is a serious regression. Those boot tests don't really do anything besides
trying to boot the system. If 4% of those tests fail, I don't even want to
know what else is going to fail when your patch (or patch series) hits
mainline. Your patch should be reverted until that is resolved. If making
the API more stringent / less forgiving indeed makes sense and improves code
quality and/or performance, the very least would be to change the code to
still accept what it used to accept before but generate a traceback.
That would let people fix the calling code without making systems unusable.
This is even more true with failures like the one I observed on arm,
where your patch causes init to crash without clear indication of the
root cause of that crash.

Guenter

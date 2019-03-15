Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C767BC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 06:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F261218A5
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 06:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfCOGaj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:30:39 -0400
Received: from nautica.notk.org ([91.121.71.147]:56501 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfCOGaj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 02:30:39 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 38059C009; Fri, 15 Mar 2019 07:30:37 +0100 (CET)
Date:   Fri, 15 Mar 2019 07:30:22 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] blktrace: change strncpy+truncation to strlcpy
Message-ID: <20190315063022.GA12910@nautica>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445162-19771-1-git-send-email-asmadeus@codewreck.org>
 <20190314213721.339979f0@oasis.local.home>
 <80ab6751-cd34-1da6-91c7-7558d3a17943@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80ab6751-cd34-1da6-91c7-7558d3a17943@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, Steven,

Jens Axboe wrote on Thu, Mar 14, 2019:
> On 3/14/19 7:37 PM, Steven Rostedt wrote:
> > I noticed this old patch in my inbox. It looks like a legit cleanup.
> > Want to take it?
> 
> Indeed, I've applied it. Thanks!

Thanks. I am terribly sorry about this patch series to be honest, I did
not prepare it properly and sent too many generic patches at once but
more importantly some were unsafe (strlcpy expects the input string to
be validly formatted, because it basically does strlen() on it to check
how much hasn't been copied for its return value)
I was pointed out strscpy instead as a safer alternative.

In this case `name` comes from bdevname() which is disk_name() in
block/partition-generic.c which is a snprintf, so we are guaranted
null truncation from there and it should be OK, but I wanted to check
and point it out.


Anyway, thanks!
-- 
Dominique

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB78C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C330161155
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhDHNRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhDHNRJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 09:17:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53C086113A;
        Thu,  8 Apr 2021 13:16:57 +0000 (UTC)
Date:   Thu, 8 Apr 2021 09:16:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210408091655.64905da9@gandalf.local.home>
In-Reply-To: <YG6gLd9bnDsXhrNx@kroah.com>
References: <YErOkGrvtQODXtB0@google.com>
        <20210312183238.GW4332@42.do-not-panic.com>
        <YEvA1dzDsFOuKdZ/@google.com>
        <20210319190924.GK4332@42.do-not-panic.com>
        <YFjHvUolScp3btJ9@google.com>
        <20210322204156.GM4332@42.do-not-panic.com>
        <YFkWMZ0m9nKCT69T@google.com>
        <20210401235925.GR4332@42.do-not-panic.com>
        <YGbNpLKXfWpy0ZZa@kroah.com>
        <20210407201746.ueijmegmpbyq5quv@treble>
        <YG6gLd9bnDsXhrNx@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 8 Apr 2021 08:18:21 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> And I would love a taint for rmmod, but what is that going to help out
> with?

Just like any other taint. If a rmmod can cause the system to lose
integrity, the rmmod could cause a subtle issue that manifests itself into
something more serious and may look unrelated. If you have a bug report
with the rmmod taint, one could ask to try to recreate the bug without
doing rmmod. Or perhaps we have a similar bug reports that all show the
rmmod taint. That would give us an impression that something was removed
and caused the system to lose stability.

-- Steve

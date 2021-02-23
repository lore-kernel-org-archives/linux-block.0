Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B430C433E6
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE1764E7C
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhBWRBS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 12:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233690AbhBWRBL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 12:01:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1770260295;
        Tue, 23 Feb 2021 17:00:30 +0000 (UTC)
Date:   Tue, 23 Feb 2021 12:00:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: remove debugfs file dentries from struct
 blk_trace
Message-ID: <20210223120028.36e2f438@gandalf.local.home>
In-Reply-To: <b0caa52e-5817-5ba4-29da-1444e6d6be86@kernel.dk>
References: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
        <20210222180255.1b117616@gandalf.local.home>
        <b0caa52e-5817-5ba4-29da-1444e6d6be86@kernel.dk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Feb 2021 09:54:22 -0700
Jens Axboe <axboe@kernel.dk> wrote:

> On 2/22/21 4:02 PM, Steven Rostedt wrote:
> > 
> > Jens,
> > 
> > I guess this goes through your tree.
> > 
> > I'm pinging you in case you did what I did, and confused this patch as one
> > of Greg's stable patches (which I almost archived as such)!
> > 
> > No, this is an actual update from Greg, not a patch that was backported.  
> 
> I did! Greg really needs an alter-ego for these kinds of patches.
> 

Or perhaps Greg needs to use "[UPSTREAM PATCH]" in his subjects for patches
he writes for upstream, to differentiate them from stable patches.

-- Steve

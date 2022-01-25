Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E5DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 20:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiAYUEY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 15:04:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41740 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiAYUDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 15:03:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212A161733;
        Tue, 25 Jan 2022 20:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDECC340E0;
        Tue, 25 Jan 2022 20:03:53 +0000 (UTC)
Date:   Tue, 25 Jan 2022 15:03:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
Message-ID: <20220125150352.147d3c58@gandalf.local.home>
In-Reply-To: <CAHbLzkq51-_Rxj0YyWR4qxQRzosvP2Tj6D52=OtCZUG_mydDBQ@mail.gmail.com>
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
        <CAHbLzkoUmhPbnt=yMfBSFs2G6r2S5ggD6AkYQvg0zxBAqQK2fA@mail.gmail.com>
        <20220125093702.3ffdb721@gandalf.local.home>
        <20220125093846.59826cad@gandalf.local.home>
        <CAHbLzkq51-_Rxj0YyWR4qxQRzosvP2Tj6D52=OtCZUG_mydDBQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 25 Jan 2022 11:58:10 -0800
Yang Shi <shy828301@gmail.com> wrote:

> Never mind. Other than the code restructure, I also found some data
> structure (struct request) and function (blk_fill_rwbs) change. I
> think I'd better rebase the patch to 5.17-rc1 then resubmit it. Since
> there is no fundamental change to the patch, can I keep your
> reviewed-by tag?

Sure, but please Cc me.

-- Steve

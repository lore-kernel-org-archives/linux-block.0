Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C04CC54FD0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AE42076A
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgD0RGR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:06:17 -0400
Received: from verein.lst.de ([213.95.11.211]:50039 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgD0RGR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 13:06:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C935B68C7B; Mon, 27 Apr 2020 19:06:13 +0200 (CEST)
Date:   Mon, 27 Apr 2020 19:06:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v3 0/9] Add a new LOOP_SET_FD_AND_STATUS ioctl
Message-ID: <20200427170613.GA13686@lst.de>
References: <20200427074222.65369-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-1-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've just been looking over the loop driver for other reasons,
and noticed that setting the block size still isn't possible
with LOOP_SET_FD_AND_STATUS as far as I can tell.  Might that
be worth it?  Also maybe an explicit direct I/O flag, and maybe
enough padding with a future proof flags bitmap that we can easily
extend it for new features if they pop up?

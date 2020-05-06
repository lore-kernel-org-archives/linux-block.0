Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D9C28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 05:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA047206F9
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 05:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEFFKn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 01:10:43 -0400
Received: from verein.lst.de ([213.95.11.211]:38823 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgEFFKm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 01:10:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87DA468C4E; Wed,  6 May 2020 07:10:39 +0200 (CEST)
Date:   Wed, 6 May 2020 07:10:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/10] loop: Refactor loop_set_status() size
 calculation
Message-ID: <20200506051039.GA9983@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-5-maco@android.com> <20200501173032.GD22792@lst.de> <CAB0TPYFJT5A-+T-B6tD1O0X8GGK_LFOpBDZv+fFc7LqDyN_aAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYFJT5A-+T-B6tD1O0X8GGK_LFOpBDZv+fFc7LqDyN_aAg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 01, 2020 at 09:33:23PM +0200, Martijn Coenen wrote:
> On Fri, May 1, 2020 at 7:30 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > For some reason this fails to apply for me against both
> > Jens' for-5.8/block and Linus' current tree.
> >
> > What is the baseline for this series?
> 
> This was based on Linus' tree from a week or two ago or so, but I
> think you're most likely missing this one?
> 
> https://lkml.org/lkml/2020/3/31/755
> 
> (I mentioned it in the cover letter, but can make it a part of this
> series if you prefer).

Yes, I missed that one.

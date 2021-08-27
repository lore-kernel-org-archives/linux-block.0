Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24115C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 15:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E443F604D7
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 15:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhH0PjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 11:39:05 -0400
Received: from verein.lst.de ([213.95.11.211]:34357 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhH0PjE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 11:39:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7988567373; Fri, 27 Aug 2021 17:38:12 +0200 (CEST)
Date:   Fri, 27 Aug 2021 17:38:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Milan Broz <gmazyland@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 5/8] loop: merge the cryptoloop module into the main
 loop module
Message-ID: <20210827153811.GA21217@lst.de>
References: <20210826133810.3700-1-hch@lst.de> <20210826133810.3700-6-hch@lst.de> <977860f6-efc4-a55e-50e3-c5204fc762c5@gmail.com> <20210826163422.GA28718@lst.de> <ebfe4404-e251-ec0d-e46d-0a02b031bcb2@gmail.com> <20210827064505.GA23147@lst.de> <3a2fcf7b-f5d6-bb12-65c7-c2ebc5975383@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a2fcf7b-f5d6-bb12-65c7-c2ebc5975383@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 08:33:10PM +0900, Tetsuo Handa wrote:
> I posted "[PATCH v5] block: genhd: don't call probe function with major_names_lock held"
> ( https://lkml.kernel.org/r/b2af8a5b-3c1b-204e-7f56-bea0b15848d6@i-love.sakura.ne.jp ) for v5.14 (and also stable),

And I've already told you that I think this is going in the wrong direction and
do not thing it is a good idea.

> and "[PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock"
> ( https://lkml.kernel.org/r/2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp ) for v5.15 (but not stable).

I will review this.

> Don't try to merge the cryptoloop module into the loop module now; it makes
> backporting the fix difficult.

Which is on the one true, on the other hand simply does not matter.

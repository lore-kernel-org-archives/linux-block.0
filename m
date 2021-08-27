Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52496C4320E
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366D060FD9
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbhH0PfH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 11:35:07 -0400
Received: from verein.lst.de ([213.95.11.211]:34339 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233303AbhH0PfG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 11:35:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50F5667373; Fri, 27 Aug 2021 17:34:16 +0200 (CEST)
Date:   Fri, 27 Aug 2021 17:34:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: sort out the lock order in the loop driver v2
Message-ID: <20210827153416.GB20687@lst.de>
References: <20210826133810.3700-1-hch@lst.de> <b34196f3-c407-1d8a-175c-485c4bf0b5d8@i-love.sakura.ne.jp> <20210827064049.GA23112@lst.de> <67aa49f1-c3d4-205f-fd08-0bc0dbcd3689@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67aa49f1-c3d4-205f-fd08-0bc0dbcd3689@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 04:46:42PM +0900, Tetsuo Handa wrote:
> On 2021/08/27 15:40, Christoph Hellwig wrote:
> > On Fri, Aug 27, 2021 at 09:30:12AM +0900, Tetsuo Handa wrote:
> >> Again crashed in 3 seconds. We can't accept this series.
> > 
> > Would you gladly point to the reproducer?
> > 
> 
> You can reach dashboard at https://syzkaller.appspot.com/bug?extid=$hashid where
> $hashid is Reporter's mail address <syzbot+$hashid@syzkaller.appspotmail.com> .
> For this bug report, the dashboard is https://syzkaller.appspot.com/bug?extid=f61766d5763f9e7a118f .
> Then, please find C repro column within the dashboard page. For this bug report, the C reproducer is
> https://syzkaller.appspot.com/text?tag=ReproC&x=13d20adc300000 .

Thank you very much!

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58047C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 06:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED2C60F4C
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 06:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbhH0Gll (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 02:41:41 -0400
Received: from verein.lst.de ([213.95.11.211]:32978 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhH0Gll (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 02:41:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DDCC16736F; Fri, 27 Aug 2021 08:40:49 +0200 (CEST)
Date:   Fri, 27 Aug 2021 08:40:49 +0200
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
Message-ID: <20210827064049.GA23112@lst.de>
References: <20210826133810.3700-1-hch@lst.de> <b34196f3-c407-1d8a-175c-485c4bf0b5d8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34196f3-c407-1d8a-175c-485c4bf0b5d8@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 09:30:12AM +0900, Tetsuo Handa wrote:
> Again crashed in 3 seconds. We can't accept this series.

Would you gladly point to the reproducer?

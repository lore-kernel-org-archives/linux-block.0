Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DD1C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCA16191E
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhCWTB4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 15:01:56 -0400
Received: from verein.lst.de ([213.95.11.211]:33812 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233244AbhCWTBs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 15:01:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 594FC68B02; Tue, 23 Mar 2021 20:01:45 +0100 (CET)
Date:   Tue, 23 Mar 2021 20:01:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323190145.GA17528@lst.de>
References: <20210322073726.788347-1-hch@lst.de> <20210322073726.788347-3-hch@lst.de> <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me> <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me> <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com> <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me> <20210323161544.GA13402@lst.de> <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me> <20210323182244.GA16649@lst.de> <c4ceed19-cdc5-aeca-0c4b-ebed088e8b82@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ceed19-cdc5-aeca-0c4b-ebed088e8b82@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 12:00:34PM -0700, Sagi Grimberg wrote:
>
>>> The deadlock in this patchset reproduces upstream. It is not possible to
>>> update the kernel in the env in the original report.
>>>
>>> So IFF we assume that this does not reproduce in upstream (pending
>>> proof), is there something that we can do with stable fixes? This will
>>> probably go back to everything that is before 5.8...
>>
>> The direct_make_request removal should be pretty easily backportable.
>
> Umm, the direct_make_request removal is based on the submit_bio_noacct
> rework you've done. Are you suggesting that we replace it with
> generic_make_request for these kernels?

Yes.

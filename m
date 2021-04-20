Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0F4C433B4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 09:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E2561107
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 09:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhDTJh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 05:37:56 -0400
Received: from verein.lst.de ([213.95.11.211]:49879 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDTJhy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 05:37:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC71A68C4E; Tue, 20 Apr 2021 11:37:20 +0200 (CEST)
Date:   Tue, 20 Apr 2021 11:37:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210420093720.GA28874@lst.de>
References: <20210416235329.49234-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> RHEL9 is coming, would really prefer that these changes land upstream
> rather than carry them within RHEL.

We've told from the very beginning that dm-multipth on nvme is not
a support configuration.  Red Hat decided to ignore that and live with the
pain.  Your major version change is a chance to fix this up on the Red Hat
side, not to resubmit bogus patches upstream.

In other words: please get your house in order NOW.

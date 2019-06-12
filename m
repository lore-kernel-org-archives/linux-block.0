Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B710C31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 10:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5639E2082C
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 10:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437971AbfFLKLd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:11:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437611AbfFLKLc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 06:11:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90F2C3007406;
        Wed, 12 Jun 2019 10:11:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5278B2CFA7;
        Wed, 12 Jun 2019 10:11:17 +0000 (UTC)
Date:   Wed, 12 Jun 2019 18:11:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: alternative take on the same page merging leak fix
Message-ID: <20190612101111.GA16000@ming.t460p>
References: <20190611151007.13625-1-hch@lst.de>
 <20190612010922.GA17522@ming.t460p>
 <20190612074527.GA20491@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612074527.GA20491@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 12 Jun 2019 10:11:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 12, 2019 at 09:45:27AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 12, 2019 at 09:09:23AM +0800, Ming Lei wrote:
> > We have to backport the fixes to -stable tree, and downstream need to
> > ship the fix too.
> > 
> > The issue is quite serious because the leak is in IO path and the whole
> > system ram can be used up easily on some workloads. So I think the fix
> > should be for 5.2, however, regression risk might be increased by
> > pulling cleanup & re-factor in now.
> > 
> > I really appreciate you may cook a fix-only patch for this issue.
> > Especially the change in add pc page code isn't necessary for fixing
> > the issue.
> 
> Patches 3 and 4 have no dependencies on 1 and 2, and should have
> arguably been ordered first in the series.

OK, that is good to make patch 3 &4 into 5.2, I will give a review
soon.

Thanks,
Ming

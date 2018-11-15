Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFB2C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 09:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F449223CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 09:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F449223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeKOTmR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:42:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeKOTmQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 14:42:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDB231555A;
        Thu, 15 Nov 2018 09:35:14 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A14041A930;
        Thu, 15 Nov 2018 09:35:07 +0000 (UTC)
Date:   Thu, 15 Nov 2018 17:35:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 00/19] block: support multi-page bvec
Message-ID: <20181115093502.GB5967@ming.t460p>
References: <20181113151505.15498-1-ming.lei@redhat.com>
 <20181114024455.GE6311@dastard>
 <20181114152252.GC22186@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114152252.GC22186@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 15 Nov 2018 09:35:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 07:22:52AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 14, 2018 at 01:44:55PM +1100, Dave Chinner wrote:
> > Can you please cc this entire patchset to linux-fsdevel? I've only
> > received 3-4 of the patches in this series and I can't make head or
> > tail of them because I haven't received the rest of the patches.
> 
> And to anyone else for that matter.  Adding a person or list to just
> a few patches is fundamentally stupid, don't ever do that.

Fine, I have added all related guys and lists into patch's CC list in V10,
which is posted out already.

I appreciate much if you guys may take a look at V10.

Thanks,
Ming

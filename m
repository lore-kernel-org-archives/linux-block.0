Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB42C6783B
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34E82084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34E82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLLAWo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbeLLAWo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 19:22:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB00A461CD;
        Wed, 12 Dec 2018 00:22:43 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F8585C228;
        Wed, 12 Dec 2018 00:22:39 +0000 (UTC)
Date:   Tue, 11 Dec 2018 19:22:39 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: for-next hangs on test srp/012
Message-ID: <20181212002238.GB20445@redhat.com>
References: <1544569107.185366.391.camel@acm.org>
 <20181211230514.GA20445@redhat.com>
 <1544569767.185366.393.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544569767.185366.393.camel@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 12 Dec 2018 00:22:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11 2018 at  6:09pm -0500,
Bart Van Assche <bvanassche@acm.org> wrote:

> On Tue, 2018-12-11 at 18:05 -0500, Mike Snitzer wrote:
> > On Tue, Dec 11 2018 at  5:58pm -0500,
> > Bart Van Assche <bvanassche@acm.org> wrote:
> > 
> > > Hi Jens,
> > > 
> > > If I run the following subset of blktests:
> > > 
> > >   while :; do ./check -q srp && ./check -q nvmeof-mp; done
> > > 
> > > against today's for-next branch (commit dd2bf2df85a7) then after some
> > > time the following hang is reported:
> > 
> > Jens has applied a fix from me today that I think is very relevant;
> > it'll be in tomorrow's for-next:
> > 
> > http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.21/block&id=c4576aed8d85d808cd6443bda58393d525207d01
> > 
> > Please try with that and see how things go.
> 
> Hi Mike,
> 
> Thank you for your reply. I should have mentioned that I used Jens' for-next
> branch as starting point and that that commit is present in the branch I used
> as a starting point for my tests:
> 
> $ git branch --contains c4576aed8d85d808cd6443bda58393d525207d01    
> * axboe-block-for-next

next-20181211 doesn't contain c4576aed8d85d808cd6443bda58393d525207d01

I'll try to reproduce, but in the meantime can you just try jens'
for-4.21/block?  It is currently 2c4d5356e64

Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D368FC65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A7A2084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 18:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A7A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeLLSKs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:10:48 -0500
Received: from linode.aoot.com ([69.164.194.13]:40552 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbeLLSKr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 13:10:47 -0500
Received: from stevoacer (47-221-137-213.gtwncmta03.res.dyn.suddenlink.net [47.221.137.213])
        by linode.aoot.com (Postfix) with ESMTP id 360578285;
        Wed, 12 Dec 2018 12:10:47 -0600 (CST)
From:   "Steve Wise" <swise@opengridcomputing.com>
To:     "'Sagi Grimberg'" <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc:     <linux-block@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Keith Busch'" <keith.busch@intel.com>
References: <20181211233652.9705-1-sagi@grimberg.me> <02a201d49239$0b00f3f0$2102dbd0$@opengridcomputing.com> <bd50927c-c72b-01f6-bad7-080076610cde@grimberg.me>
In-Reply-To: <bd50927c-c72b-01f6-bad7-080076610cde@grimberg.me>
Subject: RE: [PATCH RFC 0/4] restore polling to nvme-rdma
Date:   Wed, 12 Dec 2018 12:10:45 -0600
Message-ID: <033101d49246$00d1c320$02754960$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEbJkp2FK6IJZkEqzZVYGFa+MjfAAIDSCYyAoZmJJymyfDnwA==
Content-Language: en-us
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > Hey Sagi,
> 
> Hi Steve,
> 
> > Is there no way to handle this in the core?  Maybe have the polling context
> > transition to DIRECT when the queue becomes empty and before re-arming
> the
> > CQ?
> 
> That is what I suggested, but that would mean that we we need to drain
> the cq before making the switch, which means we need to allocate a
> dedicated qp for that cq, and even that doesn't guarantee that the
> ULP is not posting other wrs on its own qp(s)...
> 
> So making this safe for infight I/O would be a challenge... If we end
> up agreeing that we are ok with this functionality, I'd much rather not
> deal with it and simply document "use with care".
> 
> > So ib_change_cq_ctx() would be called to indicate the change should
> > happen when it is safe to do so.
> 
> You lost me here... ib_change_cq_ctx would get called by who and when?

I didn't look in detail at your changes, but ib_change_cq_ctx() is called by the application, right?  I was just asking what if the semantics of the call were "change the context when it is safe to do so" vs "do it immediately and hope there are no outstanding WRs".   But I don't think this semantic change simplifies the problem.  




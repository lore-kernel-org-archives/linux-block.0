Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1992C67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BBC2145D
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 13:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BBC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeLNNAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:00:24 -0500
Received: from verein.lst.de ([213.95.11.211]:47259 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbeLNNAY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 08:00:24 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 044B968DEE; Fri, 14 Dec 2018 14:00:23 +0100 (CET)
Date:   Fri, 14 Dec 2018 14:00:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: misc block cleanups
Message-ID: <20181214130022.GA11066@lst.de>
References: <20181213203214.10650-1-hch@lst.de> <5a57919d-7098-8b00-bc72-54538d384d09@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a57919d-7098-8b00-bc72-54538d384d09@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 09:28:33PM -0700, Jens Axboe wrote:
> On 12/13/18 1:32 PM, Christoph Hellwig wrote:
> > Remove a few pointless helpers and unused exports.
> 
> We've got quite a bit of churn this round, do you mind if we
> push #1 to next round? I'm fine with killing the exports, if
> they are not used, they should go.

Sure, fine with me.  Are you going to drop the accidental hunk
yourself or should I resend?

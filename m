Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCAAC5CFFE
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 11:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F49120870
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 11:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F49120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeLJLRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:17:31 -0500
Received: from verein.lst.de ([213.95.11.211]:48268 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLJLRb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 06:17:31 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C2BBE6732D; Mon, 10 Dec 2018 12:17:29 +0100 (CET)
Date:   Mon, 10 Dec 2018 12:17:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Todd Aiken <taiken@mvtech.ca>,
        Keith Busch <keith.busch@intel.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Restore tape support
Message-ID: <20181210111729.GA21553@lst.de>
References: <20181210030814.13235-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210030814.13235-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 09, 2018 at 07:08:14PM -0800, Bart Van Assche wrote:
> According to what I found in
> https://bugzilla.kernel.org/show_bug.cgi?id=201935 patch "block: Clear
> kernel memory before copying to user" broke tape access. Hence revert
> that patch.

This looks wrong.  The patch from Keith is obviously correct for
normal usage of bio_copy_user_iov.  The SCSI tape drivers use the
somewhat odd null_mapped case, so we probably need to refine the checks
for that a bit.

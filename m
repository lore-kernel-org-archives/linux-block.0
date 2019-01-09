Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29381C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E1F20657
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 18:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfAISlG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:41:06 -0500
Received: from verein.lst.de ([213.95.11.211]:43377 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfAISlG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 13:41:06 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 286EA68DD2; Wed,  9 Jan 2019 19:41:05 +0100 (CET)
Date:   Wed, 9 Jan 2019 19:41:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling
 scsi_add_host()
Message-ID: <20190109184105.GB22070@lst.de>
References: <20190108205043.3122-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108205043.3122-1-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks good.  I wonder if there is any good way to prevent other
drivers from picking up this bug byt using a better interface, but
that should not delay your fix.

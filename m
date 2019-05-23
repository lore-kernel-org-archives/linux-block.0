Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F9BC282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9989120863
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 14:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfEWOLS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 10:11:18 -0400
Received: from verein.lst.de ([213.95.11.211]:47114 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWOLR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 10:11:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CCF5E68AFE; Thu, 23 May 2019 16:10:54 +0200 (CEST)
Date:   Thu, 23 May 2019 16:10:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] Reset timeout for paused hardware
Message-ID: <20190523141054.GA19635@lst.de>
References: <20190522174812.5597-1-keith.busch@intel.com> <20190523032925.GA10601@ming.t460p> <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com> <20190523101311.GB15492@lst.de> <20190523132304.GB14049@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523132304.GB14049@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 23, 2019 at 07:23:04AM -0600, Keith Busch wrote:
> > Figure 49: Asynchronous Event Information - Notice
> > 
> > 1h		Firmware Activation Starting: The controller is starting
> > 		a firmware activation process during which command
> > 		processing is paused. Host software may use CSTS.PP to
> > 		determine when command processing has resumed. To clear
> > 		this event, host software reads the Firmware Slot
> > 		Information log page.
> > 
> > So we are supposed to get an AEN before the device stops processing
> > commands.
> 
> Hm, I read the same section, but conclude differently (and at least some
> vendors did too). A spec compliant controller activating new firmware
> without reset would stop processing commands and set CSTS.PP first,
> then send the AEN. When the host is aware to poll Processing Paused,
> the controller hasn't been processing new commands for some time.
> 
> Could you give some more detail on your interpretation?

What would be the point of the AEN if it wasn't sent at exactly
the point when the controller stops acceppting command?

The wording is of course NVMe-like, but "The controller is starting a.."
pretty clear implies this is sent at the beginning of the paused
state, not the end.

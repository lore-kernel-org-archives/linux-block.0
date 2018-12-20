Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F61C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 07:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972CD20815
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 07:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeLTHMf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:12:35 -0500
Received: from verein.lst.de ([213.95.11.211]:51298 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbeLTHMf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 02:12:35 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CFE8668AA6; Thu, 20 Dec 2018 08:12:33 +0100 (CET)
Date:   Thu, 20 Dec 2018 08:12:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] bsg: deprecate BIDI support in bsg
Message-ID: <20181220071233.GA9895@lst.de>
References: <20181219143934.3910-1-hch@lst.de> <1545260831.185366.484.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545260831.185366.484.camel@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 03:07:11PM -0800, Bart Van Assche wrote:
> On Wed, 2018-12-19 at 15:39 +0100, Christoph Hellwig wrote:
> > Besides the OSD command set that never got traction, the only SCSI
> > command using bidirectional buffers is XDWRITEREAD in the 10 and 32
> > byte variants, which is extremely esoteric.  It probably doesn't make
> > sense to keep the support code around just for that, so start
> > deprecating the support.
> 
> You may want to add to the patch description that the XDWRITEREAD command
> has been removed from the latest version of SBC-4 (SBC4r15).

Oh, I didn't even noticed that, thanks!

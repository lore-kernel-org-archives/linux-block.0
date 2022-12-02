Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFFCC4708D
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 18:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiLBS21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 13:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiLBS2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 13:28:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E069E5AB8;
        Fri,  2 Dec 2022 10:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ED47B82233;
        Fri,  2 Dec 2022 18:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BAEC433C1;
        Fri,  2 Dec 2022 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670005692;
        bh=assX6AclUULnaB5DHYKUr0RJBOXXDomk1Zc7tzDb7Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uFxgVPm6BtFBne/h+c87PP/DLRh0ig7G1PUCeOnDKuDFzOPdmM7VVAvZP+iQ1ZB4
         2l66AR2tJbwO+sjhq/Q3AIDIlpdLZ/LZ5wWhNc2Sa/YvBwzVf4863mwlCIlbZMVYO1
         xv8lvvxbZ8T3/XaXCzNrwSL64mviaR1DWUXaoKhQ=
Date:   Fri, 2 Dec 2022 19:28:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blkdev: make struct block_device_operations.devnode()
 take a const *
Message-ID: <Y4pDuSd2wkCyarCf@kroah.com>
References: <20221109144843.679668-1-gregkh@linuxfoundation.org>
 <Y3NYI04dFGgtQke9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3NYI04dFGgtQke9@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 15, 2022 at 01:13:07AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 09, 2022 at 03:48:43PM +0100, Greg Kroah-Hartman wrote:
> > The devnode() callback in struct block_device_operations should not be
> > modifying the device that is passed into it, so mark it as a const * and
> > propagate the function signature changes out into the one subsystem that
> > actually uses this callback.
> 
> Yes.  In fact it really shouldn't exist at all.  I wonder if we can
> do another attempt at dropping pktcdvd?
> 

Patch removing it now sent.

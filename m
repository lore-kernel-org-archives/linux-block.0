Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1501C433E1
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF5F322D06
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596770680;
	bh=RJ45wmBMUe6xMFzcXJs/9JOy6dpvl3djVMKZygZP1Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V5+y4HNFnEMggK2rQzNDjlp5Brqe+F/EwXzt0HINWXZV7dVq12CxLOJGJwDFw531s
	 Y03QFAQqAF9ChFgoizWCiZGP21plA5cq5ZeabmF3k/XGUiL5vZt96t8iiejKUW0KRZ
	 WWEKA8FgPexjp+lT4Zmp5nl8QzMf6Pmw+e4tZLz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgHGDYk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHGDYk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Aug 2020 23:24:40 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C74F2086A;
        Fri,  7 Aug 2020 03:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596770679;
        bh=RJ45wmBMUe6xMFzcXJs/9JOy6dpvl3djVMKZygZP1Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKvJ5629uOx3/4USbh2KBTLx0IFNwPWsKczU2D3AB2s6uA0sIR4ev3ywWiQtZetW+
         +BaK800siqWDrWSPRFAnEFctfcNeGQZxgsSk1s4bDOliDv58KSFXMZgVUnvpPABOP9
         wKj7K6mDwrJ3DXDfKv0qQCCUgV/ET0CDuo/IqCtc=
Date:   Thu, 6 Aug 2020 20:24:37 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Eric Deal <eric.deal@wdc.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: fix get_max_io_size()
Message-ID: <20200807032437.GC3797376@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200806215837.3968445-1-kbusch@kernel.org>
 <88d4db76-b912-8987-cfac-a2b926fbfe3d@acm.org>
 <c2275412-5106-e0a3-63db-a7b0ceedd1d3@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2275412-5106-e0a3-63db-a7b0ceedd1d3@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 06, 2020 at 06:25:50PM -0700, Bart Van Assche wrote:
> This should work better than what was mentioned in my previous email:
> 
> -	return sectors & (lbs - 1);
> +	return sectors;

It used to be something like that. There were some situations where it
didn't work, which brought d0e5fbb01a67e, but I think the real problem
was from mismatched queue_limits, which I think I addressed with
5f009d3f8e668, so maybe this is okay now.

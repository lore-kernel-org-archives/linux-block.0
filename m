Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDF2C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D73C20715
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574881748;
	bh=UqhatcLR9LOxkP1ncrlrHAD7fkzxOKAPqpZZMh3TRYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jFjDDTuNAH0XmdR1ZqgKus80i7iRPg9nshHFzSIPxdYSB+vdOVNk8esg++UddhB1r
	 P03Khyh3AOKDDY1iMJi5fTsjfJ4A1I0dG3VkgQT3d9BUT9WHoXwyej+PZ7Me7OhXQr
	 K0MLj5D3B2mLo69gsiIBzSE/3HYR7ksUNFyDURk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK0TJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfK0TJH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 14:09:07 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89854204FD;
        Wed, 27 Nov 2019 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574881746;
        bh=UqhatcLR9LOxkP1ncrlrHAD7fkzxOKAPqpZZMh3TRYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w9lHJilaBv2YyLvgX30eneNq5uGG3Z7cF5NVWt5j//AFTmw3bdCLs+vo49WsHHsic
         WFBoNGez1LazROdQXKVdsiDkmfbOgr4UeVnnyK8DruvwSCLiC5A3YEgRH2SJor6c1n
         C6jybFzunZHpL/6TNi+ACTDOXlMmZ5YZ9oqU4L3c=
Date:   Thu, 28 Nov 2019 04:08:59 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Meneghini, John" <John.Meneghini@netapp.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jen Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Message-ID: <20191127190859.GA2050@redsun51.ssa.fujisawa.hgst.com>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
 <20191126162412.GA7663@lst.de>
 <AC3DED38-491E-4778-88E0-DEC84031A115@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AC3DED38-491E-4778-88E0-DEC84031A115@netapp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 27, 2019 at 03:29:58PM +0000, Meneghini, John wrote:
> On 11/26/19, 11:24 AM, "Christoph Hellwig" <hch@lst.de> wrote:
>     > I agree we need to make this status a non-path error, but we at least
>     > need an Ack from Jens or have this patch go through linux-block if we're
>     > changing BLK_STS_RESOURCE to mean a non-path error.
>  
>    >>> most resource errors are per-path, so blindly changing this is wrong.
>     
>   >>> That's why I really just wanted to decode the nvme status codes inside
>   >>>  nvme instead of going through a block layer mapping, as that is just
>   >>> bound to lose some information.
>     
> It wasn't my intention to turn NVME_SC_CMD_INTERRUPTED into non-path related error.
> The goal was to make the command retry after CDR on the same controller.  So why 
> does this patch change the meaning of BLK_STS_RESOURCE?

What I meant by a "non-path error" is that those types of errors for
nvme go through the "normal" requeuing that checks CRD. The failover
requeuing does not check CRD. But thinking again, I don't see why the
failover side can't also be CRD aware.

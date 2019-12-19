Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634CC43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 20:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBF524679
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 20:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576788738;
	bh=v9auNo8rkNHOXG05cTjzKAwluyv3XeVsSOf+rklCYPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DU7DDMKpKeFlNxM1unDVcKpRMtvnz8IbPJGoUEx93DnnyxiBjHNChDCNpihbHVeaP
	 DHvUJ8GWNxMl1gV2JyTFI2YtLGrgN+GoUsdCEjv8kb7AhtY/juf+UZ5FZ0THHbHXc+
	 pYfQrIKuO5QIFEgKyDTJc6Z/3Heuo09q0B6IpNP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLSUwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:52:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfLSUwR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 15:52:17 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E681E227BF;
        Thu, 19 Dec 2019 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576788736;
        bh=v9auNo8rkNHOXG05cTjzKAwluyv3XeVsSOf+rklCYPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoNSjSNZj7/ypeN73ewtv/LvBgZ6bhnrJNr3eYPqwRdFTbuBC/Jqk/TN+CW3yBuC5
         xAtyjg+taT1+XU1mDc0mPVYN8PJ7zsxvFq5AbRGQ/KDiCHNmoh8WhSkziKFT9jcEo5
         w12PQILu5aNGblagVhfYZU2khTGRtXEkG/8UPbSE=
Date:   Fri, 20 Dec 2019 05:52:10 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Ober, Frank" <frank.ober@intel.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "Rajendiran, Swetha" <swetha.rajendiran@intel.com>,
        "Liang, Mark" <mark.liang@intel.com>
Subject: Re: Polled io for Linux kernel 5.x
Message-ID: <20191219205210.GA26490@redsun51.ssa.fujisawa.hgst.com>
References: <SN6PR11MB2669E7A65DD0AD9DC65A67C58B520@SN6PR11MB2669.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2669E7A65DD0AD9DC65A67C58B520@SN6PR11MB2669.namprd11.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 19, 2019 at 07:25:51PM +0000, Ober, Frank wrote:
> Hi block/nvme communities, 
> On 4.x kernels we used to be able to do:
> # echo 1 > /sys/block/nvme0n1/queue/io_poll
> And then run a polled_io job in fio with pvsync2 as our ioengine, with the hipri flag set. This is actually how we test the very best SSDs that depend on 3D xpoint media.
> 
> On 5.x kernels we see the following error trying to write the device settings>>>
> -bash: echo: write error: Invalid argument
> 
> We can reload the entire nvme module with nvme poll_queues but this is not well explained or written up anywhere? Or sorry "not found"?
> 
> This is verifiable on 5.3, 5.4 kernels with fio 3.16 builds.
> 
> What is the background on what has changed because Jens wrote this note back in 2015, which did work in the 4.x kernel era.

The original polling implementation shared resources that generate
interrupts. This prevents it from running as fast as it can, so
dedicated polling queues are used now.

> How come we cannot have a device/controller level setup of polled io today in 5.x kernels, all that exists is module based?

Polled queues are a dedicated resource that we have to reserve up front.
They're optional, so you don't need to use the hipri flag if you have a
device you don't want polled. But we need to know how many queues to
reserve before we've even discovered the controllers, so we don't have a
good way to define it per-controller.

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BF5C77B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 19:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEATfn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 15:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjEATeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 15:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354355A1
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 12:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 428B461EF9
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 19:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DD0C433D2;
        Mon,  1 May 2023 19:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682969471;
        bh=yZTPkgjXn8jZDNAxbqseiaFvxDc8hw1TPYB6hr1/1W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fs8YrZ3oyy/mVoTB9xKjEfrgOYfZHaQAc6HZx/q4sQOy9x6LY0lLYKJKSQNsKhe6y
         cIr1FcvDQXxqO6QMlh8B69OT37kuCUg+EMKN4i9nYGaekayb3+4mXkuzbWWYQRy/XJ
         nIWIsevVbH5UunltqXjbbk/4goElO2s54vzir7lpdld8S24b3YfXTrTddE9+T0Q+vD
         2fWDr1nRfmnaXX3+nzAz/5G92oYbipvG79k6m+KCVPaMDOknG6PyspW5X2xgNhofqp
         UQrVTV76TT1EvVb9IgWpf0NqiBy5NMMOdj3Y0H8J541UIeYgGC5OxwuO/xPtwruV5x
         rDv1iD2mxlVrA==
Date:   Mon, 1 May 2023 13:31:08 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 0/3] nvme uring passthrough diet
Message-ID: <ZFATfIe1wDjSzAgq@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947@epcas5p3.samsung.com>
 <20230501153306.537124-1-kbusch@meta.com>
 <20230501190109.GA14341@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501190109.GA14341@green245>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 02, 2023 at 12:31:28AM +0530, Kanchan Joshi wrote:
> On Mon, May 01, 2023 at 08:33:03AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > When you disable all the optional features in your kernel config and
> > request queue, it looks like the normal request dispatching is just as
> > fast as any attempts to bypass it.
> 
> Did a quick run, and it is not the case.
> For that workload [1], this one moves to 3.4M from 3M.

There's more to trim, more work to do. I was running not quite as
heavy a kernel config as I needed, but I've got something more
appropriate to experiment with now.

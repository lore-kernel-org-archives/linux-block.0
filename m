Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC51C282D7
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A8021855
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900165;
	bh=wpXnhNuLSjedjv9fFo7VGMn842b7zsXpNQAWI/HTkdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oF4uHEUZLDPRLLhrTQqxUOByHZnjoa/91RbwMUDHlNlcd+XAoxXvU62DD/7w9tMSy
	 j8m65A3Ln1dTDwPdGgjN7dbdVmcanFR6UkjblbzaxWo71iGSWSALaUrE5o+FQqVre2
	 +0YEqyuu4eB7ciqWcTv4a9wo6Wqzs9lXLgrh0duw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfBKOjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731224AbfBKOjx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:53 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55A42082F;
        Mon, 11 Feb 2019 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895992;
        bh=wpXnhNuLSjedjv9fFo7VGMn842b7zsXpNQAWI/HTkdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLaQrSIpftMG9hN334OOm1DOY5I+Mx/tcgq1A8vFdb93FVfy2Vdbs/dU98h4NVe+t
         sEpt9l7IEEAMhUrX8AVizPonBiIwxdpb3Fqlt2GW/uJYPSzxewOMGwxpCsE+j1fLkb
         oKR7hfry4UrfK3ZXFEAMwtRi+UF07JvUdCBVkdDo=
Date:   Mon, 11 Feb 2019 08:39:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
Message-ID: <20190211143950.GA151039@google.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
 <20190211035358.GA8638@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211035358.GA8638@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 11, 2019 at 11:54:00AM +0800, Ming Lei wrote:
> On Sun, Feb 10, 2019 at 05:30:41PM +0100, Thomas Gleixner wrote:
> > On Fri, 25 Jan 2019, Ming Lei wrote:
> > 
> > > This patch introduces callback of .setup_affinity into 'struct
> > > irq_affinity', so that:
> > 
> > Please see Documentation/process/submitting-patches.rst. Search for 'This
> > patch' ....
> 
> Sorry for that, because I am not a native English speaker and it looks a bit
> difficult for me to understand the subtle difference.

I think Thomas is saying that instead of "This patch introduces
callback ...", you could say "Introduce callback of ...".

The changelog is *part* of the patch, so the context is obvious and
there's no need to include the words "This patch".

I make the same changes to patches I receive.  In fact, I would go
even further and say "Add callback .setup_affinity() ..." because "add"
means the same as "introduce" but is shorter and simpler.

Bjorn

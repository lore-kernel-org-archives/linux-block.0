Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D5BC433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 06:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47C020716
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 06:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GB71ygqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHQGiC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHQGiA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 02:38:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA27FC061388;
        Sun, 16 Aug 2020 23:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vFCbJ3ug2U1sY/t9JxVGfwsBp7E2ZDBnSzqrL0yKU6g=; b=GB71ygqQK5AcFDF6QOiadRELSn
        IwohiW6Xy3vy1LevaEoifMeosAWzkp36zJlfX8w6/kLEePZCDfLHmuTmg3o0yY08Zgt6T2DNAHd8I
        BaomfyuiRnjM9PEAaaA/qaNMz3Ru/f04dmi3k5Dq9K/LLp+HhlgJxM97II2qWCGhfoE8j50nk+Gjt
        GXpk4QOiklF+N8C+vFEKkkG7CrecHzMkap9LOAz49xYUtUHyvBFG905ksG0+1Nh0gpD7Bb1dw6DVp
        wd7QRAt96+bO9LvbC0Rc8el2Kvvcfa/HRjAg0WkforfS+IhQ7x0QTrXJ8/FO+rpW9eJSAb37JxkYx
        HFU0IrUw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7YmL-0005lI-TD; Mon, 17 Aug 2020 06:37:57 +0000
Date:   Mon, 17 Aug 2020 07:37:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 0/4] block/bpf: add eBPF based block layer IO
 filtering
Message-ID: <20200817063757.GA21966@infradead.org>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812163305.545447-1-leah.rumancik@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 04:33:01PM +0000, Leah Rumancik wrote:
> This patch series adds support for a new security mechanism to filter IO
> in the block layer. With this patch series, the policy for IO filtering
> can be programmed into an eBPF program which gets attached to the struct
> gendisk. The filter can either drop or allow IO requests. It cannot modify
> requests. We do not support splitting of IOs, and we do not support
> filtering of IOs that bypass submit_bio (such as SG_IO, NVMe passthrough).

Which means it is not in any way useful for security, but just snake oil.

But even if it wasn't this is a way to big hammer with impact for to
the I/O fast path to be acceptable.

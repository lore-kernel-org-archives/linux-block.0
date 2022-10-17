Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A255EC4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 07:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJQHpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJQHpJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 03:45:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA72F3B1
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r1mA8Mak6toYu3p+9V37Z14J2DJpL5UVe9VkOqbso44=; b=mlbzbPWOrw/Gnk41716c9HtlWE
        hGQmMC9l4DGJiUsgSDy/yzkLowM4IRgbW88HUKEQ24dk35jKoqu2rmybsqqGliSLPPcRtzg6/UmT3
        C/xKWXDxngYnYOPPTkExWwkg6MPjN+xzQkm/EV1KEnSjSbGwDGQS+dwt55xZ5/01SYaiJIUmejo0D
        Rcv+NRtC1vbVkF8Nt0+FWoDWNs6a76WuPuMutRN5A3J1w5eVVrwybDJwhLf5rJHWiCED5VZZyZkuL
        kdrA/PkppDP3+sJll5A+kELq9OcGvSp7XVcf2YGvN5FXrpf3XB/jeKzB3v15Itjb6gLrHYCWt0s7C
        yVVk8aew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okKo5-008ZUL-8h; Mon, 17 Oct 2022 07:45:05 +0000
Date:   Mon, 17 Oct 2022 00:45:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com
Subject: Re: [RFC PATCH v1 00/14] mm/block: add bdi sysfs knobs
Message-ID: <Y00IAStl/NTcvz50@infradead.org>
References: <20221011010044.851537-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 06:00:30PM -0700, Stefan Roesch wrote:
> At meta network block devices (nbd) are used to implement remote block storage. In testing

FYI, this mail is pretty much misformatted and really hard to read.

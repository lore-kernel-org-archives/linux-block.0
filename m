Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF6C433DF
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 16:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A8920874
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602867372;
	bh=9U+8Baf6DXu/tV5OyMNV9nKYYBT1kOh1QcLFG+xP3ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TCg+BmqPgQoKlbb/z1YA5vEezD/5wB0KmXhVIDoYcJmiU9ZYsMoUTWNl1LJVsmE/W
	 v8ZELXivIqeLlxKJF8eRmYr8gW6Trug3F1oRaFhykfo/cnzpnv/gRwKLA/ZqC/5RNG
	 /vkiEujinLRx313T9gI5BbFWFlFdAgO8cjTQLDJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410922AbgJPQ4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410921AbgJPQ4L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 12:56:11 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E158320848;
        Fri, 16 Oct 2020 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602867371;
        bh=9U+8Baf6DXu/tV5OyMNV9nKYYBT1kOh1QcLFG+xP3ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrrzactTxXG9PMRy18HAyx7fSYW48KdossGtkw3cBS2gAZHMGYaTGm4neFHNV76ra
         WMrfVXLJ2iCoMQ3hWm4omhRA0qRtCY9x3R7EWElVFkKuDHdji0VESFpO9KZvCRYZFT
         vpU4YLC84V+FVA9iYBeqU+r3RNUZA2aR/7KCK63Q=
Date:   Fri, 16 Oct 2020 09:56:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: Make mpage_readpage synchronous
Message-ID: <20201016165608.GB1426921@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201016161426.21715-1-willy@infradead.org>
 <20201016161426.21715-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016161426.21715-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 16, 2020 at 05:14:26PM +0100, Matthew Wilcox (Oracle) wrote:
> +	err = submit_bio_killable(args.bio, mpage_end_io);
> +	if (unlikely(err))
> +		goto err;
> +
> +	SetPageUptodate(page);

On success, isn't the page already set up to date through the
mpage_end_io() callback?

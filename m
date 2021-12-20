Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88EAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 20:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbhLTU46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:56:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLTU45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 15:56:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C204612F0
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 20:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61048C36AE7;
        Mon, 20 Dec 2021 20:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640033816;
        bh=tY/R0Rb5/1PSwV9cm/ZrJcRcggbFGFIhMhykWqsTt0w=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=IR5bMpmq+KpFOUkCuRClLJldzByD7yw/bX3uMiCgoOvSa5q+Z5ECjbMby2z6bILwk
         50391Xrav2TjbHVsO9dkpVq0st/m6RnCsVzO37JBkS+6z9naUPU/0k/d3J7y//Gms0
         NZpPz7305aVLDFD+4kXVKqcoFoBIVw6WR7wE050PxWfFSZI57zvo1mhqi/BiFTo/YC
         bH13knAb52s9gzRgVnVy65NTx4Q8zW7w7WgwOKE/+nW7jMkRhEc5uvuSpy8twsIJ/S
         KtR24oGS9wykwMMNaKPj1OQMeZl2PLevy78SyzZZiNWqajRTWHyICpRmxGxLN4Vb//
         BwS7y6XOdwAYw==
Date:   Mon, 20 Dec 2021 12:56:54 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH] blk-mq: check quiesce state before queue_rqs
Message-ID: <20211220205654.GA156286@dhcp-10-100-145-180.wdc.com>
References: <20211220205412.151342-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220205412.151342-1-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 20, 2021 at 12:54:12PM -0800, Keith Busch wrote:
> +void __blk_mq_flush_plug_list(struct request_queue *q, struct blk_plug *plug)

Oops, the above needs to be static. Let me send a v2.

> +{
> +	if (blk_queue_quiesced(q))
> +		return;
> +	q->mq_ops->queue_rqs(&plug->mq_list);
> +}

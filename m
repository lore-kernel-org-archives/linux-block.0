Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE0BC77B61
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 04:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjEAEb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 00:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjEAEb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 00:31:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EA410C3;
        Sun, 30 Apr 2023 21:31:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F3A6668B05; Mon,  1 May 2023 06:31:22 +0200 (CEST)
Date:   Mon, 1 May 2023 06:31:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        asml.silence@gmail.com, axboe@kernel.dk, ming.lei@redhat.com,
        leit@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
        hch@lst.de, kbusch@kernel.org
Subject: Re: [PATCH v3 4/4] block: ublk_drv: Add a helper instead of casting
Message-ID: <20230501043122.GC19673@lst.de>
References: <20230430143532.605367-1-leitao@debian.org> <20230430143532.605367-5-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430143532.605367-5-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 30, 2023 at 07:35:32AM -0700, Breno Leitao wrote:
> ublk driver is using casts to get private data from uring cmd struct.
> Let's use a proper helper, as an interface that requires casts in all
> callers is one asking for bugs.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>

No, I've not suggested this.

> +static inline struct ublksrv_ctrl_cmd *ublk_uring_ctrl_cmd(
> +		struct io_uring_cmd *cmd)
> +{
> +	return (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
> +}

I've two times explained we need a core io_uring helper to remove this
casting in the drivers, and I've explained how to do that and provided
the actual code for it.

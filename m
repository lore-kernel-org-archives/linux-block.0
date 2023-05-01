Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F46C77B61
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 04:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEAEaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 00:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjEAEaL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 00:30:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C01AE61;
        Sun, 30 Apr 2023 21:30:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A69268B05; Mon,  1 May 2023 06:30:07 +0200 (CEST)
Date:   Mon, 1 May 2023 06:30:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        asml.silence@gmail.com, axboe@kernel.dk, ming.lei@redhat.com,
        leit@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
        hch@lst.de, kbusch@kernel.org
Subject: Re: [PATCH v3 2/4] io_uring: Pass whole sqe to commands
Message-ID: <20230501043007.GB19673@lst.de>
References: <20230430143532.605367-1-leitao@debian.org> <20230430143532.605367-3-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430143532.605367-3-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  {
> -	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
> +	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->sqe->cmd;

This still adds all the crazy casting!!

As I already explained two times, last time including actual working
code, please add a helper that takes a io_uring_cmd * argument, and
returns cmd->sqe->cmd with a void * type.  With that all the casting
can be removed.

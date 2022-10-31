Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86AECAAA1
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 22:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJaWNB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJaWNA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 18:13:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41AD46
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 15:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HdrTxWDIwfYZG3mfMQu4ELjlgbfX4jxbJ502P4m305Q=; b=WPcvx5KsrqNEeqOx9Qp+jp9QU2
        IMJ9dLOh1Ui0Tuzz5kie19kbo02HvwwM33ntOOyOBY1Fm0MlKgLuPhjYnFYevsrgnzfbdEIC/4W1h
        bHvWCf2Po9yDAiI3tf7q32GLRCCdlUfAXlJ3iKLors913lS19vQ5zuv4b5mussvH3cUNo7tAsVBIK
        pEsOEiUNPuhxHt4YpGPbyNgyKgBoeScDoDuu8gT1OlC0BAOR4fH5fQV9hX3BdJvn5+NpOa5p4JU/9
        Iw9ZH7WYVk45CQguRz8XYHHjKc6gna5z43LYyT9AU/2/t5wunSdRlKdHsYG7+2L6iQZl5Kyf7UKIb
        D/qCKPCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1opd1e-00GnnT-03
        for linux-block@vger.kernel.org;
        Mon, 31 Oct 2022 22:12:58 +0000
Date:   Mon, 31 Oct 2022 22:12:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-block@vger.kernel.org
Subject: UAF in blk_add_rq_to_plug()?
Message-ID: <Y2BIad98er4QsbZY@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
{
        struct request *last = rq_list_peek(&plug->mq_list);

Suppose it's not NULL...

        if (!plug->rq_count) {
                trace_block_plug(rq->q);
        } else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
                   (!blk_queue_nomerges(rq->q) &&
                    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
... and we went here:
                blk_mq_flush_plug_list(plug, false);
All requests, including the one last points to, might get fed ->queue_rq()
here.  At which point there seems to be nothing to prevent them getting
completed and freed on another CPU, possibly before we return here.

                trace_block_plug(rq->q);
        }

        if (!plug->multiple_queues && last && last->q != rq->q)
... and here we dereference last.

Shouldn't we reset last to NULL after the call of blk_mq_flush_plug_list()
above?

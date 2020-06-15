Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BEFC433E0
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5365320756
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLGm/mOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgFOTWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgFOTWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 15:22:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C6DC061A0E;
        Mon, 15 Jun 2020 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1SYTwpfB40+JGZH3GQvOKxvSVPzTOSW3WlfOs5EOLH0=; b=JLGm/mOAW+/i4uJ5JrpcZNUndT
        w3i4B341Ih/AC8yrlBlLTOpPHZdLHl6Dju82tC2wReRTx6nYmCILE22RdtxTsYW2IOvVfzH7FSFZC
        h3HJoTbFzueBfPOFJom+mGAIL9NpEMn6OnFYKVtnIEQWUK2YAzMFHdPXFDhMueI4/1Tq7GCIQJqVm
        ItT8tAK3p14xyDnAdroABoNLdUupPoyv7bcaViU3f6IhaZjgOK1ZWHAaKQaZbStfV+7FGfqyrJ78S
        g2SWVVxL+rAfOLm3Vm6P8rbhLrni4/OxZM/MCFha92X/Qf9ucYh5bIe9+Wb4gy9FQFKNOMUrVBdT9
        C1/02cSA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkuh4-0003nA-CC; Mon, 15 Jun 2020 19:22:54 +0000
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] trace/events/block.h: drop kernel-doc for dropped function
 parameter
Message-ID: <d572a150-192a-bbce-4449-8de45bce1a9b@infradead.org>
Date:   Mon, 15 Jun 2020 12:22:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning: the parameter was removed, so also remove
the kernel-doc notation for it.

../include/trace/events/block.h:278: warning: Excess function parameter 'error' description in 'trace_block_bio_complete'

Fixes: d24de76af836 ("block: remove the error argument to the block_bio_complete tracepoint")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/trace/events/block.h |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20200615.orig/include/trace/events/block.h
+++ linux-next-20200615/include/trace/events/block.h
@@ -254,7 +254,6 @@ TRACE_EVENT(block_bio_bounce,
  * block_bio_complete - completed all work on the block operation
  * @q: queue holding the block operation
  * @bio: block operation completed
- * @error: io error value
  *
  * This tracepoint indicates there is no further work to do on this
  * block IO operation @bio.


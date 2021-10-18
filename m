Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60254C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AB16126A
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 08:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhJRIpH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhJRIpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 04:45:05 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1306C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2KpqDfMpP2+5nx/nKuBaF+6090hL1O89vwI7nb6QhJ0=; b=RvGdVei5PRSsa5/ZP05vA9S5I+
        ePaDfjBRhWJNBUuXWycoi8GxtsBNZYSXZBL3SPxrbB+srBPElnpIPWD3c09Qg/YvtKYglpYZHKyVL
        Ybwa4hMIiGlaAv8/TJqALqKSL6+lfMXCfWqOyITgwTxKcI/Gau2DQlmFVnNG3uXZgmQ5o74tdrXye
        JWtC2A1hubwNLaHR5P4doT/lGW7tZs7zBuJbf18ePlQ9bXZi8QXCXtq47js0LYZAhNmdhBAwkkUmX
        qzbUuQaOUW8vAReP3dI552MpvpDNCyRx5t5o5kOEcsnJwoMJux+OrhYL1AuQadmdk85jmy5UsN+Qt
        L4s3q48Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOEQ-00EgFW-EK; Mon, 18 Oct 2021 08:42:54 +0000
Date:   Mon, 18 Oct 2021 01:42:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 03/14] block: remove useless caller argument to
 print_req_error()
Message-ID: <YW0zjloW3axe5lFV@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:37:37PM -0600, Jens Axboe wrote:
> We have exactly one caller of this, just get rid of adding the useless
> function name to the output.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

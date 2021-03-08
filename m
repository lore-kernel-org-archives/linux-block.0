Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB92C433E6
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29E16512F
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 07:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhCHHq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 02:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCHHqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 02:46:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E036C06174A
        for <linux-block@vger.kernel.org>; Sun,  7 Mar 2021 23:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BrXBd0ikksxbg+wI2t80vq4hDOHC15HKTVqkikU8+GA=; b=oF4RZ3B3fSPNbTht4vTjCgw8yE
        7vCIW2zNEQYqlNY3wg9m/+xEThi/FMJXtIhaIQzmXCGv6JjHiL+UAanwuzXyFGpry72eUHVyk01C4
        GgjtMPlz8cgogbKiQc1g0A1VV2ZAaoqwkgRQ9SYC5UrDSXfBsnLHFTeX7XYXnfvG037jLJB9xiPcw
        OtAiy6gtRcGe1LhNDwIC02NAnw2Lm6bY26O5b1+iBpnIUI7N1UE57d1+/c4eBDFKceFiw5EMJ05Ar
        rRCvwjbEC7D0rRP88/uTHaM3dE2Ze6tDNhBp1WJ/x7Oz2f/t2+K0UBuc3u9XcEWF1hJOqgrcABI2M
        JOKvEYHw==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJAaN-00FBps-Ii; Mon, 08 Mar 2021 07:45:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: remove ->revalidate_disk (resend)
Date:   Mon,  8 Mar 2021 08:45:47 +0100
Message-Id: <20210308074550.422714-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

with the previously merged patches all real users of ->revalidate_disk
are gone.  This series removes the two remaining not actually required
instances and the method itself.

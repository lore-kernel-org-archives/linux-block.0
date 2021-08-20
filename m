Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF46C4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 05:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A6861051
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 05:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhHTFWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 01:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhHTFWj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 01:22:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4567AC061575;
        Thu, 19 Aug 2021 22:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l9q89ZWuhs36CiMrTpXwflYRe1/NvDwzZ/5qpa+mR4Q=; b=ShvOeGjjTYeoPrdQ2Kallr+avo
        T0pwSWZjB777T32OEsWKA/KWYEJrxKmgBwAtaybAiTu2WfUsgw6mAf9VDxuYRtulgb9SUZz2eYqir
        Q33KgSsqY4w5cDrQsPTQFrIIe1MSQadzewCfQNsHqBQ5lYSwCReS1mkHRHwbdvkvFXsXsAVHk8YwL
        OwoS+kQX5Qj7zRRD9VSNo/yKd0ZMZtNV6Va96v/reFD8qJzTF9ITi6wXDC61qMTf4NxuczAbo84Q1
        iIwpcKR2hrRnUAKBYvTfn2CN+66YaCBlrGXvflnJnSvOfkoAOI54lxXuk07cSoNCwLrOupVR+QU6I
        syiaX0HA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGwy2-0065Ud-EQ; Fri, 20 Aug 2021 05:21:32 +0000
Date:   Fri, 20 Aug 2021 06:21:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: use enumerate instead of integer in op_is_write()
Message-ID: <YR870nMzpojlhR3l@infradead.org>
References: <1629424512-29553-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629424512-29553-1-git-send-email-brookxu.cn@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 20, 2021 at 09:55:12AM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> For mask operation, using enumerate may be safer than integer.

Except that we are explicitly checking for least significant bit as
that is part of the encoding, not a specific enum value.

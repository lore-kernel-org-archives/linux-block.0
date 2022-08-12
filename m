Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04656C00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 05:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiHLFo5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 01:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiHLFo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 01:44:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A955CA3D67;
        Thu, 11 Aug 2022 22:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=529DmJtUxSrLNFSQktW+uljfrmaGHB9NgD+MvdUbNAI=; b=xktH1gCFM7y6R9xEnImKHts9oZ
        KnBsZmfJCo/bCSOvpU4IWGIgXz6fx8p9hE9++FVSYyg5xp7Xt7fyJbxPqyR5S9W6A6tAZtP8xiSWN
        s3eOlwNHcKMwfT724X+/znIzw6UN8B/XTo28HqtLRICiJfBDHbB/e0FYUuHhjZA+jwBX+ip2ZfBOf
        LTU3YR2hfuw7kAGJqfxTCvyUu43aahw77tAywtRsrAyuOrRfQPGI0GYylMPm+bJ7h8CWle/8mqOtF
        KT3F7q5lUM6KQPmtRl5DEW+ueMmTojIIMWeBrp75b0NfYY742rV+aqbQRDoWWLkrh+qLt88gxEoYf
        aA7saGHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMNTa-00Fr7w-5L; Fri, 12 Aug 2022 05:44:54 +0000
Date:   Thu, 11 Aug 2022 22:44:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: Question: consult patch
Message-ID: <YvXo1uCFA57t89Nv@infradead.org>
References: <420a6c4a-e526-4e8b-d5bd-563c40aa94e1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <420a6c4a-e526-4e8b-d5bd-563c40aa94e1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 12, 2022 at 11:34:59AM +0800, zhangwensheng (E) wrote:
> Hi Lee ：
>     I saw your patch because of CVE-2022-20158, the patch like below:
> 
> ---
>     mm: backing-dev: Take a reference to the bdi in use to prevent UAF

I can't see that patch anywhere, and I've not seen an bug report for it.

>     Because of a distinct lack of locking and/or reference taking,
>     blk_cleanup_queue() puts the final taken reference to the bdi, which

.. and blk_cleanup_queue also is gone upstream.

What am I missing?

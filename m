Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B26C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 06:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA60964E00
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 06:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBPGU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 01:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhBPGU3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 01:20:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F1B764DFF;
        Tue, 16 Feb 2021 06:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613456389;
        bh=3Nfe35jQ9Z3pI3ko1GnmYja3qg/E6iDxFL2xAs6Ly6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWozhMC8TRwWrR/9R6CCssiGMHU/FwJJrqRtNSEtbUikT3CoLsk57RRt0wQWGkFON
         4Y/MMK7gpnn7Mw0zloF+dQqEP4PZ04MRQv4VxoS6ew1K8QhifD3wBtmtb0LV/4gb4e
         auvlCHyVGLxapcXXAqlVj+y3ETO9M2BVVtWzxXLM=
Date:   Tue, 16 Feb 2021 07:19:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, mj0123.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v5 1/2] bio: limit bio max size
Message-ID: <YCtkAZNIgehq3ewF@kroah.com>
References: <20210204010156.5105-1-nanich.lee@samsung.com>
 <CGME20210216021636epcas1p31748fea01f2c9638216f8d8b3b3b3712@epcas1p3.samsung.com>
 <20210216020032.19792-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216020032.19792-1-nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 16, 2021 at 11:00:32AM +0900, Changheun Lee wrote:
> Please feedback to me if more modification is needed to apply. :)

No context here :(

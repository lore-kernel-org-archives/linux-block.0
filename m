Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5709DC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 23:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225FA217F4
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 23:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDIXRE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:17:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55232 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfDIXRE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 19:17:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hDzzC-0001AD-Dv; Tue, 09 Apr 2019 23:17:02 +0000
Date:   Wed, 10 Apr 2019 00:17:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH v2] fs/block_dev.c: remove unused include
Message-ID: <20190409231702.GR2217@ZenIV.linux.org.uk>
References: <20190409103752.28532-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409103752.28532-1-cgxu519@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 09, 2019 at 06:37:52PM +0800, Chengguang Xu wrote:
> Just remove unused include <linux/badblocks.h> from
> fs/block_dev.c.

Applied

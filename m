Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A625C433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B5D20663
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbgF2UzD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbgF2Uy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 16:54:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA3C061755;
        Mon, 29 Jun 2020 13:54:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq0nj-002KpE-MJ; Mon, 29 Jun 2020 20:54:51 +0000
Date:   Mon, 29 Jun 2020 21:54:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop: fix passing zero to 'PTR_ERR' warning
Message-ID: <20200629205451.GC2786714@ZenIV.linux.org.uk>
References: <1592988522-4350-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592988522-4350-1-git-send-email-dingxiang@cmss.chinamobile.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 24, 2020 at 04:48:42PM +0800, Ding Xiang wrote:
> Fix a static code checker warning:
>     drivers/block/loop.c:798 loop_attr_backing_file_show()
>     warn: passing zero to 'PTR_ERR'

Better fix the root cause of that the problem - bullshit checker,
that is...

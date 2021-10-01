Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935CFC433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 23:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7807861A6F
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 23:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhJAXXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 19:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhJAXXt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Oct 2021 19:23:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E13561242;
        Fri,  1 Oct 2021 23:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633130524;
        bh=48kjGt07XBXeXXNfXIiZPlrFB+e8fc/lTBUd5CtkDpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dQva2a1ObWFaFe3AYuTtygyRk4aWa7w/7tFSY05KA7dL91MgCiWKWdCGzQhS6BlDR
         k4Vj6fHYc4cGxSgLiT5gqKvbSy7PZHxxlMUBG10hq79mi2y2LBaYC++u0DGN7EswEg
         eLMYkX1Dtecbltiz15dX8dM1za7l8Rw4GNPb+BGQ=
Date:   Fri, 1 Oct 2021 16:22:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH] zram: Allow backing device to be assigned after init
Message-Id: <20211001162204.f8d20e62e8b528f5e2e5fa3e@linux-foundation.org>
In-Reply-To: <20211001181627.394921-1-bgeffon@google.com>
References: <20211001181627.394921-1-bgeffon@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri,  1 Oct 2021 11:16:27 -0700 Brian Geffon <bgeffon@google.com> wrote:

> There does not appear to be a technical reason to not
> allow the zram backing device to be assigned after the
> zram device is initialized.
> 
> This change will allow for the backing device to be assigned
> as long as no backing device is already assigned. In that
> event backing_dev would return -EEXIST.

Why is this useful?

Return-Path: <SRS0=mZfT=B2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCC1C433E1
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 17:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8BF20738
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I61qtUMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgHPRzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgHPRzV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Aug 2020 13:55:21 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F0AC061786;
        Sun, 16 Aug 2020 10:55:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t13so12560922ile.9;
        Sun, 16 Aug 2020 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiCG/uAK0dtENCt/PueZkz6eV6g5vA/PPqkue6QuGWc=;
        b=I61qtUMSC2HknCJQ8BnSlGPAk0WckimWiJAmc4vXKKQzxH9BEIsAhWEsTKYCph4lr5
         zKLQwUFtah4H8ruIP6TbMazrqzSXXglI+NvJiH9AoTcjE1d70tjVN0mGNRIr2XuelmIe
         jjOwjREGzAcDQ2h9u3mKWRdeN72cO2EtrYUxYrYsHhJ5RDm1NYT6NfYDu4KV7rNcWduL
         zHKS0XfdXfyLfzrOjHDULxRLhsz8I0MhwBhUgzby41g+6trfGaRKXI+MYpn5NkF7XgvC
         ilpb+Ivei2c6W4F0grs6mW2aGUlHzxXJ4keQdL2hIxk7xT+DsihZL0e0IIDS1nBz0X6+
         Q2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiCG/uAK0dtENCt/PueZkz6eV6g5vA/PPqkue6QuGWc=;
        b=B1XDQM8ljx+zBLIOzOM+TMI1gNL/OU/XztqEBbRTIQ0B9WLJoea9YJrFGVBIwJaEJK
         g8cjrvX/RR64VjRrwUHfDdlsmyMjVep+VBfnVEN0ll/oxK0vX99lsFJDy7GMpY6W2C95
         HFE1kr1ymY/QfEUSrQhvmhG8EjHTnJrTxefNz39p76GqBzPxphKWo/wklxnNRlvTZaZS
         4lHaHSrYOmzbN0wOMP5aHZcy87OLdN4iy0NeN5Fo02GwXrjH4oekHJD8zdAsEwABkXgy
         F1vdeifTHIBwopKonv7Nm60gdXKznWsuSgURr8Jj//lVYU0P7FuMHQGklyCgoNt4aCKp
         X9JA==
X-Gm-Message-State: AOAM532wPGrmLDsaWrfwia9RsVi5hPp+8l0nk7So20if5CcU5yIaRfnT
        r2p0/92CmIzQ81VJaDKoznXzKKmOZcuk8TV8OtM=
X-Google-Smtp-Source: ABdhPJxSfbQX1hDpkJkRit7p7VGjkXenq2dg0JNjY9g09NZghabgSAKJkr9JDtBOuaL+IgFlYgX60tqH7vqMFJoSaYI=
X-Received: by 2002:a92:d786:: with SMTP id d6mr10604101iln.144.1597600520704;
 Sun, 16 Aug 2020 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200816071518.6964-1-colyli@suse.de>
In-Reply-To: <20200816071518.6964-1-colyli@suse.de>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun, 16 Aug 2020 10:55:09 -0700
Message-ID: <CAM_iQpUFtZdrhfUbuYYODNeSVqPOqx8mio6Znp6v3Q5iDZeyqg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpage_ok() in include/linux/net.h
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Vlastimil Babka <vbabka@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 16, 2020 at 1:36 AM Coly Li <colyli@suse.de> wrote:
>
> The original problem was from nvme-over-tcp code, who mistakenly uses
> kernel_sendpage() to send pages allocated by __get_free_pages() without
> __GFP_COMP flag. Such pages don't have refcount (page_count is 0) on
> tail pages, sending them by kernel_sendpage() may trigger a kernel panic
> from a corrupted kernel heap, because these pages are incorrectly freed
> in network stack as page_count 0 pages.
>
> This patch introduces a helper sendpage_ok(), it returns true if the
> checking page,
> - is not slab page: PageSlab(page) is false.
> - has page refcount: page_count(page) is not zero
>
> All drivers who want to send page to remote end by kernel_sendpage()
> may use this helper to check whether the page is OK. If the helper does
> not return true, the driver should try other non sendpage method (e.g.
> sock_no_sendpage()) to handle the page.

Can we leave this helper to mm subsystem?

I know it is for sendpage, but its implementation is all about some
mm details and its two callers do not belong to net subsystem either.

Think this in another way: who would fix it if it is buggy? I bet mm people
should. ;)

Thanks.

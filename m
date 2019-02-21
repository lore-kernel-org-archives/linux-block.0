Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E2EC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E329920855
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="h7EdyN/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfBUMK1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:10:27 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36174 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfBUMK0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 07:10:26 -0500
Received: by mail-lj1-f179.google.com with SMTP id g11-v6so23805074ljk.3
        for <linux-block@vger.kernel.org>; Thu, 21 Feb 2019 04:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38sifaYAisuw9IFpeznnNdwQ3apPJyF3t76BSpeBGkg=;
        b=h7EdyN/aNNSoH6iFovWk/QxO3jvb3XJs/9lTYr7oUPpg8/5Nv7nCMDGjY7o8DKANR3
         2BCn0WuYtHCknjYtRS6E6YeR7uDRSZGm7uR+XujZhP4GY88N24ZesEKkjivWfZ40Hg64
         KJFq58pFYpWHWKum6yP9BK8UT+ODsIC8AR7UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38sifaYAisuw9IFpeznnNdwQ3apPJyF3t76BSpeBGkg=;
        b=DJzi6d5yb1r5za7bFNOsbgSbv7ZNqnsm4wxiuSdmdzS9bzUKJbrLVN9jX1vx5GyJbD
         1UAET5Ql2Z8qk2SfT1SUCwYTSSWpH7upLt+fUAAvUydpp/3Te3iwHT1GPY/7gYrb2IyF
         neVh9ToAmXu6V2cTF4OWv7SMAFSJLvUAobOiH632ft2ScT91ACEVFQKrnrIztW7ymVsj
         ODoqm9kAbAdqTJbldJYhi/a/E5cIFz35Evkcd9FSAxaAvasFhqXSVEDoVBR1qwr2oizc
         9l3epO05pxjlgurdTNwQfmgbqd6z4md7pov+WxnZ310BnzDvY/NaUWcjnMI9CAs/mIag
         NfYw==
X-Gm-Message-State: AHQUAuZcXWwvUQNEm3In8sgqZQQoJmv37Z4vgKNFnsYaPtKgkIXJUhsu
        +hAXWBiMzLsr+0vBO/nNrjOVzw==
X-Google-Smtp-Source: AHgI3IY6N+9jKcKcOJyFXs182f1K411fWvEeFnEe84QiHj4t+URbc/hGk3GSKP6wfYB+YK5I342b+A==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr22122544lja.9.1550751024445;
        Thu, 21 Feb 2019 04:10:24 -0800 (PST)
Received: from localhost.localdomain ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id k131sm6046710lfk.12.2019.02.21.04.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 04:10:23 -0800 (PST)
From:   Marek Majkowski <marek@cloudflare.com>
To:     axboe@kernel.dk
Cc:     avi@scylladb.com, hch@lst.de, jannh@google.com, jmoyer@redhat.com,
        linux-aio@kvack.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, viro@ZenIV.linux.org.uk
Subject: Re: [PATCHSET v15] io_uring IO interface
Date:   Thu, 21 Feb 2019 13:10:22 +0100
Message-Id: <20190221121022.7867-1-marek@cloudflare.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> From: Jens Axboe <axboe@kernel.dk>
> Subject: [PATCHSET v15] io_uring IO interface
> Message-ID: <20190211190049.7888-1-axboe@kernel.dk> (raw)
>
> Some final tweaks, mostly cosmetic, but also two important fixes:
> 
> 1) Ensure that we account the skb appropriately against the socket.
>    Some network config options apparently return is an skb with
>    ->truesize != 0 when allocated with a size of 0, ensure we add
>    those as references against sock->sk_wmem_alloc. Reported by
>    Matt Mullins.

Jens,

I tried using io_uring with network sockets. It seem to be doing the
right thing. One bit is missing though: "flags" as in recv(2).

In perfect world I would like to specify at least:
 - MSG_DONTWAIT
 - MSG_WAITALL
 - MSG_NOSIGNAL

Right now, unless I'm missing something, io_uring_sqe doesn't have a
place where we could store these. "flags" is needed for any
non-trivial network I/O.

A separate discussion is about io_uring supporting more complex
network stuff in future like 'struct msghdr', MSG_ERRQUEUE or CMSG.

Cheers,
   Marek

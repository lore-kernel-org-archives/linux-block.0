Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF5C5DF62
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 03:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909AE2077B
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 03:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BykSWDFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfKFDi6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:38:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33641 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKFDi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 22:38:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so17801413pfb.0
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 19:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QPBBiqfMS5k77OB0YH2gqr3f7BjeK58Hp5HexPPA1As=;
        b=BykSWDFbZUSuGsD3ykz2+M4qdugO+3K5O4DU9azAnilqVGmr8Hkc61gpiKYH6pNh5K
         4AGDtKVmEo9vhd+E692NgB+1eX6EJJbW/01/Igpb/jvf6YmVAo4WAPv6UHBYMGHNAxtd
         lvzp4GOKjX9cDMet1rKKmypqpX375of96kY1MV29elCyzycYoANLm4uOX7viT9jazakI
         qHLVnKUc+N+N/2QgL9W+5qnM1f445yvwfE6chnAcNEeRWy0s/zU+HjcOFq+WJ8DYF3Ta
         YAEJJJufkyBSSssQ7oN1iicgKufwY/BApR/bCjL1TbhirKy2+V8L+PrqxOgoD62lSnpU
         9iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QPBBiqfMS5k77OB0YH2gqr3f7BjeK58Hp5HexPPA1As=;
        b=sSPXDixsDpyNYikqkibvcD5rN8eTEqsr5/8tUTEEXM6MDpE622RRybuuEn7uE8XS1I
         1OgcnO4EFv0FxB2fwdWiSjle5B9GyX6VxG06XmtALyoz9XS5y0HjzjzN+bAPRvVIbwEk
         Hxxq2pmuluTwWiRa9BuuaKqFbzMAlb6TNgUgW5PNG6rTUs2te+v2CKc/32hdwE5CDrby
         B1XwMhSFbIjju1S7e0ZYp4dZWVjh2EhQl1fo4z6J+JQo5Y2N+DRcUsSOteIo8ruVT6uD
         pkGPYbPHo29c6Iak6l/CIrNNvpWIj35LZQo0tAx0/Vu1jHJyNZZ2SMEajXaUl9KW+szt
         Czlg==
X-Gm-Message-State: APjAAAUXk7krzWU4w90AUhMk2TyOyLkktLUARXaklmGk/ySzy0AcKldK
        m8Jf8I/4T91Gh6zmSTwdbBdpRuHWLCo=
X-Google-Smtp-Source: APXvYqx9BvD0Lu3V5XiRknj39rrY/jyg+k/cJAzeTaN4UhNZRkuSDOa3F9J3sESVQ6+rA14iJWRjGQ==
X-Received: by 2002:a63:d308:: with SMTP id b8mr342004pgg.246.1573011536103;
        Tue, 05 Nov 2019 19:38:56 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i2sm19734278pgt.34.2019.11.05.19.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 19:38:55 -0800 (PST)
To:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: kill dead REQ_F_LINK_DONE flag
Message-ID: <0c5345cf-51be-8363-cc80-6da12a334c32@kernel.dk>
Date:   Tue, 5 Nov 2019 20:38:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We had no more use for this flag after the conversion to io-wq, kill it
off.

Fixes: 561fb04a6a22 ("io_uring: replace workqueue usage with io-wq")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4edc94aab17e..cfdb51dd669e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -329,7 +329,6 @@ struct io_kiocb {
 #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
 #define REQ_F_IO_DRAINED	32	/* drain done */
 #define REQ_F_LINK		64	/* linked sqes */
-#define REQ_F_LINK_DONE		128	/* linked sqes done */
 #define REQ_F_FAIL_LINK		256	/* fail rest of links */
 #define REQ_F_SHADOW_DRAIN	512	/* link-drain shadow req */
 #define REQ_F_TIMEOUT		1024	/* timeout request */
@@ -731,7 +730,6 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 			nxt->flags |= REQ_F_LINK;
 		}
 
-		nxt->flags |= REQ_F_LINK_DONE;
 		/*
 		 * If we're in async work, we can continue processing the chain
 		 * in this context instead of having to queue up new async work.
-- 
Jens Axboe


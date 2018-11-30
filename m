Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9FC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D47E20834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D47E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAEWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:22:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40963 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeLAEWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:22:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so2762228pgh.8;
        Fri, 30 Nov 2018 09:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oBcc3UArOqhaRrlsQHHRczcczZcsQHP6WxJLcFpaoRk=;
        b=SaeNsgDRsZLl+3nlw0Pn8W7FAKJw9JpEdHqYPY2qSt60Pno/ZoW+OFct+yKabrmK7o
         8IsWcpyPnOnUTol19213Z8hNy7fFLMCPLZd14A+mePhb0QIk0o+nPhsUKYDbmy4vujho
         p7OO1lok7LZybwxfemmBVjrx6Ajh37V4k4u3GwqNZMJL/Jw7PPSvQNX3pNZSl3nR8L63
         ZGC+FGWNt5UC1j+3c1/VGW8cQheuiIDenK/Y6ZjdX657iqVpYoLRiaobumdNcELJ1leg
         w4ZolPCg/e5G475hG7+DFntfbHd0T0x4xMuNKHTuagdhfdjbWVYXqyzuXq7jp4GJ9ZT0
         QI2Q==
X-Gm-Message-State: AA+aEWYGCkMa84Rqluwb0tnQRfp7khNzVQmVmhCGpuDp5eZJYySI45ls
        3oIGa2yj7azROheCtqarbEQ=
X-Google-Smtp-Source: AFSGD/XWTl0/5AlC9CIlV7xxeDATVCsUs4ZdUKE3ukD1mHjLO4JraNZdGYojP+SrXO5Zo0oMmYdoQg==
X-Received: by 2002:a63:de46:: with SMTP id y6mr5520078pgi.198.1543597962053;
        Fri, 30 Nov 2018 09:12:42 -0800 (PST)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id s2sm8707550pfa.167.2018.11.30.09.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:12:41 -0800 (PST)
Message-ID: <1543597960.4347.3.camel@acm.org>
Subject: Re: [PATCH 05/27] block: ensure that async polled IO is marked
 REQ_NOWAIT
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de
Date:   Fri, 30 Nov 2018 09:12:40 -0800
In-Reply-To: <20181130165646.27341-6-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
         <20181130165646.27341-6-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-11-30 at 09:56 -0700, Jens Axboe wrote:
+AD4 We can't wait for polled events to complete, as they may require active
+AD4 polling from whoever submitted it. If that is the same task that is
+AD4 submitting new IO, we could deadlock waiting for IO to complete that
+AD4 this task is supposed to be completing itself.
+AD4 
+AD4 Signed-off-by: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4
+AD4 ---
+AD4  fs/block+AF8-dev.c +AHw 10 +-+-+-+-+-+-+-+-+--
+AD4  1 file changed, 9 insertions(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/fs/block+AF8-dev.c b/fs/block+AF8-dev.c
+AD4 index 6de8d35f6e41..ebc3d5a0f424 100644
+AD4 --- a/fs/block+AF8-dev.c
+AD4 +-+-+- b/fs/block+AF8-dev.c
+AD4 +AEAAQA -402,8 +-402,16 +AEAAQA +AF8AXw-blkdev+AF8-direct+AF8-IO(struct kiocb +ACo-iocb, struct iov+AF8-iter +ACo-iter, int nr+AF8-pages)
+AD4  
+AD4  		nr+AF8-pages +AD0 iov+AF8-iter+AF8-npages(iter, BIO+AF8-MAX+AF8-PAGES)+ADs
+AD4  		if (+ACE-nr+AF8-pages) +AHs
+AD4 -			if (iocb-+AD4-ki+AF8-flags +ACY IOCB+AF8-HIPRI)
+AD4 +-			if (iocb-+AD4-ki+AF8-flags +ACY IOCB+AF8-HIPRI) +AHs
+AD4  				bio-+AD4-bi+AF8-opf +AHwAPQ REQ+AF8-HIPRI+ADs
+AD4 +-				/+ACo
+AD4 +-				 +ACo For async polled IO, we can't wait for
+AD4 +-				 +ACo requests to complete, as they may also be
+AD4 +-				 +ACo polled and require active reaping.
+AD4 +-				 +ACo-/
+AD4 +-				if (+ACE-is+AF8-sync)
+AD4 +-					bio-+AD4-bi+AF8-opf +AHwAPQ REQ+AF8-NOWAIT+ADs
+AD4 +-			+AH0
+AD4  
+AD4  			qc +AD0 submit+AF8-bio(bio)+ADs
+AD4  			WRITE+AF8-ONCE(iocb-+AD4-ki+AF8-cookie, qc)+ADs

Setting REQ+AF8-NOWAIT from inside the block layer will make the code that
submits requests harder to review. Have you considered to make this code
fail I/O if REQ+AF8-NOWAIT has not been set and to require that the context
that submits I/O sets REQ+AF8-NOWAIT?

Thanks,

Bart.

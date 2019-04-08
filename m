Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C8C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D912148E
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDHWGz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:06:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33493 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDHWGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 18:06:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so8120017plo.0
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 15:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TGF/9bDXELkgaZNPxpeRVcKfSdfKOeFDWCHPs6TsMk=;
        b=jGlXVOSrBAO+YH/2pvN0np9+hkdmpwU5pi/wFBGkgu0LC7hi/TFDZPavE6qcrSiFym
         RZj3G1jnp3j+cSaGSlr5xDl3+lt/QwpW8MJLfxByQWB4EX7gF1/Na8dt5ldjUfyqRNGM
         3Zx78UW1C3oQnlijc4Udvge4s28kKPVnw0RpxG0SbqETh0xR3npi2XPhxcL02h2o7Ipc
         cFPkJkJev+H30KbWN2wPxyQRK2yhBxEL76njs9wrw6o7LFqvlsy1KklHIcJm0UmNcEt+
         55nCQLaMPUU48eM0tRy8cb2NFmRr4vzFngpHUdhjCC4hQoFZicgw0dBm1pEEbTM0vfWe
         m+kQ==
X-Gm-Message-State: APjAAAVR01VD6dy5E4psCvN0KSv4XibJle+c7pywMwUOjxkme2JsCc8h
        DCgXKKdL8/CLuE0UCrayRG4=
X-Google-Smtp-Source: APXvYqzFVBns4Yxzu6J9jrhv55NzB/BUGCgjG7g1ym4R4SKNOUvwmTzg7gxhTPoyBufuSu6Jg1l6ig==
X-Received: by 2002:a17:902:b58e:: with SMTP id a14mr3787906pls.44.1554761214027;
        Mon, 08 Apr 2019 15:06:54 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a72sm16488109pge.0.2019.04.08.15.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 15:06:53 -0700 (PDT)
Message-ID: <1554761212.118779.283.camel@acm.org>
Subject: Re: [PATCH 2/5] block: refactor __bio_iov_bvec_add_pages
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Date:   Mon, 08 Apr 2019 15:06:52 -0700
In-Reply-To: <20190408104641.4905-3-hch@lst.de>
References: <20190408104641.4905-1-hch@lst.de>
         <20190408104641.4905-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-04-08 at 12:46 +-0200, Christoph Hellwig wrote:
+AD4 Return early on error, and add an unlikely annotation for that case.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-

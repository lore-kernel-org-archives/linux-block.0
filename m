Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B30AC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7B120989
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 16:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfA3QfK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:35:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39547 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfA3QfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 11:35:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so55002pld.6
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 08:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h65OGagMrG5stMycoDZ4e/IYmCQ4bMuo91LsT4aifMA=;
        b=axiwbtjFA+3DkFXqXVCNratKJd18XYviAdEXRvrG4Yn3l9rQ/Pw8BQM987CTML6Z//
         bzN2KHhWk8GgpFg8m93wP7AiLdRP++slddAtXMQFdk0lTguWJaNvGr/CBXpmdXOkUSax
         tKBfS7u1Tfid2r6A2QJls/hx1PSHkwky8RzW+wWs9d+mUMQDakYb1dBmLCpLtIH/xppA
         9RfVL9w18i69+W1pnIpXDZypSJke1C+oRe4Qg696BxrLrZniw/9dm3pPZH7/0U9A1A9b
         TV4Cy/Xq6ftsipOeS8F1QWxk0V3J95KTfu727VGGmu48NL0g1/tL3jIUy1aIn/BScCRo
         Uubg==
X-Gm-Message-State: AJcUukc7wKeRYBCjjRtzGovV1b21XYWiNDrzo9coLPOQjq/psZZ0/Yib
        EIPR2U5qNE7l0YjdsUjZlUhaAhWz
X-Google-Smtp-Source: ALg8bN5FYWxglYosoQcMaS9K8O/Z2eyB0Xmi7SIt6f+2RkoPlJNCCJM82tWv8CQ4SdhVwOQkPyw8cw==
X-Received: by 2002:a17:902:e18d:: with SMTP id cd13mr31106348plb.262.1548866110016;
        Wed, 30 Jan 2019 08:35:10 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t5sm6495757pfb.60.2019.01.30.08.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:35:09 -0800 (PST)
Message-ID: <1548866108.9266.155.camel@acm.org>
Subject: Re: [PATCH] bsg: allocate response buffer if requested
From:   Bart Van Assche <bvanassche@acm.org>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Date:   Wed, 30 Jan 2019 08:35:08 -0800
In-Reply-To: <20190130094424.94255-1-hare@suse.de>
References: <20190130094424.94255-1-hare@suse.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-01-30 at 10:44 +-0100, Hannes Reinecke wrote:
+AD4 The 'response' buffer from bsg is mapped onto the SCSI sense buffer,
+AD4 however after commit 82ed4db499b8 we need to allocate them ourselves
+AD4 as the bsg queue is +AF8-not+AF8 a SCSI queue, and hence the sense buffer
+AD4 won't be allocated from the scsi stack.
+AD4 
+AD4 Fixes: 82ed4db499b8 (+ACI-block: split scsi+AF8-request out of struct request+ACI)
+AD4 
+AD4 Signed-off-by: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4

Please add a +ACI-Cc: stable+ACI tag. Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4



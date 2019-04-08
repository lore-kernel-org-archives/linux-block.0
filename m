Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138FC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A6C20880
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfDHWER (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:04:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38009 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfDHWEQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 18:04:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so3625424plb.5
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 15:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tiYdnH+yCOm4Ofcxx7/t26TgZgPq/GpbeF2bZ4DzJOo=;
        b=Lms+rO+HY66K3p7gFFdegqhADb3RR0HnV4Fz7nA+W6y2rnKABckBbOwNaB42oOK06D
         apHi2LmQCvLjPgi8rl1EToVE7gmkWmRGzBhRfHznxywWmHCfGFwEbDO4dEFS+3d4a80R
         mBzoU2ZXYx0LH58Py0exPEzFtPcH5ZeDlxBY6x6WFAf9D4BiBfu+jCOpEFxnK2Isf6ye
         vmBXpQXP6EX4tmddZBsWOe388gD+SvcYtUHxYLLzV5J51h28cOobnuybu3I/1p+yxsSc
         6LQiZB1eI6rQ/pm6oElFhChKC39n8uHP4F6VoIxf0HHM8QaLev6THBEhmXxc6UCMgogl
         SzSg==
X-Gm-Message-State: APjAAAV+nMUAIt/SXDeBPEsDgSB3+gqjQ81+X/+LI+MfV7ftrb4KpPWC
        8X2GLYvrzWESOXd1umPRnFw=
X-Google-Smtp-Source: APXvYqy2yFwQcKNthFQNcIA/er96qhOwjdS3OSMEq0ZsK4z7Lf3xCoWzmrkKJ+k3DYRcq9r8b9ULSQ==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr32798546plt.59.1554761055975;
        Mon, 08 Apr 2019 15:04:15 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 17sm70748262pfw.65.2019.04.08.15.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 15:04:15 -0700 (PDT)
Message-ID: <1554761053.118779.282.camel@acm.org>
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Date:   Mon, 08 Apr 2019 15:04:13 -0700
In-Reply-To: <20190408104641.4905-2-hch@lst.de>
References: <20190408104641.4905-1-hch@lst.de>
         <20190408104641.4905-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-04-08 at 12:46 +-0200, Christoph Hellwig wrote:
+AD4 The offset in scatterlists is allowed to be larger than the page size,
+AD4 so don't go to great length to avoid that case and simplify the
+AD4 arithmetics.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4



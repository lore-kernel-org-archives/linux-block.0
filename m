Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5FCC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 19:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1A020652
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 19:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfDXTtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:49:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33099 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbfDXTtO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 15:49:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so9823019plo.0
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 12:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SOWDEwz3DmKAxshWRhhsH++pX8swzMzEt1b6i/Qj+uk=;
        b=g2F2sKYDyfD3XfuR2uDuAeH8st/A2XKiyjlxn/gATV3o0TsWpFSh9SDB1X0he9m+2R
         DBMGnUBOQKbfo2b62OcNpumew5rLofNTc5sn/Z5swPWY3ppoSW6BspbvNuhoroDEDyWW
         RE7aduSgDtYomz5+77UaDX5ym/dMApr7XrpU4PN2HCxWXoiWJuXD2SPFC1+1zdgLfAqo
         Jh7+Ad5PiXnOBYfbt4+0AMIwGjOonVYwm++ydRsZgdbfnlhjEoIrJqQeT9sqpuRqNyUQ
         64TagiSRYIfgEjwggTkcZh+TKB+Pw055UleA2lMs+KCVQx6rXAoIR/fZzSOac1NzULPS
         HwIQ==
X-Gm-Message-State: APjAAAWRs9DSWD01bcMAXC7GqW/ADsKbJuBPOQ/BIcY7v5+Rn4fKrwwJ
        JA43LIhQjpdex/92S3/K1F8=
X-Google-Smtp-Source: APXvYqy1hoJVuicZ2JXSv/6q7rata9/Z46m4aJFgbQ8WWA0HN+JkVL/YXtLK722OOdqEjnOfToSG3w==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3mr34822783plp.241.1556135353195;
        Wed, 24 Apr 2019 12:49:13 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f66sm5899494pfa.5.2019.04.24.12.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:49:12 -0700 (PDT)
Message-ID: <1556135351.161891.138.camel@acm.org>
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
From:   Bart Van Assche <bvanassche@acm.org>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Date:   Wed, 24 Apr 2019 12:49:11 -0700
In-Reply-To: <20190418140632.60606-1-hare@suse.de>
References: <20190418140632.60606-1-hare@suse.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-18 at 16:06 +-0200, Hannes Reinecke wrote:
+AD4 +-static int +AF8AXw-init blk+AF8-bio+AF8-split+AF8-init(void)
+AD4 +-+AHs
+AD4 +-       return bioset+AF8-init(+ACY-bio+AF8-split+AF8-bio+AF8-set, BIO+AF8-POOL+AF8-SIZE, 0,
+AD4 +-                          BIOSET+AF8-NEED+AF8-BVECS)+ADs
+AD4 +-+AH0

The slab allocator uses +AF8AXw-init for some of its initialization. Can it happen
that blk+AF8-bio+AF8-split+AF8-init() is called before slab initialization has finished?

Otherwise this patch looks fine to me.

Bart.

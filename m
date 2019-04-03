Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE7C10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C11206DD
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDCPea (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:34:30 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42395 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCPea (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 11:34:30 -0400
Received: by mail-pf1-f174.google.com with SMTP id r15so8319390pfn.9;
        Wed, 03 Apr 2019 08:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3rr2SgTKShIPFHh05xkb9s6YGCaFJ87GvqswsxAc3w=;
        b=l1yz1c+BAuUkUlceaH27xDXa8neCAlJia2GP/YK7svjp8df2niuX8tnEAVpTufG+Is
         THvU6SAdoZ5sTnczJVGyiTY0skyfcPeLz5/FDNzz593dof2MtPg+iYbHZJ1pdHJHI+OU
         Z30eBE2Q6Iz7tO/OTLWxIJdbEuX5AqUwwngZuNc33sDquv03snRcVmDwyMsZZ7DDRcyH
         RvljIRlXFLasJihuLinO0VY4o16vqNvW3GXsHuifgRXZwiX9OV8jRZe9htuX/G7g1OXe
         aPIsuWOdFnrbb4aGdiCbXrW2ilmPzNusp5na3vAxPdV2usbEKmN3ABNm7uthftqdaPMV
         Qetw==
X-Gm-Message-State: APjAAAWozQdU8dzV5R5Av8mAlwr/bzZSl2HtKCmSxSELoKyxRr7lxZxq
        5VISB7mMepqvjutYd3QDeXk=
X-Google-Smtp-Source: APXvYqzojYh8zN7tLQmyvgwZCZKYfNRTZJyjcR1fb5gqLH3ipvqR4OVg8xqT1rvrVQVQ9VpmmUB6mA==
X-Received: by 2002:a63:408:: with SMTP id 8mr294313pge.334.1554305668670;
        Wed, 03 Apr 2019 08:34:28 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 17sm32087830pfw.65.2019.04.03.08.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:34:27 -0700 (PDT)
Message-ID: <1554305666.118779.188.camel@acm.org>
Subject: Re: [PATCH] block: bio: ensure newly added bio flags don't override
 BVEC_POOL_IDX
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Date:   Wed, 03 Apr 2019 08:34:26 -0700
In-Reply-To: <20190403091519.13376-1-jthumshirn@suse.de>
References: <20190403091519.13376-1-jthumshirn@suse.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 11:15 +-0200, Johannes Thumshirn wrote:
+AD4 With the introduction of BIO+AF8-NO+AF8-PAGE+AF8-REF we've used up all available bits
+AD4 in bio::bi+AF8-flags.
+AD4 
+AD4 Convert the defines of the flags to an enum and add a BUILD+AF8-BUG+AF8-ON() call
+AD4 to make sure no-one adds a new one and thus overrides the BVEC+AF8-POOL+AF8-IDX
+AD4 causing crashes.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4



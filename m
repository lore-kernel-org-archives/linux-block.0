Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0988AC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93C620851
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCHSIu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:08:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37474 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfCHSIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 13:08:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so14696889pfh.4
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 10:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAxz/gk/i8sF7zsVuGN+ufN7MW/xXM1h4FsRiog0GCc=;
        b=etUE3R0gDeK3bIUNknZHhb5+XN7bbRjDFVtViX5DEkHR100bg8EbO1H35Xhf/DZV3m
         78oji1XeomnEHUQJVu1cRmM6yVUSssr3hJNZYEcKWwtukLBk1NKkUdNiVR9twL9U/BrC
         IqvZPhjUTOy+zenGXX4b7038zQtjwhFy2Iuckfk/x6LSTBdIr6IWLNT+RDa3hw4V1dK2
         uw5/gUmNXBeEjSiyct4j4rlIdue2PprsbgJM9eZB0wGlky1W398qPs5L/ucHwSAt1dvf
         b01/5HNgW4Q/ZeXMndCpFLNQYA6qUNrHPyvqR/oRk1Lh9cOqVy8N6/sI3ml0ejj9qVyB
         Itiw==
X-Gm-Message-State: APjAAAXViVIgvzddz9+daaUCqglIemFT0qeAJ/a/eUirbsUAGcDAzEiw
        Hj6VOZ/+R8/Xurv4157UAxk=
X-Google-Smtp-Source: APXvYqz7/BIT43DwD368GBIDmXZ9DiVRK+QuNfJBTOEERVCO/Zq1Aryg/DVzc2NAEh2knr7sGgNE7w==
X-Received: by 2002:aa7:9286:: with SMTP id j6mr19512801pfa.47.1552068529370;
        Fri, 08 Mar 2019 10:08:49 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d5sm11467478pfo.83.2019.03.08.10.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:08:48 -0800 (PST)
Message-ID: <1552068527.45180.25.camel@acm.org>
Subject: Re: [PATCH 2/5] blk-mq: Export iterating queue requests
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Date:   Fri, 08 Mar 2019 10:08:47 -0800
In-Reply-To: <20190308174006.5032-2-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
         <20190308174006.5032-2-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
+AD4 A driver may need to iterate a particular queue's tagged request rather
+AD4 than the whole tagset.

Since iterating over requests triggers race conditions with request execution
please explain what use case(s) you have in mind and what your plan is to handle
such race conditions.

Thanks,

Bart.

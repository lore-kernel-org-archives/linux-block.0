Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D37BC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 20:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418E220645
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 20:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfCHUrN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:47:13 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36730 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfCHUrN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 15:47:13 -0500
Received: by mail-pg1-f175.google.com with SMTP id r124so15041523pgr.3
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 12:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsjOyOwJ8piGnQF5nAllUA0RPP8vGKMMignc7ImhNTw=;
        b=P8PHln8kfrr2czz15gU8sh0URpzNTC+aBDMK0P6V957lsBlghNVaUYBgAJLaw0ySMR
         tuhKJHoqh1lo5d/uLIO2ShZ3AD5zdx16l2d4tfjipbp6o2VDCRYWaT9mtRTYTuTlJSd7
         DTyuh946rf9DHr1cVCKhh832o7yl8DJIojJ8SsIxDopNsj1Y3beKgQQrk8HoywIpvW4n
         wFWQlmbGvUJQV6ajo0Vf5PPOcIDveXJjauDlYtHQhlPY0UvxgWgOiLyyRCjcDw0E6n9y
         8ZTc5HE9R48/SxV+Cd0FeZ01p9GEtOhh+kPkLI2IhLPNhIld1WtOCuaeOf5kRmeBF7tn
         u1uQ==
X-Gm-Message-State: APjAAAVKQm8x2GbCqpNi/OJy81qg+60FQpoHmIJTP6WLVPRaoCsbQNSE
        fuZTZlCN7ZkSaroghiWgwzg=
X-Google-Smtp-Source: APXvYqxbq3qi0EFVXofmKU7yTVlqN6IXTuXHyl0KXpCV28xQ6WWVcTL6qIiloqMekZCE06coqd/MYg==
X-Received: by 2002:a17:902:b10f:: with SMTP id q15mr21272732plr.202.1552078032311;
        Fri, 08 Mar 2019 12:47:12 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e123sm10568940pgc.14.2019.03.08.12.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 12:47:11 -0800 (PST)
Message-ID: <1552078030.45180.88.camel@acm.org>
Subject: Re: [PATCH 1/5] blk-mq: Export reading mq request state
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     t@localhost.localdomain, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Fri, 08 Mar 2019 12:47:10 -0800
In-Reply-To: <20190308191954.GC5232@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
         <1552068443.45180.24.camel@acm.org>
         <20190308181551.GB5214@localhost.localdomain>
         <1552070537.45180.38.camel@acm.org>
         <20190308191954.GC5232@localhost.localdomain>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-08 at 12:19 -0700, Keith Busch wrote:
+AD4 On Fri, Mar 08, 2019 at 10:42:17AM -0800, Bart Van Assche wrote:
+AD4 +AD4 I think that the NVMe spec provides a more elegant mechanism,
+AD4 +AD4 namely deleting the I/O submission queues. According to what I read in the
+AD4 +AD4 1.3c spec deleting an I/O submission queue forces an NVMe controller to post a 
+AD4 +AD4 completion for every outstanding request. See also section 5.6 in the NVMe
+AD4 +AD4 1.3c spec.
+AD4 
+AD4 That's actually not what it says. The controller may or may not post a
+AD4 completion entry with a delete SQ command. The first behavior is defined
+AD4 in the spec as +ACI-explicit+ACI and the second as +ACI-implicit+ACI. For implicit,
+AD4 we have to iterate inflight tags.

Hi Keith,

Thanks for the clarification. Are you aware of any mechanism in the NVMe spec
that causes all outstanding requests to fail? With RDMA this is easy - all
one has to do is to change the queue pair state into IB+AF8-QPS+AF8-ERR. See also
ib+AF8-drain+AF8-qp() in the RDMA core.

If no such mechanism has been defined in the NVMe spec: have you considered
to cancel all outstanding requests instead of calling blk+AF8-mq+AF8-end+AF8-request() for
all outstanding requests?

Thanks,

Bart.

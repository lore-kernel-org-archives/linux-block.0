Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D5C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 16:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8F220684
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 16:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfCFQPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:15:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33917 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbfCFQPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 11:15:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so8785966pgd.1;
        Wed, 06 Mar 2019 08:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CpHa6t6to0r574VyJ/7qSNmNIGZZsE1qy5W5MHvdrI=;
        b=kw3zFhph6UsAmf1DPisr+L1Pe3HLHkeJMb03XRhIz49riBzxKA1rEgo0cVrusIgR20
         JFuqVI+gngMjZhYt8jdCjlvjRIRj9x2paR9r2G1d/SC3e2LUJAGzyswsHHqVTk4sPgC9
         AbiU6jBApmTMD8ODnakOUCRog1nuPs7amGMmMQhc/Zt3XqetWjwX0l7CFLblSJQqvKGQ
         wo+MAdRZ+wAQt41MAFJdsNYvMm1QQG9ehVGtSyaZzHM51ZwrWKiGoK4ALACS0l7J4zTq
         yHWcL/Vs2awqQENZyU0c0o2o9ibhHuHWprIBxJ3uXT64toV4OsRqFi70WeSpAFHlLIlQ
         OAow==
X-Gm-Message-State: APjAAAU36qYVGA/iHHiMGBB82G1wF4hxCcOeUfVWeGUvBfFPE0LxnOxt
        /9ABkTFV51RUH09N4y48BKI=
X-Google-Smtp-Source: APXvYqyIu9LlyyQ4FFxnglpH6DDXtIflHLDtG33Q2S1EFzl0fqUtOAB4nAaZ7seyD12LLTCT3sInxw==
X-Received: by 2002:a65:510c:: with SMTP id f12mr7094491pgq.40.1551888923495;
        Wed, 06 Mar 2019 08:15:23 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s4sm3408248pfe.16.2019.03.06.08.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 08:15:22 -0800 (PST)
Message-ID: <1551888921.9796.2.camel@acm.org>
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tal Gilboa <talgi@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Date:   Wed, 06 Mar 2019 08:15:21 -0800
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-03-06 at 10:48 +-0200, Tal Gilboa wrote:
+AD4 net+AF8-dim.h lib exposes an implementation of the DIM algorithm for dynamically-tuned interrupt
+AD4 moderation for networking interfaces.
+AD4 
+AD4 We need the same behavior for any block CQ. The main motivation is two benefit from maximized
+AD4 completion rate and reduced interrupt overhead that DIM may provide.

What is a +ACI-block CQ+ACI? How does net+AF8-dim compare to lib/irq+AF8-poll? Which approach
results in the best performance and lowest latency?

Thanks,

Bart.

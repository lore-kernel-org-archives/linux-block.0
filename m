Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25796C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F015F20854
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCRR2J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:28:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38316 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRR2J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 13:28:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so11722628pfn.5;
        Mon, 18 Mar 2019 10:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KE4wyfuPK8v8HlyIMBIYRZHkOOdHrncsG0EpVpGZwU=;
        b=C7EXqa+Mw2udDaXmJMom8Bu3DzTWeTpo2I6vv3aYnm8+wlMi1g8gZyZbMAVT7MfPKK
         QpWZ+mAr1U70q40ropFirP1/CxJnaS8+KPmRBRLYKjZMnGiejuy8Z6ZVS6zGux9Oj5GA
         3Gva1m1UCiA5kFIXdMT0wXjuLk/wvwHK1r90uKpj34vF2saUwRLaNSJ3H70fLcJF1/Vn
         gm10jnwaghpq+2OWmBxJlIuyRYrM9plRK9OBr8aKeX+wpWx/KcpempZq9Vt3N5wKRf/S
         94OmZZVqTL4dqfdbLjVtob3V6+8UFyDffEE5agas44Md6vuuaAqQNNXqIoNOPdeqJjf1
         ZBlw==
X-Gm-Message-State: APjAAAWvZgrmk8TyvTdAsNrtLyMSu3qkC9p1JX5oF+ASg1BRmd87abhJ
        AmjPbQLV0SlmTVDWj6RaOtE=
X-Google-Smtp-Source: APXvYqxgsrVM9i5/x26a7Ori9du9Nh5vFam+SaNl68I4xRJ3CN5fa89ZLkFSxN2qHUjoGCIC6ZaE4Q==
X-Received: by 2002:a63:ef57:: with SMTP id c23mr8565915pgk.176.1552930088073;
        Mon, 18 Mar 2019 10:28:08 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m32sm1137034pgb.13.2019.03.18.10.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 10:28:06 -0700 (PDT)
Message-ID: <1552930085.152266.36.camel@acm.org>
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        sagi@grimberg.me, keith.busch@intel.com, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 10:28:05 -0700
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-15 at 16:57 +-0800, Jianchao Wang wrote:
+AD4 +AFs-2+AF0 https://marc.info/?l+AD0-linux-block+ACY-m+AD0-154526189023236+ACY-w+AD0-2

Hi Jianchao,

That is a reference to the +ACI-BUG: KASAN: use-after-free in bt+AF8-iter+ACI issue.
I think that issue can be fixed in another way than modifying all code that
iterates over tags, namely by adding an rcu+AF8-read+AF8-lock() / rcu+AF8-read+AF8-unlock()
pair in bt+AF8-for+AF8-each() and bt+AF8-tags+AF8-for+AF8-each() and by changing the calls in
blk+AF8-mq+AF8-free+AF8-rqs() and blk+AF8-free+AF8-flush+AF8-queue() that free the data structures
used by the tag iteration functions into kfree+AF8-rcu() or call+AF8-rcu() calls.

Thanks,

Bart.

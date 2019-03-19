Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C9FC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE0720828
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCSPK0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:10:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39802 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSPKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 11:10:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so4142018pfo.6;
        Tue, 19 Mar 2019 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWVbPbIJHWRu+0d/VAgqUPk+oUx6QNArMt1VL+TqPEc=;
        b=QWczDsYg5YdOTZ7vgl+ku1oNqNPZtnT7+7+xfZryztnx0fJuqiFUqbqYK4pdKv8fFi
         LGvRf3sx+5mu1TPoYoTC3T7PnbILP1ssW7fJi3I7fOWf6KAY9yjLPiNfYzYO2UP/I8fa
         NQYDGbu8uYv/PGq42J8dRawyf9/cBkomA6PM4qnAwbL7sleZzd8ak12C7bcx6gOaZRR6
         7vLS4/aCOnvOUcqFTaQhDYBwXkiYsfRuqpoGEPHYMYnyUVyDBzdqOBwXQpsABYYaj2BI
         MoYwVPUPS2+Xg6ViJGkV+BtLh4QQ1kcSgOgUOWAln3UAEBK84oxROnblKMD9y/CU+kND
         38MA==
X-Gm-Message-State: APjAAAVV5pjFPU3g2rG4/riLvWjPHm30Q1KbuLGz5wpKhY1lgjInOlcw
        YJriwLlIoKWSMrSh4yV7oLY=
X-Google-Smtp-Source: APXvYqytU74jOSTCI8MxCdE/xl60VfX4LzCCK8VWZ2KsqANhbFrzY//n7VvW5R9j6rZT54z5azrn7g==
X-Received: by 2002:aa7:8082:: with SMTP id v2mr2659054pff.164.1553008224410;
        Tue, 19 Mar 2019 08:10:24 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h9sm25950092pgk.22.2019.03.19.08.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 08:10:23 -0700 (PDT)
Message-ID: <1553008222.152266.43.camel@acm.org>
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
From:   Bart Van Assche <bvanassche@acm.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de, hch@lst.de
Date:   Tue, 19 Mar 2019 08:10:22 -0700
In-Reply-To: <3cd58454-eda3-de9a-0eed-b6a7edbce28f@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
         <1552930085.152266.36.camel@acm.org>
         <3cd58454-eda3-de9a-0eed-b6a7edbce28f@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-03-19 at 09:25 +-0800, jianchao.wang wrote:
+AD4 Do you mean this patch from Jens ?
+AD4 https://marc.info/?l+AD0-linux-block+ACY-m+AD0-154534605914798+ACY-w+AD0-2
+AD4 
+AD4 +-	rcu+AF8-read+AF8-lock()+ADs
+AD4  	sbitmap+AF8-for+AF8-each+AF8-set(+ACY-bt-+AD4-sb, bt+AF8-iter, +ACY-iter+AF8-data)+ADs
+AD4 +-	rcu+AF8-read+AF8-unlock()+ADs
+AD4 
+AD4 The busy+AF8-iter+AF8-fn could sleep for nvme
+AD4 blk+AF8-mq+AF8-check+AF8-expired
+AD4   -+AD4 blk+AF8-mq+AF8-rq+AF8-timed+AF8-out
+AD4     -+AD4 q-+AD4-mq+AF8-ops-+AD4-timeout
+AD4        nvme+AF8-timeout
+AD4          -+AD4 nvme+AF8-dev+AF8-disable
+AD4             -+AD4 mutex+AF8-lock dev-+AD4-shutdown+AF8-lock

Hi Jianchao,

I think that's an additional reason to rewrite NVMe error handling ...

Best regards,

Bart.

Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E582C0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 21:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35047214C6
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 21:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfHHVSQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:18:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37751 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfHHVSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 17:18:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so44099133plr.4
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 14:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6qU95RzBKGIiVfZW/C68m+k6dwoqM+uhezBZUZNRxaM=;
        b=lByxQKMlOXEjhVnaLgofGeBAfP+74Dexypx0pwAF+2t6xqYKuSWdmDZjwBAPBg8ypC
         Ufvce8Fb+FlmmLE5CcB0Y+Mtqynfio0x86c+cm5mTOX6guzBGWCYrojp3ybTJfaXvnEH
         wIHG6j3sJD5u3HtNbCy/IhrxuQXNYKZllQilasIpo+97AJW51+6fLw6PJFkLUlr6ZTTq
         0IqIrFcsTdLNW7l2sMHbVl1ix5dbwwyafBSofiV8lfbn1fkFQR1fVAndBycDWomtdCmm
         CDSSjtoKgnzQe97o+OKhkydumqPhRRRGu2p5SwUD2CPdDNQ18L0duwfEsmltSF9rQzZv
         vsFg==
X-Gm-Message-State: APjAAAVxb5BijlYNz3iBObJoI80YNvqwVUDqqY1YcgzkT4Bujs0qwAs0
        xpdhfgXkYAU4fjuBFY+eNdA=
X-Google-Smtp-Source: APXvYqz23ol1GyKxD5bnio8TmFOZav33ULkQz44PhJWZjmq0mKFZB4dae/dkP+KM8YBuQHmTyk0PYg==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr15684003plb.277.1565299095900;
        Thu, 08 Aug 2019 14:18:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m101sm3334799pjb.7.2019.08.08.14.18.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 14:18:15 -0700 (PDT)
Subject: Re: [PATCH blktests 1/4] tests/nvme/rc: Modify the approach for
 disabling and re-enabling Ctrl-C
To:     Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190808200506.186137-1-bvanassche@acm.org>
 <20190808200506.186137-2-bvanassche@acm.org>
 <a90e327d-ea09-0286-f985-2d3775a38728@deltatee.com>
 <a6b0bea2-3efb-fc04-f5a3-1dad562c72da@acm.org>
 <5668ac69-a7e3-766b-852b-c7d1cb99dcec@deltatee.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a49a90b1-d5fe-97d3-b38f-5539242399c9@acm.org>
Date:   Thu, 8 Aug 2019 14:18:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5668ac69-a7e3-766b-852b-c7d1cb99dcec@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/19 2:11 PM, Logan Gunthorpe wrote:
> The main code traps EXIT which calls the cleanup handler that this trap
> then overrides SIGINT with, so I'm not really sure how they interact.

Hi Logan,

You may want to know that there is already code in the blktests project 
that modifies a trap handler from inside a trap handler:

	trap 'trap "" EXIT; teardown' EXIT

Bart.

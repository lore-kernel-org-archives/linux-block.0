Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4A3C76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF632253D
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 20:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfGWU35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:29:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44073 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbfGWU35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 16:29:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so6980279otl.11
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 13:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5vBLulSYTeOVJqAoHXTD2L1BU9MGzk4eAxoU7D3HMA=;
        b=l92I5D/LfPkf0nVXObXBT2/yvvwDl12To5eSegtAMqzarx5taRyZZ4v4ClloineG+p
         ANnPOKbamWc9GU7sda2wMpXY+bQHs7sRCjjqP17hwuegrWqv7Mf25hkjD/bPP7gFymPj
         NUkPWwjYzHsTRE4H6afsdnjcqGNU/lJgrfPilpupReOOOIz1qksgxr9y3wBpccyoEsX3
         PsGs1GaxZ3n6XiLcWlOxrSOuZ2KiLvHkV2Uxh3ljT2uNdPqQ1Q4MVxn/jVBnP0mrr2L/
         dW3bvH+fZRwBSPREgsDBJwHFtOWb+xlO6FsQDaW1FtLpXSHjae2Iw+vB+xFWgpgaqn0X
         +cUw==
X-Gm-Message-State: APjAAAX9BfGjavH+JLy9XvgbITLX/KSlWnVPy/8SFneWG1IcoJoGxxNj
        7MHjPMl0bVajQ1POCIadnrM=
X-Google-Smtp-Source: APXvYqxrlVCWvf3nBld0wRfatPPbjx2JtCAwSWWwXCQtCgc/r7eRnBX9lSZyR7dv+jvjH+Jfw0AjcQ==
X-Received: by 2002:a05:6830:200e:: with SMTP id e14mr13914865otp.245.1563913796297;
        Tue, 23 Jul 2019 13:29:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id k18sm15033646oib.56.2019.07.23.13.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:29:55 -0700 (PDT)
Subject: Re: [PATCH 4/5] nvme: wait until all completed request's complete fn
 is called
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-5-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <95f000ba-d3c8-f215-5e32-4b6e44954fb1@grimberg.me>
Date:   Tue, 23 Jul 2019 13:29:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

What about fc? I know that they are not canceling a request, but
they still complete it, shouldn't it also wait before removing?

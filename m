Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DEAC433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 01:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC762067D
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 01:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfHABPP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:15:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36603 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfHABPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 21:15:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so33006093pgm.3
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 18:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lmNzmZF9FJi2vaHW0PlNrHg8bpfWbI3lWw/3vJrbfYo=;
        b=KsBfYU5B7Tl6vufmK1QvXAtBK76bYHi3OANdqLUVx+yF/gVIAIVtrT/T5oZqfIcTLi
         j1QT5mCiITpfeU+YX9vh1btuo61nKnOGRcGYulQx27ywgI6TjipI92zeKT2J2TkDYcXd
         HrpkywWRvUOcTcCPyNS3EckwhmQOHans2edSBOQucGH7CN171pU7w3zos6qF0/sX9OGt
         vpM62D7En+Qh6fJuZIQZ890R9IK2X2ZtT8GwcSXD1PY3m408Jb9kCI384HLkRXKzluPw
         KBSCfMFq9r19A5Dx1H327ePtdgjEhQesouUFWQppw5Bkx5sQTY5Hs57NkzBVU1ZPc76R
         zZKQ==
X-Gm-Message-State: APjAAAWGFzDOjOXut19JBXOC7Q0vVohfUQ8i1Y34vnI5am9ybDc8uylr
        rtYX6cLum73losn89frJcdRNhRaN
X-Google-Smtp-Source: APXvYqxKpwvyxh/wQmA8Mxo1dRM40SKDpLS9FjY7d93kQQ0SCC3Xp8SkWIZAP67dE0BLmJX/KApFcg==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr5706485pjb.19.1564622114596;
        Wed, 31 Jul 2019 18:15:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:45eb:53c1:ba3f:2a0a? ([2601:647:4800:973f:45eb:53c1:ba3f:2a0a])
        by smtp.gmail.com with ESMTPSA id 22sm79604811pfu.179.2019.07.31.18.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 18:15:13 -0700 (PDT)
Subject: Re: [PATCH V2 0/5] blk-mq: wait until completed req's complete fn is
 run
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190724034843.10879-1-ming.lei@redhat.com>
 <20190730004525.GB28708@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7eeb2e89-a056-456a-8be3-6edbda83b7bc@grimberg.me>
Date:   Wed, 31 Jul 2019 18:15:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730004525.GB28708@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hello Jens, Chritoph and Guys,
> 
> Ping on this fix.

Given that this is nvme related, we could feed
it to jens from the nvme tree.
Applying to nvme-5.4 tree for now, if Jens picks
it up, we'll drop it.

Thanks Ming.

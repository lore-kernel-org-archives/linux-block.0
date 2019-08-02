Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAF1C32750
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6072E217D6
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kRGXaQzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403936AbfHBNeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:34:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44964 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405641AbfHBNeQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 09:34:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so36091525pgl.11
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2019 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uv11iay6UFn4yJKiuRstOy4WPPsctn3pPbReDqThk3Q=;
        b=kRGXaQzIzBD52EJQZLvx4W+R0mDukgkxPnTUtTJlin+4rhjjL3JwTS/DVVx5rwAkSa
         SIWKf2ijtW91Uttw2C1OI59ojRKF9ryFw8rVixagdxpZTimERrrCNasTGB5/stbhoari
         +i3LXap+w1gTBsArj8PxA2/skOLPWE3VOP8nLSd6EST6CCsevy3JQvSmilf7ie9ynLMQ
         /W/JIrlISKOvINrxvwJqf4wbqIFZh+EhwSBmHBfnY8+hi6Qv4U3RQFux+3WROQ6WpAv/
         p0TVqRVUi+DcebHtKU9uGycN8/+n/kp1eD6FBxPvVC7DsDZVXYagIhXsUwGkOyIpqPPV
         7Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uv11iay6UFn4yJKiuRstOy4WPPsctn3pPbReDqThk3Q=;
        b=Q+CalaKMDIlAtLxpkbLI/GUScbfdRBjtI5Fz2lfGU+WY3qlDSup7N8gMNrKu9yL7rr
         6OW9teGs2OqUWZD6T+9kVhAgny335D8ER3PUyn5Ljwnrl1AhqKPy1Dyj8+PDs0uZ2zK+
         OyDk4dgVtVcK+ZxM1zKHE/HbI65PtRskaJHsVT4JaOa006ftQ6C7uhKvTPoNT0OmGWQN
         YDuP1Ltk/o0dFiHFPa4rTR8APjy3qGuJwiio8lci/7O7Yb8AUK4CZPKEDiXxqajfkFPZ
         YEv6AP+3wWaCC38GlydDIlN++haiHBv2GZP//o1eYcOXsrkxlu6Msz7qDY6xW3yyweys
         dL4w==
X-Gm-Message-State: APjAAAW+SJWjqnjhBiuXpgLi9MNSydAwHtJRc/tFd0V7hxiKr9jErhqj
        IhCspFteA6Sx5/L+KEMMSoE=
X-Google-Smtp-Source: APXvYqx/wS2ev9Ujce/PRf10xzsSqr2moZjX9x1IBr/b4cR0jjJrYFw4BFRr9McpP2lKE+D895IgUg==
X-Received: by 2002:a17:90a:36a7:: with SMTP id t36mr4347365pjb.34.1564752855745;
        Fri, 02 Aug 2019 06:34:15 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id v12sm67199728pgr.86.2019.08.02.06.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:34:14 -0700 (PDT)
Subject: Re: [PATCH V2 0/5] blk-mq: wait until completed req's complete fn is
 run
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190724034843.10879-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <040caa53-897e-287b-00be-7541bce88b7d@kernel.dk>
Date:   Fri, 2 Aug 2019 07:34:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/23/19 9:48 PM, Ming Lei wrote:
> Hi,
> 
> blk-mq may schedule to call queue's complete function on remote CPU via
> IPI, but never provide any way to synchronize the request's complete
> fn.
> 
> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> re-allocated. If the completed request's complete fn is run finally after the
> hardware queue's resource is released, kernel crash will be triggered.
> 
> Fixes this issue by waitting until completed req's complete fn is run.

Queued up for 5.4, thanks Ming.

-- 
Jens Axboe


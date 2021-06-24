Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44583C49EA5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 14:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183A961351
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 14:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFXOOy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:14:54 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:51149 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXOOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 10:14:53 -0400
Received: by mail-pj1-f48.google.com with SMTP id g4so3583867pjk.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 07:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFfw2m4PEYPvE6rHziwIL+AMwigckTtvkBaNiTvLK5g=;
        b=StnfXi6lAlHxXAr+dZdqIQmYvRBZ5Buz5wM2zVyQUYE48seFxQt2WXRsjafnNbSD8w
         Uj5HcffsCnKPX5RosyzSQaRFyhqBXcI6LCzpSgpXhtEGVLwDwVjrYSU1PNllEXYBED7c
         /XYFgkRPdogZESHbNH7d3InwyC5emaoNu8cljx2GBBcp3oTp2w+7tWec1Gt1e1PJf9n7
         6osdnuQIiiyVtzA8ekGWspqfw2FU4qR5DhP0bURRxWApZBRWOgckFBM6QVmOcdwca5DR
         Ao1i1CCYricgDXXWyD/ut43Z3QWACwqxmn2hqJN5E9kr4+366IG0E6lyU9z5C+AhzQDK
         dA7g==
X-Gm-Message-State: AOAM532ZBWVxG7fGR/zIBsYWYFO42TPCmZ908r3lu/z7OzoQ1my6GSDY
        JDAlKUsGtnB3F5HL4b3wIZdl8nagunQ=
X-Google-Smtp-Source: ABdhPJw5Vk5czn5FbyVTat9ybVVHJNSjnVVyl2oCT6CV2v+ZZOnzU6E+1xhq2NjztY79pUjoewV52A==
X-Received: by 2002:a17:902:ceca:b029:124:d72c:3414 with SMTP id d10-20020a170902cecab0290124d72c3414mr4632223plg.63.1624543952681;
        Thu, 24 Jun 2021 07:12:32 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id la18sm5735975pjb.55.2021.06.24.07.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 07:12:32 -0700 (PDT)
Subject: Re: [PATCH] block: mark blk_mq_init_queue_data static
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20210624081012.256464-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bab172ad-3bd8-9c1c-47d4-5f4de6c705eb@acm.org>
Date:   Thu, 24 Jun 2021 07:12:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624081012.256464-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/21 1:10 AM, Christoph Hellwig wrote:
> All driver uses are gone now.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

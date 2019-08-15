Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3993BC3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A5A205F4
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NavdHBfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfHORV3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:21:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43969 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfHORV3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 13:21:29 -0400
Received: by mail-io1-f67.google.com with SMTP id 18so649425ioe.10
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ik8mfC3KKSNXQt7vV4hHm5g9lCMWv8v7p2BNIzreRo=;
        b=NavdHBfEkock07WcFOsQ79CMQo/i/j4SY3luHt1ijf/JiBDlE8xQGS2Vcw8NGYF7Sb
         rWVskrZTZ5z8U8LvrYJCuTQxLMg7XtXENbvz3evnLq8MvacC7IXI7F0cMZ0vxn7X5b88
         DEb8QOH8HLZf8bvyTZpXolii0ugKO7BKb7RDNgCmFJkvePmb8geYU2ZkkxoOfZbHCsb4
         vC+DfPqtshMWi4mVdk43OEQ+Tpco2+yxFtx6fbMA1PDm0YBXvUKVD+nLH5kK1wlEAIrZ
         67wx8PtBJQi+OfxaCbc9FTYssDxk5bJW03mtb/1hDUYSSvCrwNgVkL2jjt+/SBJsSLKC
         IinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ik8mfC3KKSNXQt7vV4hHm5g9lCMWv8v7p2BNIzreRo=;
        b=W4YL0Kug0yIhijyctrGskqgqrpMGEFBxeHVaWFAm20Epz5NqpT4reBdZgG0ZoY9qXF
         cSGFj/K6L75YzRTmTK+oGzkK4kFY/gc/R3hqULOZ5tmk36wcKQ41tYHrewW2KlKuZrJd
         uEENFvAx93O2gviRMpNdy5WAWUiQU6Zur8pPAgtGnMjXf91pVDiAM/OEOJojOE02a4aW
         tY1oBcq0laq7T7RTuzD+gGno6Pp+kHv1rWjaTXdRF1dxVBBGPUC+fL7QYkAx1KuqnILG
         faANusjbe/TfRw+kCrbcJ1H9vAmcw1TkCDb6i2C5jv68ctzKxHfxVXJX+9I/U6aijQkp
         dAPw==
X-Gm-Message-State: APjAAAVG5n+8vd0AsIGltrkw2l8Dq/F936Iq9bUuqvowpOhu+DHtl6uI
        5nA0PZSZAaVu/8811yu+Fe153o8kD769aQ==
X-Google-Smtp-Source: APXvYqysjWctHm5qY8UKe9Fdt8yjmqYzGIPl515XfiHMNbwIdRUjufZw7oLn1LZ6ZcGNMHo9JMdbmg==
X-Received: by 2002:a05:6638:517:: with SMTP id i23mr5947885jar.71.1565889687825;
        Thu, 15 Aug 2019 10:21:27 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o6sm2156127ioh.22.2019.08.15.10.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:21:26 -0700 (PDT)
Subject: Re: [PATCH 2/2] io_uring: fix an issue when IOSQE_IO_LINK is inserted
 into defer list
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
 <1565775322-10296-2-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92805a41-a4b2-e42d-0132-b0f5e6f9c29e@kernel.dk>
Date:   Thu, 15 Aug 2019 11:21:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565775322-10296-2-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/14/19 3:35 AM, Jackie Liu wrote:
> This patch may fix two issues:
> 
> First, when IOSQE_IO_DARIN set, the next IOs need to be inserted into defer
> list to delay execution, but link io will be actively scheduled to run by
> calling io_queue_sqe.
> 
> Second, when multiple LINK_IOs are inserted together with defer_list, the
> LINK_IO is no longer keep order.
> 
>     |-------------|
>     |   LINK_IO   |      ----> insert to defer_list  -----------
>     |-------------|                                            |
>     |   LINK_IO   |      ----> insert to defer_list  ----------|
>     |-------------|                                            |
>     |   LINK_IO   |      ----> insert to defer_list  ----------|
>     |-------------|                                            |
>     |   NORMAL_IO |      ----> insert to defer_list  ----------|
>     |-------------|                                            |
>                                                                |
>                                queue_work at same time   <-----|

Looks good, applied.

-- 
Jens Axboe


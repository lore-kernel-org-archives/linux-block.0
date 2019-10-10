Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF42BC4360C
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 23:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B690A206B6
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 23:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LAgwFwzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfJJXwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:52:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46802 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJJXwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 19:52:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so4900627pfg.13
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 16:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCuaMw8m9UN/5q2abRR9qC4VK+02/Hh9rek8kBa5scw=;
        b=LAgwFwzKergbnZXxEXYPb1hXuvSekkTrC7KSzmPpq8N7Tlm/RwZaow6B1x/INdMzEb
         C5hY+EqJPnF+5j4jsbSW1GWM9YdNluPvijodi0lOH5sqI+AWQQx11PduIVqWBJSjL2/o
         beCGM9mc9uU+o3G2HPcp3dtBZUP9hu7IcFIl5SovfeVSPGnabvT1iXqbi/vFEDIwFME1
         Vt01jRmATApNrsO2Q4d46DUnaDLJELIkbzZGDKs6AA+FZjbNTt6AB5RfonnH0H5C24+c
         tsG93YSJfM/GsTQw5Li0P118Ia0EHr9cxWw+kchqsVT99CnLtJflhFFUvY+66wAYvl8i
         1SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCuaMw8m9UN/5q2abRR9qC4VK+02/Hh9rek8kBa5scw=;
        b=bCBNKv97Vu8mL8Il6XWoA7hXuMxd640z5RiTfhT/Jpep7Pe0yMhJoMBUFvVOQgmdW2
         E1M9ZeWYg233DGcUA0WtCFNsWNQvltPggeC2zqIA2IyoBmKsifQOs9XaqbupLMFOSf+l
         FjhNUsW4+/sajKGt8b8vxeQoaHnAgDtlUNSbJhmDu5R0Z4wQKD3jF5rdP/TGt8sgGSrQ
         CCLXz/2FZCAiThtnQ1YaRAKovEQwaVtTqGHPZjKnittJqNIeFgTEsxbAowMlfLNRIlPf
         4KoDe91BDd0cdEcSFlBbUiegz6OOtDcT9UtPp6EJQN5J8tJ2IKL5BQkDAWOpHFKYwpRh
         VIJw==
X-Gm-Message-State: APjAAAUrmXg0J+KkS13MzFZthr0Ksw9B20Zo0VSmJ0fjFeQIVYus5WoQ
        fhq7kLSBLRXdjy5/x8Gpbn3hwA==
X-Google-Smtp-Source: APXvYqwD95JGqzibrj0+hiJ53FXfYwlzs+Nax94WXn3QiMp2CttxGXrUPGbM/+RXAYcNMz6EYxabWQ==
X-Received: by 2002:a17:90a:b902:: with SMTP id p2mr13370504pjr.62.1570751542284;
        Thu, 10 Oct 2019 16:52:22 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id t68sm6043305pgt.61.2019.10.10.16.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 16:52:21 -0700 (PDT)
Subject: Re: [PATCH] block: account statistics for passthrough requests
To:     Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>
References: <20191010233626.15998-1-logang@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <303a3cd8-e95f-651d-83c2-d283a89a8208@kernel.dk>
Date:   Thu, 10 Oct 2019 17:52:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010233626.15998-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/19 5:36 PM, Logan Gunthorpe wrote:
> Presently, passthrough requests are not accounted for because
> blk_do_io_stat() expressly rejects them. Based on some digging
> in the history, this doesn't seem like a concious decision but
> one that evolved from the change from blk_fs_request() to
> blk_rq_is_passthrough().
> 
> To support this, call blk_account_io_start() in blk_execute_rq_nowait()
> and remove the passthrough check in blk_do_io_stat().

Looks good to me, applied.

-- 
Jens Axboe


Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEDCC433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 03:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE26217D9
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 03:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zk8dHHT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfHEDna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:43:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfHEDna (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Aug 2019 23:43:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so38890328pfq.0
        for <linux-block@vger.kernel.org>; Sun, 04 Aug 2019 20:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6E9dvQ0Y2cdOUhPjFJtAK6t843cdrgBaRSWhoAdkm2A=;
        b=zk8dHHT6FWDrGQ83hHhB9xeCJuBE1XyFY0fU0FVZMqBfUAG61UFPr6A88gvAqqVZDE
         /+a/mKHm3tHyObwgUPotcNgMdvKEMbcf7S/e6Vl09aD9LzrDS9620oRE7uebL5bfb3DR
         1h1/zgoDm4tDQrz8DGmQE3a5ZIuvK4RIvNi0wAh/deJi38u1r7V/9um2+As3YaSI641i
         GDkfl7lv9wpRwfqf86GAFTZyJhXBnsLLT+XEnjADCF8G7Id+HHadKwu9bQIZOkFe5LDC
         AY3jjeznl2HPYItyFrtfXACWooHVS1lbZSgdm76v9yuS/JPidsDXLQFw5YOAu0Crjzzf
         G0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6E9dvQ0Y2cdOUhPjFJtAK6t843cdrgBaRSWhoAdkm2A=;
        b=NM81DLYNJU0S7AL61m0tglk5lx8uSo/Eqcq1l84ra/eIoYWCYC24xUX5K+DmX+jx7g
         gWJsYblTFYxG6e8Q3PBvn4msda/wXFUIiDUu0LqneaEISpKSgTJTVz4qBm/Qyj38P3+Y
         Fhs29XI03ilxlgpY+nvYPZgQpx+YPapTqJR4E42dnncyjnNFnrQFNzmFanfg9nH6TK77
         brduv+826rgb1+Tcbb6PVtNMEtOgCEm1P/xWVy4pTCrPAXU84Dy3cPc766e0LXn3l53r
         Emg980LUk8nT0AaFItIhXn4FwufD/vnMr3+zinhtfMOxUIn0RTJM4rzxQTMnA64oZH5P
         RGeg==
X-Gm-Message-State: APjAAAUmjs+xgJ0WA21W0DO0EzLvPYIYgb8UJjHfXva9Me1rfgRwXJfW
        UINwaHGgEhoq+boueWIAaHlA7AC5AD0=
X-Google-Smtp-Source: APXvYqx6vggXHQyqVgWO+8euAFPj4Q2f1SBUOxt02B3cjEVI+FT7KESiBrja4rGJ57cRRRLLLotz3Q==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr16160099pjb.20.1564976609843;
        Sun, 04 Aug 2019 20:43:29 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:61e6:1197:7c18:827e? ([2605:e000:100e:83a1:61e6:1197:7c18:827e])
        by smtp.gmail.com with ESMTPSA id s7sm13690309pjn.28.2019.08.04.20.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 20:43:29 -0700 (PDT)
Subject: Re: [PATCH V2] blk-mq: balance mapping between present CPUs and
 queues
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bob Liu <bob.liu@oracle.com>
References: <20190725094146.18560-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3bf36c69-d6e0-2e5b-5d45-2e2af815a80c@kernel.dk>
Date:   Sun, 4 Aug 2019 20:43:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725094146.18560-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/25/19 2:41 AM, Ming Lei wrote:
> Spread queues among present CPUs first, then building mapping on other
> non-present CPUs.
> 
> So we can minimize count of dead queues which are mapped by un-present
> CPUs only. Then bad IO performance can be avoided by unbalanced mapping
> between present CPUs and queues.
> 
> The similar policy has been applied on Managed IRQ affinity.

LGTM, queued up for some testing.

-- 
Jens Axboe


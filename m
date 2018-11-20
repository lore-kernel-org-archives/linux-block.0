Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E8C41537
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 22:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486542147A
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 22:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486542147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeKUJ2Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:28:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46302 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeKUJ2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 04:28:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so2946555oif.13;
        Tue, 20 Nov 2018 14:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RasoWlIf0UoGzID0v1nZSIsMmbxXvftPBPZhA5dN5/M=;
        b=R0R7M5WO1benQ8OiMg4ZJw2SzvllnYifm7PU5OP+D7JRES0ZM4vksAbRe2I7FlivXN
         Xnifb2kpfAKmxQO0L20KnS+y+6TMXGtOpSXh/bFQONtv6VJOdexRjJR2ja9FJkMiW0Ks
         9O6peVSFVsAPukVubMfowImfhJ0F0th2zAaVia3gZVo8rOq+H6Fyl9/J/pJzFvuFFrxR
         oWiukUlpwTYqp0XineKDPUgzUIIgiJNdExHOCtnf/sZ85oFNJ0A0XOEbyGU3eH1R3gAO
         RGZLIG8K8pm/f3RBiKob1DAvTgu+S5y+O2Yz98gf7Jli7Tt3wNZeTUpft3sdO+itPCNx
         0AtA==
X-Gm-Message-State: AGRZ1gKePp7UGujRfmmX4wLB+73me5yUgmL38QmCVLVDF81PNEokUU7s
        gSkeHgtHKY/4TMccuAvcFis=
X-Google-Smtp-Source: AJdET5cbp3p/o6XiNnjf+LBx3HmwoV3IzgD1xpXWtttEY7RtnPDEXcAUdaA09x+Fll1OiF0c24cpAA==
X-Received: by 2002:aca:3904:: with SMTP id g4mr2290298oia.24.1542754600250;
        Tue, 20 Nov 2018 14:56:40 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o15sm14448402otb.3.2018.11.20.14.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 14:56:39 -0800 (PST)
Subject: Re: [PATCH nvme-cli v2 15/14] nvme: Add TCP transport
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-17-sagi@grimberg.me>
 <e04487c8-a4a8-bd4f-2ec7-8f67f0f1a49e@broadcom.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0a9d643a-2fc2-9e41-384a-78e693a98500@grimberg.me>
Date:   Tue, 20 Nov 2018 14:56:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e04487c8-a4a8-bd4f-2ec7-8f67f0f1a49e@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> @@ -703,11 +704,13 @@ retry:
>>          /* we can safely ignore the rest of the entries */
>>          break;
>>      case NVMF_TRTYPE_RDMA:
>> +    case NVMF_TRTYPE_TCP:
>>          switch (e->adrfam) {
>>          case NVMF_ADDR_FAMILY_IP4:
>>          case NVMF_ADDR_FAMILY_IP6:
>>              /* FALLTHRU */
>> -            len = sprintf(p, ",transport=rdma");
>> +            len = sprintf(p, ",transport=%s",
>> +                e->trtype == NVMF_TRTYPE_RDMA ? "rdma" : "tcp");
> 
> So why not just use the trtypes array above?

We can use that...

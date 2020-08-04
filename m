Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC3AC433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509C222B40
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 15:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgHDPhi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:37:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33411 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHDPhh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 11:37:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so22407224pgf.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 08:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W0s+Ay9vLHZkkpvq/j1ntxHczOmQRmqaRsOXDuy+8tc=;
        b=M10L4SCsk4fiIhOLIEOiNASCBC+gTlWkL/55XBHOWH7hi30khnX8uTeLu+9nmT6WUq
         LMtjC5HsV3fQQwrAkHT8DWN4NKA0sIBZSbGe46cnkXQyKjkFegX0EfDlcGDfDh25SZNq
         BJcKJJLCWdyxPO7ElEgRplEi/+A5UJi7+VHyowmtWuzrGgdT0SKK10Lk3ls0HvrK7wLf
         PWv7rpSY2h+kg6kaj0hF50EwPbVQ2t/ApucndQym/xJiR88l7qvmbPYoBTp7IUv0sYOX
         uf8c8hawZ5SPBqxX7p3GZonErRkT+nmz1kg3v6hdqRtUNpeElhOwe/PZQHdPYbNkWMQd
         NUwA==
X-Gm-Message-State: AOAM530BMIkhLjqQt6JgcJED8rQoNEwfza/bhvdcRnvglmPXWtSUsORB
        WM//gO89DC9jrYwpZJSOxfQ=
X-Google-Smtp-Source: ABdhPJwruxxH9JIfDK0ehFFeis8nSyJA6seDm5YVGJSglncBQbB2igvKj0C9HILue7w7gbIkoJYjrQ==
X-Received: by 2002:a62:2e45:: with SMTP id u66mr21677027pfu.121.1596555456497;
        Tue, 04 Aug 2020 08:37:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:812c:bdc4:c26c:df75? ([2601:647:4802:9070:812c:bdc4:c26c:df75])
        by smtp.gmail.com with ESMTPSA id h23sm23556249pfo.166.2020.08.04.08.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 08:37:35 -0700 (PDT)
Subject: Re: [PATCH rfc 0/6] blktests: Add support to run nvme tests with
 tcp/rdma transports
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <BYAPR04MB4965B184B6FC82243F78A569864D0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <291dd03e-1b1a-b965-775b-753ebe469d77@grimberg.me>
Date:   Tue, 4 Aug 2020 08:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965B184B6FC82243F78A569864D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> We have a collection of nvme tests, but all run with nvme-loop. This
>> is the easiest to run on a standalone machine. However its very much possible
>> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
>> tests with a new environment variable to set the transport type $nvme_trtype.
>>
>> $ nvme_trtype=[loop|tcp|rdma] ./check test/nvme
>>
>> This buys us some nice coverage on some more transport types. We also add
>> some transport type specific helpers to mark tests that are relevant only
>> for a single transport.
> 
> Thanks for having this done, overall approach looks good to me.
> 
> We can get rid of the rfc title and start the reviews.

Next send will not have RFC, but review can start with this set.

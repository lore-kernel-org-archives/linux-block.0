Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A99C43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 22:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF0122207
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 22:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgIKWGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 18:06:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37565 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgIKWGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 18:06:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id u9so1516465plk.4
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 15:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdmMNyAonF4gHCAUD7aZDErsUQgpThiEFy+6SYFOg5E=;
        b=nG+nj8ExaqLzZOpcrgCspLFXkiTDbSWRpJaVp3Aa5jjezRsboJMpSVpn+meFp5lcVC
         biEMfZAlUG85ojgoYR51tYO7IZR0ivp5IPv3cZ0CRxrGXYwwY0kCPZs4vlD/rpyh0Ik+
         mOhebCFLap2GbsiGXSrlyCzeo3EDxfq9v2PbGTZhqgjAcr1+bHzjSKSkSffvKYdOnDWi
         DYFdsniOfdg+7pPdq+ujoVBE6C7aPBxzJao1ck/UuwObYUWhQ/6/Djwc9NiMmRTIj/QL
         oOqwxdoVIo6kRYiZCcMELRmBB3E2xM4Nn3fdHBLd3KfrMbK5Bh1p8ZMbtttol4GbvriH
         8oCA==
X-Gm-Message-State: AOAM530uMGLF4kRp/bgNo2Q3SHxGCxKFeHq0hymjv35D+1OUQGWcuopw
        bS+kAMGtBrTjcFT79h1desk=
X-Google-Smtp-Source: ABdhPJyzSPnwtMRA8FWO9K4YZUe5KuRc/fFUvcvbDDEORy47OfSx8jhsoj/N8hm3EzmB7VLUhelv5w==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr4009400plr.125.1599862006859;
        Fri, 11 Sep 2020 15:06:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4428:73d8:a159:7fcc? ([2601:647:4802:9070:4428:73d8:a159:7fcc])
        by smtp.gmail.com with ESMTPSA id gb17sm2748890pjb.15.2020.09.11.15.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:06:46 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200903235337.527880-1-sagi@grimberg.me>
Message-ID: <7af726d8-b469-d36c-7be7-252b3bbace54@grimberg.me>
Date:   Fri, 11 Sep 2020 15:06:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
> 
> $ nvme_trtype=[loop|tcp|rdma] ./check nvme
> 
> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.
> 
> Changes from v6:
> - fix _nvme_discover wrong use of subsysnqn that is never passed
> - move shellcheck fixes to the correct patches (not fix in subsequent patches)
> Changes from v5:
> - fix shellcheck errors
> Changes from v4:
> - removed extra paranthesis
> - load either rdma_rxe or siw for rdma transport tests
> Changes from v3:
> - remove unload_module from tests/srp/rc
> - fixed test run cmd
> Changes from v2:
> - changed patch 6 to move unload_module to common/rc
> - changed helper to be named _require_nvme_trtype_is_fabrics
> Changes from v1:
> - added patch to remove use of module_unload
> - move trtype agnostic logig helpers in patch #3

Omar, anything left on your end to take this?

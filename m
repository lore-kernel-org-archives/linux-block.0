Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25599C3A59B
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C551C2342E
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sRYVSUQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfH3UYS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:24:18 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40942 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3UYR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 16:24:17 -0400
Received: by mail-pg1-f171.google.com with SMTP id w10so4079186pgj.7
        for <linux-block@vger.kernel.org>; Fri, 30 Aug 2019 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=in9aWTB7prkon6YbFcL4nw4lBCBNNJ1R4OpyxT059Tg=;
        b=sRYVSUQNEyVt8SsHijofFXAWcmVjc6Z0PUueL4EwXqcVgDUpRuRKcYAR8360pWemoa
         ecZDXnkevFnxO38QXV5hd1sJmL4bG7G6FHyaCjuaSmGuILo1+agWnD8HCwlxNfuPDCWq
         wBt1yFDJtZxDSGgkXsy3bxRSW2SNLraiIZu2m2KcSAFFZ/pUuDp36SeIAcf9dgnf2oUh
         8Ki524trPKcQD8fBXyhrWKZnFgrxBZq2aCntCcBE7USmwQT9MNHMqoBrjxaqQhzPlflA
         68mms7BTV+L8fV+ttMlJW+EI8oRT8KR+60BdJJdySTeAr2DbqKFc8crxi/aq8+t3I0Nd
         dBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=in9aWTB7prkon6YbFcL4nw4lBCBNNJ1R4OpyxT059Tg=;
        b=e9yIrWAR5kFPsuFFHsc4sCeo7Df0LpmFjdMBuTFjAcuexRpnGjE8or5MxxK+WIaXuw
         aOGMEb5FLAXoOZ3/AJCLH+mbn8nkYmGAWGkh/Hzf9saa3D1VCXTBzo4f16kxTCno2GL3
         Ca59s6F96Z6PT8eu7knr5tECtHJmR60Wy5DiFUQwv/mQe5c6InO/CT6W6cYYRV53Jg0z
         d7oRHo1QCVDxDrFzTsGLYTtQw5JBKshYcRgWYkroTyHpstcdxQ+2mD7/HVuCmP66CHcg
         jsOZ6XdrzLVq+oWENnI6U9uWnBDM8Br8PPBwa7tslXdtTn5+MxjAAYo7Eu41fRgdNUqR
         /sUg==
X-Gm-Message-State: APjAAAUXhqnu5Ofbmpi9JxkcW3liX+5Rjc4JH9YckACWBHdpHbB/LrTH
        VE86VGJEthwTtKAgB6C8DIpbvw==
X-Google-Smtp-Source: APXvYqzciNSXJWmRwZzrAE3OgHHgoI6Orlwn1U1aHca9OArrgV/hn7ggrcOwravrIcEp0CIJ0zP6HA==
X-Received: by 2002:a62:3644:: with SMTP id d65mr20455732pfa.128.1567196657028;
        Fri, 30 Aug 2019 13:24:17 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id a16sm9158334pfo.33.2019.08.30.13.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 13:24:16 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.4
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190830190124.11961-1-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53701429-a0f9-ed67-4cde-d402da2814ba@kernel.dk>
Date:   Fri, 30 Aug 2019 14:24:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830190124.11961-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/19 1:01 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> First pull request for 5.4. Note that we do have some more patchsets
> in the pipe, but we'll have them settle first in the nvme tree.
> 
> Also, note that there will be a merge conflict with 5.3-rc fixes on
> the nvme quirk enumeration from the Apple work-around patches from Ben
> and the LiteON quirk cb32de1b7e25 ("nvme: Add quirk for LiteON CL1 devices
> running FW 22301111"). The fix pretty trivial, as the quirks enums simply
> need to increment.
> 
> I have the fixed series in a branch:
> 
>    git://git.infradead.org/nvme.git nvme-resolve-5.4-conflict
> 
> The nvme updates include:
> - ana log parse fix from Anton
> - nvme quirks support for Apple devices from Ben
> - fix missing bio completion tracing for multipath stack devices from Hannes and
>    Mikhail
> - IP TOS settings for nvme rdma and tcp transports from Israel
> - rq_dma_dir cleanups from Israel
> - tracing for Get LBA Status command from Minwoo
> - Some nvme-tcp cleanups from Minwoo, Potnuri and Myself
> - Some consolidation between the fabrics transports for handling the CAP
>    register
> - reset race with ns scanning fix for fabrics (move fabrics commands to
>    a dedicated request queue with a different lifetime from the admin
>    request queue).

Pulled, thanks Sagi.

-- 
Jens Axboe


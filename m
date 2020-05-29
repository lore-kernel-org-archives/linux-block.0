Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BEFC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 16:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5024207F9
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 16:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ifAhSGQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgE2QW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 12:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgE2QW0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 12:22:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38BC03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 09:22:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x18so1335828pll.6
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nzu2wkl8+oSfKrgNVFOxPyYjIUC7u3RtTW7DS1t/Sd0=;
        b=ifAhSGQct0IadeveV6vqjVrkQgaAs7HHuv/EHvRRUIZz8CHX/xPOvdga2YBAMWr5Ee
         WKIhM6iBKPr+/VYJ22FO0UI1sfU+O0rQzzIq3jjK4NgaYrXIFUrZ1yj6poVHHaXSK5In
         ZgjhVSYlGh1Fd6zAYfJXzHsFqQLZWmHCcUEjdOjnlPfTUKlEwgiBooi0CgIF2cKAh2zA
         56txihviS+3i4RIksUrBXGXxEDAN7nhr0jM+XoPz4qYTmUmgDuIQVw/74XWt5mcHkO2+
         7lx+nVhBVp7c8mDMn7HUlKOmwebuxfZzuKl+ainVhFH7voVPFrWp752smr3LqMnVuKg9
         0Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nzu2wkl8+oSfKrgNVFOxPyYjIUC7u3RtTW7DS1t/Sd0=;
        b=lhU4HgIAuehhA75BI5e1mjtVbLLP3WIFmY1L73yK/hw14Svr4h1+EmzHXHv+qyaZ97
         q7ojNarn5L5JeI9t03jKzUrbVsYVTarYp9zP+3NCbPV1MbeRmA86HMUQUG3GOGsvfUyZ
         dp5gNVI7TsfD0MNYHTo3tfs0tIObriYxzPv+HBNR9J2pGAAP8ohxybq94Va2WK0Wzc/w
         jEa+zfXoOwjE2ZJqSJCSvFB+7MmwEzS16x1sPFCyvu7pLNbbRFSnciRpBynt0Aap+dXm
         uOk7qZnoX2q0yNjxRIOHIa387HCKZUBfoXttk3BQO5g01rDDhUd/3EpM69SllUlqDU7H
         nGhA==
X-Gm-Message-State: AOAM531UbfUXnbdg4gCcdm8xiswVNE97IOgrKEUx1d76tzAxYFUBTWFt
        Khr7Holnh4ul5gQ94mO5dJbmtA==
X-Google-Smtp-Source: ABdhPJzpJksd9gHWFeqDPKwm5t5oRCWO73ePHFntKbFUddQeeybr4Yt2h4/Q6bXbuKOrzgZ3+G9aaQ==
X-Received: by 2002:a17:902:ab87:: with SMTP id f7mr9981615plr.166.1590769346013;
        Fri, 29 May 2020 09:22:26 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y18sm7694402pfr.100.2020.05.29.09.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 09:22:25 -0700 (PDT)
Subject: Re: [PATCHv4 1/2] blk-mq: blk-mq: provide forced completion method
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com
References: <20200529145200.3545747-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <634cf954-337d-1804-a0d8-5a2745d3e48d@kernel.dk>
Date:   Fri, 29 May 2020 10:22:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529145200.3545747-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/29/20 8:51 AM, Keith Busch wrote:
> Drivers may need to bypass error injection for error recovery. Rename
> __blk_mq_complete_request() to blk_mq_force_complete_rq() and export
> that function so drivers may skip potential fake timeouts after they've
> reclaimed lost requests.

Applied 1-2, thanks Keith.

-- 
Jens Axboe


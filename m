Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA6C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A217621924
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1AWWo1+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgJHOww (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgJHOww (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 10:52:52 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B837C061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 07:52:52 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y20so2277317iod.5
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DniGGjTKE4v2KQx2b92S7YMddx7cu5sQYwDlNrFyG4o=;
        b=1AWWo1+go7rxZ4n8NsVCzA6SEFlGnEZTWyXEBQhU4RK0xNMikPk5r8kcnVVbDvJtks
         IWmA02/m8U2UXTAroCmj+0KVn/QO1+Jhg1wZrbBzXg4IA/6UkLM/SLJFri37Vy+C9ZDh
         Gt/WpeKnWM0xPFOweoYuu+rMzIR1MgQkJeSVS++bb7gk8NeD05DXtyiZ06V0kqVtRNIF
         A6hnGFw7Ml7dJVasnz2/orVScm55d5dvHQWhtkokYMtinIHS1JQ6zQRqzEf8kcq8C9FD
         +asSqXCVyGz1sdc05LHA675wXHbPe7wrb6pz+g4flYjTW/HSSa8dp9WwpotZ8KK7RsVD
         BdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DniGGjTKE4v2KQx2b92S7YMddx7cu5sQYwDlNrFyG4o=;
        b=oHBYDhrEhGZ/yl18+4yfbXCb/dNdtkvUhhAJIwQR9qT7Qk92tf99etUanXwH6YRQ5/
         g4zwmEZhLxplYnms1gyU1Ls2ezP8x+gG9Rxa9DgETT3jWXqFlInxg7FO7FmdTtd6toX0
         oGQZNo5WnZfamney7jKgaoI2yaBNi69nr4cctmHCanqvANh0hamd/8LUbyF2RgwFnONO
         AGWEDiNn88PCxlUOSObvg0/dX4Zt1NC0HuRJ629s+5WkqdSYC4gVw+7zS4cYezj9NCjl
         iMtjbCJgMounbMcxbU3wZL9O5mK7ebyVTmqLMOd6TAbOqZMYoBSYKAOJGxw+MwnXvIEN
         4v5Q==
X-Gm-Message-State: AOAM533XOntVcoSZ10I7HrUo7Pj1gkMDOIRMe14qCt/NyNTTmbk+BkG0
        MI0zhn4TKM1WH+AqGwQ3J9RLfg==
X-Google-Smtp-Source: ABdhPJyAbg+e/or0gRB1zBJCj8noz5IOQmp6vRENMPQcGCtwR1vOzQpBDto/cvzgAPl96caPaCUtGg==
X-Received: by 2002:a05:6602:2d0c:: with SMTP id c12mr6178658iow.117.1602168771512;
        Thu, 08 Oct 2020 07:52:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u8sm2824968ilc.59.2020.10.08.07.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:52:50 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201008141041.GA1493538@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b4ad1d6-3d77-d14e-2275-0f9326b19514@kernel.dk>
Date:   Thu, 8 Oct 2020 08:52:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008141041.GA1493538@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/20 8:10 AM, Christoph Hellwig wrote:
> The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:
> 
>   scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08
> 
> for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:
> 
>   nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)
> 
> ----------------------------------------------------------------
> nvme update for 5.8:
> 
>  - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
>  - misc cleanups (Chaitanya Kulkarni)
>  - major refactoring of the scanning code (me)

Seems to be a typo here, 5.8?

-- 
Jens Axboe


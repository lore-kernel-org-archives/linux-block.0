Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B996EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 21:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjF0VPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0VPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 17:15:05 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF4198C
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 14:15:04 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso6228225e9.0
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 14:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687900502; x=1690492502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNwoN6tn+8b6nA7Abv59m414LP72VnULcLulcM/icT0=;
        b=kT/NsIZk9IINok8E7Og1z5NF1UXxryBapq91GEvo0Ey8SrGNafDqZE3NcNkinY0A+d
         PBBuUao9jqZ6NtqOm2hzkgIYa7Mhg2MjAbKS4yKAr5WL2AXbPoIVimDky6SNhnly5Y3Q
         lcxhn+2hOSdDqi/q1uL6ZbMJqxAXpVXZ63JU7CA7XhkFdeDkgfnCN7GUSvkY/MsQwfi4
         njFacwMWutqGPM0tISO3Tg5N+Ynm6RVkQuftabDrRqNXz27Ag0VQA5sOlrT8PARoQUTA
         kPogaKu+Nv/+5w39R39n8IfLxIz0ot72xj5JcI2q30fwQNjxhThLt9uHJ4oWDJ5HyVI7
         9eAQ==
X-Gm-Message-State: AC+VfDwfcm5cw4+YVQtp5rmwXoXR7VbcFiDQPx47WW0pwQ19bs9ZCdzt
        pXfIc9wXbSJE1z1yOeGKAfY=
X-Google-Smtp-Source: ACHHUZ4v0IKM/GxXvMonb/Y0KNzYmnZKryQw4zS35hXeH/ftVfu/X6j19b0PzfnJ2SixbEXYMFeNtw==
X-Received: by 2002:adf:df0b:0:b0:311:15c0:44ad with SMTP id y11-20020adfdf0b000000b0031115c044admr13904107wrl.6.1687900502318;
        Tue, 27 Jun 2023 14:15:02 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id u8-20020adfdd48000000b0030ae6432504sm11358030wrm.38.2023.06.27.14.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:15:01 -0700 (PDT)
Message-ID: <abcb7d9b-cc81-9215-cc74-73f682227bfb@grimberg.me>
Date:   Wed, 28 Jun 2023 00:15:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
References: <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Yeah, but you can't remove the gap at all with start_freeze, that said
>> the current code has to live with the situation of new mapping change
>> and old request with old mapping.
>>
>> Actually I considered to handle this kind of situation before, one approach
>> is to reuse the bio steal logic taken in nvme mpath:
>>
>> 1) for FS IO, re-submit bios, meantime free request
>>
>> 2) for PT request, simply fail it
>>
>> It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
>> always set for PT request, but not see any better approach for handling
>> PT request.
> 
> I think that's acceptable for PT requests, or any request that doesn't
> have a bio. I tried something similiar a while back that was almost
> working, but I neither never posted it, or it's in that window when
> infradead lost all the emails. :(
> 
> Anyway, for the pci controller, I think I see the problem you're fixing.
> When reset_work fails, we used to do the mark dead + unquieces via
> "nvme_kill_queues()", which doesn't exist anymore, but I think your
> scenario worked back then. Currently a failed nvme_reset_work simply
> marks them dead without the unquiesce. Would it be enough to just bring
> that unqueisce behavior back?
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b027e5e3f4acb..8eaa954aa6ed4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2778,6 +2778,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>   	nvme_dev_disable(dev, true);
>   	nvme_mark_namespaces_dead(&dev->ctrl);
> +	nvme_unquiesce_io_queues(&dev->ctrl);
>   	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>   }
>   
> --

I think this should work.

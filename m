Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC8AC77B73
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 08:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjEAIpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjEAIoz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 04:44:55 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E543D1728
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 01:44:33 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f18176ea3aso3280235e9.0
        for <linux-block@vger.kernel.org>; Mon, 01 May 2023 01:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682930672; x=1685522672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uN44ThAsReaJEu+mEPgThZfAT6oBVuEr6BhHBNOIrts=;
        b=cBoP7DAianpw3QisR9XMNiA3UsfKX68wHZhn8qRN4yN9/U7rLW9Eptma3RHvsrRCG7
         3mWJywQKbavvvOvt8lY8gZ9JRJB3oAU8oTfplpk8/UV9BilsfU+uaz6QVkvXosmV5NSC
         x82E+eaVnfaTbfSwpEnIzyVim7a3Rw7PNR5RmwwRI9yNYyvghaQeheAUZ1B3rXvZ3n/2
         +WkkeTqDY6n1reyDKk/3YHeCxqL3znfgxp34ruWuFlFhLPuPNORLZhq5GoxGbBUmW3tW
         IiFdwhPojy19Wr0PRVuJwwmsOIhQ279vn4qTTcHzrxgl4RAodmpyTPzqXjsmH2T/fFTs
         urbg==
X-Gm-Message-State: AC+VfDyOF4DqunUb/H+O1E8/1QJjq0G/6ftYC1VL6pAKdBTKQNGTOM2D
        jJHIMZkJdRetNsjPlayuiMU=
X-Google-Smtp-Source: ACHHUZ62M47GMYHvqloK+V4Z1y7qx8RrKV7E1EW8YnSr4aJMAJZCoW/8x02aI7rkcNrgylBqR3MLhg==
X-Received: by 2002:a05:600c:1d02:b0:3f0:a845:f215 with SMTP id l2-20020a05600c1d0200b003f0a845f215mr9870756wms.3.1682930671736;
        Mon, 01 May 2023 01:44:31 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c215300b003ee20b4b2dasm31961366wml.46.2023.05.01.01.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 01:44:31 -0700 (PDT)
Message-ID: <4f1c6b01-7abe-0599-8249-e3c77072ad61@grimberg.me>
Date:   Mon, 1 May 2023 11:44:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
 <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me>
 <CAHj4cs99us_r4Ebth5oAJMqHHA9aXZCpq0A3uu1BEdNw2GeRww@mail.gmail.com>
 <f74df8a4-03c6-6687-7ada-35aa268f44b9@nvidia.com>
 <763959d1-8876-31f0-25ee-57ddb2049c75@nvidia.com>
 <CAHj4cs_urWYi_yPQ-FoFo2kV4h1gz-mwxfRiOTj7co3=bUnO5w@mail.gmail.com>
 <CAHj4cs-MtUM=7w=YG2ohATeA1HSZp_5CT1Y9DATDEqPPMZ8MMw@mail.gmail.com>
 <e5717ee0-e2af-9266-4bfc-e792d53f4403@nvidia.com>
 <CAHj4cs8DPVKPs8o+tN7cdZrvZKVRAjG5-cEZspL1N0JG-a4Oag@mail.gmail.com>
 <19c61e06-0d06-c209-d6b7-adac52df27fc@nvidia.com>
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <19c61e06-0d06-c209-d6b7-adac52df27fc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/1/23 11:23, Chaitanya Kulkarni wrote:
> On 4/27/23 08:57, Yi Zhang wrote:
>> On Thu, Apr 27, 2023 at 6:58 PM Chaitanya Kulkarni
>> <chaitanyak@nvidia.com> wrote:
>>> On 4/27/23 00:39, Yi Zhang wrote:
>>>> oops, the kmemleak still exists:
>>> hmmm, problem is I'm not able to reproduce
>>> nvme_ctrl_dhchap_secret_store(), I could only get
>>> cdev ad dev_pm_ops_xxxx. Let's see if following fixes
>>> nvme_ctrl_dhchap_secret_store() case ? as I've added one
>>> missing kfree() from earlier fix ..
>> Hi Chaitanya
>>
>> The kmemleak in nvme_ctrl_dhchap_secret_store was fixed with the
>> change, feel free to add:
>>
>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>>
>>
> 
> I was able to fix remaining memleaks from for blktests
> nvme/044-nvme/045 with nvme-loop and nvme-tcp transport. I've tested
> following patch with blktests and memleak on, also specifically tested
> two testcases in question, whenever you have time see if this fixes all
> issues, below are the logs from my testing, here is the patch :-
> 
> linux-block (for-next) # git diff
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 42e90d00fc40..245a832f4df5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5151,6 +5151,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct
> device *dev,
> 
>           BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
>                           PAGE_SIZE);
> +       ret = nvme_auth_init_ctrl(ctrl);
> +       if (ret)
> +               return ret;
> +
>           ctrl->discard_page = alloc_page(GFP_KERNEL);
>           if (!ctrl->discard_page) {
>                   ret = -ENOMEM;
> @@ -5195,13 +5199,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct
> device *dev,
> 
>           nvme_fault_inject_init(&ctrl->fault_inject,
> dev_name(ctrl->device));
>           nvme_mpath_init_ctrl(ctrl);
> -       ret = nvme_auth_init_ctrl(ctrl);
> -       if (ret)
> -               goto out_free_cdev;

This does not seem to me like a fix, but a particular way to hide the
issue.

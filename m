Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26924C04A95
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJYOYO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiJYOX7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:23:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E0102511
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:23:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j12so11092521plj.5
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHFM7hSxk92IObPZe5vjZohRKRqPul0RJaS7riWUCk0=;
        b=VIxooYOaxwZ61wqPop57waVSoQw62K9KchO4Wp0x3c75zgNLBtlXYzctK143sQY6B9
         E0YCOoJUKy7pqGPDwJM86cc+VBMW+Of8qeUP7WqgStP83C08GuURb/GRfAIxAZcnWUL4
         gnfHuEJ54AthJm+J/BnSaUpIFvukzEcSupHoI/t2p1ZJzZBISD+GnIrX6NZoB1a6feOq
         WoXUJE9AdrVtQAx3ubTOL0DX1fwocYxcKOe2+UFBj01q4iXIPT0LiQFnBujKgAm8y0hY
         4oPkaPV7vmscjbdlV2ge0Uwynwv5GwTYVKB+9nQ+rtLhJouETTVQCqzH5l2G6tnRPBJG
         NqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHFM7hSxk92IObPZe5vjZohRKRqPul0RJaS7riWUCk0=;
        b=i/1031fS57HtWZ57Bs3HmvOFe2CS+K9nqC85x2ioCsW4Vk/8QHgMMGuCCGAjjm3CN4
         uZvIqprm9M21/UEq/8fN6Mx4mDRHUpGjHMTqzT6icHyWQ7j3rX3GTSCztrnR8njWVWMn
         NcUA/e81OQ/F6I6c1ndyUE2RX7T/HaYzX43maVIGl/T64jf/Ys5aDPNeymKbEB+JigBT
         n4IQxymLxO77/WKuJmlcO4drSvPuhd90gypi8Sv/T4hGTM9oryWqTQhHQ+sKuWlTgrQm
         N+rSbrvrxuZy8cRMLCXSKe4zWZYWlrSoDztf56ESiNJpzUy87A4ZoObAJVtJc6b/OlkB
         rraw==
X-Gm-Message-State: ACrzQf0OEe+8jUUaQVyukjsB+iJtad3Ri3c7euWzQvUSdteiYmcOd+4g
        RsSlsBcbm2vDPwR21mq919A6Mg==
X-Google-Smtp-Source: AMsMyM741H7P8iGhv9Qw7LG3fWhtLsvG2uiB/1mucg/H0TheENBKEWlKAS7sZ5WnLe0/9edqqKWe1A==
X-Received: by 2002:a17:90a:590a:b0:20a:e93e:2022 with SMTP id k10-20020a17090a590a00b0020ae93e2022mr44004197pji.141.1666707837740;
        Tue, 25 Oct 2022 07:23:57 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b00186cf82717fsm330817plf.165.2022.10.25.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:23:57 -0700 (PDT)
Message-ID: <2baca1bc-cee0-9a52-3fcd-bdb812e5f512@kernel.dk>
Date:   Tue, 25 Oct 2022 08:23:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/4] blk-mq: move the call to blk_put_queue out of
 blk_mq_destroy_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221018135720.670094-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c19..07381673170b9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4847,6 +4847,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  
>  out_cleanup_admin_q:
>  	blk_mq_destroy_queue(ctrl->fabrics_q);
> +	blk_put_queue(ctrl->fabrics_q);
>  out_free_tagset:
>  	blk_mq_free_tag_set(ctrl->admin_tagset);
>  	return ret;
This is wrong and doesn't apply because it got fixed upstream:

commit 4739824e2d7878dcea88397a6758e31e3c5c124e
Author: Dan Carpenter <error27@gmail.com>
Date:   Sat Oct 15 11:25:56 2022 +0300

    nvme: fix error pointer dereference in error handling

Can you respin this series so we can get it applied?

-- 
Jens Axboe


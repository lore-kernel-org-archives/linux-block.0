Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A72C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 05:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiDMF4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiDMF4D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 01:56:03 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3064506FB
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 22:53:42 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id bd13so380214pfb.7
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 22:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7hPk+CDiUhT3JD/4KlOy9PmYny5BxqkX8wQhMDLl178=;
        b=6TsoEV8b5E17+oXOeOFV6l2hHIoRhQjSxH/oRlTzveeB7gNwRUp0N/6m4RanYCm7kX
         zuV2xA2IJNeyA9cuvqTrK+kwE1O6Yq//76fveEMajD9BSY5uO4aIpJiDxn4Y+d3/WqpD
         UfDrTdnny1yPdGY3VWLjxxVkZlKDiFBeDP7GA9qAHBrz5xReO8af1hrWNeSNaTo9lOAx
         JXslOqmjlBKMubPjM9m0fC2Vbh2BPwVdJ5NHY/VTczq2nqpuawAn5N4XOi29wFlNcpaZ
         reiuRMA8yCgxofdjIwB8Q0bh1KyyuCwmfIyq7fgs2+aJpxtIQL5CEezSou+wxw2LSh+t
         UmJg==
X-Gm-Message-State: AOAM531kcgL+PNo4Z/CiTvwuf+9FIRNvU8mEzSDDBZbWBFmnqPWAvvyS
        ultKtroA+iMA+z9NyFjnweFgDwYBDgE=
X-Google-Smtp-Source: ABdhPJwRT23HPoexC5yYGQPBB/VJ963HigzBKo7vq4W80KNN5BrXnKQs3HXqgXZSgsedU8Razo9WHA==
X-Received: by 2002:a05:6a00:17a4:b0:505:b651:5b98 with SMTP id s36-20020a056a0017a400b00505b6515b98mr15684803pfg.25.1649829221945;
        Tue, 12 Apr 2022 22:53:41 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id o32-20020a635d60000000b0039cd48c7f6asm4666994pgm.32.2022.04.12.22.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 22:53:41 -0700 (PDT)
Message-ID: <6cd7ebd1-f069-7f95-62f5-e8b18d6b3e58@acm.org>
Date:   Tue, 12 Apr 2022 22:53:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, yi.zhang@redhat.com,
        sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/22 17:24, Luis Chamberlain wrote:
> I do have CONFIG_NVME_MULTIPATH=y but I also have:
> 
> cat /etc/modprobe.d/nvme.conf
> options nvme_core multipath=N
> 
> And yet I always end up booting with:
> 
> cat /sys/module/nvme_core/parameters/multipath
> Y

Is the nvme_core module loaded from the initial ramdisk or from 
/lib/modules? In the former case, does the initial ramdisk perhaps have 
to be regenerated?

Thanks,

Bart.

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FFCC433EF
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 19:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiDHTMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiDHTMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 15:12:23 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9BAFA238
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 12:10:15 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r11so7131781ila.1
        for <linux-block@vger.kernel.org>; Fri, 08 Apr 2022 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uaceRjBB2mDTyHzrgasDxaH0Scftp6QF398Ljtd1+os=;
        b=s1MqjSL/CHfTdm31fAKGu57ADqPRJl+amfCgBH7Ug7pvLE5BUNP6bJxV+JLuIU+A/D
         Obhb85OpQr1/oK/tKt0m7X+fdEIS+659SBs+aLa9wa80aebBdjvGaq6Y95dEzaZq0co+
         GsilxsbjDp8i6cPlvMcHtMpdoMSR1cJ6m1dalinxWPJH+NnWKs/hGMyynI0luGSLcWKZ
         AByQkS1VlThw2+MtLwM/PWk/nbfZn/ZdFtbxPtcgWrHIPTyQ5FYNWWw+sbM7pUlg+1mO
         NDM+Heq+qsLNNuiaqpkYR28zWIPkBPs3CWLhgaZ73LLu4766+u83eVRkWU5CCHOcs7Yd
         0dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uaceRjBB2mDTyHzrgasDxaH0Scftp6QF398Ljtd1+os=;
        b=xiJ5QZEOcCnPu0BjVUitpY0eqrux97Y+VO/fblnYzGwfbSHnie9Q8lKJVJ74cPbuUN
         ngS3kiU+/7+dYC30cdD7JNoTE1zSrxw9dPI5kIJE+23M9KCfF70Qu6ZkNEjRjBvNOSEa
         UlHHdAQhr1X5/C3xSkdxTSploIi79kf3E5srUB0hCKgCMc3smCyYAYXRKOKYibClp4xm
         KES2FqggqpPZwHtObxuz+Lw7woMFLTCIsrOWVzAo4/1gbeQKylZ/aCUovhpjsARRRdkl
         9QcscLKiHMzxHCTyTy2LCJBYDVMaofd+6112L82wsfgoHnhQs3XS7vmLaa0ibc6MUTGx
         L0fA==
X-Gm-Message-State: AOAM531jsLJp578ypulXi3oVP4az4akcxlASdM9OexSYfgzN4UD5suaQ
        cMHiMEHpruVhpht7Xf5RI/RJESQx8fecHQ==
X-Google-Smtp-Source: ABdhPJxtcYltX1BnEPzh0LFo0to385E6nrfK7qi+Y+TAJR6n34lh/R0BX7OkkS0En6Ghcbwvmqedyw==
X-Received: by 2002:a05:6e02:1b83:b0:2c8:c95:a4b3 with SMTP id h3-20020a056e021b8300b002c80c95a4b3mr9256011ili.293.1649445015192;
        Fri, 08 Apr 2022 12:10:15 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o3-20020a0566022e0300b0064ca88c0893sm16478414iow.10.2022.04.08.12.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 12:10:14 -0700 (PDT)
Message-ID: <d50a0ee1-c7e2-1b99-8d3f-ce2edeea92cd@kernel.dk>
Date:   Fri, 8 Apr 2022 13:10:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220408073916.1428590-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For this one, and other patches you send, they send up in spam because
the sender can't be verified. I would encourage you to figure out what
is going wrong here, because a lot of your patches end up getting
dropped or missed because of it.

-- 
Jens Axboe


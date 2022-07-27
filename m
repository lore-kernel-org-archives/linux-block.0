Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20AC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiG0QHy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiG0QHx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:07:53 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819F24AD7A
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:07:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id x64so13912414iof.1
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2is113T+H7tuYz2Yy/ETQXQPmWiDz7jbUDdoPkmDrDE=;
        b=IP5Zt4I59DWqtfmyYmvGfhDRHifPoE0KeS4+b4rsrh7//j99Hrrc3aJs/EPoLRGCwq
         /+E4UxGqfdukNFrDZW5v+tsguyXFVmiES53YoWlegQwzLvtz6JT49YaIOqPjUNq27hEx
         lW13ZPuwID8te4GjYRH1LSSg7b2dtuDGwSBgcmuolhUl2cde9So8pXboWZauAQYkC64o
         bTnwoBxfTI2lSlgcSbw8Wj2DEL67FKkfxg+/ThJ/k5Onx46Yj9njXOgbRK2NAEkO4W2H
         UlMTQktgDCZG40CCrrclZDExby723fgyufwfjN8yjexClHrJiGFjl+mSsZboPpPjYJ1c
         Q4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2is113T+H7tuYz2Yy/ETQXQPmWiDz7jbUDdoPkmDrDE=;
        b=GFBRGOs+UdCm38e+dDkgMqngpU3om++CcM1btTGl72264RFkC405bM2BuLMMWlLcsu
         aJU+9au0DAlYVEnbslBv53ahdlkRxE8CTyUSg0e59KR3yte+rCjHiplTdrwFx8oJ5vTJ
         AMjWTqrI5jFV9Vo8IZMGboe0nccdozWADTTj/f8nzJ25RYNrSBJT2E/RD24iubmXpcUN
         pEPKWel2YLhRdBl3P5mlQO3F9Cmvjhp0RhZjCQdAabOjU1GPwDaIrhmILNkASECurcUB
         qK67pY6W2ajU1G0YQ606dOhjPg2M7+Z5vHv079wZTOuUsFic/Va4Wf4dcY5vvMzA4akq
         hAUg==
X-Gm-Message-State: AJIora/1VWUUbH3rCq+wvPxdxYGNSBEt43NPL85wZEPZGaaDPSBLNSdA
        NCQQ2DUnRD5kfneu74SHXw3xuw==
X-Google-Smtp-Source: AGRyM1vHgE+2KLoYwpkgiqSGyw9ioNrX4EcF9+jxtFksdN+dMltzuL5i95TrOnLIwHNNIxIiyxOYeA==
X-Received: by 2002:a05:6638:1a13:b0:33f:1f32:6248 with SMTP id cd19-20020a0566381a1300b0033f1f326248mr9086808jab.53.1658938071754;
        Wed, 27 Jul 2022 09:07:51 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v5-20020a056e0213c500b002dce9ddcb08sm96761ilj.30.2022.07.27.09.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:07:51 -0700 (PDT)
Message-ID: <d428e19d-6c78-1065-8687-c95e54d71816@kernel.dk>
Date:   Wed, 27 Jul 2022 10:07:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] second row of nvme updates for Linux 5.20
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YuFhR9OoPvM9VsdT@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YuFhR9OoPvM9VsdT@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/22 10:01 AM, Christoph Hellwig wrote:
> Against the for-5.20/drivers-post tree.
> 
> The following changes since commit 2dc9e74e37124f1b43ea60157e5990fd490c6e8f:
> 
>   remove the sx8 block driver (2022-07-25 17:25:18 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.20-2022-07-27

Pulled, thanks.

-- 
Jens Axboe


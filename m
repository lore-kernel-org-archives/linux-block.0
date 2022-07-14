Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCFAC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 16:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiGNQbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiGNQbF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 12:31:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ACC655BB
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 09:31:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v21so870828plo.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fChIS7SF6nm8gZuMqg7g5RM8auvMS4gNHlZoat1RXb8=;
        b=MXUAe2lacoSQtWc3n+mnrIopZwD4pVJER7BbVPAKYYOYjOQwFkuQ3Ed13z70prQac2
         MXJS43xgkYkGFPOGhZRUlhGS5u04P7DmvARkN8XY/88OMShxtVYRZa3IVRjDOl8dOjMy
         1qludyzTG2FCczX2S0sJWe70NSJ44iFzVJ08Ol1MsiYNEH20S8r7Kounwf82YB7tM7zw
         yLS0G+3kLv09txBU7WjGqZAdwyj2LAdIFzkeb2wuIcgFe4Lmi7DIShHzXW9qqDSVg4Q3
         rWqJwJkAOf3cFUVM9F/th/vUJRrA4y3nlpT8QPb2bXetHsYJjBfMF7siXd0M+1DXc0pe
         Paxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fChIS7SF6nm8gZuMqg7g5RM8auvMS4gNHlZoat1RXb8=;
        b=S/kmC0emZtbXIqUF1U4DWBPwrJWNNdGm0k+8a1vQrTNarnBg5sZ8rtOo3nlbaAk+qz
         mtN93AWlJxgXTW3VKDDRL9FtPi2zma1iIxrJqn3YAQRfvptqmGEI0E1x+pQWfFO/ML2x
         umuksgTG6xVqct3gY81EVAtn9plAfgQlHm2Jqy4XUJ9mZhKC0p/NgldAHA9T4b89NMyw
         C+zkJrNzmfKh/rfOz5cBvfWDgIBRSEQszZNlIMGuPdbiKn+GXVtGv2y/RvDPDKhLYR0Z
         /6kK+Y8iw4tza9BMM1yaQ6km+zRzkjFYfPtGp6OROjotNXKn9Rb331DKVaf9c0dvUsMy
         BzFg==
X-Gm-Message-State: AJIora9A2rhMqfJDJSyykiydzka2n8PllkQ7ZCNLIlvqMMJx4wsOXzII
        E0oyPj58SrnTHapH9aF3ZBT2sQ==
X-Google-Smtp-Source: AGRyM1tC/2ESlB+Nku6uVdiTIFXXf12AdH6j2c8BO8CJN5VVvj3eS4zOkkHebVaRVRXh+DPcwqwjDw==
X-Received: by 2002:a17:90b:3910:b0:1f0:386e:c0ee with SMTP id ob16-20020a17090b391000b001f0386ec0eemr10502114pjb.141.1657816264205;
        Thu, 14 Jul 2022 09:31:04 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b0016bf2dc1724sm1664645plb.247.2022.07.14.09.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:31:03 -0700 (PDT)
Message-ID: <aa3f3387-2550-4f46-2dda-01d6d776e7e1@kernel.dk>
Date:   Thu, 14 Jul 2022 10:31:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YtAqRsNAUZXA60+V@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtAqRsNAUZXA60+V@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/22 8:37 AM, Christoph Hellwig wrote:
> The following changes since commit 6b0de7d0f3285df849be2b3cc94fc3a0a31987bf:
> 
>   Merge tag 'nvme-5.19-2022-07-07' of git://git.infradead.org/nvme into block-5.19 (2022-07-07 17:38:19 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-14

Pulled, thanks.

-- 
Jens Axboe


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FFFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBAE6103D
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhJRUy4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRUyz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 16:54:55 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1903AC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:52:44 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 188so17822273iou.12
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Yb6fDrcaihf9xOvWSjq7rtKlyMEYMqkVYoeVqHGi14M=;
        b=Tw+OXhmDqKY5D4HCuOfvlJN+oMihczl+mT7qw9xHk0pDv3hj0y5Az9cX9nOD1y/OqS
         NPMMjNxM4cxdUtQtbCt/qRXT3i/A9SDl2oYTXxnJAXPzyJ1dCXLe2jU3qiSnmZMN46+O
         ld19a7f2AUN8ZEAflPzwWVVavEx6kVzutjdfIX79uBZ20/fnCLM4KHxiDRIfpTP/rZEa
         R9ZoKbxX5l97xTeurxNMiy+Bsv8O9hHZtW2v9jR6BgynCMYGRK4FFMcVr4Jii8A+9hre
         K87W1OOYljBtuEBpfHiu08jk7G0N3xJb1teZbmPQLYKFKBvvnoNa6Y3BWnI0y7B4ghip
         sIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yb6fDrcaihf9xOvWSjq7rtKlyMEYMqkVYoeVqHGi14M=;
        b=vcLmPfOWKim6ynoIkS1Veup7ZHDJ1CfNSMpACBHtREO28b8c24dH8K2AA7DMMqgk06
         qyZWmNZQr9vedsZ2Ei9YQSX35NG27szLWV0fID5IzJXHOHjujgAmNlMtBVdpUVcrMALB
         +QuXUTEcGzhaAbF9X0mYSPfNV44/SC6VkQY2JWHxe3JGywp/fX+OwKOSmZUY4YoRwc21
         GG5niQOAEkSllIE7yiZlYoegDb0er+dcPzQp98VBc7oTFjnKsA92ICgZCEelaS8BKsm2
         M35YPhQ5iaWGFezWgYDBwWFBle+hYSHMSWo55A6lNuWz19qc5jctLvZrDzwwvK6pGpVS
         zK1A==
X-Gm-Message-State: AOAM531vL1TG5vCgNxic+FaXJMglfnDSQlLFvXi7iGKI5Nlef0pRM5F1
        MJxQ00RcQtyRfQbWdswGfM6gazbBSlI=
X-Google-Smtp-Source: ABdhPJyGcx9S1uef3LTD+rpqPuU/K4bpSv1PT75oVviFS+sq8fZN4odtk24QXQE98R4bmQLcOZdOGA==
X-Received: by 2002:a02:7105:: with SMTP id n5mr1476301jac.64.1634590363389;
        Mon, 18 Oct 2021 13:52:43 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d12sm7389875ila.79.2021.10.18.13.52.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 13:52:43 -0700 (PDT)
Subject: Re: Block trees rebased
From:   Jens Axboe <axboe@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <795ab0ff-dd7d-d225-e42a-04878bd4d8d1@kernel.dk>
Message-ID: <8aa58b9a-ee53-0390-1608-7c5363fa4b05@kernel.dk>
Date:   Mon, 18 Oct 2021 14:52:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <795ab0ff-dd7d-d225-e42a-04878bd4d8d1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 6:31 AM, Jens Axboe wrote:
> Hi,
> 
> Just a heads-up that I've rebased the 5.16 block trees, mainly to avoid
> a bunch of conflicts with the bdi lifetime fixes that went into -rc6, but
> also to get rid of a silly post-merge branch that we ended up having.

This should now be completed.

-- 
Jens Axboe


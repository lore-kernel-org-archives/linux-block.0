Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631B7C88CB9
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 07:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbjFMH44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbjFMH4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 03:56:33 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650DE1BC1;
        Tue, 13 Jun 2023 00:56:21 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f7e7a5aaacso10943485e9.0;
        Tue, 13 Jun 2023 00:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642980; x=1689234980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=T3pvEJ+wMlYsC7R68v+mbxY0+bFRkGqvvPLOoXcs3ZdFkMUIEvskWkgPNsm0NR7u5l
         BEafSFHJ4LjB4BIv78LFBSBnVRRBqnhCzH+uRNwXU5xyQ8lbFQG44SLyWFzGdvoe2s1F
         6y4tpZJpKY12htiuNbpiFGJNK6SKqKYbgVkn5DMfqA3NaXVl94iPLbR71DMuGIWZ4k3U
         NEZhUUo35swmtJ6wS/k0JHb4y8T9p8JYHZvmPBsNQ/ScggKmo0T/vZ1Z8LSLmkFCAh8p
         ahnSeMH58Q+0ZJ3m/QCt++bmDVIZzZUyFGqGVK3NLYY3SedebD00/JUbKo0A+LZ3z7RI
         nd4g==
X-Gm-Message-State: AC+VfDyaYOFJw/NR4aHa90iYz7sLoS1o7+FRPCFVPFST8GaO1qACDBsc
        F2EJJYk6p6Z9EvUpMoBAeHg=
X-Google-Smtp-Source: ACHHUZ7O9dcmYzFJL3OuiYarf6djDzTzW8OdZYzqPwx3UJ2mF5Okj1XrEoMhVXJPVtA2/JXM4gYRdw==
X-Received: by 2002:a05:600c:444e:b0:3f6:a6b9:bc87 with SMTP id v14-20020a05600c444e00b003f6a6b9bc87mr9523858wmn.3.1686642979578;
        Tue, 13 Jun 2023 00:56:19 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l8-20020a1c7908000000b003f7f4dc6d14sm13400774wme.14.2023.06.13.00.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:56:19 -0700 (PDT)
Message-ID: <23f1e9ab-d705-7152-2486-ced4cd34275f@grimberg.me>
Date:   Tue, 13 Jun 2023 10:56:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv3 2/2] nvme: improved uring polling
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, axboe@kernel.dk
Cc:     joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20230612190343.2087040-1-kbusch@meta.com>
 <20230612190343.2087040-3-kbusch@meta.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230612190343.2087040-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E592C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D9B60FE8
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJUO3v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhJUO3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:29:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E900C061348
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:26:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u69so1077738oie.3
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pjo8/1xhCByFj24D2uvkYYxEalaUO4YdIsYjUlnOG5c=;
        b=kc93k3l5YlQAlCienhWOoj4hZWRUrvEm3nOCeb+3WKhWZVSB6iyqQxhlD1OUxi04gA
         oxDT1zRg5joGCvYdiUP+RK87aEkg3loDRq6S0W5tUiQSGm2Nb5mfP7DZb3bgXKco+qUq
         EojMr0zgrXdkrPT7bebZZ9xzGQSQkz8Q23QqVQ9ucU9tQYVdHsezjaOg2gL7xeFx60QS
         kfkSPjUIca3pAK3B8DNLSQSn8Fv/q5usjb6JjTuqElhagtTFdOERabJ/BhsKjdCznHfV
         01fSzbkPVKykRSEDDktYHYOTrZiqXLlj/Cz4NRiRLgQq/ZNH0bs7PilLoupw6FeiAspz
         3+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pjo8/1xhCByFj24D2uvkYYxEalaUO4YdIsYjUlnOG5c=;
        b=2V3AXIlMNROjEBSlpvLzU6eQbvWHtFr9vvVZyO4Z6GQnitJ74QUFN3tWfErwuUlQrP
         2sT5dsyMusg21V6FF+aRqCK6b8ps7y81QO9Tos0+5YyzSCaT1TuN+rNamlJRMxv5hLt0
         hkqFxjrqvblsrST2HwpGWGbOP+XlcYoNwNgO7ioR9HTKz5YBBuQouP5EA8NWqwVwHyJ3
         uf/gIXuxCkOHrwnH8vBk1oMh64o6CS7X/VGlbYyd4WzKbqiSnsh1CYTgVncZTNSXZv56
         aRrvwT5QtsUxi/F3r1vXEXqAZQlnC0RTqFps8kmmc8JXQ1prDV0KIJBotmYnjOmID3lR
         wx7Q==
X-Gm-Message-State: AOAM533ynuLi8qpnieM3PiMjNb4S4ZCRbyp4v3yvu4cZzgu/lLYREjnv
        lsK812JkpTAanzohJnWlY9uY5slyxiDMqmCx
X-Google-Smtp-Source: ABdhPJyFK37EeyeeopmxukxBsFTzpAPFfr7vo9DAYIN5Pi3ZWvq73WSwEcNmR2ilyb2f8pBHb80phA==
X-Received: by 2002:a05:6808:bc6:: with SMTP id o6mr4931496oik.33.1634826395708;
        Thu, 21 Oct 2021 07:26:35 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac? ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id c17sm1163600ots.35.2021.10.21.07.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 07:26:35 -0700 (PDT)
Subject: Re: [GIT PULL] first round of nvme updates for Linux 5.16
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YXFjRq8JzDdVXww/@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f27b729f-f7dc-2ceb-4ae2-5de18e2d4c4d@kernel.dk>
Date:   Thu, 21 Oct 2021 08:26:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXFjRq8JzDdVXww/@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 6:55 AM, Christoph Hellwig wrote:
> The following changes since commit a9a7e30fd918588bc312ba782426e3a1282df359:
> 
>   nvme: don't memset() the normal read/write command (2021-10-19 12:41:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-21

Pulled, thanks.

-- 
Jens Axboe


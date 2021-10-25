Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E324C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E276054F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 02:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhJYCaP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 22:30:15 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:42679 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhJYCaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 22:30:15 -0400
Received: by mail-pl1-f176.google.com with SMTP id v16so1493667ple.9
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 19:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W9aK1etcXCIdootYAHqQdX7pqU9mXrKzcfIq9N/QPe8=;
        b=ybSFVURQCuHOOXFgG8IqlzxTjs8Bv80U6Jah6D8UATD6SPKWcdzXZ07OmX/ItE28i8
         UzsoGWb97m+es2ZkQ6bhO35ustocVtcqS3rJsNWuRoU2tJfLZJstp5Uej/250BnHQ5lE
         6xuP9s+hQofgQizgY9g8EMVl09HKocWNK8w51pc3XKfCWQ8/24aXI/Z3FXVEjiDRzRAg
         LfJjaNSW5czWDkcrkE86gm2Oph4uzgd7Y/BKO5mK1HM5hyRbApV8woRv4mVVquQA9m9u
         aawnId04drcUc/b2APANBx1+UtwsQQ5NxhPoTOPlF9o1xU600ltnJ7Pdx7pRIVSj4wov
         5yWg==
X-Gm-Message-State: AOAM532/lW5/FffyUu9A9Jg0hu/6gmAnfK+uk0gu2qT0SR5Gfqrj2rIe
        czQpnmaQSITq91lIKkX/nZg=
X-Google-Smtp-Source: ABdhPJwcGkt+dGstn178H7EoLmV4ckSt869sOslNxgNyxIaFrMqHcsQNfHR7mDGj5Ea/4jXGq0TTkQ==
X-Received: by 2002:a17:90a:ea11:: with SMTP id w17mr20098669pjy.61.1635128873400;
        Sun, 24 Oct 2021 19:27:53 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:1d23:4f1f:253d:c1e1? ([2601:647:4000:d7:1d23:4f1f:253d:c1e1])
        by smtp.gmail.com with ESMTPSA id g21sm10433787pfv.127.2021.10.24.19.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 19:27:52 -0700 (PDT)
Message-ID: <904355ef-554e-0b72-5d16-3089a042de9e@acm.org>
Date:   Sun, 24 Oct 2021 19:27:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH blktests V4] tests/srp: fix module loading issue during
 srp tests
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org
References: <20211025012416.23432-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211025012416.23432-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/21 18:24, Yi Zhang wrote:
> The ib_isert/ib_srpt modules will be automatically loaded after the first
>   time rdma_rxe/siw setup [ ... ]

Doesn't this depend on the contents of the /etc/rdma/modules/*conf
configuration files?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

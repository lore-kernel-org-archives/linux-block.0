Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92525C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 09:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiFZJZx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiFZJZw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 05:25:52 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3810561
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 02:25:51 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id n1so8912569wrg.12
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 02:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=8NJYDlwuLq5PTohC7HfJvhCYXyEryMED2D03RkMVomU1yegVbd0TW9RNlFQfl0xOYJ
         WMlMRCuE6D7OwdTyTBPTQM/9/SDHbRKpzCyurfGpd6aussdmJR8o5+kOLr5jqTcqFNmZ
         Dj6OsqPyuxN7YGQVqHveCHqfEh02jp8CYLtNlIUMLpvcDN5I9vVKTovKvkgxdYi1RqS5
         Nv0fsnjrWGaWkMGzvE/cC4bMEgYvjlNIGvb8UT6AJyzbxB7w8zLlDlN1sgWYZHb8XMeZ
         Orv+e9BqNswPMJZBRjVvC5VLQBiNI0yLRzj+QcNAQ4Tw9e2EygvBeqXoQwEasIrYbD/7
         MMFw==
X-Gm-Message-State: AJIora88ibmwDDx4oEpvIrFbdZz3CbbduSVyO7Lhv4CzG4vS6Pc/hAa8
        YaOO0bra7QpaU22Kx2joTiM=
X-Google-Smtp-Source: AGRyM1umrsFwmDL//P9SYYOZ+FZkiV/ABGjS0vn+fQc+KA7toXtrnTAn1KkSM31RITQ2h1OOzPWthw==
X-Received: by 2002:a05:6000:1281:b0:21b:9c01:df79 with SMTP id f1-20020a056000128100b0021b9c01df79mr6942350wrx.563.1656235551507;
        Sun, 26 Jun 2022 02:25:51 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j14-20020adfa54e000000b0021b93b29cacsm8667406wrb.99.2022.06.26.02.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 02:25:51 -0700 (PDT)
Message-ID: <58eb46b9-e5b2-e713-5bd9-7f5196836da7@grimberg.me>
Date:   Sun, 26 Jun 2022 12:25:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 28/51] nvme/target: Use the new blk_opf_t type
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-29-bvanassche@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220623180528.3595304-29-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

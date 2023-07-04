Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE18EB64DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 14:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjGDON1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGDONV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 10:13:21 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3A1727;
        Tue,  4 Jul 2023 07:13:19 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6687466137bso3303322b3a.0;
        Tue, 04 Jul 2023 07:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479999; x=1691071999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFB8PojU7YpiUakGKwyKSFndjIZIuNwZuyX72fdjf+o=;
        b=KYDvaxBaML+fhdE/7f1jWEE4Tlvy44egKZ4jJtnxBWXvIaKPSBBu4w4gtQsoxKc4pk
         x+rNMrZcAR5bfs5Dns6AJWqU/QJ2eJyGxavDhl8s6ruF4F7gqRRontX2oh1FAoh8aV3r
         jL1j7vaA0GnRcZxss/7krF7dp3tgV5tz7rc4RmoqxF090a3WzlTP2O/ZyHm8EqP9oPyC
         Zr80stwwKhe9K3vdikBLVON7P2Jtg1bkiJsPInatc1vY9GH+ZrBC0GHzg/AVJST4Ip5B
         +kv8P9ZJWEOjMSRB5aonT0kSauMBDHVMcGpqBMy2RgTrZcyCBty8dO+MUnMQCyqqvYG8
         Is1g==
X-Gm-Message-State: ABy/qLYQTql6CMOjVwckd5+5lvTncY4vyodH0/s+Pz47QA1EKe/ympKc
        /2zn/oOWsm+tfbBITeC5c1M=
X-Google-Smtp-Source: APBJJlGhfp3bsWTF9b4mHP2e2ofSZY80jupVTROLcOkaN2MthkZshD6I2kkhZ01NHvbaNOhSKh3EfQ==
X-Received: by 2002:a05:6a00:99f:b0:62d:8376:3712 with SMTP id u31-20020a056a00099f00b0062d83763712mr11239075pfg.28.1688479998665;
        Tue, 04 Jul 2023 07:13:18 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id s12-20020a62e70c000000b00679a4b56e41sm13131614pfh.43.2023.07.04.07.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:13:18 -0700 (PDT)
Message-ID: <32dad510-1508-f0dc-ab49-60d56ed2c2d6@acm.org>
Date:   Tue, 4 Jul 2023 07:13:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block: mq-deadline: rename sort_list to sort_rb
Content-Language: en-US
To:     lipeifeng@oppo.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshiming@oppo.com, guojian@oppo.com
References: <20230704040626.24899-1-lipeifeng@oppo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230704040626.24899-1-lipeifeng@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/3/23 21:06, lipeifeng@oppo.com wrote:
> Mq-deadline would store request in list:fifo_list and
> rb_tree:sort_list, and sort_list should be renamed to
> sort_rb which is beneficial for understanding.

Huh? I think this patch makes the code less readable instead of more 
readable ...

Bart.

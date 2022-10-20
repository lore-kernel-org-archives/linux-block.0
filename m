Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D367C43217
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJTNTa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiJTNTJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:19:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4B619D8B9
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:18:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bk15so34351329wrb.13
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hSeVYHiLgfDFZ3U0F0rSaZE0ZTnZGhClit4FrKhEWEU+x4wpj2EDICPHB+CQowOKqI
         DIr3IDNFCE+XCSsb40e2CuELSSf8AVOo0Z8AtEO9K+3suFVMzuufAsHb08f1rwxY8OAI
         IvjrLsh3QSrP1Mn3+fWH1ls5iyg5s+gsysVXQIR7K7d4lK1B7jog9xIQsd6c3we9+KIs
         mRR7z+cv64pOmna61P76T2aQJS86vkxksJVC2aS80IBJqQnMu90DJod0F9CQJ34g9TfH
         TzW0FzE5XzUU2EWmFrIaal/G0KaIHq+6KqyJMsB3XfXph8NLAQbjrUKOHThFL9lk9Mqg
         9uVg==
X-Gm-Message-State: ACrzQf1L9+GxUZYRFO4iOMHKWGP4KmZZlMwP3/e2yXaccYa+zAMKd9wp
        wCjiSCqpuuAPqVN2Qgwh+Xc=
X-Google-Smtp-Source: AMsMyM5Vk11r4d4ahShdwPrx1jTz0ulRGfUAF7C6DDWDI2BOHq1n4L2RF0B/z9kgOehESdSSxNj23A==
X-Received: by 2002:adf:fe83:0:b0:22e:6537:379d with SMTP id l3-20020adffe83000000b0022e6537379dmr8218883wrr.505.1666271810803;
        Thu, 20 Oct 2022 06:16:50 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000108f00b0023647841c5bsm1026025wrw.60.2022.10.20.06.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:16:50 -0700 (PDT)
Message-ID: <dbe8cda8-2930-91cc-567b-4f0cb359549b@grimberg.me>
Date:   Thu, 20 Oct 2022 16:16:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-2-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

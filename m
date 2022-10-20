Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01685C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJTNYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiJTNYS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:24:18 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C1918E293
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:24:09 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id bv10so34356676wrb.4
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=5doR4AZ6kJsWiMWcEMHPIqAUQuaqQgCFTcwvmWNZGmzouZzKyc4XP2pQfXvecteASM
         sb0lHYmyd0RNb7wcwQjwvRR0FNJdXD0Q6HaoX4Nml7pmn7+0TOIiSuUCYhlceeyqhGZc
         WM+9VMNAkE2gOuG8BSKOvwzgRvAS5TIA/xbEUCN/U5NNNuTiLXlBpmd9BmdGCXyMwCaN
         wLrAi+GSscxcwsWpVM2RJl39JZAqWKr/hyKd/yFwpHQkzsfw4H9Xv621GIp7plvs6sWy
         HQGS5QM4vt7LpoNAx44LEnWojOHvUQZH1YwLsEQMQNCeixrcFlv5fdx3W+T7T0WYZ8rK
         3XMg==
X-Gm-Message-State: ACrzQf2QY53dXS3hAElwd2RsQGHEJfDO23YgkuB49rAwov2pKp9StiXM
        6I07VvRIGFuVxsCZgVgBsakvP1vd4Mg=
X-Google-Smtp-Source: AMsMyM6vCHLOWdD5kqeG88pAa+uEXrOEs4c+aTaQ5X1pHElL6Ce80NDJ8CsQt4gbVe3hukUiqMentw==
X-Received: by 2002:a05:6000:1842:b0:22e:7bbf:c75 with SMTP id c2-20020a056000184200b0022e7bbf0c75mr8643659wri.547.1666272248520;
        Thu, 20 Oct 2022 06:24:08 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d6508000000b00228dff8d975sm16482207wru.109.2022.10.20.06.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:24:07 -0700 (PDT)
Message-ID: <813712d8-af9e-3b44-55be-e6496310e8f5@grimberg.me>
Date:   Thu, 20 Oct 2022 16:24:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

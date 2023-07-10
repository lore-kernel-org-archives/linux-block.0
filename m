Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54575EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 09:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjGJJdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 05:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGJJdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 05:33:12 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D673185
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:31:43 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso10395685e9.0
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981491; x=1691573491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LRe5bMmeqBdNDtTCaVSjZrreef8CXyZlprKTlJXGNyMQKTMoe36+1f9D+gAMreixnK
         QSpdotGXS4f3esXmVGeHwDhdzb3VmFD/MGSrDDwRWhSuzW1QpQqcwrbMR8YmMNpCsPFG
         ImAu3IgZ8At/ifdu8+z9GoLkCE1rrAHritoerGEDO8WEW/nHER8UF00zAMAEVtmJ2map
         3lZ1hC045JoRx94em+9XbFDVeQCBJl5DfF7yMZyGziD3cEkCYI3Lpnf9UTM1X74TnSJo
         PuP6dGU4XApY9wbYEM497CckRPh5zG9rXpxzJNEhbxQvJf4Rv/8vkFstGxaUOQQ5F6Ke
         SnOg==
X-Gm-Message-State: ABy/qLYpACG5BYVQqc1/jFij4oT9yFo3NnwCLYUL+VMt1Nabg4L9MUlW
        dl+s2ymNkabqQB5iCTAZJ50=
X-Google-Smtp-Source: APBJJlG7fnYAe2ON7tFEpp+MZFL3CfB1NhiN3mkpMczrNU9iuLt5F1nkwlUbilquV4imHlx2JZTlqg==
X-Received: by 2002:a05:600c:5115:b0:3fb:aadc:41dc with SMTP id o21-20020a05600c511500b003fbaadc41dcmr11135555wms.4.1688981491349;
        Mon, 10 Jul 2023 02:31:31 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e4-20020a05600c218400b003fbfea1afffsm9207887wme.27.2023.07.10.02.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:31:30 -0700 (PDT)
Message-ID: <969e651c-ec97-ece4-11a2-9109a971d175@grimberg.me>
Date:   Mon, 10 Jul 2023 12:31:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] nvme: fix max_discard_sectors calculation
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-4-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707094616.108430-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

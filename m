Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4CC001DC
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 09:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGJJdM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjGJJce (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 05:32:34 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FAA211F
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:31:13 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso7741305e9.1
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981400; x=1691573400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TovCFWFZBjetHPMfsj6kwv54hUIlSkcuTaXffHwiP4MURNoxZfbANaf99LZd/sH24Q
         mEeSn2Zhn7OZVhtkqLnY6ikrW4x2zc2XhssqH9iealmXZeldah9knhv6mr3Sd7O4ec2A
         Z01mFe9+v9tqlJK3YhNIRzIsWvpm+HAKsjv5ZD0wGa3d36cWnL+kMIKUVonkEdjat1/W
         OHurWq1S37RJJT/9OurS64ZfAn26UR3SnxiUzuqPNOSWZJcLjScWj09183SGfYUEmj2C
         mVqcNaj72ivty0SMIJwQiBEUjrsK6ZhVmE9GCgcT5mt27i6iKzTaSYPzY/sEOv29YYus
         EVyA==
X-Gm-Message-State: ABy/qLYw8iBDukMAq9mSrJ1ftBNi9vzPJuMSNiC/Jti8V0TTeURhgg98
        GKdv8zVffkJ4+oaLM9BZZLq8mxI3sdU=
X-Google-Smtp-Source: APBJJlGG9cfGQMVw05py4Ra8WWVn7tTX5dl2w1GUvYJfa6uz8tKqdRZZS/ToqZODl11afxdYIfVjaw==
X-Received: by 2002:a05:600c:3b1b:b0:3f9:bf0e:a312 with SMTP id m27-20020a05600c3b1b00b003f9bf0ea312mr14323974wms.1.1688981399717;
        Mon, 10 Jul 2023 02:29:59 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v24-20020a05600c215800b003fa95f328afsm9752007wml.29.2023.07.10.02.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:29:59 -0700 (PDT)
Message-ID: <d4982c2e-b993-b6c6-417d-db0238de47e9@grimberg.me>
Date:   Mon, 10 Jul 2023 12:29:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] nvme: update discard limits in nvme_config_discard
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-3-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707094616.108430-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

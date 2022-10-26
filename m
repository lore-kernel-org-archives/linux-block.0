Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0011CC433FE
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiJZMuo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiJZMuo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:50:44 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A75B11E
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:50:42 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id r6-20020a1c4406000000b003cf4d389c41so446819wma.3
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vhVf0IIA1rhNA2EifjV3QKgxr1vgv4p2NTDqk3DQJbALeOKt03ggJojVB2lj2ZgtUJ
         xt5mESiEPr3B52pobstc9crXHkWjNqqebx5r1pBREu7c0yWyBAhrcF6RFVl7e4BUtdZS
         DSyvxaVOCwKjIkh7ZpeByeM+uPGYcVjlex95KqkfheQk88Tdw3BDFSR8SQt+IuNXly20
         Jr0TLF3EvT6cI1Cm4piWTA5RG590TsfCF9ogSjiYvtIufh2cpVAwYzwDx0wFDfjknMM+
         N7zSZ60D34jJqrb7V56rvhGJY4OqMhegoeH+zazWilxgNn0wWw0Ir2s/NukrJTdqbM5P
         g+Hg==
X-Gm-Message-State: ACrzQf0UyMX1AjSi0OHcfN+aMcpzoXMwj7vTST5a1FapaklnQlFqQlrI
        SqFpq9W+KaPCrMrL64IQfA8=
X-Google-Smtp-Source: AMsMyM4r9WznkUrdw/UuWkb94bY9rSIUugCqVmtw8vp+1ots7mMJ68Kdry2WZNreT1TaVMYJVyzCXA==
X-Received: by 2002:a05:600c:3c84:b0:3b4:eff4:ab69 with SMTP id bg4-20020a05600c3c8400b003b4eff4ab69mr2362569wmb.104.1666788641377;
        Wed, 26 Oct 2022 05:50:41 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b003b4ac05a8a4sm2397387wmo.27.2022.10.26.05.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:50:40 -0700 (PDT)
Message-ID: <e367459d-e19e-6a79-20a4-20abfc6dc901@grimberg.me>
Date:   Wed, 26 Oct 2022 15:50:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 05/17] nvme: don't remove namespaces in nvme_passthru_end
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-6-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

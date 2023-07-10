Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C013EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 09:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjGJJeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 05:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjGJJd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 05:33:59 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49C810C6
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:32:38 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3145fcecef6so897147f8f.0
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981557; x=1691573557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=G6NxX5o/AlnMS332qGavg+ZGYNQ/PE2SN3FxkaZIzyFpX+PM1+DbjE+xwXUo/iUrcb
         ywRjVcRLpwBnJSKvZA1E1D0zJMAmX2l7u4wMz7TVCCKWQ5QJHE7Vrgu+MgarkcuONC9N
         h/H8vLcKOmhO7xr7k3K725D5NGf+l8R2AeoAyni4jmOrZADelpajt21jRLEVdPqUE6Vs
         xwfeO/bf1USseeRvXDaLN6ZaaEujjJc0SVOwh6pQO0fpFxCxWtbk65YzbI80mNF0S7c+
         V6eGsq6h5GVmIpRXImabndgHBTDUvXRvzuupwxPvZ9GHPA7kQGyb09nKxO72XALu1934
         4Epg==
X-Gm-Message-State: ABy/qLYNeN47D9tbpI0olOBe4r7wGUQHLCMMDCdzrAfrciLUz0A9NRa6
        3m5Ut6pFY85BKcBcHCc6Gjk=
X-Google-Smtp-Source: APBJJlFGa3h1OxjP0fcWsDDpnrcXsCeNBmBLSQFnRSX/QfFKhlMPvuz20SkqEc5eAlm+BA+WYrGazg==
X-Received: by 2002:a5d:6748:0:b0:313:e9d9:3004 with SMTP id l8-20020a5d6748000000b00313e9d93004mr10433889wrw.0.1688981557217;
        Mon, 10 Jul 2023 02:32:37 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q3-20020adfea03000000b003143c6e09ccsm11207863wrm.16.2023.07.10.02.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:32:36 -0700 (PDT)
Message-ID: <427a5543-ce19-e974-2593-5e8ea96602f3@grimberg.me>
Date:   Mon, 10 Jul 2023 12:32:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] nvme: simplify the max_discard_segments calculation
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-5-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707094616.108430-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

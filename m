Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF056C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7568C2084A
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7568C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeLKKuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:50:09 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:36584 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeLKKuI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 05:50:08 -0500
Received: by mail-pf1-f179.google.com with SMTP id b85so6954535pfc.3
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 02:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=f3yxjCMvfk0H0jtrgrZT4YheDpqAA9Hp/249iVN9JxS5y5rimab0K7DfE8Q1Qv47Sa
         WOvKWZaXEA8E1S5vk0uyvglxotGSF7ZKLWDqdDyezGYLV34j+FYN8gZnj6vg39l9j93b
         G49ZkPclGDjk8nWB2R7giz+0FWqmCDc4qholwfBkiMP+OHaqPgJrq24kczXO78b9kA3K
         K27PjhPYLfukS2Wh7f5prOQO4wiN2EYo0q/7pHNSNhMC2j0CfYiAdkRAwXF/yum25Pw3
         64RqQ1a8nSN38UONzkGMF7+ps/ITp3enWQ5lhN7kNcJceiSSmr2a+R9XQdm48SdIXtTP
         cVDg==
X-Gm-Message-State: AA+aEWad7X9VR+df/xCIFbYF4uNuOGN3Yq8KRkCdZLFhy0r9gXZhWkGs
        mdZE1UKzSXCSWPGZB8l1MHE=
X-Google-Smtp-Source: AFSGD/Uxjt+yj9M6ZeHULohD+anfOvkVDb37klhtCAY6xsOWIC3V7Zf/TRftX/h4nQ2tEk5mnx/AcQ==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr14049293pgf.33.1544525408022;
        Tue, 11 Dec 2018 02:50:08 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id o1sm19764608pgn.63.2018.12.11.02.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 02:50:07 -0800 (PST)
Subject: Re: [PATCH] nvme: fix irq vs io_queue calculations
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>
References: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aeee5f1e-9ab6-5474-226f-4ff588dbebae@grimberg.me>
Date:   Tue, 11 Dec 2018 02:50:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

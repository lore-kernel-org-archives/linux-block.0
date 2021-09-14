Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BB6C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804BB61164
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhINHLl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:11:41 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:41665 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbhINHLh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 03:11:37 -0400
Received: by mail-wm1-f46.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso1709857wme.0
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 00:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IiINBX3YO3NsYfPfcxgfWP6Ep5EKOEns/Ok0gUTvVaKKb0Z6MS3qT0iVfyCsN9A2D8
         00Tv+X4aMkdGnmKrFyTpKCJGzB+yzBw6QuZxOAnJ3asUujU2Qfv80z+w4YC2YJutOfcC
         XSrencJqjhaY80d1rVfXxL81pxU2fCGajD/EyDt0R3yFgDUC2l2Q0kHW3dyS/PPELsCG
         6D89ixKvdTd65WeyLWYILaPqaotPjYL5ImCMxotTGt78Puwa4/JL2Ns2Ba6UuIqxMJs0
         VG53XIjpBYazLonmVDGQM1kBOqL4EG0wfTrgDmGGDhURuR7gcMgFj80bZTjofUo6x0q1
         wiWw==
X-Gm-Message-State: AOAM533O7B+BTax73Xemv/7wNH3Te8FRzRxBUihP1v4VDGRUMdA0HF8U
        Pw2kkVBjDPerMOgDEEhDZVM=
X-Google-Smtp-Source: ABdhPJx7sgMPw0ZveAhlsfNR05BybpsNgXDeSWAWCXYwgqr7q8we2bjrntKcjsDyOtsJWIFczNrzsw==
X-Received: by 2002:a7b:c447:: with SMTP id l7mr462543wmi.15.1631603419971;
        Tue, 14 Sep 2021 00:10:19 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z7sm11919641wre.72.2021.09.14.00.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:10:19 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: check if a profile is actually registered in
 blk_integrity_unregister
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com
Cc:     Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210914070657.87677-1-hch@lst.de>
 <20210914070657.87677-2-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f9ed98d5-daee-7206-59c6-88bbbc49ed25@grimberg.me>
Date:   Tue, 14 Sep 2021 10:10:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914070657.87677-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

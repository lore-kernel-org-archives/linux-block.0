Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E84C433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349372AbiALIip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 03:38:45 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35750 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiALIio (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 03:38:44 -0500
Received: by mail-wr1-f46.google.com with SMTP id e9so2816740wra.2
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 00:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WwJVaRzRUx6SGgX8lu+qCB0YWwBAJIWWY6asI7yKKVs=;
        b=K9QoG/3ZIO6cgfaD208ZpLfKJUkT+WTQ29X1VtNt/tMj0L47DHwb+1lLj0rry14d30
         ggdLuaoVMj7nGzhQUXAPpkj/t5nl2rc6s8MsGnvOB8tO6hUgwfLom404BXM6AfI/pxhm
         JSzL7ykql0hmPpwVWHFbdxjvv5PMyKXEnQq3o7sWdlB7eogNwk3XGvTlvirFlOYHbZeE
         bXmz+fBC6nedY88L7pJd+369Xk/LMxbgk4KjPzA2GkDTpiPPG6v3Q+1uJLzzj3g5nlAK
         2cXQUda1VUsmBYL/wg2jtB2ySq4hHQ4v4LplMmh9R8DKYcSoCzySyr3/gaxqEiwSi0j7
         Watw==
X-Gm-Message-State: AOAM531BKfBBFaI4ikvMTbIsHVf2qvs/Fm4pNejW4oA2QRiJAbd/EJdK
        +lL6NjqOBEC9oKN6L1EFGNII0XcW2f4=
X-Google-Smtp-Source: ABdhPJzjW88riDW5DvYGR9CcW3afhgqtMYHD2kCRbRPbENxLz7A8MxmmABHg2Bh2xOzgpvEpsv10sg==
X-Received: by 2002:a05:6000:188f:: with SMTP id a15mr7123464wri.153.1641976723596;
        Wed, 12 Jan 2022 00:38:43 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k33sm3680879wms.21.2022.01.12.00.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:38:43 -0800 (PST)
Subject: Re: [PATCH blktests 0/3] tetss/nvme: fix nvme disc changes
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     osandov@fb.com, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220112060614.73015-1-chaitanyak@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dabc21d2-6431-67e0-8ce5-62c74c76bc99@grimberg.me>
Date:   Wed, 12 Jan 2022 10:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112060614.73015-1-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

What is preventing this to break again?

Can we modify the tests to not rely on a consistent
output here. Perhaps just search/match the expected nvm subsystems
in the log page?

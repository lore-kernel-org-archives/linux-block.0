Return-Path: <SRS0=12de=XQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21034C4360D
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 15:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26F42086A
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 15:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407695AbfIUP51 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:57:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38237 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407694AbfIUP51 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Sep 2019 11:57:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so5530388pgi.5
        for <linux-block@vger.kernel.org>; Sat, 21 Sep 2019 08:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TCZbgE46D9QIbKsU55uX/A54PynugJX4GwazsILo/cc=;
        b=KWea4ku0hJM7JbqW331VbLKU4hzQZhRAgFiloRRGOOJJCesNgEZFsLhxJP2zf7SI9x
         yh0oQJRpYEGx1uEau30x5GH3zNHAgDeGIsDfdN+bTBI5z5GEQkSLLr26gcOycunSfMWy
         GJ/Gt8Ua8hL52zdLWpb03t2qEi08b+76hmFCpYgtPCCd90WUAm8LOYGxOtwAIzNQtmoD
         /kL5a8HuOhDGeR88mQngXXbn5zGEbLzlIv9Q5Z9+NOwcbUG6Gg3Gh9MtGGhMIJw+QqN8
         8re3VaECKLWjmNkx2bSOIvakb4mKc48+WHkytdkW9Z3tQFwjHjwkgIbWDFrK0Ncqw4ZV
         v9dw==
X-Gm-Message-State: APjAAAUs6fY9LlUCdWIYN/o7/SrswglXPLfETHOLky1EkR6f3RqyIAZ4
        4zCskuNyTKhWc3/EbHARhvI=
X-Google-Smtp-Source: APXvYqzTD3NG5y2sYt2Wi8GTzNoeKSvUZ8DD1L6dr9O5Ba3vQjbcfd+OPmAhZqa6ZN7GJQTgXdhFKA==
X-Received: by 2002:aa7:80ca:: with SMTP id a10mr23965955pfn.96.1569081446443;
        Sat, 21 Sep 2019 08:57:26 -0700 (PDT)
Received: from asus.site ([2601:647:4000:a:3ff9:564e:9b:720c])
        by smtp.gmail.com with ESMTPSA id w189sm6949067pfw.101.2019.09.21.08.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2019 08:57:25 -0700 (PDT)
Subject: Re: [PATCH v3] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
To:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        hch@infradead.org, keith.busch@intel.com
References: <20190920113404.48567-1-yuyufen@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <011d9eae-d4c3-db6d-355b-6780fc18b06e@acm.org>
Date:   Sat, 21 Sep 2019 08:57:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920113404.48567-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/19 4:34 AM, Yufen Yu wrote:
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Have you considered to add Fixes: and Cc: stable tags to this patch?

Thanks,

Bart.

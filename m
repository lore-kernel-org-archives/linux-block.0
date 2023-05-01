Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78214C77B61
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 16:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjEAQdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQdk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 12:33:40 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D6E4D
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 09:33:38 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so3174810b3a.2
        for <linux-block@vger.kernel.org>; Mon, 01 May 2023 09:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682958818; x=1685550818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wvXgmXTcoqinXgmTcZbLJeJ+cVt/9/6nawvCb/0Ccc=;
        b=jvQjSemcb6yp4nWNE5nW+89CLofLX5320k+xiQ6dJcMeHBwzafTXSpoK9RrF3Apn2g
         AfO7nVL/2kL9ccyA4v20RuQjG729+1vxptWj7mfUp8iOgmq3zpsB1YKeCXFFCA+e/4wf
         hTeLj0Rvg8xmH5fcjSpgId6QshNfGRsW1VH+b/+9L1qKtm7gosa4CGn36H2PZK1X3Ib2
         LlgL4XKKhRRcWJ0WtF18dNKfriZxsFhuAMU5TtZwAHuc27tS+52jOObMkATYp4UdNl8B
         AeNpVu2mmqyKjixVOkFYhAY2h26+Mtg0Rd+oqpwwtEdjXm2QqUaQaFKWIp8cQMEbx+wC
         Y14g==
X-Gm-Message-State: AC+VfDyjjG+ZbpkLABx+TT811IPsVOT6tVmgIgPQd3IvAESSmvaQYz9L
        P/R+unpLak67ytXu/d9qGTMxhAY+iWw=
X-Google-Smtp-Source: ACHHUZ4vkJ0fYm8o2BnyyfAkFbxvYe/seRtXqWqRzXk7q8DoFUff84cr5BgmMUNcRiGa9CS20pAdPA==
X-Received: by 2002:a05:6a00:2d84:b0:63b:e4:554 with SMTP id fb4-20020a056a002d8400b0063b00e40554mr22821985pfb.4.1682958817749;
        Mon, 01 May 2023 09:33:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:eba5:79b2:92dd:67e? ([2620:15c:211:201:eba5:79b2:92dd:67e])
        by smtp.gmail.com with ESMTPSA id t5-20020a628105000000b0063b73e69ea2sm20114934pfd.42.2023.05.01.09.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 09:33:37 -0700 (PDT)
Message-ID: <e561f3c5-f7ec-f343-5bd9-75919f079515@acm.org>
Date:   Mon, 1 May 2023 09:33:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [bvanassche:block-for-next] [block] 4cf040452d:
 INFO:task_blocked_for_more_than#seconds
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org
References: <202305012131.8562d30d-oliver.sang@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <202305012131.8562d30d-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/23 07:00, kernel test robot wrote:
> kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> 
> commit: 4cf040452d1cb0a66a6cac74066b1d2cd2190e53 ("block: Send requeued requests to the I/O scheduler")
> https://github.com/bvanassche/linux block-for-next
> 
> in testcase: blktests
> version: blktests-x86_64-c1da4a2-1_20230425
> with following parameters:
> 
> 	disk: 1SSD
> 	test: block-027

That commit is from an old branch that I forgot to delete from my github
account (April 7, 2023). Let's see whether the kernel test robot reports
anything for the more recent patches that have been posted on the linux-block
mailing list.

Bart.


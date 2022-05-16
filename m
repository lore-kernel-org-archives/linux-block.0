Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DE8C433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 17:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245546AbiEPRhN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiEPRhN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 13:37:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED4820D
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 10:37:11 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a10so16712673ioe.9
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YwuisP7uDoVDfdXBJmqd9YIRoCZ/b+H6kmPLu7NDx7o=;
        b=v3hXidxNGYqAeo+c7zqaHOYF0box7qSqlGLxtatUMn6AKByIl1VWHUM69zV60ZTOs2
         bSfCBwo+0Niu3CsybHlfev1BraoJSubByQxXjbcbACJVD7TQ7YTTnEAi99XCU2V26WMW
         YuxCxNb8E86RXzGh3qWjAZ6gXLA2cxnuAAwbNHbaz5xsozTxdjmSINHD2f3iNIfayDGO
         crOM/KCpytP6ij9c52sVNQ0XxcI9ft+ESz3tMB7ucHiYEhxcV0hkWkznnjqWtwqDPxqP
         d3L0g6P4KsA5lxW4oek8XSkQvDijHB2cdkGgsFQslr71Anvj4kktfrDF441taFisy0yz
         8BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YwuisP7uDoVDfdXBJmqd9YIRoCZ/b+H6kmPLu7NDx7o=;
        b=va67J+iSDebdjtWaDc0xtxKZmfG6Z/e0lOEiOAEGQ01FqBhS/ZCrDzpzKRyTP7+33t
         DI+KZ1RBxd8JCcxcMHHKCLYWEBkJi/5gqlR1CUoUBgsJNovyLp31b2ApxOz3IbjthuWl
         9h/FuAk+fOnfjd6pH3rEK21tIe5HYoZKKexNA6HxEstv7qgx3hQKxJFFYsnwimP2J4cT
         fnj2NfrTIvk5KHHntl1+b9P+umCq+vj4YJBU0e3keNJ9VLQjmyKst7V7BWUxjH0w5HPH
         /6YLX1Rcj7F7SSpbtx742wL8zHTE5fuXNKYx0+RW55r+OmdUE7fVWg+26cJyvrt7qx4V
         QSmQ==
X-Gm-Message-State: AOAM531h+sMRuLTe47QEpPmTj4xExcXcGi4jMVGMa4RXFjk1o1mhuLSz
        49NlRymT/9eLCOGTQQ44MX5njQ==
X-Google-Smtp-Source: ABdhPJwT/3nonpz1WJw0lbRiEjMo1gw1L6LCJetWMq6L414QjHZUkay1am15FXkVXTr1Gb+dYQTG3g==
X-Received: by 2002:a02:6a19:0:b0:32d:df4d:9da with SMTP id l25-20020a026a19000000b0032ddf4d09damr9300423jac.149.1652722630482;
        Mon, 16 May 2022 10:37:10 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k23-20020a026617000000b0032b5e78bfcbsm2951441jac.135.2022.05.16.10.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 10:37:09 -0700 (PDT)
Message-ID: <c9c389a0-650f-aea4-fe87-c5ebccc7129c@kernel.dk>
Date:   Mon, 16 May 2022 11:37:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] block: cleanup the VM accounting in submit_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org
References: <20220516063654.2782792-1-hch@lst.de>
 <43ae0d52-9ed7-757c-4a01-4b4ca71a00ba@opensource.wdc.com>
 <20220516141141.GA11736@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220516141141.GA11736@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/22 8:11 AM, Christoph Hellwig wrote:
> On Mon, May 16, 2022 at 03:45:08PM +0200, Damien Le Moal wrote:
>> I know it is the same value, but for consistency, wouldn't it be better to use
>> REQ_OP_WRITE here ?
> 
> Yes, it absolutely would.  The use of WRITE wasn't even initentional.

I'll fix it up.

-- 
Jens Axboe


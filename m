Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBEBC38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 08:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJXInO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 04:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJXInN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 04:43:13 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990FC36877
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 01:43:11 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id y10so6157909wma.0
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 01:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nl8uXxvLSlpL8nTxFfcKz9Rk4wiN1AtReEBVE5r49Q=;
        b=qFyVdbJ07YYr62yz65XXTtN4jt1scOO3cQQSVH77DpRZwLJygzyHppssIGvrIA0HGm
         xcpwFXZstGrf46mCKfSxK91JtuAC9GVhDLqXZ4wEFZYudLC+IaVgN6TIsEXfYhpx7meL
         Qki/pn1JoORMDX8vLvOOIx2ZRNeL58OqRglma+rBj5/zQ8WeW6jtCJTlZEjd+tQGL5NI
         kR37aGEfHwkynPgy2Q2s2h/gb3SzU+aZ8i2WH+PggcAKc89Rox03evaQ2WCQjTf83H3z
         aOjG6ZlANmNES49L3gZqbBqfoazm4ZLRijnVMmWV4fw36rgv5r33RRsaDjalMMddZtWc
         5iJw==
X-Gm-Message-State: ACrzQf0nBuUqQIilirDetmHV/AwK3mv3CTCMAp1KACR+i9ev0s5daOy7
        nMHtetdGs2nw71WxWFH4M1SJZeY9r/Q=
X-Google-Smtp-Source: AMsMyM7cU24cXF9jl5CRz0itr0ES9hhFWmak90hM098d5DB+fmhzdY0B2UpiCMj/2SW9gAHejo84vQ==
X-Received: by 2002:a7b:cd93:0:b0:3c6:facf:1fa8 with SMTP id y19-20020a7bcd93000000b003c6facf1fa8mr22681746wmj.85.1666600990040;
        Mon, 24 Oct 2022 01:43:10 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d4a4a000000b00236492b3315sm10520606wrs.104.2022.10.24.01.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 01:43:09 -0700 (PDT)
Message-ID: <7d93b4fe-f88b-2d2c-e58d-396e03f3bc72@grimberg.me>
Date:   Mon, 24 Oct 2022 11:43:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-7-hch@lst.de>
 <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
 <20221021132815.GE22327@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221021132815.GE22327@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> -
>>> +	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
>>> +		list_for_each_entry(ns, &ctrl->namespaces, list)
>>> +			nvme_set_queue_dying(ns);
>>> +	}
>>
>> Looking at it now, I'm not sure I understand the need for this flag. It
>> seems to make nvme_kill_queues reentrant safe, but the admin queue
>> unquiesce can still end up unbalanced under reentrance?
>>
>> How is this not broken today (or ever since quiesce/unquiesce started
>> accounting)? Maybe I lost some context on the exact subtlety of how
>> nvme-pci uses this interface...
> 
> Yes, this also looks weird and I had a TODO list entry for myself
> to look into what is going on here.  The whole interaction
> with nvme_remove_namespaces is pretty weird to start with, and then
> the code in PCIe is even more weird.  But to feel confident to
> touch this I'd need real hot removal testing, for which I don't
> have a good rig right now.

Lets for start move the bit check up in the function and reverse
the polarity to return if it is set. Unless someone can make sense
of why this is OK.

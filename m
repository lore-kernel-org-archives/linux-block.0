Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C61C76191
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 22:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B785522CB9
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 22:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfGZWVU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:21:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39416 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfGZWVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 18:21:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so21143424pfn.6;
        Fri, 26 Jul 2019 15:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tX/zH/PNuI497S7quCepGSwc6KOajrviepHED1Ldz1U=;
        b=NmN+E+8smrsE59I6aBMdtsBF+rVxDO37e7Mgi+AH5cz2Q2sGZyenWCZxlThVmIuyJv
         E9ZWFERwOodC64vdU+P5muOIDR7XrqIf+pztcUmffXTtvqbcrT7iHFIbTHSY1GoPayJT
         nu2t0tRS9E1M9+uV9QmsBQJz946nWWQ4c7PrLkwWQycifktlkMoyLHCxIst6CUeP865q
         eV3ZYCYgULaMnAW9biOfQbMo+wd+FE2t1ZfRAT/aywhCdb4ZE+qzrUJdJHrrDz1rTm62
         3xgCpUhwbKxUF8Dr5WUbftyduOo/xGbZowB0TPexiFmdQEajxQ/BiE7MnXOO/P66KwLj
         txsw==
X-Gm-Message-State: APjAAAUKtOKdzIHmVSwnWPRi2Sadeu0C3nsXpjCDgPkd61mfWOOAC4Yn
        tk4o3yo+orPyyzLhNFR8DuA=
X-Google-Smtp-Source: APXvYqxRjRSPO/J+H5WK/f/tD4obqHr9uk/zzNMYETV1oB/hr82CB+shC60k4aOdcZjrzFAIe9rhfA==
X-Received: by 2002:a17:90a:f498:: with SMTP id bx24mr101682492pjb.91.1564179679768;
        Fri, 26 Jul 2019 15:21:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:3044:7ea3:7e19:4d2c? ([2601:647:4800:973f:3044:7ea3:7e19:4d2c])
        by smtp.gmail.com with ESMTPSA id k25sm43828641pgt.53.2019.07.26.15.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 15:21:18 -0700 (PDT)
Subject: Re: [PATCH v6 00/16] nvmet: add target passthru commands support
To:     Logan Gunthorpe <logang@deltatee.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
Date:   Fri, 26 Jul 2019 15:21:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> How do you handle subsystem naming?
>> If you enable the 'passthru' device, the (nvmet) subsystem (and its
>> name) is already created. Yet the passthru device will have its own
>> internal subsystem naming, so if you're not extra careful you'll end up
>> with a nvmet subsystem which doesn't have any relationship with the
>> passthru subsystem, making addressing etc ... tricky.
>> Any thoughts about that?
> 
> Well I can't say I have a great understanding of how multipath works, but...

Why is this related to multipath?

> I don't think it necessarily makes sense for the target subsynqn and the
> target's device nqn to be the same. It would be weird for a user to want
> to use the same device and a passed through device (through a loop) as
> part of the same subsystem. That being said, it's possible for the user
> to use the subsysnqn from the passed through device for the name of the
> subsys of the target. I tried this and it works except for the fact that
> the device I'm passing through doesn't set id->cmic.

I don't see why should the subsystem nqn should be the same name. Its
just like any other nvmet subsystem, just happens to have a nvme
controller in the backend (which it knows about). No reason to have
the same name IMO.

>> Similarly: how do you propose to handle multipath devices?
>> Any NVMe with several paths will be enabling NVMe multipathing
>> automatically, presenting you with a single multipathed namespace.
>> How will these devices be treated?
> 
> Well passthru works on the controller level not on the namespace level.
> So it can't make use of the multipath handling on the target system.

Why? if nvmet is capable, why shouldn't we support it?

> The one case that I think makes sense to me, but I don't know how if we
> can handle, is if the user had a couple multipath enabled controllers
> with the same subsynqn

That is usually the case, there is no multipathing defined across NVM
subsystems (at least for now).

> and wanted to passthru all of them to another
> system and use multipath on the host with both controllers. This would
> require having multiple target subsystems with the same name which I
> don't think will work too well.

Don't understand why this is the case?

AFAICT, all nvmet needs to do is:
1. override cimc
2. allow allocating multiple controllers to the pt ctrl as long as the
hostnqn match.
3. answer all the ana stuff.

What else is missing?

>> Will the multipathed namespace be used for passthru?
> 
> Nope.
> 
> Honestly, I think the answer is if someone wants to use multipathed
> controllers they should use regular NVMe-of as it doesn't really mesh
> well with the passthru approach.

Maybe I'm missing something, but they should be orthogonal.. I know that
its sort of not real passthru, but we are exposing an nvme device across
a fabric, I think its reasonable to have some adjustments on top.

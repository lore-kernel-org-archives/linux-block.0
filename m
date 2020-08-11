Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9EAC433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 20:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68522076C
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 20:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgHKUxI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:53:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34820 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 16:53:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id r4so111828pls.2
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 13:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gd7T+8eJ8mVx/b7wAbA1Z3nYKYy/7EXK0qxlAlojUJg=;
        b=YxrUDWUyoRBotlkz8CPExx8FZUzQ9POs0Vb4ZLV8ePh0HS5CLASTLFJQc1CrykFeqA
         zSZJpeKhec/m9ZCTbyuQ7+NtJENDjETEtWkWJqGyTAK843KnY7HVygKH8QMVtfvlq36A
         VLVBetqLfE/kDgr1CM/zcPqoK9+hqVPG6/rv+vQQIACtRDJC0Lp5cc9W69ozByt0B4tN
         Tn1VGTQKqHs7wUeVR4cRZ1Hxh3nSbun+IQgW9S4U8txAJ0ws6EL1A8ioi7CaGLFFOzm2
         tjMcjRKl+4Q+sA3YH9dGlSCSIHFjeUOgTJlnT91kgLzN3nD16Hs8JhC/kW+eAKm004qp
         t+Dg==
X-Gm-Message-State: AOAM531NlNzQPKfblLVwcqjdETrn4LCJZOVqGi7hmYSWGIehw/d/dQF0
        vCFo8rUNrcfNoFGvnHSprf1Mz3hX3lE=
X-Google-Smtp-Source: ABdhPJxqu6C83I6tgr9J5Y+0EmFaUkC7oAfIdfeP6WTob9YDLecZlvnzH/njyR0r/y1VDIAB/jqm0A==
X-Received: by 2002:a17:902:7781:: with SMTP id o1mr2481936pll.149.1597179186842;
        Tue, 11 Aug 2020 13:53:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b58b:5460:6ed2:8ff9? ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
        by smtp.gmail.com with ESMTPSA id in12sm3573550pjb.29.2020.08.11.13.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 13:53:06 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
To:     Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
 <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
 <20200810031547.GB2202641@T590>
 <6dc6bb01-5bfd-bf13-f53a-1bc75a6b3991@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4dbd5fe2-b3df-dec5-81f2-6ff97472f62a@grimberg.me>
Date:   Tue, 11 Aug 2020 13:53:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6dc6bb01-5bfd-bf13-f53a-1bc75a6b3991@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> About using per_cpu to replace SRCU, I suggest separate discussion.
>>> Can you show the patch? This will make it easier to discuss.
>> https://lore.kernel.org/linux-block/20200728134938.1505467-1-ming.lei@redhat.com/ 
>>
> Directly replace SRCU with percpu_ref, is not safe.
> This may make quiesce queue wait extra time, in extreme scenario,
> maybe wait for ever.

Agree with Ming that this is not necessarily pressing as this issue
existed in nvme for a long time.

I don't resist to change the locking mechanism, but Ming needs to
provide evidence that this change does not degrade reliability nor
performance. Personally I'd like to see this specific issue solved
first and then do a an infrastructure change.


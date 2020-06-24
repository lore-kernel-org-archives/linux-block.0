Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFDEC433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1EE2082F
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404956AbgFXTDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:03:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39815 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404883AbgFXTDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 15:03:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id z5so1852917pgb.6
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 12:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxnPLwafznlw6uJemM271g2mVdpK3sZFeqy60qOzhic=;
        b=f7hDJejYPcmZQkPWbKw0uHpqtBfEAdKfwTmSfUfOQmT1ioWTJ4bhjZXbUZElGo12wE
         iIGsHw7HyvBug6dizKB+/taE1MP2jHFK86DgNSda3tOhuzqR44Rb+KMhidj1SGOjgCm0
         /+L5GcZpwdsefBrOzQHk5enE13pgb73Hk7jtkFjP7+8TyttEEjEqN5A1x3Q2fvU78ci3
         ffEvYntQ+8Al9/2OqmumvlCAfji7HbgZ5txkjBDO6pFZmN7xijOGGNVdvvH0h0NVfwDe
         SdsYrZVEniUxIfO20TpTi1cFjV5Mr0YcHQXMjtnbFegNBMy95lfW6f3LRzSTWVlc8UCm
         iCqw==
X-Gm-Message-State: AOAM532999TeM9n6n/XBIxTe5B/4tbWFGqTTN24crz99F1fabiXoA+WT
        qvrt6GQMrUw/YPu5ao5cwxA=
X-Google-Smtp-Source: ABdhPJy/Hj214+mQy5P/DMkoPRn1OUvSUd/hKX06vUukopctG/W4/3m3RFpmd44LPrnBmlYJyPLaUg==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr7035532pfn.219.1593025423919;
        Wed, 24 Jun 2020 12:03:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947? ([2601:647:4802:9070:4c08:474f:e61d:6947])
        by smtp.gmail.com with ESMTPSA id 4sm20391425pfn.205.2020.06.24.12.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 12:03:42 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
To:     Keith Busch <kbusch@kernel.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
 <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
Date:   Wed, 24 Jun 2020 12:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> If the controller does not support the CNS value, it may return Invalid
>>>> Field with DNR set. That error currently gets propogated back to
>>>> nvme_init_ns_head(), which then abandons the namespace. Just as the code
>>>> coments say, we had been historically been clearing such errors because
>>>> we have other ways to identify the namespace, but now we're not clearing
>>>> that error.
>>>
>>> I don't understand what you are saying Keith.
>>>
>>> My comment was for this block:
>>> -- 
>>>       if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>>>           dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
>>>                nsid);
>>>           status = -EINVAL;
>>>       }
>>> -- 
>>>
>>> I was saying that !status doesn't necessarily mean success, but it can
>>> also mean that its an retry-able error status (due to transport or
>>> controller). If we see a retry-able error we should still clear the
>>> status so we don't abandon the namespace.
>>>
>>> This for example would achieve that:
> 
> We're not talking about the same thing. I am only talking about what
> introduced the DNR check, from commit 59c7c3caaaf87.
> 
> I know you added it because you want to abort comparing identifiers on a
> rescan when retrieving the identifiers failed. That's fine, but I am
> saying this fails namespace creation in the first place for some types
> of devices that used to succeed.

OK, now I think I understand (thanks for clarifying that the discussion
is not on patch 3/5, but rather on 59c7c3caaaf87).

So the original proposal was to check NVME_SC_HOST_PATH_ERROR (and now
we have NVME_SC_HOST_ABORTED_CMD) but with the review Christoph gave
it seemed to make more sense that we generalize and check the DNR bit.

We could restrict it back to checking the status is
NVME_SC_HOST_PATH_ERROR or NVME_SC_HOST_ABORTED_CMD if you think it
creates problems. However, if we keep the code as is, the original
comment still holds.

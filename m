Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD8C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A130B207C4
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="qyK9J9uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgFPM16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgFPM15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 08:27:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A58DC08C5C2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 05:27:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so20577757wru.6
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=f3FqSsegVWuONp3eG1WkA/5RlLNylVls991uj2lRwqI=;
        b=qyK9J9uQoKsaNt2FGRy0BUP/bfjDIRw0YZp1nruNfgz7pQmEDjNLnahweKf/xLrnZa
         E2qZ94//oAm+qdeYNTp5H0YAH5CwICOoR96qd8JPLrcmS02WzF+o+fgYS9jMkm+MiC57
         f9g18fu0/wqugZ5XpJWc8J5uKNgrKEMuLqnDT3GIcmxf1Z9lE5RM4yHX2MdJ7fJh8gln
         EMKK8oF9MlJiOrc9DRiMXfjfMXJ5rh3Pl3xvr4fOR0hVeVeauxRybulEzDGNx0Glfm0P
         hwHSpuhgnCUhroaUt3yr0Zfght5PmbHNf3vLdSZdy3UDcrqFPqq5IuMZHtCLjTQH2FL8
         8qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f3FqSsegVWuONp3eG1WkA/5RlLNylVls991uj2lRwqI=;
        b=ZzYf+TynpX6UTeWq9IAYf8AB4KS5JAloS/9ixzjkW9PG25UAZIKe8/YjZif9YnN+UI
         jhVXmbtJNMvNPBfqjWR+PrZ4QZJwuuRQNuRgEm6zEQ4R5ct0ttVsnGcfrWKAjzlGIiaP
         n8fK19GAstzEGJyhDeesqIUcwoFuUwTuqayCkVcB9FS2EwYPAkUsDZ6qGSTbQMGj9+6f
         vrQwhD3Nmtv7sty3NoevCVltHxNN/ojLZsZ7eH9t9BPGqvtPY5PJN0CGbzQzE+Xzz7uZ
         Z6q728uCBc2Qg9kNfdmKGMex/tvHCd6PBFL6DUs20+ZGc3PliMm8Jxqza/ruuOv7ebAc
         LNSg==
X-Gm-Message-State: AOAM530M/xOlbQpYUpQdTwSHaaldUsPY6sEO0uLeh0vOFjRi6L2tc3+H
        kDFy9/rCqb85m9PGPmA+AG7TYA==
X-Google-Smtp-Source: ABdhPJxN7epVg3PiMWkO7GDgGTIqnGR7t9+3TLGyUPPj2EK8eXiPAJ0rW5PBN9YTxhs9vmhG0BT79g==
X-Received: by 2002:adf:82d0:: with SMTP id 74mr2701433wrc.138.1592310476204;
        Tue, 16 Jun 2020 05:27:56 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id e25sm4487850wrc.69.2020.06.16.05.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 05:27:55 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0a49ade0-1961-ee21-30b6-de589d7ddd48@lightnvm.io>
Date:   Tue, 16 Jun 2020 14:27:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200616122448.4e3slfghv4cojafq@mpHalley.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16/06/2020 14.24, Javier González wrote:
> On 16.06.2020 14:06, Matias Bjørling wrote:
>> On 16/06/2020 14.00, Javier González wrote:
>>> On 16.06.2020 13:18, Matias Bjørling wrote:
>>>> On 16/06/2020 12.41, Javier González wrote:
>>>>> On 16.06.2020 08:34, Keith Busch wrote:
>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set 
>>>>>> defined
>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based on 
>>>>>> their
>>>>>> Command Set Identifier reported in the namespaces Namespace
>>>>>> Identification Descriptor list. A successfully discovered Zoned
>>>>>> Namespace will be registered with the block layer as a host managed
>>>>>> zoned block device with Zone Append command support. A namespace 
>>>>>> that
>>>>>> does not support append is not supported by the driver.
>>>>>
>>>>> Why are we enforcing the append command? Append is optional on the
>>>>> current ZNS specification, so we should not make this mandatory in 
>>>>> the
>>>>> implementation. See specifics below.
>>>
>>>>
>>>> There is already general support in the kernel for the zone append 
>>>> command. Feel free to submit patches to emulate the support. It is 
>>>> outside the scope of this patchset.
>>>>
>>>
>>> It is fine that the kernel supports append, but the ZNS specification
>>> does not impose the implementation for append, so the driver should not
>>> do that either.
>>>
>>> ZNS SSDs that choose to leave append as a non-implemented optional
>>> command should not rely on emulated SW support, specially when
>>> traditional writes work very fine for a large part of current ZNS use
>>> cases.
>>>
>>> Please, remove this virtual constraint.
>>
>> The Zone Append command is mandatory for zoned block devices. Please 
>> see https://lwn.net/Articles/818709/ for the background.
>
> I do not see anywhere in the block layer that append is mandatory for
> zoned devices. Append is emulated on ZBC, but beyond that there is no
> mandatory bits. Please explain.
>
>> Please submitpatches if you want to have support for ZNS devices that
>> does not implement the Zone Append command. It is outside the scope
>> of this patchset.
>
> That we will.
>
Thanks, appreciate it.

Best, Matias



Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A21ECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 07:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiH3HNS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiH3HNR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 03:13:17 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B8B07D4
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 00:13:15 -0700 (PDT)
Message-ID: <ad345e98-a448-3983-fea8-294bf5558875@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661843593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YNkzH2bAzxIaAdbg5kn+mcBX6u4vJUms8etz8covKk=;
        b=tlQ4JHLcJ7pYci0tO+kD2PMlhwvdPBV55Ei4D1GpPXBbYpDEwHDvBLq95yZbz5HwJ+tfxs
        u8ks49DBvB8iK1uSAeIceJ543m2q9cZaCCy2zcILreRJEvn3oTfJc1A4kHul5dF2Zg1tRP
        cezHFm0o7mMCBw7izE+I2Vki9YnMFRQ=
Date:   Tue, 30 Aug 2022 15:13:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi.

在 2022/8/30 15:05, Sagi Grimberg 写道:
> 
>> Hi Sagi,
>>
>> On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>   tests/nvme/043 | 1 +
>>>   tests/nvme/044 | 1 +
>>>   tests/nvme/045 | 1 +
>>>   3 files changed, 3 insertions(+)
>>>
>>> diff --git a/tests/nvme/043 b/tests/nvme/043
>>> index 381ae755f140..87273e5b414d 100755
>>> --- a/tests/nvme/043
>>> +++ b/tests/nvme/043
>>> @@ -16,6 +16,7 @@ requires() {
>>>       _have_kernel_option NVME_TARGET_AUTH
>>>       _require_nvme_trtype_is_fabrics
>>>       _require_nvme_cli_auth
>>> +    _have_driver dh_generic
>>>   }
>>
>> Do you see failure without this check?
> 
> Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=m).

Maybe I don't understand correctly, but I think when NVME_AUTH=y
CONFIG_CRYPTO_DH can only be built in.

-- 
Jackie Liu

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46FEC0502C
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 07:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiH3HFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiH3HFQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 03:05:16 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785FE56BBE
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 00:05:13 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id k17so5307011wmr.2
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 00:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eNBaPHnxbiQ6yKQoJwWSkcw5860l2H72wMufKuOd9KI=;
        b=1qV/WcUpopKqlLmdvDnYLkpAudAKlXvAwJ0GZl82ucC5pVY1iBBaGqrzM61lJpxvtx
         Y5l43TdKy6fGVshsBNvFIo0w9/2gmkHzgiHFCDQ186Ov2VWmbxOQQsUqNSPfgogMNU+0
         B4Hj7lBvGpiJ1C5BE2/PVZFLEaYemyMdWFJ6iVvchpXKM60tjaM6jolE9Mq5tX0XLcQ3
         2xXgNf0MB+Xc3gnxNpCqhKAuxHxDeGL8XJXSSFOpB5FmUOL2GAc4MfXEwmMBsfH/bt8U
         vRGHM9LgWfF942AY7rx2Z/MGkUkKljvG1Iev6XD1YhTFvRflZuaA2lule7j8sCX15viw
         t0mA==
X-Gm-Message-State: ACgBeo2Lq8iS6Af+zsu3/v3l+2MyIR6mikRYfRV51+ItQ9n7cWsjWtFV
        PvFy7E6nXQUDWGKBHv6FQXA=
X-Google-Smtp-Source: AA6agR6lHUqstw27OUXRK7iEnBGRYQGYcDOzbqhUTllFwM/N9l93JWBOLZqGtYBKU2JBwVjKKjcxew==
X-Received: by 2002:a05:600c:1e08:b0:3a8:39bc:d416 with SMTP id ay8-20020a05600c1e0800b003a839bcd416mr7986143wmb.202.1661843110972;
        Tue, 30 Aug 2022 00:05:10 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d43ce000000b00226d1b81b45sm9778835wrr.27.2022.08.30.00.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:05:10 -0700 (PDT)
Message-ID: <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
Date:   Tue, 30 Aug 2022 10:05:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220830044632.j7k45lhdlyvksrxh@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Sagi,
> 
> On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   tests/nvme/043 | 1 +
>>   tests/nvme/044 | 1 +
>>   tests/nvme/045 | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/tests/nvme/043 b/tests/nvme/043
>> index 381ae755f140..87273e5b414d 100755
>> --- a/tests/nvme/043
>> +++ b/tests/nvme/043
>> @@ -16,6 +16,7 @@ requires() {
>>   	_have_kernel_option NVME_TARGET_AUTH
>>   	_require_nvme_trtype_is_fabrics
>>   	_require_nvme_cli_auth
>> +	_have_driver dh_generic
>>   }
> 
> Do you see failure without this check?

Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=m).

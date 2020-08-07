Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95438C433E1
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A52D20748
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgHGRPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:15:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39930 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGRPa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 13:15:30 -0400
Received: by mail-pj1-f67.google.com with SMTP id f9so1219685pju.4
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 10:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSZBHQoFco6MmpafCg+12XHweWdRqSYtg9yoUgQCrUg=;
        b=YHh7p53U0rYtssmt3phMm7yUW2MdCWrIpJ4X3ZSCd/JBr3pzJhrX1SZppWFVgSATyu
         exB+wS2/01JYV6czyxPGoEts1FxFZYN63BmjKouK3CL/izX4xAEtC/4GnlDefCR670J6
         JpFo5IDUMY4YzlzWPb8esE/FgeS5hnloxDa+8MDoE30mNYpFZt+h+2ng9AqQORbALIIZ
         e/VIhznIJeNSnfSuj+MbzFHu436t6S4NhhrqLsTEgRThORTIkd1wJiTw6XX1jMBLygvc
         X1E2ca4qSaFNXOOS3mV92xp0eu8M/g9J7Sct7JUH+XrWY3/96No164N9xN06REg4slaW
         K/pA==
X-Gm-Message-State: AOAM5332WQIyOrIzfkZ/CgzAvx+FMOCcDGNMSpExVNh+IKX2fsrEDCiB
        NcOo0Do8LSXfH5jdZ2WYgao7OIip23U=
X-Google-Smtp-Source: ABdhPJy+qRGV6XhNzN6gEhQjVDuBmpBPKZ932w255Rjai0n+mHLkIEbLpMaEvWyzlivpILe2zwzo1Q==
X-Received: by 2002:a17:90a:f416:: with SMTP id ch22mr14300270pjb.232.1596820529424;
        Fri, 07 Aug 2020 10:15:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c? ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
        by smtp.gmail.com with ESMTPSA id g10sm13440948pfb.82.2020.08.07.10.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 10:15:28 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-3-sagi@grimberg.me>
 <BYAPR04MB49654E81437918F224CDD26486490@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aef21d09-e31a-de7a-54dc-974c0d65756d@grimberg.me>
Date:   Fri, 7 Aug 2020 10:15:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654E81437918F224CDD26486490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/6/20 7:53 PM, Chaitanya Kulkarni wrote:
> On 8/6/20 12:15, Sagi Grimberg wrote:
>>    
>> @@ -97,6 +97,33 @@ _setup_nvmet() {
>>    	modprobe nvme-loop
>>    }
>>    
>> +_nvme_disconnect_ctrl() {
>> +	local ctrl="$1"
>> +
>> +	nvme disconnect -d ${ctrl}
>> +}
>> +
>> +_nvme_disconnect_subsys() {
>> +	local subsysnqn="$1"
>> +
>> +	nvme disconnect -n ${subsysnqn}
>> +}
>> +
>> +_nvme_connect_subsys() {
>> +	local trtype="$1"
>> +	local subsysnqn="$2"
>> +
>> +	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
>> +	eval $cmd
>> +}
>> +
>> +_nvme_discover() {
>> +	local trtype="$1"
>> +
>> +	cmd="nvme discover -t ${trtype}"
>> +	eval $cmd
>> +}
>> +
>>    _create_nvmet_port() {
>>    	local trtype="$1"
>>    
>> @@ -206,6 +233,6 @@ _filter_discovery() {
>>    }
>>    
>>    _discovery_genctr() {
>> -	nvme discover -t loop |
>> +	_nvme_discover "loop" |
>>    		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>>    }
>> -- 2.25.1
> 
> I'm okay with having a wrapper for disconnect but for connect and
> discover command it can have many arguments having a call in the
> test-case might loose the readability.

That's why these has default values.

> The downside is it will need argument count handling in the future
> and makes things not easier when user want to skip certain
> parameters, closest example would be _create_nvmet_ns().
> 
> Also if we are adding wrappers why not move $FULL 2>&1 to avoid
> duplication ?

Not exactly sure what you meant

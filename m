Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6DFC433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9805A2086A
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGROH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:14:07 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38318 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGROG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 13:14:06 -0400
Received: by mail-pj1-f68.google.com with SMTP id ep8so1218697pjb.3
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 10:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WDhvBaZrJnJ4jgZQWWfHB6fNmDXA5JZyzuuiZ8iUSA=;
        b=Quc2GPdkqN/5VJE3khGDbUbmR7931XHFeTrLj0acXOMiGfIl9+lygDisld1A954drj
         AEcnwgXCN0vt9q5xJzEhho3IvmQdNJbUSJkoU5xSX/dJh9JW95ETBJgR1jAJAv1vrv9e
         +Umcg+3eq61STnNpynOXSoBHKJnNdXsqTBKx1uIk1y8PTKXX1nDwMZPEAjahkqO/slCm
         Y5BaQjsgO5wLioc3YDsr879aC+wJk0SlxMll2EppYztBSWpcacEO5z6Ht1YBw1AW49sw
         phRFfmln6UkZhHZJWaZ0kio2EnoGeY6XapIYmBLPWstSM+uBa0fvto5cuDFJ2N6nNdGV
         lItw==
X-Gm-Message-State: AOAM533XFG3fw4Twdz+RcE+cLZ+NWxrEaNJiSnU3tS9hJLJ3LogalRTc
        q3Fvr/+/zkgzfb/UIT5ZX3E=
X-Google-Smtp-Source: ABdhPJxYPYSslV5v0zGDZQCpWSXYntqtbLvPD6nyyOEVMwCjiIr2opMeO0cz2oIrCMcQaQk65/7Xog==
X-Received: by 2002:a17:902:a611:: with SMTP id u17mr13596173plq.263.1596820445697;
        Fri, 07 Aug 2020 10:14:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c? ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
        by smtp.gmail.com with ESMTPSA id s1sm5660681pgh.47.2020.08.07.10.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 10:14:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] nvme: consolidate nvme requirements based on
 transport type
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-2-sagi@grimberg.me>
 <BYAPR04MB496546CB79B5F7D4F4B0A54186490@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fc11798d-52aa-01b0-8289-f6e76659e564@grimberg.me>
Date:   Fri, 7 Aug 2020 10:14:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496546CB79B5F7D4F4B0A54186490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index 6ffa971b4308..320aa4b2b475 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -6,6 +6,25 @@
>>    
>>    . common/rc
>>    
>> +nvme_trtype=${nvme_trtype:-"loop"}
>> +
>> +_nvme_requires() {
>> +	_have_program nvme
>> +	case ${nvme_trtype} in
>> +	loop)
>> +		_have_modules nvmet nvme-core nvme-loop
>> +		_have_configfs
> We should just move nvmet nvme-core configfs _have_nvme_fabrics_common
> which are common for all the transports to avoid the duplication.

That's a minor duplication, not sure it warrants consolidation...

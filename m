Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94588C433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759DF20748
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 23:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHGXq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:46:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45582 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHGXq2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 19:46:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id f193so1946016pfa.12
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 16:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANban76DzY8YtDad9UPwri3M9KHoqBxXkK+LfTFEkHw=;
        b=K30H2/eWKlHwQ1MkDm1csINcSIhe+vQjo/20HZP3HHoVzvVEbgLgWIkDWGlhCh8VAG
         kr3m0RHWqan+NGN2WyAvbCSwqEdBVOOgECciPOosfk7Rsm3VyKkUrecPOQUs7XnqZf26
         0ukFgXKM6pCnkOxa4IylOPo2ttRWyxsBFEiKLg9Y63cwr9mQYIG0XK5KOlxhZFkEJ9dX
         zHQpic0ull5i2JxJwCtcFZpuUBRWVDjWseTaN4bcMmDSYA/4cjEvCstRkqQdrPKDnCvv
         W55juEFhe0IT7/ivEWQAdQnkDXQWcDGLaqQHcplsrSUC3NU5ycr1NKJmOLgShTNeg+lb
         cDhA==
X-Gm-Message-State: AOAM530g93HbpU8Fe5wL5rVCXRK5NzuWhFl1ExI2jwLyst9To0yAX/r4
        aLQ/r77puHpOsg5q2yZIRaY=
X-Google-Smtp-Source: ABdhPJxGk8DzDCI2jMfpFfN2PpZDpXywuEjdmyN3VN9gaiXej1l879LV58XYz9SgrrcDDG7eFXK9MQ==
X-Received: by 2002:aa7:8c09:: with SMTP id c9mr15896625pfd.157.1596843987604;
        Fri, 07 Aug 2020 16:46:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c? ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
        by smtp.gmail.com with ESMTPSA id v11sm11910347pgs.22.2020.08.07.16.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 16:46:26 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] nvme: support nvme-tcp when runinng tests
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-6-sagi@grimberg.me>
 <BYAPR04MB496517FF9B9E262ACD555A2686490@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bd794263-02d2-a723-44de-3a9f63723275@grimberg.me>
Date:   Fri, 7 Aug 2020 16:46:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496517FF9B9E262ACD555A2686490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +	tcp)
>> +		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
>> +		_have_configfs
>> +		;;
>>    	
> Same as previous nvme-core nvmet configfs can use a helper.

So for every trtype instead of having:

	_have_modules nvmet nvme-core <trtype specific>
	_have_configfs

You will have:
	_have_nvme_fabrics_common
	_have_modules <trtype specific>

Don't see it as an improvement...

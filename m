Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AFAC433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D613922CA1
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHGRVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:21:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40708 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHGRVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 13:21:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id h12so1225784pgm.7
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 10:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQI2EkcJh8fFvaX7MS/0gUqNIelTRPuoK+JO7BBcGSU=;
        b=royajrFE36KEJeiic1VkXP7X8ywwBqKAicHxD8Gm4FO9deQK8Y54nx4aGx1+WnKlSf
         2ZyE98FIsgEBDh74uYM+Myvgs7i23qpnTukvLjUxX85TuZGuQ5QZupXMkyz5jeHTfcWI
         67717CQcicG8WrsdFEiZ0HyadIcew3p2pePw/21znn6RcNzIlUWi6/hmf0ES7rhiq4ps
         P6J3HVfrb98gxrKdNA2yfx1qNtzFNLOHF1jXLzZ8ycG37Y3bHy1CW2WgruN1W/f1sxeq
         FMkPNUVffmIWfWGuVlTBVR5CPnR3YWf75qHet0pDh/FTzt2N/u3iGyN1hVzgZ6SJf56t
         YytA==
X-Gm-Message-State: AOAM531AVKrTlm21ZMep8MnpzPdD1uKWMlKvUWdATTCCjoT5noAgTlEY
        Vgj8dFrouAeKHaDJlfbFkkY=
X-Google-Smtp-Source: ABdhPJz6cFtiHQztotSPH8HxyFZiudQaQ0ovLBrRlG/pQ0O38BBoNQ8J116IMfAN5ojDfP0VOBR0Og==
X-Received: by 2002:a63:9dcd:: with SMTP id i196mr12139102pgd.378.1596820864267;
        Fri, 07 Aug 2020 10:21:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c? ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
        by smtp.gmail.com with ESMTPSA id a5sm13471705pfi.79.2020.08.07.10.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 10:21:03 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] tests/nvme: restrict tests to specific transports
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-5-sagi@grimberg.me>
 <BYAPR04MB4965E3767211F0CD3DF7CAF186490@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <abb2246d-9096-d491-5d00-5212e4e29769@grimberg.me>
Date:   Fri, 7 Aug 2020 10:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E3767211F0CD3DF7CAF186490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +_require_nvme_trtype_is_loop() {
>> +	if [[ "${nvme_trtype}" != "loop" ]]; then
>> +		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
>> +		return 1
>> +	fi
>> +	return 0
>> +}
>> +
>> +_require_nvme_trtype_not_pci() {
>> +	if [[ "${nvme_trtype}" == "pci" ]]; then
>> +		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
>> +		return 1
>> +	fi
>> +	return 0
>> +}
>> +
> how about instead of not_pci  if we can requires_nvme_trtype_fabrics ->
> returns true for loop/rdma/tcp etc ?
> 
> It is a same thing, just my preference to void not.

Fine with that.

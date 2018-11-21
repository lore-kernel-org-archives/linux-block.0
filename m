Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21357C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 05:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E949621104
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 05:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E949621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeKUQQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:16:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43176 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUQQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 11:16:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so3805620plb.10;
        Tue, 20 Nov 2018 21:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A2FO0EHOFwCqdoxeUWoI8cmVOAVNOGuVaIEk5Qt7cJQ=;
        b=LJSkomH6lUkHbmdaG/nUJV18aVfAzayykssR//9kea0KMvviIkLQcb/cQWk++yIP26
         3qxy5D/MJLrQCAKxrI8juDoWPOrdCC9bcetcuhJV9koAy6NvWyO7+lJv/NxSXwnzy+6K
         mw2WD5c9AeHjjClwcD1oHuJZhc7JPQT0ZiMZNOk5+HUQsML7v85/3ySiSunjMGh5N0Ab
         EhPmTQCeHMjReGK+m9vGDkrurS+McdjYd0s0KHtDQDltPG5DKjL2Ev09cvKIHZqGyzPf
         ED8hsgwWZZeDyQdlWr8SnZu9hiq/w7TACfIyIfk4+kohKL8ya1TsGUeMjU+9W8PoAvEf
         z42w==
X-Gm-Message-State: AGRZ1gJzzauWjR2q6ONacoSkl7NJdDP91EivooN3ydKPYhbLOPe9T+5s
        R7wLtbBIoN2zO0Mue0dbrXI=
X-Google-Smtp-Source: AJdET5e7uWXH4sbAieWzPw6rFcKe50BW37Dt422Ogvwzt4qYfLuu/FrUthnpHTVqqIAv5gyj1xxRdQ==
X-Received: by 2002:a62:ed09:: with SMTP id u9-v6mr5275330pfh.188.1542779028783;
        Tue, 20 Nov 2018 21:43:48 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:8a0:7611:3223:f4db? ([2601:647:4800:973f:8a0:7611:3223:f4db])
        by smtp.gmail.com with ESMTPSA id q8-v6sm88606814pfa.18.2018.11.20.21.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 21:43:48 -0800 (PST)
Subject: Re: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
To:     Ethan Weidman <ethan.weidman@kazan-networks.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
 <CY4PR08MB258265FB085A9C26B6F27D93CFDA0@CY4PR08MB2582.namprd08.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f947a8e0-9e88-2264-e771-11eabe735807@grimberg.me>
Date:   Tue, 20 Nov 2018 21:43:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CY4PR08MB258265FB085A9C26B6F27D93CFDA0@CY4PR08MB2582.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> NVME_TCP_DISC_PORT, 8009, should not be the default for nvme fabric connections when trsvcid is not specified.

Its allowed, the statement simply does not recommend it as a possible
misuse in an environment where iWARP and TCP are deployed on the same
port spaces...

And, it recommends that subsystems don't listen on the 8009 by default,
not anything about a host. Furthermore, usually controllers that are not
passed with a default port are discovery controllers anyways.

> NVME_RDMA_IP_PORT, 4420, should be used, or renamed to something more generic.

Not at all... in fact, this is really not what the spec is intending.

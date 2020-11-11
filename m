Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A104CC388F7
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 01:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56538216C4
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 01:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgKKBlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:41:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34198 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbgKKBlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 20:41:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id w6so592170pfu.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 17:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xlHvNWa4yPPWg+JCLfaBgBaYnaHb/EDR8S1yfsdthVI=;
        b=r/oLwWmY+knV1CTcJjSd+uiLtEAZU7bqHjk7ueOxKRkZuimGJMbKmYFYll1z6cESN5
         52pXcWWrRHbEa41Xce+Yr+hoQUBhZbKEjpkweyiCCNTjcO3ohvJP+k5XJRWBH8VL5OBL
         /H7HC5D5BnMwplnpeG6QDvkrjut1lbYyJhoKQul1xypcuBdHDYVIDJZkq4TutMWRI2TE
         anm/iEggFdUfdl9UU7pW9bc3dcFxw4VLBf50kLhJn1IQKUkgWRfFFepbsK6XSrD7fqxB
         D1ODIbHL3od9RwN4YHA9CU1BHe04FvcnhLL3dCV5oiyFXgtRg3WBBYx7VVWs1n9Jmy2p
         RjlQ==
X-Gm-Message-State: AOAM532NSJsg9jgIc4DxIvL47qP+KGbJhp8auzTqXEjyv8odm7wu1u0J
        9tMoL/yE3fxDs+y0j2NKLYA=
X-Google-Smtp-Source: ABdhPJzysruYkddhFxxLZHPQAlV3Si3fxM8NYhaHMKeV6NohtwI9UgFNvguQCuWfLfyOUoeKJR+A9g==
X-Received: by 2002:a05:6a00:134d:b029:18b:2cde:d747 with SMTP id k13-20020a056a00134db029018b2cded747mr19956640pfu.60.1605058878583;
        Tue, 10 Nov 2020 17:41:18 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:47ee:2018:3e3c:f9be? ([2601:647:4802:9070:47ee:2018:3e3c:f9be])
        by smtp.gmail.com with ESMTPSA id s5sm358489pfh.164.2020.11.10.17.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 17:41:17 -0800 (PST)
Subject: Re: [PATCH V3] nvme: enable ro namespace for ZNS without append
To:     Keith Busch <kbusch@kernel.org>, javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>
References: <20201110210708.5912-1-javier@samsung.com>
 <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
Date:   Tue, 10 Nov 2020 17:41:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>> +	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>   		set_disk_ro(disk, true);
> 
> If the FORCE_RO flag is set, the disk is set to read-only. If that flag
> is later cleared, nothing clears the disk's read-only setting.

Yea, that is true also for the non-force case, but before it broke
BLKROSET so I reverted that. We can use this FORCE_RO for BLKROSET as
well I think...

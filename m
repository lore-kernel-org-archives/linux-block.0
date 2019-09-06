Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61F1C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DF720838
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404457AbfIFSYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:24:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43603 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404380AbfIFSYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 14:24:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id t84so5733411oih.10
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 11:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=roLUFRdkVas8gGkywiuk4zGdrYFAnmHTNze64GidaUo=;
        b=oErzKa0bYh4i3NXsXhXgCSQw7RoDfID8UIF3kaLnq+1eqveo4FuLaA0AeRfwhUKAiz
         mrR+zCfsGkFkQzbPRY3dh39OFWDPZvLhAZknN5h+u0j2epqb1P2zYrPE3O0uipIqm9Vx
         yf3H1QBKAk3CNwY4ZY8sNZplJpZc6fOSVQs/z5BFe+tUk9+gAJaKLfpURupwbpq3H+zt
         0qyDVFT1ONiI2wsld3YcXRP3GO6G/yITt1a6WwbYIGU0FJqVqiSNMcXvxK/VywRcrdAm
         4t8xvlEWUBKq5z8CPf5BriNfgXk4LS+DgWSxSSoWS4aApxo+pWjnGMIQ1uXROvwXRC+B
         JdGg==
X-Gm-Message-State: APjAAAUKszkZfYOQ7UpgChXBaSOUZaQoBTEzkdYPG/bRkI9Vb8f8gDcJ
        TdQgE82jXcamD0UpuzCL5+0=
X-Google-Smtp-Source: APXvYqxpm1bC1p1Yiaqad3NvGFS+m+RWQsFCjsVuZIg/5uxynLKPjGDRhuXDR4uXOSFB6Sz46ZBwFw==
X-Received: by 2002:aca:cc0b:: with SMTP id c11mr7951111oig.169.1567794282454;
        Fri, 06 Sep 2019 11:24:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id j3sm2133733oih.52.2019.09.06.11.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 11:24:41 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: remove PI values definition from NVMe subsystem
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, keith.busch@intel.com, martin.petersen@oracle.com,
        israelr@mellanox.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, shlomin@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
 <1567701836-29725-3-git-send-email-maxg@mellanox.com>
 <882441fc-599a-21fb-9030-5208b3b671cc@grimberg.me>
 <20190906052334.GA1382@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6d28d72e-6afd-d6d8-5c8b-831587c44557@grimberg.me>
Date:   Fri, 6 Sep 2019 11:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906052334.GA1382@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> The nvme_setup_rw is fine, but nvme_init_integrity gets values from
>> the controller id structure so I think it will be better to stick with
>> the enums that are referenced in the spec (even if they happen to match
>> the block layer values).
> 
> These values aren't really block layer values, but from the SCSI spec,
> which NVMe references.  So I think this is fine, but if it is a little
> confusion we'll have to add a comment.

Yes, at least for patch #2 where we set the disk->protection_type we
need to explain that the dps match t10 in the type definitions.

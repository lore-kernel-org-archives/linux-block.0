Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 19:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbiCNT5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbiCNT5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 15:57:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F11117B
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 12:55:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h15so25737008wrc.6
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 12:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2Hk3B55ZqkeAB3AADrQYItrSmT5x8nVHCaq2sovky6w=;
        b=oqHAJyqH40KbnVUZYh8YWeQz2EHXN0lf9GsjikkHW0/PdLytLdNUbbiNmdaItLokoA
         iI9aXSLoO0EC3N8pYtgX9abm20lSDhFItHZo4FUBzezeNlUo+Day+DTQRrMI2Zb58r/4
         vNhV4dDfL3k4Y0tX9PZMYJiNocWIl9X7yjfafiefA4pEQaIaq0b0ZRfOh+dOIKKAWGgR
         drWVFzSukmhwDqsMtn5JhbY3HbL6hCeItNJW6W55VLXb/D8Py++wdR/whcpY9Z3BZk/+
         3ZH9IFCiD1BSyerxNntVE3yryw6fBAS2y4ygkPHB7bqw6tHFBGLevYCsV9I/aBsBaBwV
         wwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2Hk3B55ZqkeAB3AADrQYItrSmT5x8nVHCaq2sovky6w=;
        b=Ra3nCQz71HBfH+ULDLnGToRxzZ8JoYlqCHNPH1Ag16nJsI8V429I9OtIgRtJJVTXU+
         B1arnMXqOHlyYoKTZY9vFgao4vhqqM4JczAF6v+E0zrA+u0DXBcW/hBYYUooWni7XHit
         rCSas1AIq2OheQwnN7yr/4xDsqAznsbiWkEsF0+9I53dVXmwC5IHwlUI536HABq0TbvG
         Q1VE52tMyV3hWHnvlnhbzWh97d/IdTrcU0IYv2GUb1k6tZEVweuOlQkwob48wCTsohWm
         55W2zJBGVTr966RIyxQPN4xCaxFKuWZFciGJM3+YnIUNiSOaselUL2c49cQ4x+k8xDoy
         IaqA==
X-Gm-Message-State: AOAM532AdDzEQTcrnN52IwLa1hyWxUlwup2OF9sr0KHeyI+cPGPFddAu
        winaxe30wx6GpQlEqczt/DFnIQ==
X-Google-Smtp-Source: ABdhPJw/dNd3SM6HQqoRh/j2Cu426pE5a5vSXgfYJsX3tJtfqwKBUg1b/9Wa6kRaNBQKA2hWYgdnVQ==
X-Received: by 2002:adf:e746:0:b0:1ef:8476:dab3 with SMTP id c6-20020adfe746000000b001ef8476dab3mr18077872wrn.449.1647287752873;
        Mon, 14 Mar 2022 12:55:52 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm14072789wrl.95.2022.03.14.12.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 12:55:52 -0700 (PDT)
Date:   Mon, 14 Mar 2022 20:55:51 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
References: <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14.03.2022 14:16, Matias Bjørling wrote:
>> >> Agreed. Supporting non-power of two sizes in the block layer is
>> >> fairly easy as shown by some of the patches seens in this series.
>> >> Supporting them properly in the whole ecosystem is not trivial and
>> >> will create a long-term burden.  We could do that, but we'd rather
>> >> have a really good reason for it, and right now I don't see that.
>>
>> I think that Bo's use-case is an example of a major upstream Linux host that is
>> struggling with unmmapped LBAs. Can we focus on this use-case and the parts
>> that we are missing to support Bytedance?
>
>Any application that uses zoned storage devices would have to manage
>unmapped LBAs due to the potential of zones being/becoming offline (no
>reads/writes allowed). Eliminating the difference between zone cap and
>zone size will not remove this requirement, and holes will continue to
>exist. Furthermore, writing to LBAs across zones is not allowed by the
>specification and must also be managed.
>
>Given the above, applications have to be conscious of zones in general and work within their boundaries. I don't understand how applications can work without having per-zone knowledge. An application would have to know about zones and their writeable capacity. To decide where and how data is written, an application must manage writing across zones, specific offline zones, and (currently) its writeable capacity. I.e., knowledge about zones and holes is required for writing to zoned devices and isn't eliminated by removing the PO2 zone size requirement.

Supporting offlines zones is optional in the ZNS spec? We are not
considering supporting this in the host. This will be handled by the
device for exactly maintaining the SW stack simpler.
>
>For years, the PO2 requirement has been known in the Linux community and by the ZNS SSD vendors. Some SSD implementors have chosen not to support PO2 zone sizes, which is a perfectly valid decision. But its implementors knowingly did that while knowing that the Linux kernel didn't support it.
>
>I want to turn the argument around to see it from the kernel developer's point of view. They have communicated the PO2 requirement clearly, there's good precedence working with PO2 zone sizes, and at last, holes can't be avoided and are part of the overall design of zoned storage devices. So why should the kernel developer's take on the long-term maintenance burden of NPO2 zone sizes?

You have a good point, and that is the question we need to help answer.
As I see it, requirements evolve and the kernel changes with it as long
as there are active upstream users for it.

The main constraint for PO2 is removed in the block layer, we have Linux
hosts stating that unmapped LBAs are a problem, and we have HW
supporting size=capacity.

I would be happy to hear what else you would like to see for this to be
of use to the kernel community.


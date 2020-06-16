Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB55C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A855207C4
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 15:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="iCqIeop8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbgFPPzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPPz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 11:55:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07685C061573
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 08:55:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x93so14646627ede.9
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xEs6l5YYTY7vWmlgrA4jKAEGGbn+MWtaOcxgiTkeLQk=;
        b=iCqIeop8uWupJGMennpOIzPf38n3kpEQx4Mey9ypwVY8qEGCONkA3fUDrjiuAljUI6
         ufdFa5vVM2k8tiOyiKnxyMgiKRBJdFlsuCq9E//zPkFh1D9gNYpfidValanJwfKV/moe
         OZT+7vfQTcMfveiiBpbiN2DqiI7JTWa2wPTz4AFF5W2Qvx10SLXVoeBRKcfZYaWIwFbt
         Jd6s6FmvnVpteDtP8DDHXLsApxezLl5gJCSzoGIM/CsirGAbX/UxTCshksQnjaCNHRYl
         k7gD4V0BJiYg5fK9z1O8xd6yF7p7ANQoEuhWTbTZKe8TUFp7fPiWXo8byLJta4Cjyvpi
         5Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xEs6l5YYTY7vWmlgrA4jKAEGGbn+MWtaOcxgiTkeLQk=;
        b=JzbnogyMNV09CsXmBXB/GJqWRhfFGvtA4S4jWqNvrePT/4sWmtQ+5O+vL0zxnujP1c
         xZf6hNACTh92VY2dhElcsVAiARRDgVTOOFhm8S1SKVuNL7LvR4Lw7v2pHNbU6uNqDNFe
         Zarc2YZKplst8abU+lku+1BycbNfpM6lyTWaqB5lA0/eeGO3pyDXV1CHbSKgplP+T7By
         Dh9lF8hK0Px6U1rYYlHyTO99m5hfWSsYrSxbvZfpXOgHi9hYLfshxPAolBDpOo+Xts/+
         6jv6bnjbhzRlUYdKA2qE1SDR+mf/BEJoP+b3nmaxHJCWaA8WZHMZIcI/+O8lyYd6JZ8j
         ioUA==
X-Gm-Message-State: AOAM533xGkd2ZTlp4ugd+uYIbpARiZd5fcXaLej2vK53punMfrnPaBrv
        TtjiEHXiTwXyaMZ/fyHtFnB0eQ==
X-Google-Smtp-Source: ABdhPJwCU0HhktxdeeAYE7dZV8sNul0cD22hMf98on+8qLbGFxigdQeQ0A6QzgR5omVM8s0X5pYJFg==
X-Received: by 2002:a05:6402:cbc:: with SMTP id cn28mr3266688edb.220.1592322927768;
        Tue, 16 Jun 2020 08:55:27 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id b26sm11283494eju.6.2020.06.16.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 08:55:27 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:55:26 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.06.2020 08:48, Keith Busch wrote:
>On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier González wrote:
>> This depends very much on how the FS / application is managing
>> stripping. At the moment our main use case is enabling user-space
>> applications submitting I/Os to raw ZNS devices through the kernel.
>>
>> Can we enable this use case to start with?
>
>I think this already provides that. You can set the nsid value to
>whatever you want in the passthrough interface, so a namespace block
>device is not required to issue I/O to a ZNS namespace from user space.

Mmmmm. Problem now is that the check on the nvme driver prevents the ZNS
namespace from being initialized. Am I missing something?

Thanks,
Javier

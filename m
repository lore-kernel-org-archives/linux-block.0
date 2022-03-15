Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED91BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 13:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiCONyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348837AbiCONyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 09:54:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F02191
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 06:52:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r131-20020a1c4489000000b0038c2c33d8f3so79258wma.4
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KdshR93Nhoyes2FUQEsrqe/ka5wjtTCfmc9HxxpJuUo=;
        b=vipbPZ0CqNdXy0Ve0LL+7W05Rk9DaoBFYbdws8gHtB9I9xi2b2hfZcbnSIyeZWhkf6
         +7yLbLmz6H+O+rIazdC7YTF0xjbpDjvgKdArEPRMSJBMQDK3RTu0oNRjF4qaMGBzTYGW
         oRNKWdW77hS8nkyXyK4e5xMr5BqIR8+WdXZgLmVFJn7snYwu83JzIkmv7E+3IUTjsn5V
         UAclxluy1sxS9bBK5K3Ws0pE1+/m/w5ifQ2cm+qiCPf7CAiLJwiQw1udn8qz4uegNCFx
         oxJyvYP7AXmGN++rw19WRzZxipDg3h48fUCCES3JvOngz4lW4KicrCbYAaSn0rj3cUL5
         mamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KdshR93Nhoyes2FUQEsrqe/ka5wjtTCfmc9HxxpJuUo=;
        b=dW32WKDiAdvNi89RWrMIbZSN2sFKv/9YrUG2vjEEvML6ZvigPE8JCuc3aU+Ohk33tQ
         vOkh9EZ6K3BJDgI2MB61Itw+lyYTutTgRBMN8U41GLBIjEVLB4zspX5vmqSv01/r/1GM
         PFM9pun2zpQV4f7OpfdsfVjMC57ufDaXORhgBs0yrnWnX6FbZx4iJNiOULa7dIyBTzwX
         /c1+syxWmJoOhBFoGTFt/6NBgg4ujNl71VnDG1y6CoaJA1LcZ09LDbAZVjcaQCQC79y4
         Gb9wsUQAM+Ydp/YZyFwQp3T3o2Tqg6sQcU7GSbzFp3suM0ob0/YJyG2rlW9S/YwZbVE5
         f4NA==
X-Gm-Message-State: AOAM533+P8hINGMk78CI2ZxezqrCi4rvjmT5CAYabn6v92Uwby1Sa5Uz
        BQGm42jR4UxjOCe7NeNlpu4kd6q7SC+HEKzOQao=
X-Google-Smtp-Source: ABdhPJz71VHfZp7McCWbA6R8ulBsi7JHktSjZWsfHY6SMEPVsLq1rLCl/vp//5kreHGLWvL96enSjQ==
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr3437244wmc.146.1647352366893;
        Tue, 15 Mar 2022 06:52:46 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d548c000000b001f1f99e7792sm15419652wrv.111.2022.03.15.06.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 06:52:46 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:52:45 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
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
Message-ID: <20220315135245.eqf4tqngxxb7ymqa@unifi>
References: <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315133052.GA12593@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.03.2022 14:30, Christoph Hellwig wrote:
>On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
>> but we do not see a usage for ZNS in F2FS, as it is a mobile
>> file-system. As other interfaces arrive, this work will become natural.
>>
>> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
>> still do the work in phases to make sure we have enough early feedback
>> from the community.
>>
>> Since this thread has been very active, I will wait some time for
>> Christoph and others to catch up before we start sending code.
>
>Can someone summarize where we stand?  Between the lack of quoting
>from hell and overly long lines from corporate mail clients I've
>mostly stopped reading this thread because it takes too much effort
>actually extract the information.

Let me give it a try:

  - PO2 emulation in NVMe is a no-go. Drop this.

  - The arguments against supporting PO2 are:
      - It makes ZNS depart from a SMR assumption of PO2 zone sizes. This
        can create confusion for users of both SMR and ZNS

      - Existing applications assume PO2 zone sizes, and probably do
        optimizations for these. These applications, if wanting to use
        ZNS will have to change the calculations

      - There is a fear for performance regressions.

      - It adds more work to you and other maintainers

  - The arguments in favour of PO2 are:
      - Unmapped LBAs create holes that applications need to deal with.
        This affects mapping and performance due to splits. Bo explained
        this in a thread from Bytedance's perspective.  I explained in an
        answer to Matias how we are not letting zones transition to
        offline in order to simplify the host stack. Not sure if this is
        something we want to bring to NVMe.

      - As ZNS adds more features and other protocols add support for
        zoned devices we will have more use-cases for the zoned block
        device. We will have to deal with these fragmentation at some
        point.

      - This is used in production workloads in Linux hosts. I would
        advocate for this not being off-tree as it will be a headache for
        all in the future.

  - If you agree that removing PO2 is an option, we can do the following:
      - Remove the constraint in the block layer and add ZoneFS support
        in a first patch.

      - Add btrfs support in a later patch

      - Make changes to tools once merged

Hope I have collected all points of view in such a short format.

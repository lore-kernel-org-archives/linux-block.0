Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72025C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 13:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiF3NKW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiF3NKV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 09:10:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E722BCE
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 06:10:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so2801445pjb.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G4bLlDbGum0qb3IbsWjcup0EsY9KhuiCtpjJmTBamCs=;
        b=ZVvAl4tpb2fSc6YkelD54V0gMKmTtvxa7vCPkoTXLZB8QWMEwJebi1KLcbpkkACTyX
         fPQ1gH1iw7sEGgOKZSBNfJJEpIl2JM/Z6IGZTkZCasIzN9UrVTtnhvJmAKmYZTBBSqob
         q94D6DOJpZcOYDTktGGzsn1bbQUTiJnCToKDDE4lSydRK7a5vmm/HxGQTFMjuNUyxnlu
         05k3SYnqTji/0ukl+Z5FcHvaEvWcSLXM9NSPmljBaxO7/w9peh9EK3r9OAXJyyl3bGpU
         dktstq7ehOiKJQ22gHW2wKpk99kcVzb6TM50C5PToHv6/KdEJbfDvpCQ05pudCg/tVIL
         Iz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G4bLlDbGum0qb3IbsWjcup0EsY9KhuiCtpjJmTBamCs=;
        b=eWJa/Kr6uFPt7nnryuzgj+326ncTnB7fdkBLxJPieeHx/sop4sno6v2QhsIKyDGghY
         +Gl96o1JoE4LEC7qJVl+7TJrn5YFSP4FYpFZNlip1Vi+a12e3P1ATsBDcroQSNozZ0mW
         17WUtRQZrdCxok74M0DZozaV+ch0dTyip4jQGbx81F3QcoHKMB5eg/tImNrpZn3tfbhb
         +BMgcYBSbiIRtLhn1EX+UFazbLla6P4R+n5l2EF7Nwq5K3MufqMXsKf/eIxstpDEcY4c
         uZG74vETLOPU6ukYPEe5xVC7cfk6+ct6ArSd1kpBklcXyKC95NmUusgmvwDME3H21UHt
         bI9Q==
X-Gm-Message-State: AJIora+IzoQ463b9eq066cmSTKNYv8i28nm+cmCTUQEQZ/TKVj9BJXv/
        GbrdSa4HLLaJ6EywTeOgvkCU6A==
X-Google-Smtp-Source: AGRyM1tobyytABbKIJoPSwwfqrpszougg0VkfWQ3lfNaLzQLQO9ET5B5PhZFxXp7AsaFZqwzdwQcNw==
X-Received: by 2002:a17:902:e888:b0:16a:1b3d:aac4 with SMTP id w8-20020a170902e88800b0016a1b3daac4mr15788906plg.80.1656594616335;
        Thu, 30 Jun 2022 06:10:16 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c18-20020a621c12000000b0051bbd79fc9csm13544285pfc.57.2022.06.30.06.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 06:10:15 -0700 (PDT)
Message-ID: <a0e96da3-bc4a-3714-c186-2fcfb1fb8bcc@kernel.dk>
Date:   Thu, 30 Jun 2022 07:10:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/2] blk-cgroup: duplicated code refactor
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, tj@kernel.org, jack@suse.cz,
        hch@lst.de
Cc:     linux-block@vger.kernel.org
References: <20220629070917.3113016-1-yanaijie@huawei.com>
 <2ba24ea6-df8f-3afb-1526-bfb5916f2fcf@kernel.dk>
 <da262064-3952-0ded-03e3-9c0246960603@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <da262064-3952-0ded-03e3-9c0246960603@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 2:16 AM, John Garry wrote:
> On 29/06/2022 18:09, Jens Axboe wrote:
>> Like I told Yu, stop using the huawei email until your MTA
>> misconfiguration issues are fixed. They end up in spam and risk getting
>> lost. This series was one of them.
> 
> Hi Jens,
> 
> Just wondering - are there any of my mails in your spam folder?

Don't recall seeing any of yours in spam.

-- 
Jens Axboe


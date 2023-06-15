Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A85EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 07:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbjFOHLz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242925AbjFOHLV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 03:11:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24FC26BE;
        Thu, 15 Jun 2023 00:09:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso5770875b3a.3;
        Thu, 15 Jun 2023 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686812978; x=1689404978;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7NJbOl1aaGyCKbSYz9Od9Pbxs8lhNMZi6Ndxm06NJY=;
        b=CwCoXJSKVyNFLQJg7X6ZvhXisgcZqAcjHwLIkZ1G58+ejJQLcA16m+7QrAQ3b2+wRM
         rbaFdj3fsqyreQaBA0Un3+mCwrMPSQJGeIr1TUX0ZogcHGdDm2GqURutvhoIJfJ3MHKD
         FwHJZGsp0fOMCmTZFzcIL2XfjDDK7Eq8kaUZKPm5IKpp5+ti9FkG6cCJLUvvLR/VgAKP
         2JwwKYNqRtmGwhAZaaHOWEpPf7t7OwTTPK1ILZ9iEpYwZH/0y2qs2wDc5ADkUlG64gle
         f7bDgj65wTkOHr0pWvrAsdUP5W4yme1Uy47QYzhkAfLxW9EDUtzsx1gkTAsFxOMAQgCs
         mU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686812978; x=1689404978;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r7NJbOl1aaGyCKbSYz9Od9Pbxs8lhNMZi6Ndxm06NJY=;
        b=GMjY3CBvmBxXDBOrAoimUopJCw9neXs2nY65l9c3ARACoHP71FPsGAdYNeg1nGCmX6
         bgwGhpHhrl0ApFBbP1gkRRP+ghgo2rd+Y9L4cGlQ7+vempasTTuZDoP9HdwoIbl/r91p
         Nxydofpvm0YrEWsT2SrQFVfi/2lm1lfaMZhPSnKMVtmd8kFMzKji/wY3IJbwckzCqDsD
         /MEK6ifpPosEREWfJ/MA56wqAaNq9Vh/xXUJQl3oBpQb8DZn2d1CIs3c0okqiZfdWava
         GYpTPh7SC1lhV/ddyfx1UBzqT/uA4cqZB7LDCXgBmWHAcJ8h243gJzEa7IJ9uCfMRdJB
         8dDg==
X-Gm-Message-State: AC+VfDwEkWZ7NL3Y5CgFZKcT79Sos90IjNHbpbE8Bu11WeUK2/phoWcF
        C3D3Co7RrmLkDegl9Hwf8SsW2lZSSJg=
X-Google-Smtp-Source: ACHHUZ4aXyaXaNsSmRuOdK2n5dMdo6L3ISEJk/jvJvOW7KxS1uPnFrLe3kV97KPML6prCZiaBZUsKg==
X-Received: by 2002:a17:902:e845:b0:1b3:ea47:7972 with SMTP id t5-20020a170902e84500b001b3ea477972mr6800038plg.38.1686812977939;
        Thu, 15 Jun 2023 00:09:37 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00198d7b52eefsm13269004plh.257.2023.06.15.00.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:09:37 -0700 (PDT)
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
To:     Christoph Hellwig <hch@lst.de>
References: <20230615030837.8518-1-schmitzmic@gmail.com>
 <20230615030837.8518-3-schmitzmic@gmail.com> <20230615041742.GA4426@lst.de>
 <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
 <20230615055349.GA5544@lst.de>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        martin@lichtvoll.de, fthain@linux-m68k.org, stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <841007d6-65f8-6635-6b57-9dcd68fab017@gmail.com>
Date:   Thu, 15 Jun 2023 19:09:31 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230615055349.GA5544@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

Am 15.06.2023 um 17:53 schrieb Christoph Hellwig:
> On Thu, Jun 15, 2023 at 04:50:45PM +1200, Michael Schmitz wrote:
>>> And as far as I can tell everything that is a __u32 here should
>>> be an __be32 because it is a big endian on-disk format.  Why
>>> would you change only a single field?
>>
>> Because that's all I needed, and wanted to avoid excess patch churn. Plus
>> (appeal to authority here :-)) it's in keeping with what Al Viro did when
>> the __be32 annotations were first added.
>>
>> I can change all __u32 to __be32 and drop the comment if that's preferred.
>
> That would be great!

OK, will respin tomorrow.

Cheers,

	Michael


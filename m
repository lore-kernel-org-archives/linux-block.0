Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52166C61DA4
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 14:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCROdD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCROdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 10:33:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0312B28F
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 07:33:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a16so3699143pjs.4
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679149980; x=1681741980;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euFgKuZiJAI8fjRtYSJs4nwMqmIYbqq3bnMsbjrWIPk=;
        b=X1m92A6oZ1iyVGFj0cHLEXa14ewYEKakkdsqxyqO20WlGluUGMjuuwTDt86UG5qqMI
         4551mSymrN/GBfFFVstC+lHHDBPvVIbVtgRbO6Cyhc1zopJdenC0L3gRNRP6QawFbipc
         jPxQxJdd0DZp+aUlfQdV6YsA6YH48BTIbyP+Ug4RzRqGI+Ci+QqY7gpX9P7KIflny3WE
         lzxf1+tydA7VZkFoWbt86ydGsDeuYL7d1t5pdDju5HOMmMx3hLGXgjqK/hpx7hMKrGcX
         NqJmt6JwVEH2hzuHIIbR1qCeQ80c2Bf97cYwTj/cWwuahQJqVpiM7Ra1jsJY0xkTLcOZ
         86BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679149980; x=1681741980;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euFgKuZiJAI8fjRtYSJs4nwMqmIYbqq3bnMsbjrWIPk=;
        b=XMDS7UqSrSKpj+ipZyqdHPC6EasuU7DC4ObNUngrBw2Ima45gxq+D+JX7kXFZcWbeQ
         wq9GpbGAuhwVXNGDgdW2MmCqAMZKlC1rRePwBqO/ztJfOnWv6jXGA2kDSnUYNtL2MKKY
         w1CH5yxyltzqXFxv4IFFBpHbizkC/NJHYXcbIYrUHU9IERdZP4Z3kRk75RDLRnI9VcQl
         UZjBKp+D4pP5RWMvCyIO29P2wvTdMYiR+sY+YfHDH1GXragvuvCTXsd1lothfslBRKkT
         ltBcgov5rYU26NGUXF3T2q16FuVofVHPzMgLSPkLptIZR7eEVr18XFIw7Bl1ig74PsUq
         YX7g==
X-Gm-Message-State: AO0yUKXlamDpjF/qmOnsdwIC0BF7OlB9lhdjfvQXonsyH2LrJBv2W6Gu
        bLB2xnaW74Bej7vM/d9OUhNQ7A==
X-Google-Smtp-Source: AK7set8w3ie7UJSnp32YjRolxIwl+Q8t6Hb2wbHvTQCq9zqJWJRVlvEGcIlAK2PvFQGjbYmkpMpeRA==
X-Received: by 2002:a17:902:c94f:b0:19a:9269:7d1 with SMTP id i15-20020a170902c94f00b0019a926907d1mr10798905pla.4.1679149979898;
        Sat, 18 Mar 2023 07:32:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709029b8900b0019e6f3112b6sm3356794plp.91.2023.03.18.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 07:32:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230318141231.55562-1-ming.lei@redhat.com>
References: <20230318141231.55562-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: ublk_drv: mark device as LIVE before adding
 disk
Message-Id: <167914997920.312664.10763418802006125999.b4-ty@kernel.dk>
Date:   Sat, 18 Mar 2023 08:32:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 18 Mar 2023 22:12:31 +0800, Ming Lei wrote:
> IO can be started before add_disk() returns, such as reading parititon table,
> then the monitor work should work for making forward progress.
> 
> So mark device as LIVE before adding disk, meantime change to
> DEAD if add_disk() fails.
> 
> 
> [...]

Applied, thanks!

[1/1] block: ublk_drv: mark device as LIVE before adding disk
      commit: 4985e7b2c002eb4c5c794a1d3acd91b82c89a0fd

Best regards,
-- 
Jens Axboe




Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA23BC433FE
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 12:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJFMWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 08:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFMWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 08:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A39C2C0
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x/UtysfkCuzrgaeKGLYY50FbPjsMgpmsjeWMnapVU2o=;
        b=gKZvqWdpox/xVFKNInt/M4RCX4DOJQBOFAmcwpk9xaAlGvD0KI4DNFrUKbG7uO59Qo4qHB
        CZjN+DgeO0UDuhoV9voZmxJknLdRgtTnksEHrfCcg/i1hnbkJKH55UbH3b+0T2v2frB6GV
        w9RD5K5k3/q3Io/adPZZEiq/Ye1K1c8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-CivfJ0IfO9azxm5RN6Ojfg-1; Thu, 06 Oct 2022 08:22:13 -0400
X-MC-Unique: CivfJ0IfO9azxm5RN6Ojfg-1
Received: by mail-wm1-f70.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so2508324wms.5
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 05:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/UtysfkCuzrgaeKGLYY50FbPjsMgpmsjeWMnapVU2o=;
        b=NE55KfqqvjXarxtWiKpVa1HuOUvSOg5VgXy54eeOXTF4xBSSHLgVSg7yEYeUisWT+1
         Ah2aVS1lLG1zVlyTlxX75Yj4JBTtrCsfumDCWeklOeh8enqvTztwbFJlgtlGcYhyKl7X
         f0NFtMm0lgLAJH/wOti/un3iP2YThGSkfvsYn49mWvGtnSCCeSyY9UVNDjWDZ2t24zst
         kqnzMnKasTechJaYYfqfo3gh6xk47h1FVFbk8om9s8hCyO4b7k+toAZ1WdtJ5DwiAT4Y
         StTzyVlB94u92qOX7SySuEtJ/hbB7mpr43h0TS+mi3GgQ1FEJhDyyyB0JaYfaNWEkiNs
         0Jew==
X-Gm-Message-State: ACrzQf0vq1WQYyZhOtuMemmWxVCLJ7Pl109wZoKvuz0T3kMdAoIhFhfu
        fxHzOpyaKN2cVFWoNfQaBGcKaAzQW9XLFwXYIdF/BCMBk13qIaU1QeQYaWDWbtdW4M2ditnq2DU
        SQ4FwNDOd+tDBCZ8mgMfqihYFp8Bm62RvEnPDymd0Nt7HUyv34YOxzLYdPXhDGM94+RvZWmKDu2
        4=
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id a16-20020adffad0000000b0022e4998fd5dmr2944440wrs.267.1665058930454;
        Thu, 06 Oct 2022 05:22:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ostctxgUrwy0VS1dKaIuIw1DmSeOPVJhENSLFGHA06L5k0dOWjKEbI8XvwfNKgINr50wTyw==
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id a16-20020adffad0000000b0022e4998fd5dmr2944420wrs.267.1665058930230;
        Thu, 06 Oct 2022 05:22:10 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:09 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 0/4] lib/cpumask, blk_mq: Fix blk_mq_hctx_next_cpu() vs cpumask_check()
Date:   Thu,  6 Oct 2022 13:21:08 +0100
Message-Id: <20221006122112.663119-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I've split this from [1] given I don't have any updates to the other patches,
and this can live separately from them.

I figured I'd follow what Yury has done and condense the logic of
cpumask_next_wrap() into a macro, however cpumask_next_wrap() has a UP variant
which makes this a bit more annoying.

I've tried giving the UP variant its own macro in cpumask.c and declaring
it there, but that means making cpumask.c compile under !CONFIG_SMP (again),
which means doing the same for all of the cpumask.c functions that have UP
variants (cpumask_local_spread(), cpumask_any_*distribute()...).

Before going too deep in what might be a stupid idea, I thought I'd stop there,
send what I have, and check what folks if that sounds sane.

If it does, I see two ways of handling the UP stubs:
o Get rid of the UP optimizations and use the same code as SMP
o Move *all* definitions of the UP optimizations into cpumask.c with
  a different set of macros (e.g. a *_UP() variant).

[1]: http://lore.kernel.org/r/20221003153420.285896-1-vschneid@redhat.com
  
Cheers,
Valentin

Valentin Schneider (4):
  lib/cpumask: Generate cpumask_next_wrap() body with a macro
  lib/cpumask: Fix cpumask_check() warning in cpumask_next_wrap*()
  lib/cpumask: Introduce cpumask_next_and_wrap()
  blk_mq: Fix cpumask_check() warning in blk_mq_hctx_next_cpu()

 block/blk-mq.c          | 39 +++++++++------------------
 include/linux/cpumask.h | 22 +++++++++++++++
 lib/cpumask.c           | 60 ++++++++++++++++++++++++++++++-----------
 3 files changed, 79 insertions(+), 42 deletions(-)

--
2.31.1


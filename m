Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDDC433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 15:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJCPfH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJCPfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 11:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243A013F11
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9/KaIUZ8WcfYAhdfeSSOczSjyK1vIpjeWwpilZoktRE=;
        b=To+cd/ZVEraS0iCT1d7wYZulJxmTdjIEVc9Av7q2cqWPAp404bd1vnDN4MJv2wobT1cXNC
        EHIbyoUq7F3mXcaQRFHbjMRp8VXM0Pt6DcSAPlJA2A/PNG/PosDZqdt+AzKNnOsxcJ8Hng
        h3UgtrOL+QLjiJGPGq7ca5sBtzvHwYg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-VGBEZfAjN8uuGPHuU52tgw-1; Mon, 03 Oct 2022 11:34:48 -0400
X-MC-Unique: VGBEZfAjN8uuGPHuU52tgw-1
Received: by mail-wm1-f71.google.com with SMTP id y20-20020a05600c365400b003b4d4ae666fso3001130wmq.4
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 08:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9/KaIUZ8WcfYAhdfeSSOczSjyK1vIpjeWwpilZoktRE=;
        b=nzD5Kdrr/ED305pMzQBAqZp+Y8KG74dmI0BYOPDiHwreZMpTsiZzY9ikIuMgMISJYz
         fsXVzORZOSVdg9l+3YIrNQgkDbrAbx8E46L1KppxZsY0pDFvFGfVl70ppeQUV86Fh44v
         oj30fCUW3R56URWYQpCqs94p8llaCt1uXWRgP7rlMigFsYGUaJwkNa7LsHQk5/IGHkqM
         ngpWmh6nPbAs4kMLfjRYWaDn0rr5PUBm09rZWirxjdCPQUFU58nmI/wrgcdSFBPtDQzo
         iYFAGKa39MhqkIoAmLu3GsDev39B1Ix8VgBT/d1Mab/c+lrSD7iOd5XZ7sK8hxtsLkTy
         eu/A==
X-Gm-Message-State: ACrzQf29Dkb6f5Em/VzOIv6RmJ3u0W4eo3MPKwTmQYl9BCQIj6pYGTL4
        LrP+kjIwzrZZsZlNYJu5DAUspQlIRorD5Jafs9+U7+mKaeh5dJ5jld4peYLpXZ7EhbLCwMGFQao
        EvjlpjEaQ/psj0RRRgYIJFcm8+tLwhZ7pHE/iDSxR2p3ouFn2fhg51UIp3SMGJzjbxDWgXCSuws
        Y=
X-Received: by 2002:a5d:6dc1:0:b0:22b:1256:c3e5 with SMTP id d1-20020a5d6dc1000000b0022b1256c3e5mr14192810wrz.336.1664811281090;
        Mon, 03 Oct 2022 08:34:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MSdMQHVCu5bw/khyaPuqLPgcIvcggY9w1GfE9Ep4o5wwBn4hHdqI6JmJCkVHAu/ZvAjcn/Q==
X-Received: by 2002:a5d:6dc1:0:b0:22b:1256:c3e5 with SMTP id d1-20020a5d6dc1000000b0022b1256c3e5mr14192782wrz.336.1664811280807;
        Mon, 03 Oct 2022 08:34:40 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm18343151wms.2.2022.10.03.08.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:34:40 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH bitmap-for-next 0/5] bitmap,cpumask: Add for_each_cpu_andnot()
Date:   Mon,  3 Oct 2022 16:34:15 +0100
Message-Id: <20221003153420.285896-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As suggested by Yury, this is the bitmap/cpumask specific bits of [1]. This now
also contains an extra fix for blk_mq.

This is based on top of Yury's bitmap-for-next [2].

A note on treewide use of for_each_cpu_andnot()
===============================================

I've used the below coccinelle script to find places that could be patched (I
couldn't figure out the valid syntax to patch from coccinelle itself):

,-----
@tmpandnot@
expression tmpmask;
iterator for_each_cpu;
position p;
statement S;
@@
cpumask_andnot(tmpmask, ...);

...

(
for_each_cpu@p(..., tmpmask, ...)
	S
|
for_each_cpu@p(..., tmpmask, ...)
{
	...
}
)

@script:python depends on tmpandnot@
p << tmpandnot.p;
@@
coccilib.report.print_report(p[0], "andnot loop here")
'-----

Which yields (against c40e8341e3b3):

.//arch/powerpc/kernel/smp.c:1587:1-13: andnot loop here
.//arch/powerpc/kernel/smp.c:1530:1-13: andnot loop here
.//arch/powerpc/kernel/smp.c:1440:1-13: andnot loop here
.//arch/powerpc/platforms/powernv/subcore.c:306:2-14: andnot loop here
.//arch/x86/kernel/apic/x2apic_cluster.c:62:1-13: andnot loop here
.//drivers/acpi/acpi_pad.c:110:1-13: andnot loop here
.//drivers/cpufreq/armada-8k-cpufreq.c:148:1-13: andnot loop here
.//drivers/cpufreq/powernv-cpufreq.c:931:1-13: andnot loop here
.//drivers/net/ethernet/sfc/efx_channels.c:73:1-13: andnot loop here
.//drivers/net/ethernet/sfc/siena/efx_channels.c:73:1-13: andnot loop here
.//kernel/sched/core.c:345:1-13: andnot loop here
.//kernel/sched/core.c:366:1-13: andnot loop here
.//net/core/dev.c:3058:1-13: andnot loop here

A lot of those are actually of the shape

  for_each_cpu(cpu, mask) {
      ...
      cpumask_andnot(mask, ...);
  }

I think *some* of the powerpc ones would be a match for for_each_cpu_andnot(),
but I decided to just stick to the one obvious one in __sched_core_flip().

[1]: https://lore.kernel.org/all/20220923132527.1001870-1-vschneid@redhat.com/
[2]: https://github.com/norov/linux.git/ -b bitmap-for-next

Cheers,
Valentin

Valentin Schneider (5):
  blk_mq: Fix cpumask_check() warning in blk_mq_hctx_next_cpu()
  lib/find_bit: Introduce find_next_andnot_bit()
  cpumask: Introduce for_each_cpu_andnot()
  lib/test_cpumask: Add for_each_cpu_and(not) tests
  sched/core: Merge cpumask_andnot()+for_each_cpu() into
    for_each_cpu_andnot()

 block/blk-mq.c          |  9 +++++++--
 include/linux/cpumask.h | 18 ++++++++++++++++++
 include/linux/find.h    | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c     |  5 +----
 lib/cpumask_kunit.c     | 19 +++++++++++++++++++
 lib/find_bit.c          |  9 +++++++++
 6 files changed, 92 insertions(+), 6 deletions(-)

--
2.31.1


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B662CDB47E
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 21:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMVvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Oct 2023 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJMVvk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2023 17:51:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC1FBE
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2023 14:51:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66cfd874520so15214846d6.2
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2023 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697233897; x=1697838697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyy9YIX2I3x3QCpL532Lfca+iWPr3umdGP+7RW66dQM=;
        b=nSarddLCrg0YSLVPTAw7yRrdix4NtOqcjctrxVmYoqxnK7/KtPob7mNwQmvweISc78
         4sHH91meLJXkm8+gieMYA6UIkzb6YOdbhrrPLLgyniDu+U173fI+9+BNuF5UV0tZTEJ9
         KEKo4xeTD+hNNlU5avp8zb/a/0EmXPO1XkoIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233897; x=1697838697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyy9YIX2I3x3QCpL532Lfca+iWPr3umdGP+7RW66dQM=;
        b=izk1NBVWY+IKI3Yd4wB08Odpt2wqXxq9KkZMD5WW1jlKK55bKs2QFmhdT8qwpDJFPd
         ozsnrkidhDHqV9LovbESF0ca/UGzozuyHAGO4YzmLAPPqwFtzxX3U+1CBdjJN1zlAEGS
         YPz/iS+Qltvg7BLF8qcQiE/n1YWsybwfIjhKbYJfTCKx8Sgo3tVo+kGT3FUAGWWGS/no
         Ssi5gSeQZFc1j2Z/+UQr9rKtNtQY1JS2qHyhObBJgR1FNs/Zu7U/xaITaEv0VNEHX4JA
         W7GJ3fLyfhSh2jEoK+xOzMUVYubKTdFSYt5xNsICF55eeHGA+ZkPRw1PJieuD3MP2+3H
         BErQ==
X-Gm-Message-State: AOJu0YxDVWSt4Bo+7keyEWo01XvmGHHuIRgufPSccwyoytCWT3SgZ2s3
        3Zp20fJfbUMvZL5kvkD57gTLdCc8+qlHZkuvegM=
X-Google-Smtp-Source: AGHT+IHW4VPhAhDjPdjL7rVcANLR/kiguNjLOUlpUWzamWLeDUnfk/k5+OjpogwbfZw28d+nj8Te7g==
X-Received: by 2002:a0c:ec8c:0:b0:64c:9d23:8f55 with SMTP id u12-20020a0cec8c000000b0064c9d238f55mr29211401qvo.58.1697233897519;
        Fri, 13 Oct 2023 14:51:37 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ccdca000000b0065afe284b3csm1005906qvn.125.2023.10.13.14.51.36
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 14:51:36 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-419768e69dfso41571cf.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2023 14:51:36 -0700 (PDT)
X-Received: by 2002:a05:622a:760d:b0:40d:eb06:d3cc with SMTP id
 kg13-20020a05622a760d00b0040deb06d3ccmr9844qtb.7.1697233896288; Fri, 13 Oct
 2023 14:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com> <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com> <20231008113602.GB24726@redhat.com>
In-Reply-To: <20231008113602.GB24726@redhat.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Fri, 13 Oct 2023 14:51:22 -0700
X-Gmail-Original-Message-ID: <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
Message-ID: <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Li Nan <linan666@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looking at the generic mul_u64_u64_div_u64 impl, it doesn't handle
overflow of the final result either, as far as I can tell. So while on
x86 we get a DE, on non-x86 we just get the wrong result.

(Aside: after 8d6bbaada2e0 ("blk-throttle: prevent overflow while
calculating wait time"), setting a very-high bps_limit would probably
also cause this crash, no?)

Would it be possible to have a "check_mul_u64_u64_div_u64_overflow()",
where if the result doesn't fit in u64, we indicate (and let the
caller choose what to do? Here we should just return U64_MAX)?

Absent that, maybe we can take inspiration from the generic
mul_u64_u64_div_u64? (Forgive the paste)

 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
+       /* Final result probably won't fit in u64 */
+       if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
+               return U64_MAX;
        return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }

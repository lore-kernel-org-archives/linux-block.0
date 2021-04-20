Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA50C433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7217613C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 19:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhDTTxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTTxn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 15:53:43 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8DC06174A;
        Tue, 20 Apr 2021 12:53:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so27413152pga.11;
        Tue, 20 Apr 2021 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYKg2J0xe3aYfBDpLCkcNYmiAt9vweJDAtDNBhQTjGE=;
        b=Cpe8NpEnbh6iHdYQV8JL/r0l05aziwv1Jvq2KKW94Wh8VYbH22gig+Yps4k+OY1Uc6
         jN2iIA0qPs5GzYNFmNONUObh7rBWCGQJG34AmWu4l14Ukedrfe46Bv13P59Sa2dMEeqL
         56eHiQqthchMRYyo/t0NDn5WaXpiZPb8w1wzUHqCksSIZAGPLoQ7+igf5tGzgHHyWu56
         9yHOnkWhofvGDXcBLkjYVK6r+X0KMd5iJpjQ6RQyW9652qcdNFwh/n5kJ5uge6tnt8CA
         zTo17mvpohnMB5c/O++4s1Jx1rHqXS4H7ajLzwklDLjUroQm8pSKBnbkhN59OFiA+XRh
         os9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYKg2J0xe3aYfBDpLCkcNYmiAt9vweJDAtDNBhQTjGE=;
        b=IRZSe2hOnZqLrhwqdGOBb5JxD2U6Hm/cigV58LN9YBPLEvz9kFx58Q8yuiO11Bj/2a
         mB3NtA6SCPM4WyRA20uc3A9fF7/Ci6YAEFVK3YLyg3OHmK/qwv7XshXsyzDzFwndPxiM
         T/F3qweCL49H89qUAHuGDocCpTOP83mulrZD2HgoTroJ1A4IUbDlmpiB4NOyLo+MxSrg
         /IAmLGLdS0/BhNe7jvhJcNlaJd+aifALMjKkPTCZN3HMU2pXPCGH7PAuYgVU8P5EAUcF
         HgsYDm5A/9M1BHXpVZBr2z25jcqx3YIaqFnMKB7Vtr3dZBljoHyqS3CVuZpxykbueOye
         yfzA==
X-Gm-Message-State: AOAM532rhV/zC4vTucgafPBcagADm4AeieXpmj+fD0j432rXC+VrPcx0
        RfxGB50roLqWNuzyBAxoWywFrtjJCxxagzQuyCGqR8fflU1GiA==
X-Google-Smtp-Source: ABdhPJxcYjZrcV/WYyz/6KJ9FRGCiKMK8h95HIN1z3ZWEkhSK5862cBSHyqmETkSJ9OLLsmlWQmXCu+ad5twBpG6DOQ=
X-Received: by 2002:a05:6a00:c8:b029:260:f25a:f2ef with SMTP id
 e8-20020a056a0000c8b0290260f25af2efmr9810244pfj.78.1618948390983; Tue, 20 Apr
 2021 12:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210418044101.26730-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20210418044101.26730-1-xiyou.wangcong@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 20 Apr 2021 12:53:00 -0700
Message-ID: <CAM_iQpVsAhsG_SLDSgTkZ0RjvCzhu2d5Nt5SQ=NoVa0UYYMoug@mail.gmail.com>
Subject: Re: [Patch] blk-wbt: fix a divide-by-zero error in rwb_arm_timer()
To:     linux-block@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 17, 2021 at 9:41 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> We hit a divide error in rwb_arm_timer() and crash dump shows
> rqd->scale_step is 16777215 (0xffffff in hex), so the expression
> "(rqd->scale_step + 1) << 8)" is 0x100000000, which is just beyond
> 32-bit integer range, hence it is truncated to 0 and int_sqrt(0)
> returns 0 too, so we end up passing 0 as a divisor to div_u64().
>

Never mind. rqd->scale_step should be capped by
rq_depth_scale_down(), so should never be so large. In the old
calc_wb_limits() implementation, rwb->wb_max was set to zero
accidentally.

Thanks.

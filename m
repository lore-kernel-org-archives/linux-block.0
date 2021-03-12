Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3583C433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 14:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA8964FDD
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 14:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCLOqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhCLOpk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 09:45:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2AC061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 06:45:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v11so1917808wro.7
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 06:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zNm99R4uMu8Wbja5tyUhmwmE1+/8YzPhAAxGmhIJuZ8=;
        b=qabzXqtEOSS8ndXP7Mx1jPRfza9+oCwYABMu/LnBE7fmVPME5eSEXYXVaQlaE7Nmxo
         67UFDGjaVaI/yhHJv3JgbJJY8M3DwJFlPk++8PqrvGT275k2TO/cKqzLY5MHwQtysbRw
         ebVWoGjCqCzAFw6x91o80FsJexKp/ikt1ImU6bx1psVSwflrbujisy3FsiwGBGEptzCn
         9EHF4V3czvqEaZP9wIm/N5qMizrBSzSA31SALYR/LQQFlt+OClP9syIGJS/mXNMGwgAF
         9xE3GMcCnyFwR3aSL8oT6Y9VFtxo/QBoOMmv53puPWAxhcx2WuNlgArlkNbocXfRwAIq
         Q/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zNm99R4uMu8Wbja5tyUhmwmE1+/8YzPhAAxGmhIJuZ8=;
        b=bJ6z0jTDgqgmn3CSQWpsG/u0KJpEbJ+Wn3wjkGz/ldA41JVFvT3aPe5f8xlQiAWZFD
         SeoxcOhJehxFFcK94xnVaUeiybDjRuqnUBlzWsZee0YHbNRXTDWbADjnevxrmfBMq9NC
         x/yAWkwvhfV+rW3zZ/sZrcTW0QdeB8OLMW/lEIZ3N6Ia5FIjqXRPaREikTI+90gx7UNd
         BUuBune10haX4qHTlsud5oRU6qnFlQgVhwIszKcLBxgPcOstyc4tfG7XgbY+0szwEmT9
         yp6in8KjMCYD8wmHEbHzqV7wlTSjVH1wm4HCE3wAgl/Qbe5gTIK6Tgha8S5tL0rF/IqY
         kyag==
X-Gm-Message-State: AOAM531eSSlzgakFDchTtmAz6tqHG2ZE7y3qtROQUdZ5RO+kGGpvBCr0
        N/DrrkyOWCMs608O4LwqNYFR9NrNa3Fdqpjb
X-Google-Smtp-Source: ABdhPJztcuRzhjP41YXI4iuB3tsYNDF/SWY6EZTV3OmpXB7cI9VefZEbC/DVsUKRxtUlX6XcUi8XTw==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr14268795wre.386.1615560338298;
        Fri, 12 Mar 2021 06:45:38 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id w131sm2340962wmb.8.2021.03.12.06.45.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 06:45:37 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [BUG] block/bfq-wf2q: A Use After Free bug in bfq_del_bfqq_busy
From:   Paolo Valente <paolo.valente@linaro.org>
X-Priority: 3
In-Reply-To: <24de85db.8011.1781a216e77.Coremail.lyl2019@mail.ustc.edu.cn>
Date:   Fri, 12 Mar 2021 15:47:22 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        security@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <275344D4-8DF4-4F7B-A3C9-592CE2DB0AC8@linaro.org>
References: <24de85db.8011.1781a216e77.Coremail.lyl2019@mail.ustc.edu.cn>
To:     lyl2019@mail.ustc.edu.cn
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 10 mar 2021, alle ore 04:15, lyl2019@mail.ustc.edu.cn ha scritto:
> 
> File: block/bfq-wf2q.c
> 
> There exist a feasible path to trigger a use after free bug in
> bfq_del_bfqq_busy, since v4.12-rc1. It could cause denial of service.
> 

Thank you very much for analyzing this.

> In the implemention of bfq_del_bfqq_busy,

I've checked all invocations of bfq_del_bfqq_busy, comments below.

> it calls bfq_deactivate_bfqq()
> and use `bfqq` later. Whereas bfq_deactivate_bfqq() could free `bfqq`.
> 
> The trigger path is as follow:
> |- bfq_deactivate_bfqq(.., bfqq, true, ..)
> |--  entity = &bfqq->entity;   // get entity
> |--  bfq_deactivate_entity(entity, true, ...); //has a path to free `bfqq`
> |--  if (!bfqq->dispatched) // use after free!
> 		
>  
> |- bfq_deactivate_entity(entity, true, ...)
> |--  ...
> |--  for_each_entity_safe(entity, parent) { // in the first loop,
>                             //entity is the same as before
>  		if (!__bfq_deactivate_entity(entity, true)) {
> 
> |- __bfq_deactivate_entity(entity, true)
> |--  ...
> |--  if (!ins_into_idle_tree || !bfq_gt(entity->finish, st->vtime))
> 		bfq_forget_entity(st, entity, is_in_service); 
> 
> |- bfq_forget_entity(st, entity, is_in_service)
> |--   bfqq = bfq_entity_to_bfqq(entity); // recover `bfqq` by entity
> |--	if (bfqq && !is_in_service)
> 		 bfq_put_queue(bfqq); // free the `bfqq`
> 

For this put to turn into a free, bfqq should have only one ref.  But
I did not find any invocation of bfq_del_bfqq_busy with bfqq->ref == 1.

Did you spot any?

Looking forward to your feedback,
Paolo

> The bug fix needs to add some checks to avoid freeing `bfqq` in the first
> loop in __bfq_deactivate_entity(). I can't come out a good patch for it,
> so i report it for you.


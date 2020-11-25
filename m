Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CBDC5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 11:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8C9206D4
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 11:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aujxCesO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgKYLbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYLbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 06:31:09 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA45C0613D4;
        Wed, 25 Nov 2020 03:31:08 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id z136so1026404iof.3;
        Wed, 25 Nov 2020 03:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lGlvuabGufuxy6ujt/Rc7r7lPdDL7IxgeI87NR4IWa8=;
        b=aujxCesOJ9iF8uyVKIgwnpJX3SgqGJ6u5G5iAml09Fd7SzN1UI2jk+YmQI0zYMu0sq
         sxwXLYA/hIdrs8RvMFdR6VrIXPZ8nRwvh3Kl5VXAuctuFlwE/YQkXJf1dPm7+0r4Y5jV
         s0iOn2G4HfGpafPkuM2pM+1t+D4eQxBRqd6pb8nPNk16hyYzYrQT+kQgFPQfFZ/X/z2J
         lCO80FuS9DgQk20zkaC9bm3ldapFcIVNwvMjFINfGXy2WrELoyqo+3WNmWKS/wnzBDB0
         lk13q1jh/u3/Sx2CBG5I40GL/0WWKtEydtSZwrfBAl2R+sUjpgjiG/a2eSGZc6FLdCKw
         07yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lGlvuabGufuxy6ujt/Rc7r7lPdDL7IxgeI87NR4IWa8=;
        b=bPueIiv6cEn0VSUy2vIPdC5OPep2tau2b4D/6AV/ZezPpTbcW5mhQ60auEOI44psap
         IEsCr8wATN10cfm6RUm3cVkhv8/WrqTXrOn05NClPo4XBW1T3plG+sI72UJixN4xmvWv
         ZmX3hgzHaC+DG2qiEHQWM7FJDSs4gdrl349kEISfwbwBqgE1AUPTjDy4i0DgGFNYszAg
         WhaHpacgWuRAJDawQA+60FoWWyqVK1fIMxN5dTYoP1WcTXzKi/YjksmGAEFzPHXxOu6r
         I5vDJUZiUg860tZBTHY5q96JqNo347xSXazUCyGxhLKhH1GT74PtKP7ms8DT41udcH+k
         Ix2A==
X-Gm-Message-State: AOAM531zs9iMh5u0k8+IwVbTCy0XXbUskQQ8eBjY7WtMEQ22X4W01VPl
        o0to0bZwoUC65EGec7cOMco=
X-Google-Smtp-Source: ABdhPJwoA5m584VMLHOvmW1s/OSUpuiYo6A68F7i3Hb++UdP5jaalpukZyBEuuOkSrp2FJeUFcwTrQ==
X-Received: by 2002:a6b:db18:: with SMTP id t24mr2135845ioc.51.1606303867972;
        Wed, 25 Nov 2020 03:31:07 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id a7sm944187ioa.50.2020.11.25.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 03:31:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 06:30:45 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] blk-iocost: Fix some typos in comments
Message-ID: <X75AZeHmESipRzcH@mtj.duckdns.org>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <54cf5f249bf91a6d1a0ea18a1024ba1af861f9c5.1606186717.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cf5f249bf91a6d1a0ea18a1024ba1af861f9c5.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 24, 2020 at 11:33:30AM +0800, Baolin Wang wrote:
> Fix some typos in comments.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun

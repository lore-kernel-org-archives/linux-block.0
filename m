Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD157C3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 18:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984D521897
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 18:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXrN3Q7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfICSTZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:19:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41121 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICSTZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 14:19:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so18513385wrr.8;
        Tue, 03 Sep 2019 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ty/2ohLAJ+2sCNPsz6Mg9g82ZAcXCLPeRSTUh8dn1AM=;
        b=iXrN3Q7PNVG79k4/QPwtJd360wJBFRowaCrtFARluncD92iaxPMac9rPX4B8Hxlta6
         u/egCzq2FHk7WjWNT5OjHCutDCAyvbBIMEMQuj8Uk4fIXVLKHzupt38V5eoEGLwnfxwW
         SqBXpSsY/Zq0zJG1z5wQjb1fmAE3V7w/wzzAZ519iQse6X2qAu5JHAI73GwS2t32czqK
         aEyRcgYkrUFclz9SJ+tw3xs2406lVI/hppCdyT62DYo33sOUME/5kqeaSlong/0UwJNK
         BC39yQeVjmmfS/aYtMtAzcaVCNQrjnTBP1j/Srlo1GRn0raysle8n1hJupyIU46tYxsy
         mumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ty/2ohLAJ+2sCNPsz6Mg9g82ZAcXCLPeRSTUh8dn1AM=;
        b=a6O2CJbylSxcnI+FXxqhwa20+OHPsux9nxODLJNNpuay+BzEp2CtZmXl7SFujkVyWi
         +wxStXpQZ3lXgo1jDDXUbi82x0mTyjaovM4MCjRTmb8DY2he1Djhyk3oHJBcM2f3c/tn
         iCf5LKPDelXH3cwLhSBmWDjtATYWaroP8sqqgG9VR9GX5Agigvgqs8aZupwk7Ta3VYcm
         jW9GuvERyDCL5Mjm4a+mUMrCtKqU/RyajS/UWrJpXAWCMTOiO4EZm1WxNGv/qczsY20P
         yJDYsRUmTJ6RX7Lj+I53qQw9RjZhx0phgoOr+Jk8VLt2vkdONSJ+QGzZ7gg1y12nE5SA
         Tkmg==
X-Gm-Message-State: APjAAAUnnXk44zLvxTQ7eMwbEZ19Iz/5dgOZ9j/xfJr8ua8JOv5exYNU
        x9swyvR/O6uND2suTcHmww==
X-Google-Smtp-Source: APXvYqxlHBA49WV+BHVeO2PilKn9QU1HiFxpBtiAo0xzOr9c+REPpHiXHtdsI/PxDenk0UyGl0Lj6A==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr1790618wrs.195.1567534762701;
        Tue, 03 Sep 2019 11:19:22 -0700 (PDT)
Received: from avx2 ([46.53.254.228])
        by smtp.gmail.com with ESMTPSA id t14sm19292468wrs.58.2019.09.03.11.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:19:22 -0700 (PDT)
Date:   Tue, 3 Sep 2019 21:19:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        aarcange@redhat.com
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
Message-ID: <20190903181920.GA22358@avx2>
References: <20190902210558.GA23013@avx2>
 <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 06:29:06PM +0100, Valentin Schneider wrote:
> On 02/09/2019 22:05, Alexey Dobriyan wrote:
> > 32-bit accesses are shorter than 64-bit accesses on x86_64.
> > Nothing uses 64-bitness of ->state.

> It looks like you missed a few places. There's a long prev_state in
> sched/core.c::finish_task_switch() for instance.
> 
> I suppose that's where coccinelle oughta help but I'm really not fluent
> in that. Is there a way to make it match p.state accesses with p task_struct?
> And if so, can we make it change the type of the variable being read from
> / written to?

Coccinelle is interesting: basic

	- foo
	+ bar

doesn't find "foo" in function arguments.

I'm scared of coccinelle.

> How did you come up with this changeset, did you pickaxe for some regexp?

No, manually, backtracking up to the call chain.
Maybe I missed a few places.

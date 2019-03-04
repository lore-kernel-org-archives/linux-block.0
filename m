Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF7CC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 02:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6A420835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 02:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551666919;
	bh=R6gYf2SWohM18Z7XrwJqe0/3D8jwpttFInw7S/OCQVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0bHGxmulStZcZpptmWAfKLOJFkle7xpaWVRD2KiIskfGx2yHSxpuMzucEFtjvGQIj
	 3NYDKPPmMW9gt5myYyWsKNgBdgqEsGz0+q9vKGQ4yw5dR6sAc4PZwOT1ywbyRb8R2t
	 Wkh5xh1J7wOBfLFKmm4D4CEPc+lzAczzEGfs5cls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfCDCfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:35:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44945 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDCfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Mar 2019 21:35:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id q128so2917515ljb.11
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 18:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3m9jnAhk/1BVNMIWjOTRXbo66gl9/pHorI4ypdFIykA=;
        b=L54lM6f24ClEr/j3Q+LtuVMoOd2U4gbCTsJqWm/Zh9cW98Ew5z89Wx8yoWvXGOCaU6
         EqC4wqIvNEm2UvrsgVQSmWbTPNO6QCfE/vCNFXbIZ/o1kjT7GloCg5hDvDJ3MwjA3eqn
         Yohsok9GUCn2lNq2CQjV4m5UAeVWMxj6T2q5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m9jnAhk/1BVNMIWjOTRXbo66gl9/pHorI4ypdFIykA=;
        b=G4BVJuUzoR/lPL8pOy0eQgxARwX6zlcdab0/YWwcC3V2TKiQDLzDApNfPxF31cUXdX
         w0WbMsT1knCLOItVHyuwnnsIERe8hYNy/Vx+vdyvQfTD5esL4a7zXTmmD9jvCso+dbrD
         uhV5uzBLz7yjlfSQBAP9DPAbNNi7iplp/C6c6NCOSIZkjlwLTpph3R9BAuj3S75/3MlR
         ESKHc/xhOmLVSF8sBo2k7Wbtl3qELdggELuug8p3923OBKDzaOwOgu7b/J0zsdMbMWwx
         Ew9RZ3+pqsh63OpxEy0rWWjnLBHrEU+RZgNrWjz0u7MtmIt4+Za89ILjuxsVHwR+AVnk
         8m4g==
X-Gm-Message-State: APjAAAXNrblad5xqb23NXn49U0rQqGQLAtZKR4nTVooF40UA8sMCTijL
        aHXGUXGft45zriUhgwPSw0M1ae3sLtU=
X-Google-Smtp-Source: APXvYqw6e3QWSPj1eBGB7bFnkNybB8BlkXyo4PbqUKnCg6y0W09nu18M9zWPHZQrBrjxduJ9C2crJg==
X-Received: by 2002:a2e:9d0:: with SMTP id 199mr6093232ljj.148.1551666916602;
        Sun, 03 Mar 2019 18:35:16 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d5sm1258400lfi.95.2019.03.03.18.35.15
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 18:35:15 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id y7so2361121lfg.8
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 18:35:15 -0800 (PST)
X-Received: by 2002:a19:3f44:: with SMTP id m65mr8607376lfa.136.1551666915158;
 Sun, 03 Mar 2019 18:35:15 -0800 (PST)
MIME-Version: 1.0
References: <f15aeeb9-e602-27bc-f230-ce52e59f6bb2@kernel.dk>
In-Reply-To: <f15aeeb9-e602-27bc-f230-ce52e59f6bb2@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 18:34:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgf6WfxnskG06zRGN=+6u5xyRdAb2GP0mT7J6f5xk+3MA@mail.gmail.com>
Message-ID: <CAHk-=wgf6WfxnskG06zRGN=+6u5xyRdAb2GP0mT7J6f5xk+3MA@mail.gmail.com>
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 3, 2019 at 5:53 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> This pull request adds support for a new IO interface, io_uring.
> io_uring allows an application to communicate with the kernel through
> two rings, the submission queue (SQ) and completion queue (CQ) ring.
> This allows for very efficient handling of IOs, see the v5 posting for
> some basic numbers:

Having just looked at the bugs in fs/aio.c and not finding a lot of
users of *that*, and absolutely zero actual test-cases, I'm actually
less than thrilled to see a new interface with the same behavior.

So I would want to see some test programs that actually use this.
Perhaps as part of tools/testing/?

                     Linus

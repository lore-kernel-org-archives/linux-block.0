Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC0AC433FE
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 19:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AC66109D
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 19:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhJVTZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:25:08 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40583 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhJVTZI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 15:25:08 -0400
Received: by mail-qk1-f179.google.com with SMTP id x123so5613495qke.7;
        Fri, 22 Oct 2021 12:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JcURMBS9Y8PdDJIxlTdxpTDoglZA5EDZMktU0Iw1H1o=;
        b=mj4whCqmXBsHARp17EBvftyVmVUakeBGJM3Zc/3H+F39FZqfWUpDBwIQjabJSyZO2b
         cCwA98Npsy2AKhU/rZXKuHj6Et4l2X4Kzm++4E2+6Ci5AV8r0sIFvniQudrhkCe0UuKh
         P7seWQBnAgm+DG2ByPvmZ1FeDkfgXcz3nNb72P3FwRq/BXyk3Skm95Bnt7vZIbZVF3Ix
         ZaTuQ5oF3pcr0L+S4u5Nh/KzvL8tLCli9FfX7JsEjKnGvkdnlj49SIVEcNwppuN7XTx2
         8kekRCokeyMSzqbTK3LgOe8fD4Igf7dHQBZdfUFxVw+cOxkvB1adUHuorkxJR0l3dgUG
         wmYQ==
X-Gm-Message-State: AOAM531Hzeiqvv3Ni7qHEgUItpa9cwNE+3VLhXpaaUM5NAiSH2+UXBGi
        emCpXYBeXfYSvWd+kWHQPYg=
X-Google-Smtp-Source: ABdhPJwkV0a9KDG599gq/X+geXmTHTk4qkO+qX3DwxEkccPEdGPJJzljJVCeZhNMx2WeC35A2dVILA==
X-Received: by 2002:a37:a809:: with SMTP id r9mr1692706qke.50.1634930570074;
        Fri, 22 Oct 2021 12:22:50 -0700 (PDT)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id m6sm4557267qti.38.2021.10.22.12.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:22:49 -0700 (PDT)
Date:   Fri, 22 Oct 2021 15:22:47 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] percpu_ref: percpu_ref_tryget_live() version
 holding RCU
Message-ID: <YXMPh4jZ0dr6EFqX@fedora>
References: <cover.1634822969.git.asml.silence@gmail.com>
 <3066500d7a6eb3e03f10adf98b87fdb3b1c49db8.1634822969.git.asml.silence@gmail.com>
 <YXFytAdeF5RPRERf@fedora>
 <cdf7c768-47ad-78c4-a22a-f0f1a435b6f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf7c768-47ad-78c4-a22a-f0f1a435b6f6@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 22, 2021 at 10:22:30AM +0100, Pavel Begunkov wrote:
> On 10/21/21 15:01, Dennis Zhou wrote:
> > Hello,
> > 
> > On Thu, Oct 21, 2021 at 02:30:51PM +0100, Pavel Begunkov wrote:
> > > Add percpu_ref_tryget_live_rcu(), which is a version of
> > > percpu_ref_tryget_live() but the user is responsible for enclosing it in
> > > a RCU read lock section.
> > > 
> > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > ---
> > >   include/linux/percpu-refcount.h | 33 +++++++++++++++++++++++----------
> > >   1 file changed, 23 insertions(+), 10 deletions(-)
> > > 
> [...]
> > > +
> > >   /**
> > >    * percpu_ref_tryget_live - try to increment a live percpu refcount
> > >    * @ref: percpu_ref to try-get
> > 
> > Nit: it's dumb convention at this point, but do you mind copying this
> > guy up. I like consistency.
> 
> Looks Jens already took it. If you still want it moved, do you mind
> it in a separate patch?
> 
> And I'm not sure I follow where you want it to be, currently it's
> right before percpu_ref_tryget_live, which uses it.

Don't worry about it. I meant the @ref comment line. Honestly it's not
really useful, it's just every other header block has that convention
among most of percpu related files.

If I have to make any changes in the future, I'll clean it up then.

Thanks,
Dennis

> 
> -- 
> Pavel Begunkov

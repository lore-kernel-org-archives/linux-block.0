Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B90C54FD0
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D3820784
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 20:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRYryNCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDWUko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgDWUko (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 16:40:44 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D143C09B043
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 13:40:44 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id l84so3864694ybb.1
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiAggMTdEI+PSkFEvICFsKzD8PMWNxu1XhigoAo8ZFk=;
        b=oRYryNCltzBR3y9BL1s+jCUMyN9XWGhlvZ9oUn9+pG6V3VAcQ1F2Fa7hy6KTQMdPcW
         6nmtEUOW3SO6xJcZgPo3iDPRoNjaAXcIqFXSxf5+vH+YPSmfhaz24EMF510kpbixaOmw
         TmUo9nKPZo7qkJyMKY7/Uq0L9Ik53muTIGFQTaHus8WKQvNVIjCNYfaLVDmAjyP1uAZ7
         JkpAqlbEGHfKesLKISlS1Dt1BbzCK9mwNFaESPfnbPJun0mVkY7snd5DxCpRmB2Gl3NV
         TPhkssL2/QHq0TgXR2wkYTox51FI4TWsB+c87jNU0n9cRKn+rVujbTn3CMuFQT3FIisG
         015w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiAggMTdEI+PSkFEvICFsKzD8PMWNxu1XhigoAo8ZFk=;
        b=rcP7GVSz8J8nRT0kV9xJIJ+l6sWSGaCgOyN1E+7kmyrSX76QETQka3RzjISHXkGWgU
         eZIG+vyesRTPexrg/WHEC8HrLnL59PhewYsPEb1m89pjI8AuvTUfcDsiL0LUL4TfLGwR
         d1yN5liV5PXUyxlPCoLQS3HCNSiGHiubvr9Rn+ppR6/T1gdOjsjE27AKsY3/XsqMtMIm
         rxW2oeHI6My1UqRItVbBkILnVjAdxBM7P7YP4qqAdEcMBtuqazPN5asEJhmzX9uzS9tU
         jFBISBR4Yn4oARVlcdJar+UZdx5v8nDECQR7LLW0lCPNeKt7+dIKbD8uHcRRNGFXWKPL
         atlA==
X-Gm-Message-State: AGi0PuagGeN68MEC/0yTAlBzQLs1ql+XvlzV086lLX37nZTUt/js4oQl
        9TMnuK0CFYd5Z2BdYqabKMEhRSbQVc6JCHiCzPtZ1g==
X-Google-Smtp-Source: APiQypKe47D7DaKEuIi8C1WVF0Ns073XtAG6vWerLoivJWqWnBs2788wmfmGlFru+F19EXnmArWGEg6XCUwbqZ8WuAk=
X-Received: by 2002:a25:4d04:: with SMTP id a4mr9734046ybb.153.1587674443304;
 Thu, 23 Apr 2020 13:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200206101833.GA20943@ming.t460p> <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org> <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
 <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org> <CAKUOC8X=fzXjt=5qZ+tkq3iKnu7NHhPfT_t0JyzcmZg49ZEq4A@mail.gmail.com>
 <CAD=FV=WgfAgHSuDRXSUWFUV8CB3tPq7HG0+E7q2fRQniiJwa1w@mail.gmail.com>
 <CAJmaN=m4sPCUjS1oy3yOavjN2wcwhMWvZE9sVehySuhibTmABQ@mail.gmail.com> <016647fc-1d7b-7127-68aa-044d4230a22d@kernel.dk>
In-Reply-To: <016647fc-1d7b-7127-68aa-044d4230a22d@kernel.dk>
From:   Salman Qazi <sqazi@google.com>
Date:   Thu, 23 Apr 2020 13:40:31 -0700
Message-ID: <CAKUOC8V_4Xz7ft_UBE-EO=ZQ00o_-TceaSawAMax97-DQs-93w@mail.gmail.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I had posted a version on Feb 7th, but I guess I neglected to
explicitly label it as v2.  I am sorry I am not well-acquainted with
the processes here.

On Thu, Apr 23, 2020 at 1:34 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/23/20 2:13 PM, Jesse Barnes wrote:
> > Jens, Bart, Ming, any update here?  Or is this already applied (I didn't check)?
>
> No updates on my end. I was expecting that a v2 would be posted after
> all the discussion on it, but that doesn't seem to be the case.
>
> --
> Jens Axboe
>

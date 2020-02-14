Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA5C3B195
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 09:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EAB222C2
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 09:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDZxTrRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgBNJXL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:23:11 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38043 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgBNJXL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 04:23:11 -0500
Received: by mail-wr1-f53.google.com with SMTP id y17so10054433wrh.5;
        Fri, 14 Feb 2020 01:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSsfBY73FO1UU5jzBVaE+iGEtOR0A4j37n3sHs5sps4=;
        b=uDZxTrRpXta3sKqqut6QK4COszMH5GkzhZtwp1xtigiRMsqMsLeWtR2By294F3MxR4
         fWNe2MZUcQTO4apSXNIJz8K7xh4RaqtXf03mlxfFXRVD4xbi4dz6eyEOH9D9WououKCw
         xZHnzEZ+7DXjUy5rTPZWybSYulgBhsW73ooGaC24Zx56Husw4PSUeNgCcGdgi/FMfvav
         y71r5kubDkJ6gI34zb9fRaCtPgDfcsQaBhSrCe1WErIeiXDXBM1EwW4ZdvGfXGpTqYZm
         7eHSENHGLBsXMcXoD4YzdhuOKvJUXn9IXepoM3vdArjgXCBi6QmulnkBpHHjKGrafFqE
         l5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSsfBY73FO1UU5jzBVaE+iGEtOR0A4j37n3sHs5sps4=;
        b=YIRPl4Wn11gr7U6A5RBideUQ830Fe2ZujBbcYnWTOSoEs1JkG904um2uNbXVMNLuol
         eUIfQ2U1moys7u32tUEi1w6MC70jOkGpwAOI9W3uEma70y6ptrX4bsceVuUgnb2asbCu
         8XsNX1jO5kTvcHOLXxjBfrtcXdkyTQ7FnZI5wp1g65vVuVp3EilkwWFaOvYLkZ1ATLSP
         xCy9drXzBMmbrHHotoFV01Sse7LYVmJyLDKIqKy3Nc1pqcDWhF2wzanBkQMnHlGCz1ce
         4s5w2jrHBCVkxwzkpprH4mc45jaGGwa6XxNzufYO/yTcY1FHFwCH0DL2lsrfTHM5cpFX
         E4XA==
X-Gm-Message-State: APjAAAXTbYZQrB35QU6ex7KxxvK8pPRXNi73FtRb6cmAxgdUNrIlUyN3
        v8U0Acawfn8Pu6eKHFlhqMaTLHA4iooCpybA6C10A+ZRuLA=
X-Google-Smtp-Source: APXvYqzZhItrGvjmEVClJemEdRwzFF3r8PKOpw8V1evmgfA844Rpa8qbof9FRLCpxj7UY6GFXwkSfPjbqcW82VPMH9Y=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr3139782wrn.124.1581672189119;
 Fri, 14 Feb 2020 01:23:09 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p> <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com> <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org>
In-Reply-To: <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 14 Feb 2020 17:22:57 +0800
Message-ID: <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Salman Qazi <sqazi@google.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 14, 2020 at 1:50 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-13 11:21, Salman Qazi wrote:
> > AFAICT, This is not actually sufficient, because the issuer of the bio
> > is waiting for the entire bio, regardless of how it is split later.
> > But, also there isn't a good mapping between the size of the secure
> > discard and how long it will take.  If given the geometry of a flash
> > device, it is not hard to construct a scenario where a relatively
> > small secure discard (few thousand sectors) will take a very long time
> > (multiple seconds).
> >
> > Having said that, I don't like neutering the hung task timer either.
>
> Hi Salman,
>
> How about modifying the block layer such that completions of bio
> fragments are considered as task activity? I think that bio splitting is
> rare enough for such a change not to affect performance of the hot path.

Are you sure that the task hung warning won't be triggered in case of
non-splitting?

>
> How about setting max_discard_segments such that a discard always
> completes in less than half the hung task timeout? This may make
> discards a bit slower for one particular block driver but I think that's
> better than hung task complaints.

I am afraid you can't find a golden setting max_discard_segments working
for every drivers. Even it is found, the performance  may have been affected.

So just wondering why not take the simple approach used in blk_execute_rq()?

Thanks,
Ming Lei

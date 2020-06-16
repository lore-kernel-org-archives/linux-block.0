Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6452AC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 11:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C4920786
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 11:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUsfdubc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFPLNE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:13:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58392 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbgFPLND (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 07:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592305982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fYBk2H3U1f+pIy7QDyXrQYJ9ikO/21+702smWTVcFik=;
        b=SUsfdubcTIE3CFZuY0+aK5rc1stp/7gNOdTNegiMG7nhd5YdgItXjgrYPsK4uEhxa+uwZe
        KWWVv413JkfuSa761G22pd/qO66VIP/UZXlH+g2hguZsvKyJNOHbL7fhIm+oowuqO04g4q
        I+TsgXdGWnb/4E+Ko73tXfi475hB0yk=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-DoQqIrDvMxCwl0GJtSeEWw-1; Tue, 16 Jun 2020 07:13:00 -0400
X-MC-Unique: DoQqIrDvMxCwl0GJtSeEWw-1
Received: by mail-ua1-f71.google.com with SMTP id k12so8341088uag.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 04:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYBk2H3U1f+pIy7QDyXrQYJ9ikO/21+702smWTVcFik=;
        b=kLqRZt/pw5s9ALuXiScXRHu4LwL57eD2Tgpa2eDKxpObPjGVlDmduHZkgc5KXdkzdN
         ggGcosf0SG7nGQtdNAGF6NN4EHFzao6J+30ddIMt1bQuwqCerseCgv2wSHY9uAA/wbaD
         DWcPAjnOW/mjHNGRiWlHELhKV9HjJtCel4dipb6xfrS1RQzLoYx48DV4Ijg9CmKX9+sV
         zpWA6Wrco6z77Pwtn64kpjCdzxwEMqX4997QRGbWe1gopIrCg/LAUCeuwCzCn6bBILVM
         Zviv/YT6BkloYlw9xXRLsb07JfYSvsEK6xA223BIR9Cv5ughAy1hUApEPPwwwhF/N5qT
         6IjQ==
X-Gm-Message-State: AOAM530MSFAHbsVxffL2yATjK4gRq9chcHLW4jJI9/FnkiPGPhXwheTB
        vdr5wxrQlt2qV5yETtarE4JtJl7nkveoCMFnuJJ4NYs8PmEgJ16cYnW8387mnS6IFvw8Whj2u9L
        lWo45y5hUrOdosomNNAHuWKZx72NeqYc2/H2fv5s=
X-Received: by 2002:a67:8c89:: with SMTP id o131mr1150039vsd.218.1592305979863;
        Tue, 16 Jun 2020 04:12:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbkBrFFQdF4fYmZIOLCam06HEuM7KzNrul02YEkbn2UbOwmC7p9Jd7Wtd0K9SY09rpeXySGe37nevPAsXYsjY=
X-Received: by 2002:a67:8c89:: with SMTP id o131mr1150028vsd.218.1592305979650;
 Tue, 16 Jun 2020 04:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com> <20200616072955.GA30385@infradead.org>
In-Reply-To: <20200616072955.GA30385@infradead.org>
From:   Sweet Tea Dorminy <sweettea@redhat.com>
Date:   Tue, 16 Jun 2020 07:12:48 -0400
Message-ID: <CAMeeMh-beYNtEA1TVvO5v=6BAnqSyyAFgkFN=Ngr2Z0UDfipSA@mail.gmail.com>
Subject: Re: [PATCH] block: add split_alignment for request queue
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-block@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph;

Forgive me my newness and not understanding most subtleties, but I
don't actually understand why you say "that is a completely bogus
assumption" -- could you please elaborate or point me at a
document/code/list archive explaining?

Thanks in advance!

John

On Tue, Jun 16, 2020 at 3:30 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jun 15, 2020 at 05:56:33PM -0700, Harshad Shirwadkar wrote:
> > This feature allows the user to control the alignment at which request
> > queue is allowed to split bios. Google CloudSQL's 16k user space
> > application expects that direct io writes aligned at 16k boundary in
> > the user-space are not split by kernel at non-16k boundaries.
>
> That is a completely bogus assumptions and people who think they can
> make that assumption should not be allowed to write software.
>
> Can we stop this crap now please?
>


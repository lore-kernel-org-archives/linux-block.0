Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598DDC3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 19:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331D220707
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 19:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ZcYngXLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgEDTdB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 15:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 15:33:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B81C061A0E
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 12:33:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u15so10953075ljd.3
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tdFYvcT41YTzDNkVNPYHdUeYPdsLJc2p6xhg5qcub4=;
        b=ZcYngXLRhMQTpLXO72cOeMJqVDo7zn5U+X30jFwooH99mYem72aqdll6QcOUOdolf1
         yZ2Nw1UT5jrg3DuyEjncVGxoizLKmC/DdOaZ1wK9181qeWP04byoxNFMI6AfdXGKrlIf
         bdh+9WykdVshHWpexorcenm6Pk8eK9pH7PvgonOmco+g2AnCZHAlvQjBACS0RWebJ2Nc
         3NzDgJ5swnjBSZSrLFr7bBZgo523Nr+2sAGgtLmqKrtwQjypJuiOlm6B6OvZBZ6uYzMI
         aRxUQfxBnTuEu/je27gvbezsso5Hpvpf8YjK6ziAGiJIIpkuugzwl2VuRCdE42+OxM9e
         F1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tdFYvcT41YTzDNkVNPYHdUeYPdsLJc2p6xhg5qcub4=;
        b=PJ7Qxc2erMYwdAUsZApl/mae/YyweT7OWdFv7LnOg/QGQNuM3MQy2Q9MDvUEkkPkct
         DK81kTPhMsQxOVAEd+q7qjiDBhe9UHQ7etbi+Uw9q2fquXsOKcmLl898apo2VvkKeVmm
         LFyg5sPIEegnjJZPnAj3gL66dJ0Ep24nsApvGnS5oMH4CBXIsINXiAtrYTjsd75HuP5U
         pPBg+o87LUYRh4eEcUC77us1gX/9/MeMo2GfCPI6jtbUPVBrWeLfH3Ww2UlV7IRrZ3wU
         Uj1GvJa9cFVy9uKnU3LbmZTY8bs7xfQtnlHyZAv1wyVzBl4oJE+rLcI2ohBvCQvqKvVW
         eJ2w==
X-Gm-Message-State: AGi0Pua64iDPb4VYAJtd6B5+4qjyUX1ibffdtLWozGjwMMc9z2ncli3J
        AZsD4zkmifrw1zVmu5iGGaGFShAMgnQxRHfEGPVKFPGe5bs=
X-Google-Smtp-Source: APiQypJu4Wc5TNYHL7fFHBQGROIySU294VVImxL3I24hySbhKnWnxQmTtqGmH5Sad8lXifiP/QcTsVhMmn0uJmvSP00=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr11422070ljk.134.1588620778130;
 Mon, 04 May 2020 12:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114116.21642-1-maco@android.com> <3cd82069-0ed6-688f-0d7c-bb0c5ccb0e5b@acm.org>
In-Reply-To: <3cd82069-0ed6-688f-0d7c-bb0c5ccb0e5b@acm.org>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 4 May 2020 21:32:47 +0200
Message-ID: <CAB0TPYHMF0rMkVryEW0oshbdkjdjGhfL_Z5E-Dy0vnYK8m2KNQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Call loop_config_discard() only after new config is applied.
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Are you ok with this one? One of my later series depends on it, but so
far I've kept it separate because it's a bug fix.

Thanks,
Martijn

On Sat, Apr 18, 2020 at 5:46 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-31 04:41, Martijn Coenen wrote:
> > loop_set_status() calls loop_config_discard() to configure discard for
> > the loop device; however, the discard configuration depends on whether
> > the loop device uses encryption, and when we call it the encryption
> > configuration has not been updated yet. Move the call down so we apply
> > the correct discard configuration based on the new configuration.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

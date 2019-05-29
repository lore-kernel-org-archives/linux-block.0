Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A4AC04AB3
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 07:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67918208C3
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 07:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1iCH5bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfE2HkY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 03:40:24 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37069 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfE2HkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 03:40:24 -0400
Received: by mail-yb1-f195.google.com with SMTP id l66so439268ybf.4;
        Wed, 29 May 2019 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uf3XOVAHfXPCfr8dRyPpWkbOd4puvL3Lbr0iJDk5Q1I=;
        b=C1iCH5bpm711M72M5wAAm0k0Bt6GL6CJyoDkgSHvbUnNwNQYbdMRkND6Vpr8qgJX82
         lErBtEWsqcfIM9vfpnHcox926VPvuk9LKTzIFg+n04RgowmsU4r5AhUwZF+lhv/f0cTP
         9qFhKjr+T7stLtNiN5WfMxsQL7BoUKeGP7HsLF0XxEABHFaKJ/XXKurM5FUvSZvm2vn1
         r09nsiiputvR6gZRit0BfEFUZd+ioZYtCk9qPMK0Nc/+mMSqRfSed8sn3gcoebfb9/+z
         xTdMYFBm+BjWp51NS/OMiuhvikkDavrlP4VtaqIPU7h9jWV63c6GtghCzx9v8K7O8iS/
         K6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uf3XOVAHfXPCfr8dRyPpWkbOd4puvL3Lbr0iJDk5Q1I=;
        b=SVPVmoVNuI82G1b4Ml6vyAtul5FcvhW2T9UXX4fhGsn+9SSzm9UQx+tsmE92EKfCuw
         ZTJd+559kN7VfZcG/bQ483QcNPt+zqy/FI+PsRTcKnNYbz5k0sT6bsJwBdo2dkBHzoos
         WklGtL2wRWKCIP5/aOyTa88SgYwtlAF6TuAmtUDEqBKjjVZcG1qDjYgwNrIchKZUA9oq
         wXyy52UD9lyZD/KFYMxSzNbdAYamu7blPyXYG8Gqp91sjNV9Fx7Mm+ptzYfki0DEC3uH
         LRx2kVOdI3f4yo2cdEQ9fHswyGjO0WBrxj+pRMAEN1yoiuwx7P8RR02M8Gq2YeoLkmTL
         9c8Q==
X-Gm-Message-State: APjAAAUXECDPrEEO+spvtCt7rSD+k5oUEdSP9J+r7l9O+MHrIf/MUgmR
        OkvpD2USwibfWjnaez/7YJQ6kl8uOP3KL4xGrRs=
X-Google-Smtp-Source: APXvYqwZABQOcup+HXgYpJiSytFgde+d348ySrWsdcR9Kv4BV37H74k/0aqOaZHjIz1K+LhGOCYMbvlhdcakMq/WNQw=
X-Received: by 2002:a25:4489:: with SMTP id r131mr6122190yba.14.1559115623559;
 Wed, 29 May 2019 00:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <CAOQ4uxjC1M7jwjd9zSaSa6UW2dbEjc+ZbFSo7j9F1YHAQxQ8LQ@mail.gmail.com> <22971.1559112346@warthog.procyon.org.uk>
In-Reply-To: <22971.1559112346@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 10:40:11 +0300
Message-ID: <CAOQ4uxiBMmDg2Rn2+jsexTdK7g25J7WD79chDdRvofrvC_PLXQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 9:45 AM David Howells <dhowells@redhat.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I am interested to know how you envision filesystem notifications would
> > look with this interface.
>
> What sort of events are you thinking of by "filesystem notifications"?  You
> mean things like file changes?

I mean all the events provided by
http://man7.org/linux/man-pages/man7/fanotify.7.html

Which was recently (v4.20) extended to support watching a super block
and more recently (v5.1) extended to support watching directory entry
modifications.

Thanks,
Amir.

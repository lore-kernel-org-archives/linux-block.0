Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7134EC2D0FD
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 07:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D0206F5
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 07:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="J9qIkN4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgEMHH6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgEMHH5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 03:07:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B91C061A0E
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 00:07:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so12680703lfb.8
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mW8RDOfapkDaoa0Hb9EShwMwCn8vakzjoyWs3SU+BGc=;
        b=J9qIkN4GOdr3b0TDdPyfF5iwQMxySZVVwyEt4C2nQgvCPYow2lWfeAh6Hp3j2u3g+0
         CpAXZ6pgAlgu0Ac73YY7tSAw8K/WpZwe+TL3PY2N7q4H3UgoHoR4E6LAZb8BH8Uz5BA9
         CxtS+rvDyaC4WK604GPAD+E7pJgAu0if/r4q3rMZ3gPPEPNWMJSBVkCxXcTwQEl/+Yp9
         nFBEKSpOH3hes9GiSy/N6Wuq+8s6+uIG3u9MDIxDbNkwklUr38268FXRPsFgWahImOOK
         8sbQIU05WISkLCPgzq+D6VBy9LU2GtYEyPW9tSD+GlaCyHxbY5VsYmBhcZuLsS+9bE7Z
         tHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW8RDOfapkDaoa0Hb9EShwMwCn8vakzjoyWs3SU+BGc=;
        b=iKl3bxbfRAIkrKvTProb3mXTzXCjWEjJOm8IPen8kCF3vSB7Q0PUBwHhR3EIa82kZ4
         wYF0XUbKeCIDEBwPaQu9f2nkGj5HBuiBSLJ2Y2XIVnld17MAWhzN0YlZW7rtCMKA+d1v
         XlEZy+f+1VMdcz+BTAloSgAHxNcvJt2xypu/GLO4L6sFJkj+9p+N2+P4R2F4TiRe9/jd
         Uy8XEOW22BV6+J/HVMhg3sFXeZXs25grDNy8tvQ5fKBF6Vt+P0q2EQbGlhPV/X2GnJnu
         7vbYslBtKI0nBHOpslEnGouqCpUfKtjmlYD40T2F2lalkPv0Qj1kFX6KZg+65at0RZfD
         H+WA==
X-Gm-Message-State: AOAM533a7ouYd+qo3iD4oGy0DdEyLeRVgowLU9UghdRvwsw0oFqixNHV
        zz3knNcUadghnUNaePRalGq/j1Dvryv+zeRzihDy8Q==
X-Google-Smtp-Source: ABdhPJzDwBLW0Ng55ay6pVZ/lv4nKFNfw9bBAXMfoDctZFD/KSd0XtGRMmmuj+JMpqtM15bEUnfuAGGNF+u0G5wmXU4=
X-Received: by 2002:a19:ec7:: with SMTP id 190mr17595542lfo.203.1589353674058;
 Wed, 13 May 2020 00:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
 <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk> <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk>
In-Reply-To: <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 13 May 2020 09:07:43 +0200
Message-ID: <CAB0TPYHikHc3tTTQcUOOZsYZmqNxGtthpkPX_z6dKgy+V8kovg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 4:30 AM Jens Axboe <axboe@kernel.dk> wrote:
> > Looks acceptable to me, but I'm getting a failure applying it to
> > for-5.8/drivers on this patch:
> >
> > Applying: loop: Refactor loop_set_status() size calculation
> >
> > So you'll probably want to respin on the right branch.

This series depends on a separate bugfix I sent to LKML earlier - see
https://lkml.org/lkml/2020/3/31/755 . I mentioned it in [00/10] of
this series, but perhaps I should have just included that patch.

I just verified that patch + this series still applies cleanly on your
for-5.8/drivers tree, but if you prefer I send a v5 with that patch
going first let me know.

Thanks,
Martijn



>
> Then you can also drop patch #1.
>
> --
> Jens Axboe
>

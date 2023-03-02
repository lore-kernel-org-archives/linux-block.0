Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBA8C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 09:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCBJPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 04:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBJPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 04:15:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3F136F2
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 01:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677748470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gn95fNZsWohda/Gt3RBIsmBf9yhGLuJiMqSDf2HskJM=;
        b=J7KpUdE8EK4IH/BFn7aFsNVrgoAHJibVqEi+fw/YcJd22mpDP8M0gKnZwmIpkO7tbFvh13
        3E7vRjoWnprXLxyY3LfVoHDuV4UStcFlljy6djDIMPwrRxk6mxHhmDHk4QWNdQqaSSrOlu
        cK0hmPXSIOZhhmDxL6MS92Shl3bXIOc=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-plMmQZdbNTOogBfHVPli7A-1; Thu, 02 Mar 2023 04:14:26 -0500
X-MC-Unique: plMmQZdbNTOogBfHVPli7A-1
Received: by mail-vs1-f71.google.com with SMTP id df27-20020a056102441b00b004216a8c8b91so5780279vsb.17
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 01:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677748465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn95fNZsWohda/Gt3RBIsmBf9yhGLuJiMqSDf2HskJM=;
        b=L+GIKJaNBnSZx+tUq7tmldxOb9F2IODLhyHJgRqRlC4Uellg5+fcJdqIypLVwKagVB
         n2uNy+ssC623/vpsxX4YmK7di9Ui75kx6ojeor8c48Y93TUNWpXyhlkZBHjQ/yFXTnMs
         io2kFTEeqcWLeCr8Lyvq7QxuReKLJfsrSwyWmoWBR6UXVMgR+XxpVZFu4W49Di1e+bmw
         SgpjXojxplP5FPWPln1kKZ8d9J/KxrDv4NLQL+iVj/1UhXg4xC2Vl7S+5a8z4i+3/zKh
         DdP034OuZ7g//oM8LSKot76gye3jfJg4+XCqmxTTppeGvHDdjk3QToCxKgr3y85WSIFo
         HWMQ==
X-Gm-Message-State: AO0yUKUA9JGsYMRN7JJN58I9woCBshgz1cNArsq693+rV2nqD1zfT4J2
        3/wjtiQByKXgAEWo2aYMFiRtjZjNLGP1bOi0b4++QwYblR5Uv3xD6u6r1HC8+NgBaQRR8sFT3jZ
        etq6RO1qqZVMhbF8wuJtTbdL0ilh38KmyH9d6B3M=
X-Received: by 2002:a67:b910:0:b0:412:364c:68be with SMTP id q16-20020a67b910000000b00412364c68bemr6074227vsn.7.1677748465726;
        Thu, 02 Mar 2023 01:14:25 -0800 (PST)
X-Google-Smtp-Source: AK7set9yW7PU8Zj8MjrA77EC8H0DigRUOzdN0Dz8qC8KWJKL3ib/eNM3P5KnWHbX3gi8isXs+lAWQfcMSDapi1ZlXxs=
X-Received: by 2002:a67:b910:0:b0:412:364c:68be with SMTP id
 q16-20020a67b910000000b00412364c68bemr6074220vsn.7.1677748465514; Thu, 02 Mar
 2023 01:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20230224200502.391570-1-nmi@metaspace.dk> <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk> <ZABfFW+28Jlxq+Ew@T590> <ZABmAR6Du1tUVEa7@T590>
In-Reply-To: <ZABmAR6Du1tUVEa7@T590>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 2 Mar 2023 17:14:13 +0800
Message-ID: <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 2, 2023 at 5:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
> > >
>
> ...
>
> > >
> > > I agree about fetching more zones. However, it is no good to fetch up=
 to
> > > a max, since the requested zone report may less than max. I was
> >
> > Short read should always be supported, so the interface may need to
> > return how many zones in single command, please refer to nvme_ns_report=
_zones().
>
> blk_zone is part of uapi, maybe the short read can be figured out by
> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
> reporting zones.

oops, we have blk_zone_report data for reporting zones to userspace already=
,
see blkdev_report_zones_ioctl(), then this way can be re-used for getting z=
one
report from ublk server too, right?

Thanks,
Ming


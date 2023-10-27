Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09995C25B6E
	for <linux-block@archiver.kernel.org>; Fri, 27 Oct 2023 12:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjJ0MGQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Oct 2023 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbjJ0MGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2023 08:06:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B6011F
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 05:06:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc209561c3so90545ad.0
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698408372; x=1699013172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQHQ463K822d0eu3lSUzX50hYKP6nmOhDBx20ObjtTc=;
        b=I2oYKKgAC1sTJYcIs5n2w/uDCwCmxUcLpbJVQBcv31qrGHWyQ45G8uWgU0EpzwU65i
         /aktVLo94NjG1Ceq+VaSXNAWK2kxF92RUlFOuV4ljVloYQsWeRDwNMRIMrWEV051HUYV
         GS7SSB+Es8bwa2ttJgjDDopbgmqvC20qTKAn50Vb1XujZyYA1QaTXfdoGdE6183ARW4k
         Zsi1eGiP2T7JLgzTh0VW+cSb/+dhiV0+RuHyciakgJ10Fk3KeXtvDAk/jYarg4bG3roK
         Lxbvv5oBH/azAgWljC3DBSVf/qOVt/vD9aJPwp9P/3TgQHxxYqrt2M81nXh9OKh5ofI7
         wbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408372; x=1699013172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQHQ463K822d0eu3lSUzX50hYKP6nmOhDBx20ObjtTc=;
        b=ITkscJIw47LsKEHGfKL4Ga94zJrZkZU6Xm+fgQ/dR1QTQczgpXWPg2ot39Dh6QdP8c
         +IYQN9aenu9gfKvb+zclgD5oAh5De13l5Dbomh3DuEXVm9vRiB0gVZ4sAAYePdvHPaFY
         HXar0sXZGG39BK3qJz+ov23qkXqX1q/k3Z310sfDg/BnpfhufdO4O7Meqn15+chF7G+q
         xMaWqdCfmMSnyQ7bNEKz55oY5QUgiRu2Yz3VXyzrHMY8LoJ8Ag1/yf5C2gdzZxKrSYJ1
         jJLmN7XghTwHmZiagzuJEMkKX82tQFxm2hkUoBVibIE5lag5uAJaO6h6tQpApGdopi+3
         aGqQ==
X-Gm-Message-State: AOJu0Yzs0/urSaTjR268bj7KgqnGE5Y57zjH+5n7nQA/8+oMM9x6yUQj
        0tUoh4VyaBsAJIj6QF2colME68ON/btyA2I//fyLFw==
X-Google-Smtp-Source: AGHT+IHaExLG43RBJIionRW/c9b84KpmLdtS6fNiD0MK5F1uxefsg3PebOwhWetdV53Pmmf6YDEOuPH/Hzj0pzzd92E=
X-Received: by 2002:a17:902:ea0e:b0:1ca:209c:d7b9 with SMTP id
 s14-20020a170902ea0e00b001ca209cd7b9mr217852plg.2.1698408372181; Fri, 27 Oct
 2023 05:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230704122727.17096-1-jack@suse.cz> <20230704125702.23180-1-jack@suse.cz>
 <20230822053523.GA8949@sol.localdomain> <20230822101154.7udsf4tdwtns2prj@quack3>
 <CANp29Y6uBuSzLXuCMGzVNZjT+xFqV4dtWKWb7GR7Opx__Diuzg@mail.gmail.com> <20231024111015.k4sbjpw5fa46k6il@quack3>
In-Reply-To: <20231024111015.k4sbjpw5fa46k6il@quack3>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 27 Oct 2023 14:06:00 +0200
Message-ID: <CANp29Y7kB5rYqmig3bmzGkCc9CVZk9d=LVEPx9_Z+binfwzqEw@mail.gmail.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I see, thanks for sharing the details!

We'll set CONFIG_BLK_DEV_WRITE_MOUNTED=3Dn on syzbot once the series is
in linux-next.

On Tue, Oct 24, 2023 at 1:10=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Thu 19-10-23 11:16:55, Aleksandr Nogikh wrote:
> > Thank you for the series!
> >
> > Have you already had a chance to push an updated version of it?
> > I tried to search LKML, but didn't find anything.
> >
> > Or did you decide to put it off until later?
>
> So there is preliminary series sitting in VFS tree that changes how block
> devices are open. There are some conflicts with btrfs tree and bcachefs
> merge that complicate all this (plus there was quite some churn in VFS
> itself due to changing rules how block devices are open) so I didn't push
> out the series that actually forbids opening of mounted block devices
> because that would cause a "merge from hell" issues. I plan to push out t=
he
> remaining patches once the merge window closes and all the dependencies a=
re
> hopefully in a stable state. Maybe I can push out the series earlier base=
d
> on linux-next so that people can have a look at the current state.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

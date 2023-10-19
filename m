Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5499CDB465
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 09:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjJSJIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJSJIK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 05:08:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76CFE
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 02:08:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so7581a12.0
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697706487; x=1698311287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut1u++pUnprqXDu+7d3k9MbS7GT1qangQpeLiBStwV0=;
        b=CnTHOWNbYRDvqqmiXsrNlG7n9ob5nZNYPUu9mapAFOo+slCpEbSvNUuL4xMohEU8vT
         DrSDAonN7742PfmmlBvJoQHUWkLINCVWKjOJvz7739fcFRPgS11SUa80a+WZCubq35l9
         6b30v0zYw13lSh8qTv6eKOBBLn+H2VIjminyg4fBoxb+tFuFCfLD0y+9PqwWJ2bg8Xng
         zEtd6NrBT+gIpv+L1Y2RAN3FeFi7WR2RPvYGLwlvSvcEVKCtOnX9Hog4iNX0D3l2sg4G
         mJ6TtHzDZ25I2dPHHdb/EknjhxeSv+xCVbyC4rF3SBMjkYgaWLh0V9kJ41dNyG7rueVO
         s6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697706487; x=1698311287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut1u++pUnprqXDu+7d3k9MbS7GT1qangQpeLiBStwV0=;
        b=njRD51jJcNYHtH4/hsO5VR8q3QfkU2cyOh9W+Mlm4cHHIVbLZEkSUk9zJFkDeGxuz9
         aUsRyXT2oLNZhgRpZAo+yjgCm3DItC73CVVsRrdoCtwqMxtc/9DBfMqQc8/q673pdF/K
         GVYlw5TdI5zHxRp6EisnQ+n3/NmABhRNtQNzcUrUjObhT+nfgovqMVtACiQLir7yAZyH
         cnb4Fj4Pz3fYs33czLivaZZ6Hi6YhB8PgxfgprZzXZw2k1CD2FmxMA3jAG82UsTa2Mdb
         /cxObQHr5XXiET/UzpaAu1vyYohqhmhDgnk6u1cgWgsq3G6Si0dKQNm/Mp9Z0JdAhiah
         CIBg==
X-Gm-Message-State: AOJu0YyWJ3+LkZHtuSqu7hP33veLaW4w9M0D94r9hYpTUJ7qlJolSr6w
        eK6ASUxKxM3jZ66O4jL47HP+eRQGgeofQcId0EtaIQ==
X-Google-Smtp-Source: AGHT+IG4JcoaLNwjNx17ut2GEUh9WtVu3+ZvbgjZVKAPsxDcj/V4LWL8PB/GK1yuubG0rKt6q+IWuxTYvq11jCh0CAg=
X-Received: by 2002:a50:f613:0:b0:53f:2694:c3d5 with SMTP id
 c19-20020a50f613000000b0053f2694c3d5mr112645edn.6.1697706486772; Thu, 19 Oct
 2023 02:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003b14000606e7f15b@google.com> <f5d66783-b8ca-4f81-9d24-faaf00961dc7@kernel.dk>
In-Reply-To: <f5d66783-b8ca-4f81-9d24-faaf00961dc7@kernel.dk>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 19 Oct 2023 11:07:50 +0200
Message-ID: <CANp29Y5VzndnC2dka2tHxFdD8wq6cs+KC7iy7gK4dKrbbtX6Xw@mail.gmail.com>
Subject: Re: [syzbot] [block?] WARNING in __floppy_read_block_0 (3)
To:     efremov@linux.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+06ecd359d1a53c832788@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've updated configs[1] so that syzbot won't send any floppy driver
reports to LKML (they'll only be displayed on the web dashboard with a
special tag).

If the driver gets rewritten or there's again interest in floppy
reports, please let us know.

[1] https://github.com/google/syzkaller/pull/4273

On Wed, Oct 4, 2023 at 8:52=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> I'll keep saying this:
>
> https://lore.kernel.org/all/7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.d=
k/
>
> but apparently nobody is listening.
>
> --
> Jens Axboe
>
>

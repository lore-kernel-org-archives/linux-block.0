Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE54C77B7E
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 09:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjEBJQR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 May 2023 05:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBJQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2023 05:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEC54237
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 02:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B7DF615A2
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 09:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A058C4339B
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 09:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683018974;
        bh=dqx/wjcFq2JhnEZiDCxKAYmE5VX7jiGXDMMs95Jgst4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qFen1Ffkcux4jHaPHkxPgfoA7hZd9inMbYtO7x71G8a0mWrPPhHVxJK2tvDpsMBJ1
         jcuKm6Lp7jbRt8XW+cHCfQ2AW2mJuYZdItu0sra3xtSiUnExmLihD8Ma3OmnClzdCt
         mNWi+MdYQqINxwW6SDVtN0hkwF4s69ON/hzljlIvhixX1o3PvC2sI2Vb+JPQ46M057
         /qgr84pgk7n1FfIQi6L9kLdMOGyYSAIxup7S0AN6hav04bvqTnl2yHEKSOB/0CzNce
         e5KFbPhc4fH3vAqbGTTj7EY5RKgLcWVQMLEdACQbA+d6Es2+9lP0qEUYpH9F0BK5y/
         zf1NVibxsdfRw==
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4404c9d9fceso1207893e0c.2
        for <linux-block@vger.kernel.org>; Tue, 02 May 2023 02:16:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDzm3HlWg6mmfgGwU4W0fUsoWn2EEqqyfaDtYsNUad30Yc/443ip
        B5Uvj21ysFAaYzIBeZFwP0xsNzMM9yT8zdHxkOc=
X-Google-Smtp-Source: ACHHUZ4HrGEmyMng7rujh2owvb22nzURl9p2YCD3GaaUiW2403z50b1S9NCWXmTELxfwOe/78olkX9aOkgrtfiS48K0=
X-Received: by 2002:a1f:3f02:0:b0:440:19fe:1790 with SMTP id
 m2-20020a1f3f02000000b0044019fe1790mr5527396vka.1.1683018973372; Tue, 02 May
 2023 02:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230502090018.169275-1-mcgrof@kernel.org> <3b2d04b8-e7ac-81a1-1751-f63403713a27@suse.de>
In-Reply-To: <3b2d04b8-e7ac-81a1-1751-f63403713a27@suse.de>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 2 May 2023 02:16:02 -0700
X-Gmail-Original-Message-ID: <CAB=NE6Vi5JcWVqe1A9fRgVM1wg17FbSLfbdhuvz_uBsBqe+UoA@mail.gmail.com>
Message-ID: <CAB=NE6Vi5JcWVqe1A9fRgVM1wg17FbSLfbdhuvz_uBsBqe+UoA@mail.gmail.com>
Subject: Re: [RFC] block: dio: immediately fail when count < logical block size
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, kbusch@kernel.org,
        willy@infradead.org, p.raghav@samsung.com, da.gomez@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 2, 2023 at 2:11=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 5/2/23 11:00, Luis Chamberlain wrote:
> > When using direct IO of say 4k on a 32k physical block size device
> > we crash. The amount of data requested must match the minimum IO suppor=
ted
> > by the device but instead we take it for a ride right now and try to fa=
il
> > later after checking alignments.
>
> Something is askew with that reasoning.
> If the above were true, we would also crash if we were attempting a 512
> byte direct I/O write on a 4k drive.

We do fail, the question is if the math with iov_iter_revert() is
right for the failed return value when unaligned.

> And I'm reasonably sure that we don't.
>
> So where's the difference?

I think a different return value used which busts iov_iter_revert().

  Luis

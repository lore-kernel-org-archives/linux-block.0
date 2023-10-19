Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F98ACDB465
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 07:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjJSHRT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 03:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSHRS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 03:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBB9F
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697699793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHJcZu1bgZMSOtJcLmzf/C1viqUT3ZpBLIx/Hxz6KbA=;
        b=GuBcPdOH0hI6KtxL13ZM8O5zx8WfJa6HlFtcxEWc9BfZeiu+LmuAa3uUcGksf1kif6Hv8t
        zwZmurUVqxB4nSlTKuo35XVv+zUoAPHaZvknWwRnIeJ0XJU9uHftl+9l/7zifTSYvWr0WO
        XCIYrF732Of/sOqV/jB+s/lwpdulx0g=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-OJyo0RocPP6DA4iyWOiFkw-1; Thu, 19 Oct 2023 03:16:26 -0400
X-MC-Unique: OJyo0RocPP6DA4iyWOiFkw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1dcdb642868so10480017fac.0
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 00:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699785; x=1698304585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHJcZu1bgZMSOtJcLmzf/C1viqUT3ZpBLIx/Hxz6KbA=;
        b=f4sYE5qWUlQlFFh+Uwlq3tAsg2yPstS/Fz3oX+uUjP9jQSBTuk372N9A9DmvzjNTvX
         gH7+uriHqIdrAWLsWq0NxVgk2zVsYXScNyZUHzSb0/VgcYvIvot5R1tBvCgikC0wj+zS
         /r2EGtpAARiqpuwP7eeYmPSf5hPUdf3A77Se4NFjiaPk9ndID89g90uSC705JJeuhFAG
         Ok2vnf42NoDvj4t+IIOU/xsQJX4Eeaf/NhafcWU8e1EIasQL6gN8/nCaiRizLWuI4bYY
         WBNEnPwlYndEMXv1aGAdDu2rPXvzx5YSMAjYzxXI1oA3ayeinP4MRHgdmQM11nIMX6W3
         3zLQ==
X-Gm-Message-State: AOJu0YxbO+YyK6D7HoPy8UbplC56mDb8v8RU4yuKRyj8t6gWJP9uT6W4
        t2PDCvgTLKl85NXtnlbS+rn8IrbWOrszMQAsCS75iwr/mwPZv8bvCZZ+2OcwBrIsyciv7dPZuox
        uMWOXEAi74lbAaEgzdo/Y74oUlTd9phlgFYt0sWeiM1DAehZXUh6ARtQ=
X-Received: by 2002:a05:6870:8a24:b0:1e9:54a3:9884 with SMTP id p36-20020a0568708a2400b001e954a39884mr1804696oaq.15.1697699785120;
        Thu, 19 Oct 2023 00:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFctZqZZ+bT7uBFh0uztVUPwCwtBGtBIayvNkFmHfDUpc2UDDf9XigvO//Gh/P1uvkMHOoskeKA/bgOfGRyEi0=
X-Received: by 2002:a05:6870:8a24:b0:1e9:54a3:9884 with SMTP id
 p36-20020a0568708a2400b001e954a39884mr1804688oaq.15.1697699784906; Thu, 19
 Oct 2023 00:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
In-Reply-To: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 19 Oct 2023 15:16:13 +0800
Message-ID: <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
Subject: Re: [bug report][bisected] nvme authentication setup failed observed
 during blktests nvme/041 nvme/042 nvme/043
To:     Hannes Reinecke <hare@suse.de>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Maurizio Lombardi <mlombard@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hanns

Bisect shows it was introduced with this commit.

commit d680063482885c15d68e958212c3d6ad40a510dd (HEAD)
Author: Hannes Reinecke <hare@suse.de>
Date:   Thu Oct 12 14:22:48 2023 +0200

    nvme: rework NVME_AUTH Kconfig selection

    Having a single Kconfig symbol NVME_AUTH conflates the selection
    of the authentication functions from nvme/common and nvme/host,
    causing kbuild robot to complain when building the nvme target
    only. So introduce a Kconfig symbol NVME_HOST_AUTH for the nvme
    host bits and use NVME_AUTH for the common functions only.
    And move the CRYPTO selection into nvme/common to make it
    easier to read.

On Wed, Oct 18, 2023 at 2:57=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hello
> Just found the blktests nvme/041 nvme/042 nvme/043[2] failed on the
> latest linux-block/for-next[1],
> from the log I can see it was due to authentication setup failed,
> please help check it, thanks.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log=
/?h=3Dfor-next
> e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
> 'for-6.7/block' into for-next
>
> [2]
> # ./check nvme/041
> nvme/041 (Create authenticated connections)                  [failed]
>     runtime  3.274s  ...  3.980s
>     --- tests/nvme/041.out      2023-10-17 08:02:17.046653814 -0400
>     +++ /root/blktests/results/nodev/nvme/041.out.bad   2023-10-18
> 02:50:03.496539083 -0400
>     @@ -2,5 +2,5 @@
>      Test unauthenticated connection (should fail)
>      NQN:blktests-subsystem-1 disconnected 0 controller(s)
>      Test authenticated connection
>     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
>     +NQN:blktests-subsystem-1 disconnected 0 controller(s)
>      Test complete
>
> # dmesg
> [ 2701.636964] loop: module loaded
> [ 2702.074262] run blktests nvme/041 at 2023-10-18 02:49:59
> [ 2702.302067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 2702.447496] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> with DH-HMAC-CHAP.
> [ 2702.447707] nvme nvme0: qid 0: authentication setup failed
> [ 2704.099618] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> with DH-HMAC-CHAP.
> [ 2704.099688] nvme nvme0: qid 0: authentication setup failed
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


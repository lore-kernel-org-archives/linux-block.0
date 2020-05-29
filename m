Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB55BC433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 22:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25AB20810
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 22:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgr42ZBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgE2WXW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 18:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgE2WXU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 18:23:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB36C03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 15:23:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x14so5732905wrp.2
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 15:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhUWUhv2t93m8FZWyi4PhqbyZ2LKivXiPEzLODLgNE4=;
        b=cgr42ZBkgMxXl6FziWMPoLfX+f3yDnZNqqrNP+zSsEOr80755Zu3tUe+x7JQTsig67
         lKte5BfjXrgkquAyRGC5pALpkBNZJNYmJoq6E80j8g1YjsU+wLVytC9Rt2yqTTYwbqNq
         Yl2tFy/qU00FJIHywAbt43zHEXm92nPDQ8q3NX3JuTmPfUaeMVRgUKehx7/x+NmZZxu5
         8gQfg/GZaK5FX6lfmjvcAHXRNuqjZ3u548omN8R0cu+XZQh8saAycKu1lcTw7Kx36RUz
         TIueIq21Er0KG8JD2C6iEzZXtnHeYvh29/ZYZWA8KwxyoatBY9NnCeyfKlMxoXxYuDkk
         fRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhUWUhv2t93m8FZWyi4PhqbyZ2LKivXiPEzLODLgNE4=;
        b=lVHz2hDMXXxicq7XQviXvEeDPwdMJVHtj80NWWe91eTJPZ3thgxqm540pCri03+tH0
         MI75K4gJy8g2Eqf+VyEbg3+PsnFw4EwjKpr3KZUvBM2Ay3Q8hK0EfBa9lvkONtM0hFAX
         5SwWgU10nT30Q82q1i/pI926QcS6OmIiIrmN5vuKD4biGzQRoOJ7s3HBm1ewj7rda31H
         xEV8fzjG5+4RCrW5/K+WcsJloURpJ5vDXrX+ckyWIYLtUyXwimuy+02HMqw30Qsc14Gu
         H9KMhXdEMy705XPiWCTM7cUFznxDFNh4otO/sZzXpdFgplVPTRQ4DtsoYeSjLk0/vxdo
         VTbQ==
X-Gm-Message-State: AOAM531BccQSMkhMf3xMFvkrLsF97WmzQCsZzSk9Rsh+YEJemmoUIJ3r
        iqAOhD0V4TbSDgTfHtNZWwFvFuOnjGsl1viF71w=
X-Google-Smtp-Source: ABdhPJxkGAbNH3w9I9hsRjgXZ2CBJoNRXCrsOtreFOCMf2Y8sbICZzHSYFGdh4X7H+3E8mg5/jDgDzHBZUXXQ5V0d7c=
X-Received: by 2002:a5d:4745:: with SMTP id o5mr10092817wrs.87.1590790999382;
 Fri, 29 May 2020 15:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200528153441.3501777-1-kbusch@kernel.org> <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com> <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
 <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
 <f9cbedc9-88b2-acc8-5b95-f1c247ab1525@oracle.com> <CACVXFVOTQ7HLV5DCP1XezPqha13LfUrj-fZE8++_BAoTvtPWMA@mail.gmail.com>
 <20200529132217.GB3506625@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200529132217.GB3506625@dhcp-10-100-145-180.wdl.wdc.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 30 May 2020 06:23:08 +0800
Message-ID: <CACVXFVMithaukPF45qFzTgzqQ2g2mhLbUD+-AyaNwVwZo7+CyA@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
To:     Keith Busch <kbusch@kernel.org>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 9:22 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 11:39:46AM +0800, Ming Lei wrote:
> > On Fri, May 29, 2020 at 4:19 AM Alan Adamson <alan.adamson@oracle.com> wrote:
> > That said NVMe's
> > error handling becomes better after applying the patchs of '[PATCH
> > 0/3] blk-mq/nvme: improve
> > nvme-pci reset handler'.
>
> I think that's a bit debatable. Alan is synthesizing a truly broken
> controller. The current code will abandon this controller after about 30

Not sure it can be thought as a truly broken controller. When waiting
on nvme_wait_freeze()
during reset, the controller has been in normal state.  There is still chance to
trigger timeout by any occasional event, just like any other timeout,
which isn't
special enough for us to have to kill the controller.

> seconds. Your series will reset that broken controller indefinitely.
> Which of those options is better?

Removing controller is very horrible, because it becomes a brick
basically, together
with data loss. And we should retry enough before killing the controller.

Mys series doesn't reset indefinitely since every request is just
retried limited
times(default is 5), at least chance should be provided to retry
claimed times for IO
requests.

>
> I think degrading to an admin-only mode at some point would be preferable.

If the timeout event is occasional, this way gives up too early and
doesn't retry
claimed times, then peopele may complain for data loss.


Thanks,
Ming Lei

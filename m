Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069FC433F5
	for <linux-block@archiver.kernel.org>; Sun, 30 Jan 2022 16:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiA3QT7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Jan 2022 11:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbiA3QT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Jan 2022 11:19:58 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C3DC061714
        for <linux-block@vger.kernel.org>; Sun, 30 Jan 2022 08:19:58 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id b16so10502493uaq.4
        for <linux-block@vger.kernel.org>; Sun, 30 Jan 2022 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPkNoKQ4Pd+AHckOSmZ38ryny5w+vsqu07xNizGyqTY=;
        b=kg3+JjiXad8tw+GIisyMJbE2xUu4NenS+YohXz+XGdFNW+Hyo/OKmsvwR0sxd10qW3
         XX/03mD4ye8FfvqRA2TvNeCUtIewVQpYSUiy/YDN6uV+mPgSJiL+2kVKm6rllRrMnDYh
         iXhZkkjm/YKT1c2nRYllIR5IaRZuT9jBgxeuNYL7PADRGo1BSp7VnPnrkM2iVJq1wVF2
         PCmxw4iVd5QkaUWDZRvwTtb1IePxdWbx9jxv1RwG2MQWfs2lCdHTqKULRy14r/X8TXkT
         pWiV0SZta1yNz9TlpYzFL/zHrrtHNYQvcusbSPi4NKlhsTLLte3JpnEVDmT4yZiUuehd
         yxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPkNoKQ4Pd+AHckOSmZ38ryny5w+vsqu07xNizGyqTY=;
        b=0ntr9i9cf9yp69Z/OJ40d6388Hq3SWxMvIjGmj+DLapRXBn4qI54XtNVlFqiUxAqxG
         FPTleWcE+ZVqrkfRyM/tNu0OezYhkcf9C06xcYvArPNbb5lF9boQSmkUTR7rf89BIjO9
         AR63XW0tz6FkdpfthGL1TPzXMp5RD9TVkhKf1aTI5YmmhJ2qlDAwndQaRx0+j1MZxoNz
         5vAqKrzftX7s6BogP3c/ZJOhL57Hrmiu1hN+PFlxR6oCBYflXaMUjKOC3tG5LvrDE7ZN
         JmV9aPTMa0CSg/hAiKIcJZYo7qBoF8JTsBMSzGy9ii8F32kddk0VByCoFpoKUq87t35E
         x3ZA==
X-Gm-Message-State: AOAM530agoZcYap2F7wtbK0oLEViEy8CAggdUp6kDjS4a4ozcPv0GxpB
        FPYSaQ8dVp8qDSiQkQOL/xoln7WzIOu/l0xQmS7+RHmn
X-Google-Smtp-Source: ABdhPJysG7oWQL32REKtB4OlNKprhg0z6kmtqUnf53trMGZAwj49WnslkkGALJoUwRNx/p/sEXFUq9NJePNLQT4Sn3s=
X-Received: by 2002:ab0:372a:: with SMTP id s10mr6636778uag.86.1643559597396;
 Sun, 30 Jan 2022 08:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20220125215248.6489-1-luca.boccassi@gmail.com> <10a8fbc8-c242-af90-2a3f-d55cd27497a8@linux.vnet.ibm.com>
In-Reply-To: <10a8fbc8-c242-af90-2a3f-d55cd27497a8@linux.vnet.ibm.com>
From:   Luca Boccassi <luca.boccassi@gmail.com>
Date:   Sun, 30 Jan 2022 16:19:46 +0000
Message-ID: <CAMw=ZnTJxFhcVgApcj6YNtU2Djcybrf9gN_6dmfr7QM+jxXmww@mail.gmail.com>
Subject: Re: [PATCH v3] block: sed-opal: Add ioctl to return device status
To:     Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 25 Jan 2022 at 22:03, Douglas Miller
<dougmill@linux.vnet.ibm.com> wrote:
>
> On 1/25/22 15:52, luca.boccassi@gmail.com wrote:
> > From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> >
> > Provide a mechanism to retrieve basic status information about
> > the device, including the "supported" flag indicating whether
> > SED-OPAL is supported. The information returned is from the various
> > feature descriptors received during the discovery0 step, and so
> > this ioctl does nothing more than perform the discovery0 step
> > and then save the information received. See "struct opal_status"
> > and OPAL_FL_* bits for the status information currently returned.
> >
> > Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> > Tested-by: Luca Boccassi <bluca@debian.org>
> > ---
> > v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> > v3: resend on request, after rebasing and testing on my machine
>
> I would like to withdraw this patch. We are going a different direction
> for our SED-OPAL support and will be submitting a new set of patches
> soon, which includes a different method of obtaining the discovery0 data.

Hi,

Do you have a rough ETA on the new series? Also would you mind CC'ing
me when you send it, please? Thanks!

Kind Regards,
Luca Boccassi

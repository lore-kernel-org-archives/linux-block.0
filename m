Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259DFC433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 07:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiC2H02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiC2H01 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 03:26:27 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E1231936
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 00:24:44 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id q85so9275735vkq.4
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pL+Cp4iZbwgLcxUWKxODDZPNpYMnhx3erX4iFxsT0IY=;
        b=T2X5MvUivqE5mgGVO92sTOil53SIfwWtVoWix5F1x5/LbLmTJinRQzydeIjsOg+oYm
         pKDi6tgHEHYKB3OTiYFgcyri+RIF4Qn9qCIuKBnQ1Ol/qoEXzmd+qvThYxVafmsd6YDd
         3UpcuL/FjUuxWcpFOoyJFuVabitOWYdb87YBN4vgSkLQRa3MovqdaeuuHzbtqdC8ModF
         4y/cffHuq9h74/FNSFBBxy5AHd26Gv6zhaEEGx++3d5FVkVSDcR5K58YEvvQiFM9FtZq
         z87LdY/aWEQ2eZk6XGd97IZzuVcXmea6pv2SlMJqokJ9cY6SzGdMyMCMZw1lYb4rHAYy
         +QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pL+Cp4iZbwgLcxUWKxODDZPNpYMnhx3erX4iFxsT0IY=;
        b=eJ/jgTW619o61lwOE3l2P6FN5Z5qJbBRlk5QqXnWvQ0qWXxHkiKI/nEILjQpRwRYoD
         1zD1IMskcqDBCK/nZip0f+OPI/ywY4vidjU57HpUy6yTv6mP86/AjQfNfLEdnHvo1gHX
         GzspYZqnCwuhWLJNJLa6NRBcxFCYlAuflIIP1r3WVVBdnU391lp+BEbwzP7yZR+EBUfW
         MqCAhSKRdutGT9uqnfgd277gN1Fso1grMsYzKYKd27lfFK9CYhGZ3+6etkNSuRP4w8eG
         WFBExb0Di8Fclnn282D/qKdHlLoxrEheuZyfiioohk7viYWGoHP2IgNSm04br4/wsYM/
         IbPg==
X-Gm-Message-State: AOAM533OqBvQxvLhJfcJPmrUR57k3m07yuwA9zvwL01+qJJTHkUA3EeC
        CWOiCQH5LTjXmgVAB+GAWqUkAxiTi4P3wm4zXwMpyQ==
X-Google-Smtp-Source: ABdhPJx+IvOLBtbExo85GXpQ1kupYL8mOSu3U3yGjfkVfzkRpmTZcfCSmQYoicsRKDWxcSVJxNJYCXyWphBtDzrQDWQ=
X-Received: by 2002:a1f:6a82:0:b0:33f:7eeb:5989 with SMTP id
 f124-20020a1f6a82000000b0033f7eeb5989mr15757736vkc.29.1648538683833; Tue, 29
 Mar 2022 00:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de>
In-Reply-To: <20220329070618.GA20396@lst.de>
From:   Philipp Reisner <philipp.reisner@linbit.com>
Date:   Tue, 29 Mar 2022 09:24:33 +0200
Message-ID: <CADGDV=XrhzSxLyES9dtKj1-cQq6Zh32psipLJCoDGRNzAYaZwA@mail.gmail.com>
Subject: Re: state of drbd in mainline
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

what do you expect for the DRBD changes? Usually, they fall into the
category: yes, obviously. When you are changing the block layer in
this way, then that is necessary for the in-tree DRBD code.

Regarding users: Yes, there are users of the in-tree DRBD code. Very
big corporations. And, yes, we see pressure building up that we get
our act together and re-sync the in-tree DRBD with the out-of tree
DRBD.

best regards,
 Phil


On Tue, Mar 29, 2022 at 9:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> while I've been reworking large parts of the block layer over the
> last months I've basically never gotten drbd reviews, and in general
> drbd seems to be completely maintained upstream.  Do we even have users
> for it?  Is it time to drop drbd from the kernel tree?
>
> Thanks,
>         Christoph

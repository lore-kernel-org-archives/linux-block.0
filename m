Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 06:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiDMGnN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiDMGnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 02:43:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6FE2C117
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 23:40:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bh17so1892569ejb.8
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 23:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUtafTS5bbm7w+XJYVemBkOAYh5lBscMoQ8qcKKpMqg=;
        b=Mm1kMoh9RG4tEhG/2qjy8o2a5FtsLSAtW0ABT98X8gL3SheMnNLIcTaRCsln/9v/Ud
         z/02UiilPONzE2ThI/8FoN2sdVa3mPawKwK5T7Kk5YTnq33cC3Xq4IVa47+4RCnN7jDN
         MvQ3voFc9TyoMC9naC9hAdzMwrVETCS5B2+JMx2PYBHtMMFGeDzjTNRwfyYhxZ0Ti0hh
         WYVmjW3pDvNGS3Wpx4kdmOo3UV6FwdY1hMddiIxNQlWH2ld6e4PhgsU9lxBKKk4n/n9n
         8EC3Xms015f16+gXMKAOO8JwaRBw1sBr/vHTGh4CeBO4B3Z3aYoroqZQLZh+budlhxJd
         1gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUtafTS5bbm7w+XJYVemBkOAYh5lBscMoQ8qcKKpMqg=;
        b=FiE2FeZZMsDLA9sIqPLfKgU/U+GDaHAWO5OD6yprWwMLl5P2DKKMzT7DIV5TY7ULhd
         LsRuqBfI6jAqkyJ48F9KMTu5EQGfrWPUk+roOg0hDdQxrUFCKkGXbW8JCXoxcxmcIZm2
         w2UiRKV6ZEIczLhPleo5X85irrlXS6RQlIU5GCxxMev3A3zjpmm5fnHCJ4Q83LAgbV9a
         9fP+n+CTUqs+mnugIYbK2zYikcS8+zioec4nIghKZmBOdIxpgD5//YkuxYhU8v4/GqVd
         +BQ/hpjfJcLNmUVjJY+kMw33NbOe9X5mXMyOTkqDOC86mXelO8VURSU4Q2KD72IzAvlY
         VpDQ==
X-Gm-Message-State: AOAM531iM1tx3JSP0K7ceLjdg8kJwr8UKSlgEiv3BDDGRlXN1lie04Jq
        yNWvjhezxITbHD1U3w/uOeEy4quESPU92s7jaYHa7/lI7DiBew==
X-Google-Smtp-Source: ABdhPJyU071dNJ1fwpnZw46980R8xTuu/uen5K9WIAioMoRh5GKRC6IpaXpCf/YBrXwaSvMwI2RNZ5Izhp65Vm7jzKE=
X-Received: by 2002:a17:907:7e82:b0:6e8:92eb:2858 with SMTP id
 qb2-20020a1709077e8200b006e892eb2858mr12065463ejc.443.1649832050185; Tue, 12
 Apr 2022 23:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <becb2389-e249-0aa2-7701-2c02155aedf2@I-love.SAKURA.ne.jp>
 <55006f3b-9571-9167-eaf0-6a2caec747ad@I-love.SAKURA.ne.jp>
 <CAMGffEnXi8AiC2rqZaHER1rrcsCPR0UNocKyxr9H6hXRwjj4MQ@mail.gmail.com> <7adb8272-6836-77f6-70c8-6fbd180c0e2e@I-love.SAKURA.ne.jp>
In-Reply-To: <7adb8272-6836-77f6-70c8-6fbd180c0e2e@I-love.SAKURA.ne.jp>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 13 Apr 2022 08:40:38 +0200
Message-ID: <CAMGffEnJm13zBa0o=v3Qtk1Cab3sLdYr9ER3FL6wHeiHe9205w@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: client: avoid flush_workqueue(system_long_wq) usage
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 7:31 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/04/13 14:21, Jinpu Wang wrote:
> > I feel the simple approach is to replace the global system_long_wq
> > with a local workqueue for rnbd_client.
>
> OK. Please post a patch.
Will do, thanks!

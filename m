Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE77C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 10:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbiHSKqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347538AbiHSKqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 06:46:09 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECFF4389
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 03:46:06 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id q14so2033383vke.9
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 03:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IhG8Oy5T7tOwfiDRsMTf1YaWBJ/K7pb1xkFCd/q0YDo=;
        b=5PDMZ/tQE9C3+HOQu92AEtYXdIVVCvwuCfdvD5n4YCWZLj6NbfXzwnMVDJHoAHVoqS
         xU5AqwiU7OPDE/O59BZpj8VY3ok2eywRea2BA2L9VQQc5CV0Fr8q0lsj4eQLsE7uELUt
         evRYUUZFkA5EO42qQfshqQdXs+cpjyrBqPnKC/5QAHXpWAS9EyQTvHC8XseC/yQfyDro
         yVzrmo1K27Cbhiyr9Sku1uDpTAG8EYfX4YqcJi1Qpyn+Keopeb+91sNaXywdOJG2hZgd
         Zh5OE5ve8/1Z0hs/GgVz5sXpmAB2lHbbMm6dMoMO7JcJMeizHhO3uy4BTzsuPfcw2GC8
         9MBQ==
X-Gm-Message-State: ACgBeo3Cl7rhiO1nYsK0BQbgQQHkSe1pXmMzGOEzemsn+FaJK7BskK7t
        DBNR4gKoetzd2XVZE0jojZNS2zMGyUPUEg==
X-Google-Smtp-Source: AA6agR6ofoS71fgi7ainthEQ3EBgwJOCxOelrZ1zV9TY+zdsnqvdjLo493dpBSdme1BQPRQunfTGHg==
X-Received: by 2002:a05:6122:2d4:b0:377:7cf1:5e3b with SMTP id k20-20020a05612202d400b003777cf15e3bmr2800998vki.9.1660905965762;
        Fri, 19 Aug 2022 03:46:05 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id h186-20020a1fd0c3000000b003793fcd6747sm2181474vkg.13.2022.08.19.03.46.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 03:46:05 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id h67so3089093vsc.11
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 03:46:05 -0700 (PDT)
X-Received: by 2002:a05:6102:321c:b0:390:217d:df6d with SMTP id
 r28-20020a056102321c00b00390217ddf6dmr874776vsf.35.1660905965127; Fri, 19 Aug
 2022 03:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220816140713.84893-1-luca.boccassi@gmail.com>
In-Reply-To: <20220816140713.84893-1-luca.boccassi@gmail.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 19 Aug 2022 11:45:54 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRSV3uF+HFjvL5Fdb_S_RB=3YrWT4ZqtG9e4ZmJTpehVQ@mail.gmail.com>
Message-ID: <CAMw=ZnRSV3uF+HFjvL5Fdb_S_RB=3YrWT4ZqtG9e4ZmJTpehVQ@mail.gmail.com>
Subject: Re: [PATCH v7] block: sed-opal: Add ioctl to return device status
To:     linux-block@vger.kernel.org
Cc:     Milan Broz <gmazyland@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 16 Aug 2022 at 15:07, <luca.boccassi@gmail.com> wrote:
>
> From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
>
> Provide a mechanism to retrieve basic status information about
> the device, including the "supported" flag indicating whether
> SED-OPAL is supported. The information returned is from the various
> feature descriptors received during the discovery0 step, and so
> this ioctl does nothing more than perform the discovery0 step
> and then save the information received. See "struct opal_status"
> and OPAL_FL_* bits for the status information currently returned.
>
> This is necessary to be able to check whether a device is OPAL
> enabled, set up, locked or unlocked from userspace programs
> like systemd-cryptsetup and libcryptsetup. Right now we just
> have to assume the user 'knows' or blindly attempt setup/lock/unlock
> operations.
>
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> v3: resend on request, after rebasing and testing on my machine
>     https://patchwork.kernel.org/project/linux-block/patch/20220125215248.6489-1-luca.boccassi@gmail.com/
> v4: it's been more than 7 months and no alternative approach has appeared.
>     we really need to be able to identify and query the status of a sed-opal
>     device, so rebased and resending.
> v5: as requested by reviewer, add __32 reserved to the UAPI ioctl struct to align to 64
>     bits and to reserve space for future expansion
> v6: as requested by reviewer, update commit message with use case
> v7: as requested by reviewer, remove braces around single-line 'if'
>     added received acked-by/reviewed-by tags
>
>  block/opal_proto.h            |  5 ++
>  block/sed-opal.c              | 89 ++++++++++++++++++++++++++++++-----
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h | 13 +++++
>  4 files changed, 96 insertions(+), 12 deletions(-)

Hello Jens,

Is there anything else I can do for this patch? I've got two acks. We
really need this interface in place to start working on supporting
sed/opal in cryptsetup.

Thanks!

Kind regards,
Luca Boccassi

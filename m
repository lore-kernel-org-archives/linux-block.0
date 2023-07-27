Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C672CC001E0
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjG0K7t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjG0K7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 06:59:36 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279BF2719
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 03:59:35 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-444c42f608aso335468137.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690455574; x=1691060374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQIJTiY4t0sGJf9XX/8DZm5r+JjhDJ3XudJDmkX1ui8=;
        b=gEcZqk97W/OeCP8dpWKOOmoAQyHVzKFQGVlv+8RqtCXn6hMEovVO3prj1lAx26zdx+
         XW7zEQqUJoT2DnO+m0UzWM+0Y2B7RdwDzL65ctETydYHp02dDePs6HNmXuj0nPovD7f2
         RW1AnxTOkt9LG44RDf5rYGbO1j3scLJT+HIXEuFPA/tuijgey4eZJBvbxipiRUQjFUT/
         gTjPxXOVKx77kWqfGeb0zHOUZ2mH6STbjXoYXqr5J98gFsiFtz1hHNJ8edF6h01oEtii
         D6tNPDGjRhh3X+F+N+b9EG7oiYUdwyjVeEe0w/OvPN17Ks+vn/DDVipxOnHWtBVQ192w
         Zmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690455574; x=1691060374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQIJTiY4t0sGJf9XX/8DZm5r+JjhDJ3XudJDmkX1ui8=;
        b=L5E2USzL9uHwRRcwJXoMqE5VRbqu3BeSffveH3LdeNmJnCIqsPESPxTR7ShgFEHVto
         YxkkPjeNW+tGlalAmyqb67t071uJDcgGkERkFEBCzj9X9ZLu1r1lyWLdYsBF4+tL42QK
         X65jEucrdMGMN3c2A1ifDJUgZCo1t8LHBR9mzSRjpwrAlC7EFcZIy30zvEeA4YgdRYct
         LxrJn562bX2rBAYPADd7yZEDvYg1l3f1T62w/Kkb7cRXIyv6gOKVL+/SRwXXfxncaPTH
         8JvM0xCrUUn1ZDI17iT3DcKpgtb3NFwAb5U2AA6vUU3u+KQmrbmXn3MbJs8ve/D8sbBA
         A+ZQ==
X-Gm-Message-State: ABy/qLbHCQr8uY4IuaNkXz8stC/ldkolsd+FhLcj2O/GoPVfKWImtEqr
        YVboj71iKP07MkeVF3zGN19N5N7nZda4eGQ7QSc=
X-Google-Smtp-Source: APBJJlEJSw4Z79IBlZYUkO5gyiGCXYwqAm6nXTGCPCMWRPkA16SS1yEKQyXJlGQohCT2eteZF3HEDrLIyDdB2CxPARg=
X-Received: by 2002:a05:6102:366b:b0:447:4c30:cb68 with SMTP id
 bg11-20020a056102366b00b004474c30cb68mr986179vsb.32.1690455574147; Thu, 27
 Jul 2023 03:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230726193440.1655149-1-bvanassche@acm.org> <20230726193440.1655149-2-bvanassche@acm.org>
In-Reply-To: <20230726193440.1655149-2-bvanassche@acm.org>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Thu, 27 Jul 2023 16:29:22 +0530
Message-ID: <CAOSviJ0uBynC9M16cRusttU1OaB4HJS8=xmjCGP7bUCMicmiOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] block: Introduce the flag QUEUE_FLAG_NO_ZONE_WRITE_LOCK
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 27, 2023 at 1:39=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
> + * Do not use the zone write lock for sequential writes for sequential w=
rite
> + * required zones.
> + */
> +#define QUEUE_FLAG_NO_ZONE_WRITE_LOCK 8

Instead of QUEUE_FLAG_NO_ZONE_WRITE_LOCK I feel
QUEUE_FLAG_SKIP_ZONE_WRITE_LOCK is better.

--Nitesh Shetty

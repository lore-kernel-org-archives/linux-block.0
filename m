Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A63C7618E
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 06:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbjDZGdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbjDZGdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 02:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02752694
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 23:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682490755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HA+d9poW4wgIjY/MKbtnI0DUGhkyl/r8x47jX1FJye4=;
        b=ab2O7kAbBOtnmV47IeIfI/W0HqpP7P8zOx1eBJ0Ow5Y9WDhu2g1SUlDQ5HlraFAsm9Wuai
        oS7vQw/hT6JlNFqCIFeN/ukK6rUVkM71Gpldp7DwW/uQweSV0mLwBWPIKOni9bV9MO9tCt
        W4WzzjZqrOh9iMHXqC2JULGig1Xaut0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-LDMn1V9pP7enYzlZjAhiKA-1; Wed, 26 Apr 2023 02:32:32 -0400
X-MC-Unique: LDMn1V9pP7enYzlZjAhiKA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-506a597d3c3so7784136a12.2
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 23:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682490751; x=1685082751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA+d9poW4wgIjY/MKbtnI0DUGhkyl/r8x47jX1FJye4=;
        b=A+81fqg7LvlUdKe3lSv0t4/Tu1H92qRYvQgJB7V9fNZmXJyuQxl8/xaxXyrjzSZXrE
         +PszxI6Cr+vmPT/Y4UN40BhCubOEmDuFtjd3ovbUZrr3b0ZD5AWCyTxOyTUbAWtkzYK+
         Slo8h7s3JE44fRv9tgUKlAFSOntbtBoXpnV/JtE1mAtciOxsnxeboF7DSFEqN8W0IcOc
         kbI+CtR/7JQFD3Z5zLCX7593gYQ2YRRvpBcTCl561T/MM/ul3YeLXtS9KhXNZtsgID3x
         lMiWD65pDyuDAbXazMbzM2ryTk9uqXDIXcdF3VLTGpkxs484ln9ECBWjRpEbJfg0Lrvf
         isJw==
X-Gm-Message-State: AAQBX9dsy3tjkmlEDjOq1mpURh4F16yWZcy9e4Oh8i1L2QMwBk020jiP
        TOJ43BgD6r6Q2yU5FJF50KpzxFYcoLdqeShIZAF/OIvtNlEBFMiGOJVZ0yUDpbbz1frpnqsi/HZ
        7ucj+9NpMfE6M17QD/+maOl/cu/1JIHcj93JU3MI=
X-Received: by 2002:a05:6402:18c:b0:505:47a:7ae8 with SMTP id r12-20020a056402018c00b00505047a7ae8mr18027081edv.4.1682490751498;
        Tue, 25 Apr 2023 23:32:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350aCX8No4b1VUu5bv8WGDwtAfQGmiKUyBt6dr3fV2Yfgs8ZX8z5X5LBZ4OB36WufNPZLoTcLP4AVGrQRdGHfTNA=
X-Received: by 2002:a05:6402:18c:b0:505:47a:7ae8 with SMTP id
 r12-20020a056402018c00b00505047a7ae8mr18027069edv.4.1682490751270; Tue, 25
 Apr 2023 23:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
 <ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com> <CAGVVp+Wrhi0bWWR4nDVM5OXKp==RKbVKPSyt8pbuofUWVqQDGA@mail.gmail.com>
 <f5d3b05b-33a6-818f-6476-c3993f9d4e87@huaweicloud.com> <CAGVVp+W9SnHaEyi7o2Pkh6XEJsWL1E7W7esHvyXfXed8DFjt8g@mail.gmail.com>
 <c1277414-bc3c-b191-de9c-1620c5533aa0@huaweicloud.com>
In-Reply-To: <c1277414-bc3c-b191-de9c-1620c5533aa0@huaweicloud.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Wed, 26 Apr 2023 14:32:19 +0800
Message-ID: <CAGVVp+WLSaf3AOShs7HrUxM0985zaWdPJh6LB2Oekjd+7o3h8A@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 00000000000000fc
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 26, 2023 at 2:24=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/04/26 14:20, Changhui Zhong =E5=86=99=E9=81=93:
> >> Is this patch in the branch for-6.4/block?
> >>
> >> 3723091ea188 ("block: don't set GD_NEED_PART_SCAN if scan partition fa=
iled")
> >>>
> >
> > Hi, Yu Kuai
> >
> > this patch was not found in the for-6.4/block branch, and found it
> > exist in the master branch
> >
>
> Can you try to test with this patch?
>
> Thanks,
> Kuai
>

ok,I will retest with this patch,will feedback test result later

Thanks,


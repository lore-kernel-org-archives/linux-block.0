Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D635EE4996
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 09:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjHUJdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Aug 2023 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjHUJdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2023 05:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44129D
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2023 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692610370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NW0H5YY6tEUfUsrJHZpIlunAV22vJAx4tbyK+cyHoGI=;
        b=iM5idAN0/D9uW7CXZVvwFhdCEvXxSpa/KqgBfqKz4R3+D/CoQ8IwPFfnCfj8dIxA+ziZ1l
        pjaLQngK9MJD28JGxmknwo3VBPmJNMULW8C3QGUVF/B1/UGVkwd24GCTKatLUuDRAJ7WrZ
        Wz1SPG21EYaW4hePZo3vs8N7AsmY6n0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-5fMGggRDMMWjJj-Z85rA1w-1; Mon, 21 Aug 2023 05:32:48 -0400
X-MC-Unique: 5fMGggRDMMWjJj-Z85rA1w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-267f00f6876so3266951a91.3
        for <linux-block@vger.kernel.org>; Mon, 21 Aug 2023 02:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692610367; x=1693215167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW0H5YY6tEUfUsrJHZpIlunAV22vJAx4tbyK+cyHoGI=;
        b=BhHpZkktxYV9sGPNiIn6kpw3vkAJ19Ai5yTw6I2Sd2umHdfu5EEcT+HQabVf7P/tZZ
         /4mfbFX1+RTIUTzr+YQXN09tq6TVbBz79IAvdkDz+DfxKxcpHKpZah+8SUpidAg0X1UV
         kmOb16WP7cbGyPAUwnITvRSOdCeN3dWK53/tI999cd4C/sS43pFoeE4PJ5oxzowspr2h
         OefIyQKU6xC423gDiFsCirr9xczwprdgmHCbRbxEKzAKFe4rBPzn8bUB0m1C1sdPNPGW
         N7ggfsMS04m8H661v5c8ucW7h01/439Of4tatazUZ5bmb3NDtaWv/fLVGb1wZoH9d3Bl
         B6eQ==
X-Gm-Message-State: AOJu0Yy0nGt1In49t9u8VTsEfYxLubjI4G3rz0xMtVx3IL/isyYPDEcy
        GMqtgCfSXTGGzRHfL5giuwtt2M9pcF/Meu/TRkQig8xATWi5TpSWsGI2f6jDqvyJuxj//+5Zfl2
        iXwQNMg8u5WUX5Jp/J8/ih0Iar8yl4GiHsYBv4uE=
X-Received: by 2002:a17:90b:23c7:b0:26b:17ef:7365 with SMTP id md7-20020a17090b23c700b0026b17ef7365mr2797183pjb.48.1692610367494;
        Mon, 21 Aug 2023 02:32:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBYHsRN8ElizVXEXZra+vOZGm6HWRwFb6DeJ1fgtOCWZRqknWPixxhInnU4qcZUF7Pv4vJv+mgD8HuzGjyQEM=
X-Received: by 2002:a17:90b:23c7:b0:26b:17ef:7365 with SMTP id
 md7-20020a17090b23c700b0026b17ef7365mr2797169pjb.48.1692610367114; Mon, 21
 Aug 2023 02:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+Xiz99dpFPn5RYjFfA-8tZH0cSvsmydB=1k08GfbViAFw@mail.gmail.com>
 <cffead50-032a-46d3-bc9e-ace6586a69d5@kernel.dk> <CAGVVp+VRcQs1qvsEeKyvmOXz=8KTybHpNDAwS9GzVMVw+FvTUg@mail.gmail.com>
 <f0c0937f-485c-d317-8bd9-b7d32ace4e1f@bytedance.com>
In-Reply-To: <f0c0937f-485c-d317-8bd9-b7d32ace4e1f@bytedance.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Mon, 21 Aug 2023 17:32:36 +0800
Message-ID: <CAGVVp+US6zjWzTR_1zALr-jrVNWewtr4ARa3_3NXvEBjC01ZfA@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 12 PID: 51497 at block/mq-deadline.c:679
 dd_exit_sched+0xd5/0xe0
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 21, 2023 at 10:36=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/8/21 10:17, Changhui Zhong wrote:
> > On Mon, Aug 21, 2023 at 9:56=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wr=
ote:
> >>
> >> On 8/20/23 7:43 PM, Changhui Zhong wrote:
> >>> Hello,
> >>>
> >>> triggered below warning issue with branch 'block-6.5',
> >>
> >> What sha? Please always include that in bug reports, people don't know
> >> when you pulled it.
> >>
> >
> > ok,I pulled the whole branch of block-6.5, I don't know which patch
> > caused the issue=EF=BC=8Cthe HEAD is=EF=BC=9A
>
> Hi, this problem should be fixed in the latest block-6.5 branch,
> specifically including this commit:
>
> commit e5c0ca13659e9d18f53368d651ed7e6e433ec1cf
>
>     blk-mq: release scheduler resource when request completes
>
>
> Could you please help to check again?

Hi, Chengming

this issue is no longer triggered under the current branch=EF=BC=8C
looks it has been fixed by this commit

Thanks=EF=BC=8C


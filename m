Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09EC19F2D
	for <linux-block@archiver.kernel.org>; Sat, 13 Aug 2022 10:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbiHMKeq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMKeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 06:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5582C1EAF7
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660386884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gm2ncJtARBUuOif1STg+pfPMBR1QfN/WBnqwbhFW1rs=;
        b=gk5aLBBkKEj+YsSuSJStzwzH3QaHwM2c1L3MSM2Qkc0UpSzM8BsZX5HHrUFO3TMuSVwLA5
        +TKbWw8IqyYeyV7UtFAVpRV6mx8qLMYDWSVh9Z0RcDz8pKPE10lnZ/oPTGiprrBW1YJP8J
        qKB8A6OYwsthsl6ru7decRr0/V/Ud5Y=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-VivpiXVTMbKRaDG_cJxZLw-1; Sat, 13 Aug 2022 06:34:42 -0400
X-MC-Unique: VivpiXVTMbKRaDG_cJxZLw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-3282fe8f48fso25907127b3.17
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 03:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Gm2ncJtARBUuOif1STg+pfPMBR1QfN/WBnqwbhFW1rs=;
        b=McFdTzUpsY4c8W4k06JhxJCNdF7ihncVwFH+0HsoO1fP2pfbIbsoU2IgIOtLHEnHwC
         fLKowPYrOLEVI1Ji1JJp4uW8zBjXH9zhvWjOjnHfJtaF4NTqSRoNGLqXrY9fBGuv/BP0
         3gxE/w1CxXNVJAYlu8S6rYZvr5vzggiZ0wjqP0JgkdUKDi/U59NrA0J350aBNP7k5ktt
         WC2e1+eTZsnWyCjmm2EzIc3z2BYbh0zA4loqqVpH//HHdbxZE1HuFRzYlwMKWW3Q393D
         2VP1i8ec+8JMscLjWVhtoHgqptAO5kxN8Wo2lu+voY8FFCh9rKmn1K5fP7mIbEqKzFqQ
         6yaw==
X-Gm-Message-State: ACgBeo39LiiFdLab8y7/ChJfkuBSu51LgkG6wzBVXDJsPaSKb1BybozZ
        sBE3jJ+7MlEQ4VcEHouQ2WXxZitBtJvnfKs49dAFb9VM9U/emsTxq5OZP2WKElugbTrHqxx6TJG
        K8yjOzxMTs1lMZ6kMxYxlpTHbmqpFP2zY23tCYeY=
X-Received: by 2002:a25:3756:0:b0:684:410c:55d8 with SMTP id e83-20020a253756000000b00684410c55d8mr3321215yba.141.1660386882062;
        Sat, 13 Aug 2022 03:34:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5SwGrGaN+MljDY6c46RbjVpLKJQg+wNgAC8kEH3eE/0g5QjH7JDg+Wl32/3SVe7eVU1+wqlkdELav+wn4AinA=
X-Received: by 2002:a25:3756:0:b0:684:410c:55d8 with SMTP id
 e83-20020a253756000000b00684410c55d8mr3321209yba.141.1660386881872; Sat, 13
 Aug 2022 03:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220810055212.66417-1-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220810055212.66417-1-ZiyangZhang@linux.alibaba.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Sat, 13 Aug 2022 18:34:30 +0800
Message-ID: <CAFj5m9+Y=tnG3iy2_ch8nmenZHdAzzhz4PExkce2W-_Pzn+pDA@mail.gmail.com>
Subject: Re: [PATCH] ublk_drv: update iod->addr for UBLK_IO_NEED_GET_DATA
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 10, 2022 at 1:53 PM ZiyangZhang
<ZiyangZhang@linux.alibaba.com> wrote:
>
> If ublksrv sends UBLK_IO_NEED_GET_DATA with new allocated io buffer, we
> have to update iod->addr in task_work before calling io_uring_cmd_done().
> Then usersapce target can handle (write)io request with the new io
> buffer reading from updated iod.
>
> Without this change, userspace target may touch a wrong io buffer!
>
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 0b9bd9e02b53..98c345df6896 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -677,6 +677,11 @@ static inline void __ublk_rq_task_work(struct request *req)
>                  * do the copy work.
>                  */
>                 io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
> +               /* update iod->addr because ublksrv may have passed a new io buffer */
> +               ublk_get_iod(ubq, req->tag)->addr = io->addr;
> +               pr_devel("%s: update iod->addr: op %d, qid %d tag %d io_flags %x addr %llx\n",
> +                               __func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
> +                               ublk_get_iod(ubq, req->tag)->addr);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,


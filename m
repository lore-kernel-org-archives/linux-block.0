Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58206C77B7D
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 12:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjEJMIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbjEJMIm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 08:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BAF7D8C
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683720474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBHRFYfYRKquYIG9IbgfFHCMnVDomaQ80tiU2jYECfk=;
        b=hIcAHqV70db6RdTE2LLfehED66qHhJ4bu5pA+P2KT/4czgn/fAzQBmvdD+AcfBB/WkfhxN
        mv2/bnrMOXyO0B5i+9vJB7fewYLyjo39ZGKf2/5pRN+ydI0aG8MfmlnsvXrehp245oGbu6
        rTNsk4/X6aPqaRPInvSjj32D9fu2sYA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-hGojQGqgPO2dR1awdLQjYg-1; Wed, 10 May 2023 08:07:53 -0400
X-MC-Unique: hGojQGqgPO2dR1awdLQjYg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-643fdfb437aso22316552b3a.0
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 05:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683720472; x=1686312472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBHRFYfYRKquYIG9IbgfFHCMnVDomaQ80tiU2jYECfk=;
        b=XmFFMtHgu1V4Kp0cA+eOPpf3Gbs2vA46ySfb+JSfjr6B4pPPoWjeimFCstEzwT3SQK
         BPJlkCl/xChAK9UYtgwj5N4fowlsOsc/P7wIHSu1krIOUSxM9A8fYk2o6RQMxI28tkEB
         3gE4Ay5JdDDUD0tItoLP6CSGUvI5hhYZMsfqg4q/rVsnzk0GA+cDTHFC+R3tpmzq3PcP
         kjuanyO3/DSa8OPm3fXRnjHeQ+IuvUbH7NPI+Jf52enOltOFrLr+n8iU88Cbzl350123
         Bfe3zac5bqkCHzk5ga5vGu8tmUfHo5haHefidVI5/Flo7ODHO6vFC9Bbmev+c0BuTyZY
         xmPA==
X-Gm-Message-State: AC+VfDxA5vQhEStira0s3nVYq6EVke5vStquU2k5yrnbGXsz+Y4BhVSF
        PJ08FdvJm55TnCd/JhLERvSeV5enXIvTh8zoRXkAb3OM8De7ExJlTGdc7PCSsCLsv7eNNS0y97R
        ZJjiQ5Bo8140Wvxb9I9YHLJFpW6cykaRV7KYUCzsT7PIxhuVGmRCn
X-Received: by 2002:a17:90a:ad09:b0:244:d441:8f68 with SMTP id r9-20020a17090aad0900b00244d4418f68mr25722211pjq.16.1683720472464;
        Wed, 10 May 2023 05:07:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZiAfNVnQO0UPQ3VAy4kjRuo5FB9+xdUBrPgacbACuNg4amS2P3Jdczy0yCDToSd5CBd6yB5vipAn175sY1M0=
X-Received: by 2002:a17:90a:ad09:b0:244:d441:8f68 with SMTP id
 r9-20020a17090aad0900b00244d4418f68mr25722188pjq.16.1683720472159; Wed, 10
 May 2023 05:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGS2=YosaYaUTEMU3uaf+y=8MqSrhL7sYsJn8EwbaM=76p_4Qg@mail.gmail.com>
 <ecb54b0d-a90e-a2c9-dfe5-f5cec70be928@huaweicloud.com> <cde5d326-4dcb-5b9c-9d58-fb1ef4b7f7a8@huaweicloud.com>
 <007af59f-4f4c-f779-a1b6-aaa81ff640b3@huaweicloud.com> <1155743b-2073-b778-1ec5-906300e0570a@kernel.dk>
 <7def2fca-c854-f88e-3a77-98a999f7b120@huaweicloud.com> <CAGS2=YocNy9PkgRzzRdHAK1gGdjMxzA--PYS=sPrX_nCe4U6QA@mail.gmail.com>
 <ZFs8G9RmHLYZ2Q0N@fedora>
In-Reply-To: <ZFs8G9RmHLYZ2Q0N@fedora>
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Wed, 10 May 2023 20:08:57 +0800
Message-ID: <CAGS2=YqNEVngkP2yWb78KuS46Xy6QWuk2qMCswOXRW-AgFgU3Q@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000048
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
Don't hit the issue after apply your patch.
thanks

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8810=E6=97=A5=
=E5=91=A8=E4=B8=89 14:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 10, 2023 at 12:05:07PM +0800, Guangwu Zhang wrote:
> > HI,
> > after apply your patch[1], the system will panic after reboot.
> >
>
> Maybe you can try the following patch?
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f6dad0886a2f..d84174a7e997 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1303,7 +1303,7 @@ void blk_execute_rq_nowait(struct request *rq, bool=
 at_head)
>          * device, directly accessing the plug instead of using blk_mq_pl=
ug()
>          * should not have any consequences.
>          */
> -       if (current->plug && !at_head) {
> +       if (current->plug && !at_head && rq->bio) {
>                 blk_add_rq_to_plug(current->plug, rq);
>                 return;
>         }
>
>
> thanks,
> Ming
>


--=20

Guangwu Zhang, RHCE, ISTQB, ITIL

Quality Engineer, Kernel Storage QE

Red Hat


Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F85CC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054102082F
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 16:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EaTx7TGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054102082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeLDQvS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:51:18 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:40479 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeLDQvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 11:51:18 -0500
Received: by mail-io1-f45.google.com with SMTP id n9so14166136ioh.7
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yvf4CCOw0oZU7oSX2BnSyJQVfkmFi6gGtbTNxequSzk=;
        b=EaTx7TGBOuGIs6LJV8E7tvSQZCOkjdEJvCIlkb3h8TjTBPK5djADDTCxNzG2lyd+OZ
         tUPfblESXI9m6CNgD15sa8sT47lVYz9dtWJHYpuwjLBIZZvnobaqB3NLgta5V7d26rdV
         /4zePIWwnynDeOd9hugqazkhWhjOkJmI4J4wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=yvf4CCOw0oZU7oSX2BnSyJQVfkmFi6gGtbTNxequSzk=;
        b=Ko7BPGvjutHo35eYjTmoan4LrriryFrkqtpc+qZQ6Z4fxlu+KuKYUX5UIHXTzHa7eG
         pQLW6UUSL8I5yxJZU38jVg66iFtijmC16OuQaY3iFvELjo/hN5eSsI7CEyjjxhVBLgKO
         do3G7FPRb+Jh6J6o9ffea0JrWT/tl/tyvmaIqGI4+cZh4O71kPscPdHDGfqPv4soZNNs
         oKUBxOolbnGpQ21fZpdpBm0n9I9eRkrG8Ka/uKXZ8IytpoBpQ6/O9wjvJsG4Q6nRG9cj
         ob1qWqqP9ewA2uVbAi8b/5TbPgZeOWfK0CmVmzeoq7uYHGMfUr6c3A2DzumeMSfZzcKY
         sBxw==
X-Gm-Message-State: AA+aEWa9huIyZeiZYlbsOmHJ9suS3ttyPHjRKoiKoEl82Yra5BlSkHnv
        dN8v9LuUTrT5jPwJFRVcwbzMwZoR+VUgDTBYt2P59w==
X-Google-Smtp-Source: AFSGD/XQVPWpvOTB+9U9PR08fCTwgBWtNsoxahjfee+3fn0cLMXo2x9OCFqPVZLhThBaKhiaQbWofm/zX7LPYJrHm/A=
X-Received: by 2002:a5e:9510:: with SMTP id r16mr1993432ioj.224.1543942276741;
 Tue, 04 Dec 2018 08:51:16 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe_pkFVGJg73v0Wp7O38A@mail.gmail.com>
 <20181204113550.GA11121@ming.t460p>
In-Reply-To: <20181204113550.GA11121@ming.t460p>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQEyvrdX27HdOCj1DHPKEZclYJ8CJQFrfz1ipqcI21A=
Date:   Tue, 4 Dec 2018 22:21:15 +0530
Message-ID: <b7a7cacc2da38a97aeb14f9b44f23d8f@mail.gmail.com>
Subject: RE: [PATCH] blk-mq: Set request mapping to NULL in blk_mq_put_driver_tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Tue, Dec 04, 2018 at 03:30:11PM +0530, Kashyap Desai wrote:
> > Problem statement :
> > Whenever try to get outstanding request via scsi_host_find_tag,
> > block layer will return stale entries instead of actual outstanding
> > request. Kernel panic if stale entry is inaccessible or memory is
> > reused.
> > Fix :
> > Undo request mapping in blk_mq_put_driver_tag  nce request is return.
> >
> > More detail :
> > Whenever each SDEV entry is created, block layer allocate separate tags
> > and static requestis.Those requests are not valid after SDEV is deleted
> > from the system. On the fly, block layer maps static rqs to rqs as belo=
w
> > from blk_mq_get_driver_tag()
> >
> > data.hctx->tags->rqs[rq->tag] =3D rq;
> >
> > Above mapping is active in-used requests and it is the same mapping
> > which
> > is referred in function scsi_host_find_tag().
> > After running some IOs, =E2=80=9Cdata.hctx->tags->rqs[rq->tag]=E2=80=9D=
 will have some
> > entries which will never be reset in block layer.
>
> However, if rq & rq->tag is valid, data.hctx->tags->rqs[rq->tag] should
> have pointed to one active request instead of the stale one, right?

Yes that is my understanding and learning from this issue.
Side note -

At driver load whenever driver does scsi_add_host_with_dma(), it follows
below code path in block layer.

scsi_mq_setup_tags
  ->blk_mq_alloc_tag_set
          -> blk_mq_alloc_rq_maps
                     -> __blk_mq_alloc_rq_maps

SML create two set of request pool. One is per HBA and other is per SDEV. I
was confused why SML creates request pool per HBA.

>
> Thanks,
> Ming

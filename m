Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDCAC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 01:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB86C21871
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 01:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH1iIc20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeLSBTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:19:14 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:36647 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeLSBTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 20:19:13 -0500
Received: by mail-qk1-f175.google.com with SMTP id o125so10739957qkf.3;
        Tue, 18 Dec 2018 17:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPk7kEYwxNHb0G5HMeWlTF02OIgIabeRAUKDFm1wpC4=;
        b=mH1iIc20v/l3yTadzZDB+6KpG2q+m9FKO1SlUGpWv52l+HfddItQNi2jKcHxBO5M03
         5ou7TaAW9COud+m+2npq4x99gy/BLg/As2QQPAi5wXIoGGM+fG9z5d+x5IXNUzEvEALV
         c/krv4o45ApfWYCzRNY+USVV7Mxucx2hSspK7MTnsNdgeNUU4LIJ7yfPT5suNYy68n1N
         vJiai44AKUs1WhL1oPyTAIPKstFX0uYXJgB5ti7dGhAnM1/Aeg+p9pZ5xTJf4araXLzG
         XqT7Z1MpQkqtRJ1FqJWMbIZ4Wq0oVvNvQvsCDQq0O8SUJ8lUJ44xAkBfchB5YvzO6kmC
         logA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPk7kEYwxNHb0G5HMeWlTF02OIgIabeRAUKDFm1wpC4=;
        b=Q6bCAJ2ycrQuySQAHgAwg0pmK/aQFHJCvUyN2IqAy3TGZBYTBADDL6VsprrlZ5ExS4
         r+5Dwy70tdt1pm6UhdAtesMHaGuQo+HqZfbOjtOJiAaEgRaR/B38KBdFtpxf3zQnjwhL
         QWk87/B/ApnXBNbQdPA946QErdJXzmiETvpKqorzLSz4JB5gfV5Kby/QlGsNIWsIRR0R
         iZms8zUuzaGFdToUzRs9t28sNfwbDKzr58rHjDYpB9qiru3nwXsiABRWzGxRlMkSgEPz
         ZMc7pfKr7RpGPEQjojA8/TsVX57jU9dj9s8mChW7TceSdNKLTQalfyWRMvTD28fkB4br
         B8Iw==
X-Gm-Message-State: AA+aEWaW0F95YzIE0SbKw9ybQ1szRXc/RIWtRQTA1wFrf0LbeyO+hME+
        3z8dl0ElbrqLRDVRje3gltC7WtgGPd2iG5s4yi3QcW45
X-Google-Smtp-Source: AFSGD/X4EGMWb5ZgaoXgtpMjcAC1finTQIvw/DArOKzO1IzUUHXDiBrFfOcKbVLiCv5CC4hAXrUG3WeG1E64S80g++Y=
X-Received: by 2002:a37:498a:: with SMTP id w132mr18962358qka.92.1545182351789;
 Tue, 18 Dec 2018 17:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20181218045138.4282-1-yupeng0921@gmail.com> <20181218045138.4282-2-yupeng0921@gmail.com>
 <20181218172645.GB13768@localhost.localdomain> <20181218174750.GA14416@lst.de>
In-Reply-To: <20181218174750.GA14416@lst.de>
From:   peng yu <yupeng0921@gmail.com>
Date:   Tue, 18 Dec 2018 17:19:00 -0800
Message-ID: <CAG3TDc3QarHcz_ez=GYYzqDp8VwMHL=nUTvur+5XN+m5-T57sA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] trace nvme submit queue status
To:     "hch@lst.de" <hch@lst.de>
Cc:     Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 9:47 AM hch@lst.de <hch@lst.de> wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2477bd906904..5a0bf6a24d50 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1004,8 +1004,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>         }
>
>         req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> -       trace_nvme_sq(req->rq_disk, nvmeq->qid, le16_to_cpu(cqe->sq_head),
> -                       nvmeq->sq_tail);
> +       trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
>         nvme_end_request(req, cqe->status, cqe->result);
>  }
>
> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index cf666709bc50..3564120aa7b3 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -185,22 +185,24 @@ TRACE_EVENT(nvme_async_event,
>  #undef aer_name
>
>  TRACE_EVENT(nvme_sq,
> -       TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
> -       TP_ARGS(rq_disk, qid, sq_head, sq_tail),
> +       TP_PROTO(struct request *req, __le16 sq_head, int sq_tail),
> +       TP_ARGS(req, sq_head, sq_tail),
>         TP_STRUCT__entry(
> +               __field(int, ctrl_id)
>                 __array(char, disk, DISK_NAME_LEN)
>                 __field(int, qid)
> -               __field(int, sq_head)
> -               __field(int, sq_tail)
> +               __field(u16, sq_head)
> +               __field(u16, sq_tail)
>         ),
>         TP_fast_assign(
> -               __assign_disk_name(__entry->disk, rq_disk);
> -               __entry->qid = qid;
> -               __entry->sq_head = sq_head;
> +               __entry->ctrl_id = nvme_req(req)->ctrl->instance;
> +               __assign_disk_name(__entry->disk, req->rq_disk);
> +               __entry->qid = nvme_req_qid(req);
> +               __entry->sq_head = le16_to_cpu(sq_head);
>                 __entry->sq_tail = sq_tail;
>         ),
> -       TP_printk("nvme: %s qid=%d head=%d tail=%d",
> -               __print_disk_name(__entry->disk),
> +       TP_printk("nvme%d: %sqid=%d, head=%u, tail=%u",
> +               __entry->ctrl_id, __print_disk_name(__entry->disk),
>                 __entry->qid, __entry->sq_head, __entry->sq_tail
>         )
>  );

I think this change is nice. Will you submit this change or are you
suggesting me to do it?

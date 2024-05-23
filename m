Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C25B64B;
	Thu, 23 May 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475993; cv=none; b=Ctcnjb+YcpeEnRYEME+tB2pyPio9V7h8UxHxXTASiPVkRU9j1GlqvV/gyDUR8zrKkm037WHPLYf1FakoWHv5ysip23rwIM74H5eeP70DkcN+Hqu5S+agK5bqwHToTcDI0fnCsPjUgTgU1tAnYFSI9OlNYlXaZlomIopxce7wAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475993; c=relaxed/simple;
	bh=nskMZhrOa+cBy0V3H9Mgkw0GXALjTsxZIfmk3NddwoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/9aThWkVMLEVH26LZGjy25YIvjHmKtjHq7qoKiTw71EFwssc8gWeKwJgqCi6IFlIZ5Mg6lWUqXOeE1LUi1y1D55kiUnRGW3aXgeRfzBlcv6AgU+++EZ3wpIRF9ENArp0vP4QnCeyViCaFcwy6/PSf+nIBHk0Q+czGI1ISGv10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzg6ydgU; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzg6ydgU"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b27bbcb5f0so3396545eaf.3;
        Thu, 23 May 2024 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475991; x=1717080791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+WJGgcUVcvy4hmulZw0dUM995imr9T5p+NnO0w0cvY=;
        b=Tzg6ydgUkn+UbaLxBOrqva4ptV/3802TEcRE7wLCl+xcnZQCBzs3LlEN4NfIJE6IAt
         VRL095YsGSq7+x0bTMlHr9WJKSLf7SU9gRlWKNnWGjwW1jMiVk2jnApn2A+nPSwnqWlx
         ZxsRpuRFSrnsp15u4fQDSbllvVForEFOMxeqv1iZaWEj2Aee7lq9VkfC65+17/lfClkS
         j7w4VNMaJntVmKfoTQ2RQRtwcC9i4QF0hzevuTL4i2c3/NIZSQ/tBFNanhLCD0LkBtl2
         V0sSysX84OI9zQOQVOCWOAV3B8oin1dC0jdS3MQijYtaHKoUFM4/r+In2xtAdEtssQha
         AuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475991; x=1717080791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+WJGgcUVcvy4hmulZw0dUM995imr9T5p+NnO0w0cvY=;
        b=CgMgNZh/W94JU+tsg2kDC1iyJDLOIqmxsmSDmD+wgfTWhRCmdl1n51HwVbUqpY2Wh4
         mrILIxK2nshdBKWPhMTn+gsn5i4hVdr3DB1/Ge028Rxe/kszyWg3KdvE3ZjsTdqiMofy
         u7MCrQ14MxRdrLspJwqJoTCeF8PbW2n+jFNOr81hKDquC6TfNW01pWNrIwEvKfqmRnV1
         7qOahXvKT4jjFmWXxWS6mwLXqze66IuRrFt5sytux87xXrGZ23T5JSb9NPqzX+9eSSPW
         2A+rlqi2v9AH10ZgzvzECs5Kuj+htnUQap5ucIljeCN3oS0ugQJjmuLHbhAVqIzLe5qr
         xIuw==
X-Forwarded-Encrypted: i=1; AJvYcCUfepRRWV+Xjo9si5x1Akj9Oy+/YhgqN+WR1quRjUW+9qVI71jk7IpcDBXtEwwSaMROwXiG16iQJWtaKzIXce3UiRzqM2qpO8rB/hRTpX3gAePqNAgGRi9/MbT6AD/6ELRCIo2WK+jWZzQ=
X-Gm-Message-State: AOJu0Yw4I/VJ1BxUq2V+gylmEsQypdJ2PRf5PfzNdua8jUkf/826KbZh
	q1twOP7f2VoMCLcA2M6Y9CXhzXmEXvoqzOn64GduzlTu0YqOp/5E1aSemokiZ9oqlBySn2NZ4h2
	WF/8npUpbsI8Hnm/XMjqbC8hNYT4=
X-Google-Smtp-Source: AGHT+IH6ixkd1cR1BKAc1C3TqQV4Rn+d5J1vHdslE5CXslqI86HUqGI+niLbhN8tBDfmX7fBUYuBoOzHWIydOj3jz6k=
X-Received: by 2002:a05:6820:2218:b0:5af:36ef:27d0 with SMTP id
 006d021491bc7-5b6a19003fcmr6085309eaf.1.1716475991216; Thu, 23 May 2024
 07:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org> <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org> <CA+3AYtS=5=_4cQK3=ASvgqQWWCohOsDuVwqiuDgErAnBJ17bBw@mail.gmail.com>
 <ab21593c-d32e-40b4-9238-60acdd402fd1@kernel.dk>
In-Reply-To: <ab21593c-d32e-40b4-9238-60acdd402fd1@kernel.dk>
From: yunlong xing <yunlongxing23@gmail.com>
Date: Thu, 23 May 2024 22:52:58 +0800
Message-ID: <CA+3AYtTbkG_8KWNWJ8rZ-z=v-V+A9CqKCUUsXLPJyHZgL-FjwQ@mail.gmail.com>
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, Yunlong Xing <yunlong.xing@unisoc.com>, niuzhiguo84@gmail.com, 
	Hao_hao.Wang@unisoc.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jens Axboe <axboe@kernel.dk> =E4=BA=8E2024=E5=B9=B45=E6=9C=8823=E6=97=A5=E5=
=91=A8=E5=9B=9B 21:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On 5/23/24 12:04 AM, yunlong xing wrote:
> > Bart Van Assche <bvanassche@acm.org> ?2024?5?23??? 02:12???
> >>
> >> On 5/22/24 10:57, Jens Axboe wrote:
> >>> On 5/22/24 11:38 AM, Bart Van Assche wrote:
> >>>> On 5/22/24 00:48, Yunlong Xing wrote:
> >>>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd =
*cmd)
> >>>>>            set_active_memcg(old_memcg);
> >>>>>            css_put(cmd_memcg_css);
> >>>>>        }
> >>>>> +
> >>>>> +    if (ori_ioprio !=3D cmd_ioprio)
> >>>>> +        set_task_ioprio(current, ori_ioprio);
> >>>>> +
> >>>>>     failed:
> >>>>>        /* complete non-aio request */
> >>>>>        if (!use_aio || ret) {
> >>>>
> >>>> Does adding this call in the hot path have a measurable performance =
impact?
> >>>
> >>> It's loop, I would not be concerned with overhead. But it does look p=
retty
> >>> bogus to modify the task ioprio from here.
> >>
> >> Hi Jens,
> >>
> >> Maybe Yunlong uses that call to pass the I/O priority to the I/O submi=
tter?
> >>
> >> I think that it is easy to pass the I/O priority to the kiocb submitte=
d by
> >> lo_rw_aio() without calling set_task_ioprio().
> >>
> >> lo_read_simple() and lo_write_simple() however call vfs_iter_read() /
> >> vfs_iter_write(). This results in a call of do_iter_readv_writev() and
> >> init_sync_kiocb(). The latter function calls get_current_ioprio(). Thi=
s is
> >> probably why the set_task_ioprio() call has been added?
> >
> > Yeah that's why I call set_task_ioprio.  I want to the loop kwoker
> > task?submit I/O to the real disk device?can pass the iopriority of the
> > loop device request? both lo_rw_aio() and
> > lo_read_simple()/lo_write_simple().
>
> And that's a totally backwards and suboptimal way to do it. The task
> priority is only used as a last resort lower down, if the IO itself
> hasn't been appropriately marked.
>
> Like I said, it's back to the drawing board on this patch, there's no
> way it's acceptable in its current form.
>
> --
> Jens Axboe
>
Thanks for your advice. So, you can't accept pass the ioprio by set_task_io=
prio=EF=BC=9F
If only the method of lo_rw_aio() counld you accept? I don't want to submit=
 this
part of the modifications separately. I just want to know, this is ok
to you or not=EF=BC=9F

@@ -442,7 +442,6 @@ static int lo_rw_aio(struct loop_device *lo,
struct loop_cmd *cmd,
        cmd->iocb.ki_filp =3D file;
        cmd->iocb.ki_complete =3D lo_rw_aio_complete;
        cmd->iocb.ki_flags =3D IOCB_DIRECT;
-       cmd->iocb.ki_ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);

        if (rw =3D=3D ITER_SOURCE)
                ret =3D call_write_iter(file, &cmd->iocb, &iter);
@@ -1856,6 +1855,9 @@ static blk_status_t loop_queue_rq(struct
blk_mq_hw_ctx *hctx,
                break;
        }

+       /* get request's ioprio */
+       cmd->iocb.ki_ioprio =3D rq->ioprio;
+
        /* always use the first bio's css */
        cmd->blkcg_css =3D NULL;
        cmd->memcg_css =3D NULL;

Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D06D1D7;
	Fri, 24 May 2024 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528390; cv=none; b=Ycvq5fTdY2COC+wKwaf8m+xz0je8dy7tPzbB4cB51sBOrk5FtktMDJyn8myzXs/sWi91CRYynD3DLpiUCCBAw8O2flfNUWb0+Sn7cvrQOKNICPNXwG3wLzhJTX0IFWLVctrRf1CMU9c8BkOzwaEtDhSELO9OdwxKp5UheMnDH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528390; c=relaxed/simple;
	bh=gjbSTewq9ORbRmdsHXCP3Ffcve3q9vPy5ZfVjtrnJQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSh5d+34WWxs0vr1Sj0mlvqXcpwi4PgNxJtCmy8KsRzNKHCJ6qAEyX533/0VGm3QF3caCTnmKgX+G87R9lAMEW5kasUppljH2jWcCyfY3iPcCyVHj4dSgraJ2jkA9LTXeMSG2rKd5HLv1U01mo1bBgSfmWY177Ew2b1bTJbViL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njiEdhrh; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njiEdhrh"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b278cdfad6so2973566eaf.3;
        Thu, 23 May 2024 22:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716528388; x=1717133188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W80EX3A3tIlo3aCVhjs82wC6do/jTc3fWr2y4v1W1ig=;
        b=njiEdhrh5EXDZljvV3/+meMAUbbXrWZ0kqDrPHta/48mU8KyXCliLb9viKcRXtYKFY
         8NiweGS++vqaSIJjnTzF44Y2z2JbCKY3EcjMphK3/S562EPvkN9IwRasgCiG9jOxEjQS
         42z5My4LcS7VHHJARHKnL/bajFxFNBAAEVoU45SrNjAt/qsBXBZ5E7RUannQh1P0GzQo
         SefuKlrZmy0D9fiexezCh5ptuYUSPtFBmrnCgdAl1d4zCNRm8DcWefeKkzLfgmt4Fgdl
         baObyiew1vYKBVzgWzYZGJghHO7lf2/I8tYCFKBlpo2W365lTzAJCwyA87k3MlZBPYqE
         y2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716528388; x=1717133188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W80EX3A3tIlo3aCVhjs82wC6do/jTc3fWr2y4v1W1ig=;
        b=kuZDRjDLqAxzLKNLzYfrTTP4lGOcxhntCjTXL9uscd8z9za4xyTHwKbYaNNQIL9HMQ
         KDZATfq8/u4IwchQMHlNUfpEq2LR5sAoWqPwH5g+0HnwTDTZ7YRfPH6gj9hTbqGQU7wd
         oN2vevVKpuChbDKkDNSLFj/sMPLRR9PBCmgL23Jb1LwUJzSesFw28x9uZ+acMslBV/Ms
         2zwob1EKc0KjnfDn6DD1MklX42G8AJDuXYvweMCastoKhqOcnAPq24x2hPxO3oo/XAHv
         Ag5O3sT7xLho0bo6pzEBBB1i8gVsN5HGZo3CIieK1KqxH45qlzgF/tw2ZWPZ26z653FK
         ZkOA==
X-Forwarded-Encrypted: i=1; AJvYcCWP8K9919wEetem8ZWT4S4fViRsSGuHH94v3isEMU5O+ezKkrZsBLNnJl53OCJbq+9/hLkRmk/WliGwOxmDA7y1s6YY2iLQRk9fVJv4IPTB37sKHQN2Lf2hLnnzfHp8Yk+iIL40ecosr2Q=
X-Gm-Message-State: AOJu0YzgMaR7paEyWR22A8Sm8NstnUTPs2csLM1iwxSO6SLSBGd/GuXQ
	nY7kRnJ4s48cPUmNCvFMuB5w5H7b4AAn5+PE46uJtReF79AA6GbEDOZ4xVuAAMZs9hiUrxF0dM4
	Fx78JmyKZTmpdizY5fjk6ck9O3Ho=
X-Google-Smtp-Source: AGHT+IG3JZqCWMll/1fWprnVbk7t7DOTPBSQZ/wBnkP+hePJt4Rwr1sui9YPrp9oQFx/GQMEVxl69sRDbSv6saFFfcg=
X-Received: by 2002:a05:6820:2206:b0:5b2:ff69:9814 with SMTP id
 006d021491bc7-5b95f8bc8c6mr1505170eaf.2.1716528388138; Thu, 23 May 2024
 22:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org> <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org> <CA+3AYtS=5=_4cQK3=ASvgqQWWCohOsDuVwqiuDgErAnBJ17bBw@mail.gmail.com>
 <ab21593c-d32e-40b4-9238-60acdd402fd1@kernel.dk> <CA+3AYtTbkG_8KWNWJ8rZ-z=v-V+A9CqKCUUsXLPJyHZgL-FjwQ@mail.gmail.com>
 <fac0eb31-55f4-43fe-9e85-6363031aa5ce@kernel.dk>
In-Reply-To: <fac0eb31-55f4-43fe-9e85-6363031aa5ce@kernel.dk>
From: yunlong xing <yunlongxing23@gmail.com>
Date: Fri, 24 May 2024 13:26:16 +0800
Message-ID: <CA+3AYtR-6MxZg9_Mwqe0-w0jf15dr7=fOsMw-Y3Btbzo=jPd9A@mail.gmail.com>
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, Yunlong Xing <yunlong.xing@unisoc.com>, niuzhiguo84@gmail.com, 
	Hao_hao.Wang@unisoc.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jens Axboe <axboe@kernel.dk> =E4=BA=8E2024=E5=B9=B45=E6=9C=8823=E6=97=A5=E5=
=91=A8=E5=9B=9B 22:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On 5/23/24 8:52 AM, yunlong xing wrote:
> > Jens Axboe <axboe@kernel.dk> ?2024?5?23??? 21:04???
> >>
> >> On 5/23/24 12:04 AM, yunlong xing wrote:
> >>> Bart Van Assche <bvanassche@acm.org> ?2024?5?23??? 02:12???
> >>>>
> >>>> On 5/22/24 10:57, Jens Axboe wrote:
> >>>>> On 5/22/24 11:38 AM, Bart Van Assche wrote:
> >>>>>> On 5/22/24 00:48, Yunlong Xing wrote:
> >>>>>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cm=
d *cmd)
> >>>>>>>            set_active_memcg(old_memcg);
> >>>>>>>            css_put(cmd_memcg_css);
> >>>>>>>        }
> >>>>>>> +
> >>>>>>> +    if (ori_ioprio !=3D cmd_ioprio)
> >>>>>>> +        set_task_ioprio(current, ori_ioprio);
> >>>>>>> +
> >>>>>>>     failed:
> >>>>>>>        /* complete non-aio request */
> >>>>>>>        if (!use_aio || ret) {
> >>>>>>
> >>>>>> Does adding this call in the hot path have a measurable performanc=
e impact?
> >>>>>
> >>>>> It's loop, I would not be concerned with overhead. But it does look=
 pretty
> >>>>> bogus to modify the task ioprio from here.
> >>>>
> >>>> Hi Jens,
> >>>>
> >>>> Maybe Yunlong uses that call to pass the I/O priority to the I/O sub=
mitter?
> >>>>
> >>>> I think that it is easy to pass the I/O priority to the kiocb submit=
ted by
> >>>> lo_rw_aio() without calling set_task_ioprio().
> >>>>
> >>>> lo_read_simple() and lo_write_simple() however call vfs_iter_read() =
/
> >>>> vfs_iter_write(). This results in a call of do_iter_readv_writev() a=
nd
> >>>> init_sync_kiocb(). The latter function calls get_current_ioprio(). T=
his is
> >>>> probably why the set_task_ioprio() call has been added?
> >>>
> >>> Yeah that's why I call set_task_ioprio.  I want to the loop kwoker
> >>> task?submit I/O to the real disk device?can pass the iopriority of th=
e
> >>> loop device request? both lo_rw_aio() and
> >>> lo_read_simple()/lo_write_simple().
> >>
> >> And that's a totally backwards and suboptimal way to do it. The task
> >> priority is only used as a last resort lower down, if the IO itself
> >> hasn't been appropriately marked.
> >>
> >> Like I said, it's back to the drawing board on this patch, there's no
> >> way it's acceptable in its current form.
> >>
> >> --
> >> Jens Axboe
> >>
> > Thanks for your advice. So, you can't accept pass the ioprio by
> > set_task_ioprio?
>
> Not sure how many times I'd have to state that, no.
Of course, I understand what you mean. I would like to ask if you only
disagree with this part. Sorry for missing a word "just".

Back to the patch,  I couldn't find a better way to pass the ioprio in the
lo_read/write_simple(). Do you have some suggestions or ideas=EF=BC=9F
>
> > If only the method of lo_rw_aio() counld you accept? I don't want to
> > submit this part of the modifications separately. I just want to know,
> > this is ok to you or not?
>
> Inheriting the kiocb ioprio from the request is the right approach, so
> yeah that part is fine.
>
> --
> Jens Axboe
>

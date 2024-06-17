Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021C38396;
	Mon, 17 Jun 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611160; cv=none; b=l+tfwedoTmk8jEkMeWrnEaEBLWHDBEce4Nod/G04aCN4EYjXHdtc0vYEb3bJ20TGYPYrURvHnByDha02XFop9hbdSNktuuxxYcpakZ7Ppy3rx8/MbeoC3dkfVvrwm3DS3+AXJVQXkjW+qKKswYAVF0LvlbLuPjXUZi7/ZbOGetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611160; c=relaxed/simple;
	bh=ePuFg9h9bZymxTUFhveaPKc/NVgI1P7jDl0DoRBNujE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukhVFqKdRZFFmShXsY3cunQd/EYhwGwHjTOItwffmyCIai/gdUa4n2sNFotW8lsY1DsUzRT2QTXNnTQSr241lt7fri/JI2Mw4NmVecPw80+Q6RPReyaII+ivPmIGX8IYNo/zzEQPOnOOvpI9DlPjCYitGXe77ou1OlSdNNwZpj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+9QruY0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+9QruY0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4434fd275aaso7804271cf.0;
        Mon, 17 Jun 2024 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718611157; x=1719215957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9WM42kRH7boOC/BsRoJFNTr0tGwQRrRjkE0CGPsXt0=;
        b=P+9QruY0v+NiB2tZDqhxzB+njJ/Q5ZHv6idUkI25LwVvaCcqaH0xbogxv711TPi18n
         uZUY2oiKhAvVrYepwZtFzWLnaGSeulbCj0BvaW5Tdp7+KYk6FBa9mijS1QQL2xVwKzn1
         q5XNEBOqDdDYKVY5mMXQ9OFExEMt55rMFtq8krEUhFXP6onb96ZTPorntLEVDKKHggvV
         P6/nK+5Pvn9MyQEHdTSJMADbkv1ytbD/y7HftCHTDWcNCkZgS/cyZzeoM5ejAty8CJzj
         gPR439lTeSBRMF/9k5CET4hTCvxCNhSDNHAyeE+GxjIU9V1wVf3wVvCMFv8FnBEUguJQ
         iZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718611157; x=1719215957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9WM42kRH7boOC/BsRoJFNTr0tGwQRrRjkE0CGPsXt0=;
        b=G5AzeJytuGn1vy6Q4ixFUli4WXnuxeSTlvCinsIgq+Rkwd0hmbWEJdg/MbhFFIz/9R
         UmJ3wY8tWf17r3HpqW6+76mFxmOEHAH8pJNihVe8yo+/oW1kZAhIm1iuCJwWwJ3ytGT9
         pxB+3kHmVwRUcuFaW0oIM7Q8XCMrWvWzzePL3Vv7mFhzHUoaMMtEbj60Z6/R17LDyDh6
         glN096P/soqzCh0pocGgoLilj5DR2QFIQRjJBaVdHMcJjvtdmkTyjgPndWkT2vmO/ntP
         2JPuM5f0UTNFnbmkiShIUi5HamYS1V5sXr+QtmM87uM6zYdtY3R5r5aXx6eshAjKDa/S
         zeLg==
X-Forwarded-Encrypted: i=1; AJvYcCX6QSyYpyms+F0d4qnHi3m0TPKBaP6HpSINCpar8jyPPcHJIKFOsV/KBz6Wypn98LGIDNhej/QUEuh3VfliAE/zPNMJkqm+RtHzdMcHarTrTl5p+x/gHgUbrb0gwJuCOBkZ/1XYKb3Ci2A=
X-Gm-Message-State: AOJu0YzxJx9wZqybJkr/SL4H1lJzH0jiA0rybZ9HioXibCsKjxJr6d6S
	JtLTz/2b76bSkzGbZiYa3RsgStZupc9PwqBkXajwr5P9BrqMWV5TMlu7lco7VVTp/TeKu0MA3s7
	B1he0dI1Ip16i7B7G4qkvIiglHmk=
X-Google-Smtp-Source: AGHT+IEiLCdkMCZ8v+5/BSe3/X9QsrmZW/DBq+l7/Gtt3SCsZBwO6dokolQ9DgJFajxbn1fqUaY3KnP3VRK4ql0HfZA=
X-Received: by 2002:a05:622a:1999:b0:441:5428:6dea with SMTP id
 d75a77b69052e-4421687d21emr138891591cf.18.1718611157588; Mon, 17 Jun 2024
 00:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614074936.113659-1-dongliang.cui@unisoc.com> <7d0f68b8-ecdb-45fb-ae10-954eac5ed32c@acm.org>
In-Reply-To: <7d0f68b8-ecdb-45fb-ae10-954eac5ed32c@acm.org>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Mon, 17 Jun 2024 15:59:06 +0800
Message-ID: <CAPqOJe1=+dqcapg-_Y+Fq9W61wDMMzDLzP+CQqcTW69WdKQqRw@mail.gmail.com>
Subject: Re: [PATCH v5] block: Add ioprio to block_rq tracepoint
To: Bart Van Assche <bvanassche@acm.org>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ebiggers@kernel.org, 
	ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com, 
	hao_hao.wang@unisoc.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akailash@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 12:41=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 6/14/24 12:49 AM, Dongliang Cui wrote:
> > -     TP_printk("%d,%d %s (%s) %llu + %u [%d]",
> > +     TP_printk("%d,%d %s (%s) %llu + %u %s,%u,%u [%d]",
> >                 MAJOR(__entry->dev), MINOR(__entry->dev),
> >                 __entry->rwbs, __get_str(cmd),
> > -               (unsigned long long)__entry->sector,
> > -               __entry->nr_sector, 0)
> > +               (unsigned long long)__entry->sector, __entry->nr_sector=
,
> > +               __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
> > +                                IOPRIO_CLASS_STRINGS),
> > +               IOPRIO_PRIO_HINT(__entry->ioprio),
> > +               IOPRIO_PRIO_LEVEL(__entry->ioprio),  0)
> >   );
>
> Do we really want to include the constant "[0]" in the tracing output?
This is how it is printed in the source code.
From the code flow point of view, there is no need to print this value
in trace_block_rq_requeue.
Do we need to consider the issue of uniform printing format? If not, I
think we can delete it.
>
> Otherwise this patch looks good to me.
>
> Thanks,
>
> Bart.
>

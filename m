Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD26FCC;
	Thu, 23 May 2024 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716430539; cv=none; b=ly/TEDHx+uqkHGl04kJdSzPxmg5xlGIXOfi0xyTNR3m5T4Wu+HINCjPViyhnu6lvXFAZdyKnRn4FrIhDvTpBAonUqzfov/ZUu9UK16GX0S6Ovz+1zpCPuVn8IINQKJeLcA19kIksIoSxiojNF8Rh5e/zyHiut0xJltQ6ul7Y70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716430539; c=relaxed/simple;
	bh=Rz/pzibnlbL3tWRpV3ly6iHU47rBqQBAtbvLNaBhy9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpaR5tCSb3bQIFjSEUI1K3aZVsTWpnYYnLVY/hOd/R1Z5NThxkCal/EyvXWX8P47qPyQGJqVpr/4LSbkWoIEip3FQ22pdGIyqBFH326OiN2g3NMQk3qtHcDZjMpoypzaSOwDUyFxtO/PxMSeonxXOm6G3FjtxM9R7xs5aVHxG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWgRLIhW; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWgRLIhW"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b277a61f6fso637969eaf.1;
        Wed, 22 May 2024 19:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716430536; x=1717035336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uavZbL9YXxvdslM8FaHJLyH+/Wb+KYBkn+bR0P0W3V8=;
        b=bWgRLIhWZfSOt7eUwQnhuO+ZAyuQKsZUHhpolRZPFRv/X/AcAln1xSlgO/qZqZXwQm
         mEze6AFbuULyBFdpaS3HEzWK5i0nA3LUAKwKOe/92Gn2OoLO0Nh+aizEMsr/oH2aqBN4
         Wf3HXCWwrFIqryIV7RmLTWGfrFqPvaFnOwbbxirNtBIfOR5D7Ux9fmfhVv+WQACg6yXi
         ZalZd0y3mveP13TD2Pdp1B9JIuMA8vGldxAQaUAx0eqCBKZlen/5WXxT+53Kkl4cQ+NV
         KP35sXhsbB/sbmupzsyQu2nCMlAU9z5cLb8L5HwEJZTB/OQQvT893qaPpWho4gKtA//y
         +0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716430536; x=1717035336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uavZbL9YXxvdslM8FaHJLyH+/Wb+KYBkn+bR0P0W3V8=;
        b=ZX7YJ/UnbqijggmYVZgbgyhNCzjbj50Eg15XQ+N2zKpughLq7Mg0Xvc61JsK4I1h4C
         DEXS/Ph6r+g1a7w5qm3/owVlu8ZcZnIxm/rsZfYc0VLYSe894cUwDbozl4kfqBGDoZEo
         Dqx8iI/hfNOR9XBY8tlnwdSUggylyOV9rflhKN6Vptje2NdJ/omLpZKpvFMwTMpgWPYn
         bUw7JZNSOvz41aS6PjQa28zI7r1I3SbDVXJYzmjHIiONMv+sVMNiqAUmjclrNytB0SVT
         r4fES60fb5FbGkxSqM3wOEsrFLzOsZtvQELq98ghkD4MdG4ZAl2SVLrAS6fYMGlg3v9c
         u5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJKOqOQl6tSxS9PpDykX3KY6jHa7WGCZ+WJns0zf+wyGmetBJSv5TEoCKs3z2PKuJBoJY50hI2Mq7NEv8h3CHDpOAptJKoJWiC6xRpS6IxizMXN4NQBErwwgsjH2+K1ICWtFtZgMfWCN4=
X-Gm-Message-State: AOJu0Ywp64yiYmCSYaQnwHkBydL9QGzMLqibMyNeidaijLfft5L7w7u9
	EM2qt3DpsM8HHpVEhE6Le1WRfcuEOfMQZYy0n1Zl4/haFo9ASTD4BeEz3cD5bRB04/jPBveoUcV
	s/T2IJ9w1kJGpmWvM5/gYqtNJsd8=
X-Google-Smtp-Source: AGHT+IEj8CnFH5Ic4JJaIct67WmH5WU7V6wZU2RRtKRP2jz7hXvaccMyG9BQ9l1ZwIP0HkaKwmH78wp9Pgax2XYPdIA=
X-Received: by 2002:a4a:d81a:0:b0:5b5:1b3f:e5f6 with SMTP id
 006d021491bc7-5b7fe7a68b3mr508224eaf.3.1716430536471; Wed, 22 May 2024
 19:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org> <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
 <f6d3e1f2-e004-49bb-b6c1-969915ccab37@acm.org> <d9795483-ef64-4fd6-be71-a3946ae8fb3e@kernel.dk>
In-Reply-To: <d9795483-ef64-4fd6-be71-a3946ae8fb3e@kernel.dk>
From: yunlong xing <yunlongxing23@gmail.com>
Date: Thu, 23 May 2024 10:15:25 +0800
Message-ID: <CA+3AYtTpCC3g+31NDPFt4F58h_a43C+tTAXPTrFV5C_rmw=PYw@mail.gmail.com>
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, Yunlong Xing <yunlong.xing@unisoc.com>, niuzhiguo84@gmail.com, 
	Hao_hao.Wang@unisoc.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 2:13=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/22/24 12:12 PM, Bart Van Assche wrote:
> > On 5/22/24 10:57, Jens Axboe wrote:
> >> On 5/22/24 11:38 AM, Bart Van Assche wrote:
> >>> On 5/22/24 00:48, Yunlong Xing wrote:
> >>>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *=
cmd)
> >>>>            set_active_memcg(old_memcg);
> >>>>            css_put(cmd_memcg_css);
> >>>>        }
> >>>> +
> >>>> +    if (ori_ioprio !=3D cmd_ioprio)
> >>>> +        set_task_ioprio(current, ori_ioprio);
> >>>> +
> >>>>     failed:
> >>>>        /* complete non-aio request */
> >>>>        if (!use_aio || ret) {
> >>>
> >>> Does adding this call in the hot path have a measurable performance i=
mpact?
> >>
> >> It's loop, I would not be concerned with overhead. But it does look pr=
etty
> >> bogus to modify the task ioprio from here.
> >
> > Hi Jens,
> >
> > Maybe Yunlong uses that call to pass the I/O priority to the I/O submit=
ter?
> >
> > I think that it is easy to pass the I/O priority to the kiocb submitted=
 by
> > lo_rw_aio() without calling set_task_ioprio().
>
> Yeah that was my point, it's both the completely wrong way to do it, nor
> is it a sane way to do it. If the current stack off that doesn't allow
> priority to be passed, then that work would need to be done first.
>
> --
> Jens Axboe
>
Hi jens and bart=EF=BC=8C

Please let me explain the problem I'm having. There are many system service
processes in the Android system that access loop devices. The tasks of thes=
e
system services themselves have high IO priorities.

In the I/O stress tests such as filling disks, some disk devices like
emmc will cause
serious slowdowns. So now the disk speed is very slow, and there are still =
many
requests that need to be processed. I/O requests from system service taskes=
 with
high I/O priority should be prioritized over filling disk task with
low I/O priority. The
purpose is that the I/O requests of the system service process are processe=
d as
quickly as possible, without causing some stability problems due to being i=
n the
ioschdule state for a long time. However, these system service taskes acces=
s the
loop device. If the priority cannot be passed, the I/O requests
submitted to the real
disk device through the loop kwoker cannot be prioritized over the I/O
requests of
the filling disk task. Then the complete process of system process accessin=
g the
loop device will take a very long time.

So the purpose of what I do is to let the I/O priority of the task
accessing the loop
device pass to the kworker process that submit i/o to the real disk
device. Do you
think the io priority of the task accessing the loop device should not
be passed to
the kwoker task? Do you have any suggestions for my above-mentioned questio=
ns?

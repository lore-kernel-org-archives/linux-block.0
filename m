Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C41DF261
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791706151; cv=pass; b=Z9O7mueFQiAxSwBb0CCofNFKQWrRTbuyH8+6kgpC+Q9oS6CoATWm51+wezQvy2W5U6vEKLAzw3VfCE9qZDIWRAx7zCHbD2LsuSHGxQzBsqFthwgnWDIsJx4+/7WUhJAQ9ig69ZFZJ0/w11BJ5Bj/PE6OA1KqHMVUTmLSh0t/35Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791706151; c=relaxed/simple;
	bh=456hjJXzLfO9u8LggP21BRuzL0marTjopkVuGLtdsuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWeXDF9e5TjriuyzG/uGrz2p17NN4bL6la5657rtngz33lA15yQFR2B5A7iMnGWDmm2cR3x2bvCgGHghqlEozS7H1D1EXICNJ4a3mtMhvG9zBCq+QGVWR4ogZwQ40PLBI+79+kgcXlWqo1ej0LKZHmOTGfT6DE40prTeMf7EsTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCXHjei5; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCXHjei5"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4a69499cefaso26834fac.0
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 01:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791706149; cv=none;
        d=google.com; s=arc-20260327;
        b=Z/w9Weq0GoMHv6P0YPnd7cWRPpOTjqry02tglepX79FB8L2mVwsdspqUeEqO3as5eI
         qH/zN2oUImO3dt78Y6rL0nWA2gIiJ48303jC0bsTVzy8IN3REaklUFabrhteaViS+hNq
         0+0xZRmB20vYMPDYWwxwlOuuwe7rMdCPybr6ypZp+z6AVu3LMxNtKwxHAE4DVW2GO8+Q
         OvB59ur6Xb86r1Xh1sUg4SVqU421F2IGmbQghR4ytCrn0bFdn4/B0J+u6TRuyzugtwCj
         uM9P6K1hKWmYAT/GBsnCJru37rjCrCIoYcoTsGbRaxs7pixB98c8cIh5jaLebYhObatv
         Gx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TrfDN8QCSDnrD5swZB+fuUwhF2n+2YKrUm1LOsS6ico=;
        fh=miH0EywVgh4CaT3vHwpwwbPNUw/0+3OsSqn8yTN3Ci0=;
        b=QVzv9/YSVyiQoMJkulVA17sQ6GJdlwT46fgDUz6WmK85WoHqcdmEMEBZEk/AKgBxYI
         5mYMd9WZPYsEnAHTm6jk/4JvJgydx9suDG6otEWzC+Yro1H9/0ZbPE6kV8DqJp4sM7H8
         gV6vCj/2aBEm65s9XkJsNmz5ictjRBMpfnLXJ3SR0ksM6n1xKWthmUawcdMALqYf62CE
         MQzqmT5xGEzD+tJewVJdHXIU2T1ewr64P54DlOeSyqF/YRMjZ9FCy7/Vfg54ghhf1cVT
         tTCfmnJqI5vZka8Qtf+Gt1SlzxXzg2jPZxRBDnAhoQs8Wg98dP4gMB6BCgHJqXpnN+AH
         l7uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791706149; x=1792310949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TrfDN8QCSDnrD5swZB+fuUwhF2n+2YKrUm1LOsS6ico=;
        b=lCXHjei5h8rfofg0UdBPpanWkxuLd6TTxDP+yOzNXp+vQ1JNJTngkuxZAYrmrp5Ao1
         hlAKcVs1N5C3u5BBK1luN5wXXN+/+pksH1yd9SqLO65Xu3BJFpSZgRZZ6GfmQlLhZu8Z
         hACu0KJ4nb1JNkkxwN5E+kmNZRFz1tAJpzRmn1R6Bj742RMslzwsUJG3K/EsiXROYEMF
         ydffyuHpjbx4MMtRjr+HBXnyJgiCZ3Iet0P3l7WpIn996PMhp1UklTNSSoEj2W+WZpIw
         3AWCvdUYoMFc2A1lkivNeoFH1wAwa4//olkCUcNtZ5znWAG2NIciE6DSFupVUUKeYaUB
         RFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791706149; x=1792310949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrfDN8QCSDnrD5swZB+fuUwhF2n+2YKrUm1LOsS6ico=;
        b=Aa3Cq/dAkAZ0bhgYm/qGlvalO3aTowl/U8zcIJAGDI1vrnrQNKm5oL55QzhW9QBWFN
         2FTc9EIr3uznzbzxXRJenCsdEPBesdZ1GGfS+Q0+ZR9AY1Kn2GTgcC7NPOIArQsNH2LQ
         G7fXGell3d0AxwbREXk3wActrGbkkaNHCEhSBxXPy759iXWZVcNgjwiq/a1eKtegmiGn
         zWsCDiZEz8XoexV3E/lqATxhLH822kHGj4l/ntktQkVnxYahMxdMAgGicTRj4yRIc+xa
         XLTjbsG1R0h8MIey6EdDEAK2LhhBZbWuqZrvjqkIP921iB+10WLxy2LEDhrDAq2sMABy
         4Xyw==
X-Forwarded-Encrypted: i=1; AKwUvBybaYjtcmtfhTLhydU7YfYGt2PshL6bHy5j9o6O3OBoJXrtyUMpufgWc8vN/onTiGVG/auAqtdl6E8Bow==@vger.kernel.org
X-Gm-Message-State: AFq9FYLO1rXt/oK5Cf3aJB8E8B0uoWsZ7V7CQ9clJDIHunwdOoilRd0s
	glUo+wVVKwsiOrmtv/MCCRfwFKmErZJEi9pGjjnoA/8UBIzEvIfakjy4iVcItsLAzeGijLAvLrP
	APvdgGrCBxPd0ZWWyVKo4ce3w4XV4VXF7IhqAjvs=
X-Gm-Gg: AYBFou1Mf3LitYlK+qb1tlIzsZTPlQPc+1IDM8EiuiapoWOTVOi3JgbzudiCmcc+zBt
	TfjNcSRPpD1oFFsigQZZxNvR6pn4lRm/IOjEDGXi5GmoGGyVkdL7A/+Fapu5SSK0M7oLFhUHEwz
	a+MJPT2eaEMzdGjXcbF6y7gePEN0gCeySjDA6mvtDdudLbx3vWp0quQx/I+GVtFqENCVnsLH31w
	O6hkcC6H4P2NmOUCqeMPAg44/yOAhds6rPwRN1b23MmseHQFyiY64EXnCkk/TROEe/CwsDgpvPP
	nXXK4BqTVs+jytol8tUp0TbgtHZtFUmcYaREzmiI7WNFg3ulKLvNIZ8SqPr/a4xXGaR1b8W4TTk
	Zk+BrmWZHP6J7iV9gvNkiH/6V0K4ElBxZ8c3C7DFXwsZjJ9+j0MjVy7s=
X-Received: by 2002:a05:6870:263:b0:494:7af4:955e with SMTP id
 586e51a60fabf-4a2a49a8588mr4438684fac.17.1791706148658; Sun, 11 Oct 2026
 01:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALkdYjXcbwUW0=Eb52Fu1X+kLyVxVYZC0D3iEL-E+BmH6C7FkQ@mail.gmail.com>
In-Reply-To: <CALkdYjXcbwUW0=Eb52Fu1X+kLyVxVYZC0D3iEL-E+BmH6C7FkQ@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 11 Oct 2026 03:08:57 -0500
X-Gm-Features: AclHuK-ypxXVNwFF7jTrm1j0rPjKUoeQKvy5nhuzAp9PB7YTYo1QnD69PKj8D34
Message-ID: <CACVXFVM7_HPUEnjvZY23zu1kwtbw=kwm87FzcNjtpDzRs976Bw@mail.gmail.com>
Subject: Re: [syzbot] [io-uring?] WARNING in io_wq_put_and_exit (2)
To: Eugene Siegel <elzeigel@gmail.com>
Cc: syzbot+b0d54b9e81de55179e47@syzkaller.appspotmail.com, 
	io-uring@vger.kernel.org, "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.org, syzkaller-bugs@googlegroups.com, 
	Nathan Gao <zcgao@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 6:18=E2=80=AFPM Eugene Siegel <elzeigel@gmail.com> =
wrote:
>
> Hi (hope I'm cc'ing the right people),
>
> Using an LLM and a deterministic hypervisor, I was able to reproduce
> one instance of this
> happening that occurs sometimes with a process submitting
> UBLK_U_CMD_START_DEV and being
> killed or exiting shortly after. It leaves an unkillable process around.
>
> The process did the following:
>
> 1. open /dev/ublk-control
> 2. io_uring_setup
> 3. send UBLK_U_CMD_ADD_DEV with 1 queue of depth 4
> 4. SET_PARAMS
>
> The process did not send UBLK_U_IO_FETCH_REQ. This way the queues are not=
 ready.
>
> 5. send UBLK_U_CMD_START_DEV, since it will block, it will get queued. A =
worker
>    will spawn here in the idle state.
> 6. do_exit is called. io_wq_put_and_exit will set IO_WQ_BIT_EXIT and late=
r calls
>    io_wq_exit_workers which will wake workers with
> __set_notify_signal. Then this thread will
>    wait in wait_for_completion_timeout.
> 7. io_wq_worker will get_signal while still idle and exit the loop becaus=
e the
>    IO_WQ_BIT_EXIT bit is set. Then, io_worker_handle_work is called.
> There is work on
>    the queue and this worker thread will call ublk_ctrl_start_dev.
> This will call
>    ublk_wait_dev_ready_and_lock which needs ublk_dev_ready to return
> true. Because the
>    process did not send UBLK_U_IO_FETCH_REQ, this will always be false
> so it will keep
>    waiting.
> 8. no progress is made, so the trace happens after IO_URING_EXIT_WAIT_MAX=
.
>
> This race depends on the worker being idle and not having run earlier.
> If the worker has
> already run the item on the queue, then it would be waiting in
> ublk_wait_dev_ready_and_lock
> and return -EINTR instead.
>
> I think this is just one instance of this bug, there might be
> unrelated instances also
> in io_wq_put_and_exit.
>
> LLM-generated test case (7.3-rc6 (3857c2fe5449), KASAN, 1 CPU, needs
> root and CONFIG_BLK_DEV_UBLK) below. Note this will leave unkillable
> process on machine. If you run with an argument of 400, see dmesg to
> observe the WARNING.

The following patch should fix it, and I will try to improve it into
mergeable shape:

https://lore.kernel.org/linux-block/20260930042335.16199-1-zcgao@amazon.com=
/

Thanks,

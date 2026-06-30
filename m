Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162F15C14F
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804000; cv=pass; b=eZxDjQdl87qMuRiJ67JrJOM5VWWOWgRxZ3Cm9m1c2qJCU/8+eqihxmJhG46Wz0JAlFISAa0V8jyBUr2Dlei86z1gZ+6koo/2qEnj/bZF2XFET4tb4XHJKh/ZcFhE1JbqeJTKdh50dNgCvmYN9vwh1NnDe+OvNmOSs9wgGxP9P1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804000; c=relaxed/simple;
	bh=F28JSHUvtIiMJrHZex2q5cijigT1XfCkWVMp0pOXSGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obQQ2Tg1aX0RpiRg4mXdXzLQnXnqa0xVT68Fd0XSExKUONPVKWy3TgW8cU/7EHu7SE0kqe8JYNF9mv5f53bwgKu9B25Sa4HK3HvVEKnkwfGzYNVa1LXTPZaC9XjwZjtfhhFEPCC3O4aaH5obtpxs3krrkdQAONITzXSqXoDP/II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WO4vMDUR; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WO4vMDUR"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e50979c71so252384485a.3
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 00:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782803998; cv=none;
        d=google.com; s=arc-20260327;
        b=mD3B/h4pWSDiQVcmKCvaxSRTkPs4q/NeNLhkWzfbp1rkw3EM/dUL2aMjtAOT96PAZM
         NOMvJ8fW9RT7GxJ/GTO4O+3BVzX35Itxde4SRVZYDTebSmRtkZ+52uar8KcNfJWPEEHp
         dgv8k4JrshQwzbTg9Vkgaz2Hel1B2k6u5ATTL7ev8rS2458p7t8RJordhC+l1Bi1jAeh
         ZkkbOMoVBdCgU7U11Ct1CJNYstGysO8BiCDFLerDM/xFwcbW5q8wtnvlwWQQuHL+eYfj
         4P4WZCfmkWoSPK3BXAFglbAlzyBAJHQYHDDB4cAU4GFuW1UCioGzMZXn/eyRJeL5Cm+7
         Sy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F28JSHUvtIiMJrHZex2q5cijigT1XfCkWVMp0pOXSGE=;
        fh=/3p5Aw+0st+xKfk6qy1FYMltApoQyKk5tv5j2uqrOmE=;
        b=Dj+Men31yqYEkNwRf2FiPz3VE5EfJ1dOLOTSRQJk3gyfxIJfMsejLLUqUqmUHPAVju
         FVorD8tH0kjNBMMlachvwCDkCa0xVa8d2dv8dMwbkDwVDb7lxtS6b9+BfnTCikeX+xBQ
         k8X6ayWSzzThp3dDIIjTIkEuXq7OZF6zcDGS8sBgrThSfLeVadwkEbOBLRGwGiAgks20
         2saKj5768e1mmRJZAr76BFsXLlgXLlmS47pl6eKj0Dy8v+7N1Y5JxCnycIHH+bzoJqCF
         PzeTD0U4ghpLkWWhH/fTVip4/jnG4xxjZwz7cG642K1FGG3f3zfqm+hxPFh3MzizeZtQ
         B7MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782803998; x=1783408798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F28JSHUvtIiMJrHZex2q5cijigT1XfCkWVMp0pOXSGE=;
        b=WO4vMDUR22FABgTX2mO9ipdk0/9/sbrG37TxSEaIaZpX/ZQC+Z5Fz7JSlYOxe/2GYu
         dx10Icvn/NyG1qoOi/JPy84liz9ZzASKW6wEopIIIZ+DFDBsPtYizq+YAbfif+pk14Xe
         xv3loAloIGDax2iOmcgzg1EX4tdRk9kgoDi5Z7guJ9HpeZLwB4MKSp1HjLv+XIBdcpk7
         JWqNLlvMCxwalFkHfKUYn6VGKo2U+1EkOlu/oybAsIeQ3K1P2dxzivbQtqCUwzjbECLJ
         VRz7JU2wqU/QZv6cfLYKVOuyeCZQzNj2mZXmhIZrMMzV4V+Hn8a89pVzVGaw0mCzhjTw
         j5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782803998; x=1783408798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F28JSHUvtIiMJrHZex2q5cijigT1XfCkWVMp0pOXSGE=;
        b=p3rUM8N90cO/JDBXZtkgX/KjMc1iiCq3on4PwS5p5d9pRJ0CtI0uPBshAqpBRcLf4w
         PY9YqIqheqUlH6QWnWPkGgkJzYUgdquqBvxqhSD0t0BSpbsPohz+FrNc0lC1UiQHH8dw
         gxCeN8xc/L3Y+cUR0yVwTH8UjuMrlhDN0hUb/v1l0iq1Ieiiou/o5EsoI1+nvRPJ8JFn
         NxQ04s1FFJNN0T0MUUxSwMDYvto9BOTjzpA2DzUIEJLerWcR3f6jjYo2C2bQLiXsqy+K
         bS2D5OG0bURbevmF5iFN8XKtdYQwUmyL8PvzR/A3BiSXyXopW4SBr693cHgyJPUM8qFD
         5Cng==
X-Forwarded-Encrypted: i=1; AFNElJ8CpUqZhpPYk/8G08lqNgI8XJOBrEvMpPfoaMU24j6zns3nbsG/fxmMKcnMN24lJ7d7Y9CsvIrD4WXVTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhvMG8D30kLxpyZZ75/cQAv0Cd+GROjDXtEEb5W65LmxXQTb9
	cR9siHKBKClxyTsemoTg53c7ELNCqziksOTYj4ovHSAnpe2Ms3gc8+lhhT2WCdtijHmDC6o2IJN
	iXoBosWjsvo0J+Dryg8YUXDrfepdf+eNKFxnNbKbN
X-Gm-Gg: AfdE7ckO6qQyg4EyWuwyN8+nD7jWyMpxDr4YBCAd4I0Xh6peO1jtUOsSm56d3AJ0KFI
	EOysI3dQiII3TMS9CphvlNgRXpHcIE9YZ1bXycOJOMtLPvcC4QcKfNdFsBCN67b4AoKuxOfGvVm
	N4XQJ0j/4fd//ET67+l38e6T3pY0h9XJKKQY7wMfLFvp1VTIVyFmgmQVoA0VNyjcV4mMJYmesyp
	RbkudiyQ4Fc6SVy1aQwIX07TTd2vcNCqd2JELNCBFveFJyQiB0DcEOGi1ksXKx71Y4YPw2GcuJH
	WJ6aNYQcVEXkhDP+B/RlXNQpHDRzyUtfPowApb2WZnOsDb6jHD4pKq1sK5j1/3dDJ34Q69nQC34
	igLsLy/qm
X-Received: by 2002:a05:622a:1304:b0:51c:981:94a6 with SMTP id
 d75a77b69052e-51c107b21b8mr32148201cf.23.1782803997273; Tue, 30 Jun 2026
 00:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iLPWCo_u-8jCsDM6jjZYfESvtUt9n3xD7yuAyNNntSw6w@mail.gmail.com>
 <20260629052854.252-1-hdanton@sina.com>
In-Reply-To: <20260629052854.252-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Jun 2026 00:19:45 -0700
X-Gm-Features: AVVi8Cefl2XQm68lhL58TMM5XfBLIzHlOMqm7XlLDyUcPbD7Erz5hlsvmGjm4H0
Message-ID: <CANn89iL-RTVME9qcUSVZW6qBEkVh8suw2pcLMCh0WM1fTEz6Jw@mail.gmail.com>
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
To: Hillf Danton <hdanton@sina.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, linux-block@vger.kernel.org, 
	nbd@other.debian.org, linux-kernel@vger.kernel.org, 
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 10:29=E2=80=AFPM Hillf Danton <hdanton@sina.com> wr=
ote:
>
> On Mon, 22 Jun 2026 17:21:53 -0700 Eric Dumazet wrote:
> >On Mon, Jun 22, 2026 at 5:07=E2=80=AFPM Hillf Danton <hdanton@sina.com> =
wrote:
> >> On Mon, 22 Jun 2026 01:18:10 -0700 Eric Dumazet wrote:
> >> >On Sun, Jun 21, 2026 at 6:43=E2=80=AFPM Hillf Danton <hdanton@sina.co=
m> wrote:
> >> >> On Mon, 22 Jun 2026 05:22:55 +0530 Deepanshu Kartikey wrote:
> >> >> > nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lo=
ck is
> >> >> > held at the point of reclassification. That assertion was copied =
from
> >> >> > nvme-tcp, where the socket is created internally by the kernel
> >> >> > (sock_create_kern()) and is never visible to user space, so the l=
ock
> >> >> > is guaranteed to be free.
> >> >> >
> >> >> > NBD is different: the socket is looked up from a user-supplied fd=
 in
> >> >> > nbd_get_socket(), and user space retains that fd. A concurrent sy=
scall
> >> >> > on the same socket (or softirq processing taking bh_lock_sock() o=
n a
> >> >> > connected TCP socket) can legitimately hold the lock at the insta=
nt
> >> >> > NBD reclassifies it. sock_allow_reclassification() then returns f=
alse
> >> >> > and the WARN_ON_ONCE() fires, which turns into a crash under
> >> >> > panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
> >> >> > against socket activity on the same fd, as reported by syzbot.
> >> >> >
> >> >> Given the syzbot report, if you are right (I suspect) then Eric del=
ivered
> >> >> another half-baked croissant, and feel free to cut it off instead t=
o make
> >> >> room for correct fix.
> >> >
> >> > Nobody (including you) caught this.difference between nbd and other
> >> > sock_allow_reclassification() callers.
> >> >
> >> Nope, actually it raises the question -- does the deadlock still remai=
n
> >> after your fix without the lock key you added applied?
> >
> >LOCKDEP might have a false positive, but it will be much much harder to =
trigger.
> >
> >I had about 50 syzbot duplicates (that I did not release) before d532cdd=
b6c60
> > ("nbd: Reclassify sockets to avoid lockdep circular dependency").
> >
> >>
> >> > What was the "correct fix" you envisioned exactly?
> >> >
> >> Frankly I had no evidence against your fix a couple days back, but now=
 I
> >> see your lock key approach fails to take off. And the correct fix is t=
o
> >> erase the incorrect locking order ffa1e7ada456 tries to catch, more
> >> difficult than you thought so far.
> >
> >Which incorrect locking order are you referring to? This is a LOCKDEP
> >false positive.
> >
> For archive purpose, syzbot report [1] where udp was not invovled defies
> what is fixed in d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
> circular dependency") -- "Since the UDP socket and the NBD TCP/TLS socket
> are different, this is a false positive."
>
>
> [1] Subject: [syzbot] [net?] possible deadlock in inet_shutdown (3)
> https://lore.kernel.org/lkml/69c37e6a.a70a0220.234938.0045.GAE@google.com=
/


Why don't you send a patch if you think one is needed?

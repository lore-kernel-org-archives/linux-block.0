Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582A377ED4
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316808; cv=pass; b=mUxlCMzvbb9C+3dod3UDdcpwL1ZX+UQeddW6LezRhHGgYMHcTgUS+VyZZC64LMn4qo9zorE+Lzwkon3C5yo1ftYBMmDAwoS/tPgpEOqvKgC38fACXD81i7o1/w8op9ymLYsxPM7PiZM4FmrFeNHJSzi0nIaLqBPKvq6haVYqPWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316808; c=relaxed/simple;
	bh=QzVUxg+qoKRQnjHw1sUQaBfdz+Xq27o4lQVXvEw9W/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoaO0lY0ofXJCPES4OOfs/m00jTQAjj0TRcNQjQ6TSG+qhp4dmCjU70348CKtMFNLUW/henJ67VJ4WZGQlTZuHxCyW6L3pL5sD6nsd/c15iLtARzvEo6u9Xx6TBK0k7i9enT87bT5sI5MAAnNbMIcOswP0sYcILmjNLK7mvPt9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=th0TZPNg; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="th0TZPNg"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so2325657a12.3
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 05:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780316804; cv=none;
        d=google.com; s=arc-20240605;
        b=JXJB0SgSXvQQGRr522qF60SqWiok7llqnQlceYUfm1eWZ02hunABheEIbH2rl6eIu7
         +2SB0JsAcEfRtBVUYmvfNWTRbmc/SixaV0tNqFxphnYJbUUzYR3dko8TCORYmYSG8wd4
         4k3ie8I64I8I5XLARyz/KCYj+JspPgkWG4rRrmVHJvSoYSHVZbvtwHKIgW1o0mLV9OS3
         flUHE5suShe3kmsGidE87k4Y5wWo2/uoRhLX/gwvUzPDqS1TI+Eo5o3Tg/YPu7RNwDVp
         sezzOPMlCXDrT1Oy0hGV43UZyz9jLulgEHJWVfx3+WAJw5kG4QkC0xMOsk3MpDvzp/JS
         6M/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QzVUxg+qoKRQnjHw1sUQaBfdz+Xq27o4lQVXvEw9W/U=;
        fh=IsUPQerjHyGjgw0briz+yhRNRJMadGVEr4Qm6Ltujm4=;
        b=KuU8EhvozCqTYZ69TKqvt3cma3LxrCZlqQnk07qk9dl1gP11Y1J1lli4s9/DncBh58
         FZH8zRkiHSS/9EW9EIKhj+pNmzr66MUsQ5eedMhijRpLF07FZZ2/dGxOsZjVLD2S8bGv
         /qaBse+ELFCF0myn+iXxYQtTVZTDRz84kQTvNV4raGZGA9mEQ2qxr46C3F+q6k9QhcpZ
         VgnPUCbtKUE5ep+rcfa30lMfa7o4tgLDF4KOpuZNfFpxzikuzTv9Mx6Lt0WvT2UBheVd
         igSy3R6r81N/rAHNJmLnO9q14Rczk+eEjR110NW+naaNiXVzTG2ya+HX0f6yCUNbAEd+
         ty6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1780316804; x=1780921604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzVUxg+qoKRQnjHw1sUQaBfdz+Xq27o4lQVXvEw9W/U=;
        b=th0TZPNgun+5/Ats8s1hzyCRJSpruW7HYx5zPw93IKI4/twB2ZoRun7TdgeONyEBto
         XhkQ0VBKDbTaC9kdHNtAnstw+u6v2m9Qeb1C8aPVz5WPgfM3SEIDLoXHYxVDgkBnJDD4
         Ly2jMjMZQPonTXD7oS/HaxGMZUkK04a8dHMFk6LITvHAiDCyuHnfiwaFFBCsiTd4n0J1
         11ljUGK/yd9qgsairHovgK61nuIXf0K22V3+irM+2qQGD7B4EhbgsNKDfLhHP8omy2IS
         nyKe3lCtD7DL1PsONvgrJv7FdphBrjuYMOZ4eTRDPu6FiaMJfzi636PtvzuYIhetxYsP
         fosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780316804; x=1780921604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzVUxg+qoKRQnjHw1sUQaBfdz+Xq27o4lQVXvEw9W/U=;
        b=DKfB0R+xeiaH9dK2Zfc9BM4pKNAmDPW/1cSF2MYQ9urZM4qmo8i01pCJ0+W+iDlPJE
         iPsFIlywJU2xZGtCJeZ0heH6kFQy8vgknKalLVt3YQrNGiD3+CapW65a7hRBNRm1DMrR
         7O8lxOd0AO8hg6u47sWRlmCBZAzPbEFXIpzsdUIJ6kah28zHl/KDRF7BbiZhYVqKEAFR
         Ue9Hvry0HVjUxnYLNO2H5Lnc946JwCktFiOGcqAwwrZ8/zYjRVGfdt8y2WX7vUEhgfB/
         qqV+bMuZR8KD3pZzNLiNmtZoDvSiYpcRsJJyi5mcb+Fs2Q2PeElkjkcqbXpGd0o3803V
         8gxw==
X-Forwarded-Encrypted: i=1; AFNElJ/UGhF9l8/WsGGS78J/bzwrb829rWKXJ7sY9IMRzRnyT63LxrfCDjxeksVTBK/JCammDRwz+K4hHqM9sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrjWzI49y8T3xpMTq0YYKnIc0Aq+KqUMJ2nUqxYdrPFXBumho
	vk/maEiNQZt/Aq5+Y7yOpPByJLvzazKvr9EJNL0UJhK2lUd/GRlQCPX63pescml197ro9Dj0UMQ
	wf/9EOrx+43FnUYLeLtsFdrhKTWyD7btypB2yHyrQoTWhAAoVw4wiYUY=
X-Gm-Gg: Acq92OEjhDXUbmn8bOOfGWKlIDkJ1GTlKK/o/VwoPujnOeRZXjQcW6jeEd22y7lqpbR
	lNHOb0pMrIEtbq1gsr+s/9M+/ZjMihaNSlrYiNAiB30KApINthTgrfauOCbgPBxN5vTgSFJ39lc
	aNCHMemnSwBToQa1RkP5t44d4aUDVCVSzbam+E4N8yWo/2z6H3UscAubqb9Xssxj+VE2Vq+/jDg
	DJvq0CvBh8wevLth6+qBVSfvx6z74IrSq2ixxAk4dKeLsQspN32VEdXIATBLqltqE+uIrSX8REl
	qiUvn4oXVwfhyAtBJfGC
X-Received: by 2002:a05:6402:5385:b0:68d:643d:be37 with SMTP id
 4fb4d7f45d1cf-68d643dc042mr2255463a12.23.1780316803105; Mon, 01 Jun 2026
 05:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <afm2PewS5Gi5QU61@ryzen9> <CAJpMwyjcUc7n9g0YMbpBPZorUOiyseBOHHKoUhYDriEu5gzLEg@mail.gmail.com>
In-Reply-To: <CAJpMwyjcUc7n9g0YMbpBPZorUOiyseBOHHKoUhYDriEu5gzLEg@mail.gmail.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Mon, 1 Jun 2026 14:26:31 +0200
X-Gm-Features: AVHnY4JQLz_Sni5US6QGWorcaq_1mrA4ZLP-t_r4zBEVokncQIceGYxK1A6EiaQ
Message-ID: <CADGDV=USt71WBRAXXmwEERqQp0fpk7QPaOyrZjkGXpnY_yYSCQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication solution
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:16=E2=80=AFPM Haris Iqbal <haris.iqbal@ionos.com>=
 wrote:
>
> On Tue, May 5, 2026 at 11:20=E2=80=AFAM Philipp Reisner
> <philipp.reisner@linbit.com> wrote:
> >
> > Am Tue, Feb 03, 2026 at 04:09:59PM +0100 schrieb Haris Iqbal:
> > > Hi Haris,
> > >
> > > We are working on a pair of kernel modules which would offer a new
> > > replication solution in the Linux kernel. It would be a block level,
> > > active-active replication solution for RDMA transport.
> > >
> > > The existing block level replication solution in the Linux kernel is
> > > DRBD, which is an active-passive solution. The data replication in
> > > DRBD happens through 2 network hops.
> > >
> > >
> > > An active-active solution which one can build is by exporting block
> > > devices, either through NVMeOF or RNBD/RTRS, over the network, and
> > > then creating a raid1 device over it. It would provide a single hop
> > > replication solution, but the synchronization during a degraded state
> > > goes through 2 hops.
> > >
> > > The proposed solution would provide an active-active single hop
> > > replication, and a single hop synchronization (directly between
> > > storage nodes) in case of a degraded state.
> > [...]
> >
> >
> > I stumbled across this post because of the newer replies.
> >
> > I want to point out that we have significantly developed DRBD over the
> > last 15 Years as an out-of-tree module. In the past months, we began
> > the process of getting all those improvements back into Linux
> > upstream.
> >
> > With that, DRBD9 became multi-node. It does the =E2=80=9Cactive-active =
single
> > hop replication=E2=80=9D as it is. The networking part is now abstracte=
d into
> > transport modules. We have one for TCP, one for load balancing across
> > multiple TCP connections, and one for RDMA.
> >
> > What you are doing here, in DRBD lingo, is a diskless primary
> > connected to multiple storage nodes.
> >
> > Find everything here https://github.com/LINBIT.
> > The latest edition of what we bring to the upstreaming discussion:
> > https://github.com/LINBIT/linux-drbd/tree/drbd-next
>
> Hi Philipp,
>
> Interesting.
> I looked into the diskless primary mode configuration for DRBD, and it
> does look similar to what RMR/BRMR offers.
> We plan to do comparison runs of DRBD diskless primary mode, and RMR/BRMR=
.
>
> I see the DRBD version in the current kernel is still 8.x.x.
> Do you have an ETA by when can we have version 9 in the kernel?
>

Hi Haris,

We are working on it. We are currently aligning the way we do things
with Generic Netlink. We are aligning our code to follow the upstream
conventions,
and the .YML and code generator used nowadays in this area.

If we are not discovering another area where similar cleanups are necessary=
,
I expect that we will submit it in August.

Philipp

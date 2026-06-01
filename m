Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7543DBD49
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327785; cv=pass; b=q3vlY/r5nK4Z0PFavNuqRhMwRNSmRpHBVIKT0BSvAPsjdbWCjl9YJpJ1klnaT8DQ8xrTuEWntYigoDyL7Gy8P5HGD6T7vf0WrP7t6WmHiEXlInX5OTxF4gjraLWTFN/aFl6l5OeMZM0PIGqqYzRBbqdwXUeMvNzvPFbEZjzZtRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327785; c=relaxed/simple;
	bh=oi0Ow0XDEAtBt8RurlGOIpfeSQVz3W7XDL/R+3Ddj+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2+xtrRmVeD5COPjGedv88R4qZJUwEtBegMOZL48zeJEp6Afid8j/7+in6yA7JAx3IegTHsYA5G84ihkwmwLAbNdjSo/fxRh69LD3dYfilXflh3cJNiIUcmjJm5p/OD0TS9Wox7yJQSTSqnpNaaEmttqeFxHT4WyHFJ3NZMyDAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmZLuySf; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmZLuySf"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43b6f19b7d4so7431501fac.0
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 08:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780327778; cv=none;
        d=google.com; s=arc-20240605;
        b=JUtnoDX3PVwV+9v89C0uhGKB//O+/iceFCB0eW+X4hznxGI98CnF6E2If21K4CekUT
         4+gdmlDHFmKjlGSHHHXH1vrWkNbuGw3ZBe9GPfFqldvC6EGBmfWkXkFPKRZi+dlzMVpK
         5a6ugsXCpWmdrrbMSj/2u3AL/e8hCtD9211hZMkYJvB/97pIdGCF9R6n7JDHE7CepTsO
         dJPB+GYg7PzTAMMU6p0tsVsxCwihu5tUTa4HNMjlh6Y5b/MWZXZrIHmjdaLBGXQZ/hBp
         FSsyYz5PA/GX0qmLZttHV5I9gSXW9DZHKmHGWGZeUiaVLYGFhOMdw36lfPtqT5En/RWR
         aD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUPzckO9AMpnkkxRCiU7u4+L0pp2JXYyq4zdqyU3+88=;
        fh=FTOE5p5TZKIuxh5klEuSgzOxsC+WiItJby+1cgJ7DsQ=;
        b=JgeTi2rtEx9ASws8HcRYramtgaBxoufFbpSuwyJBLC6nMPeZbiX9x+vW6cCplPiOL9
         VIJZ7lpEMUrE9IhLTQzDzoDg+ilMR5PBP1XP5X9VvRoKGVYWQt/5kvnuapRKfxD/71cY
         q1OL/wXUmve1jawHdbVXhS7ct37Uu4n3Hh3gp4IR8/kPHLmVQi9zILjuIuoE8kzursK/
         635mO5s/8ztd4EZolMgYeI3ngjtKZ8nO3t6xLYpHj10cXhVAiulvPBh4ofbO2RoLJxsa
         b1j4O4f66xDWcG8HR9w3jbC8F9OXPWtSeCz14XxBoNNH2/s0uqykk2vl8EEetCw5dLez
         nG0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327778; x=1780932578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUPzckO9AMpnkkxRCiU7u4+L0pp2JXYyq4zdqyU3+88=;
        b=JmZLuySf1jxWK5iDgOUg/KC5wpk4YcTA4iHLvu3SPSE6bQSgAc/uzq/xgRbv1H9GNx
         jX29mDcnib861fKIHDOztT1C9J5hKrp56xQwMKnFZSG9MZ2K4BKW95lLf3VbLQlRAITb
         6L6p248QXgPCy070KkpSC25fdw1D25He37dIruTaI9ei4g1N0p1vtyPZa/fem+Q+Cr4e
         hexmIDrKKR1LzML5Axq6NWW7A0Q1OR2JYMMutEM0sjOrz4E9SuQSQXE0tNsTI7bH4k+t
         asSyLZRtVrAP+Ad03YBGvDtgn3bphgeBTVK3+I5flNNT3KAejHZb1WkkA3k4Qn7fpefh
         SZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327778; x=1780932578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUPzckO9AMpnkkxRCiU7u4+L0pp2JXYyq4zdqyU3+88=;
        b=O0DDvh36nGZOooIuijs2x/JDjdGB9scBvzj5Y3DG7Bsq9l4X1DAAvVynOgPHUivIEj
         awvcwWDcICrQK+xXU9qKFmcDAvSppERTD7+3pt9O7YrB5qH0aYmPXlvQ+Z4TBmj6+Kuh
         5jem0wH5jusp1MrNvpGV0qprHjbikgoT8Sm0TrP5tGbmVz6lJONRfNk4CqAnfb4Cd6z7
         WMY5obOKuvhnaZ4WEntmV6RXSbciUB1HyrjUqQ8Xiz3pCEzOMDjbcTN5RP0J990taFBa
         L8eG82DVRKUGCTwZtx1uZCZGxynuFzhh6IkLATcOiRJkP9ymRa6egqVdP8DnE5H5SPBM
         BkkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6jAGivBn3+w18271PpCsM8OWt2gNCy+usneJE1JDtP2RWvjWK8I6M7V/ynBJYGiegB/F5f43DaEcRmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJL5pc7vXU8G+iJIbb7Exx0ZH2vF33INsdw96uT8t/6CdDsVU
	MSehH3/FKfv32pdoIBEHFtdodhn/+V8J7lZFR7U7u9CCjMefEjyyfd/ZPYcQ7sFaoTl7bYwdEda
	zLoa9QtqVRknPPj+mVgoaugpb3doCUUE=
X-Gm-Gg: Acq92OHSbwdDdIvTnh6GPxMWJlOCZMXWX8xSPpRV8FXpuEkp7PUuWs+Lv/2FdxSJh9d
	dx0eYYpGL6iBBLtZ/CixVplmnkaUWM8D/2ZhqYrNKjYwhHEFqY/OUW4ZSjrjX+LR9Lc3htOQpQ9
	Hm0zjhBl7jyQL4HkdQqdY/p9KrZl/RQlRJ+gL5S9rZRIa4HZMa1kvVGLBn9azIs11ak7X8MY605
	6BPJtzPkMBYVlELvWYd8/pKNr3XQebFzRTbEMVCrgQqxeCmL3TcbFHKXccFCIlDgVV0zJ56mDOP
	tdlLfdKYWgOGAInnCjb7SG7DLW3aUQ4MLORQ35WxF4Nw3FIYGTjSz4RySM+XrcQnHlpzO7kEoHX
	c9HiRnpNLt83Kid78Dg==
X-Received: by 2002:a05:6870:e393:b0:43b:4e42:9867 with SMTP id
 586e51a60fabf-43ca40b19a2mr6888184fac.15.1780327778175; Mon, 01 Jun 2026
 08:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora> <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
 <ahRocb0Vs_m6RF_O@fedora> <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>
 <ahZGxoI6oHQ_vSrx@fedora> <d1b5a737-f0e3-4927-b762-430b37fbb2f9@I-love.SAKURA.ne.jp>
 <ahZeYQ0cLE1i8TGs@fedora> <fbb3edda-f108-4e5b-acf2-266f043f8125@I-love.SAKURA.ne.jp>
 <ab5492b6-a053-4e3b-8c59-2e836ae85bc4@kernel.org> <20260528083848.GA7694@lst.de>
 <36571f8a-4df8-4152-b078-d82dbff4ad7e@suse.com>
In-Reply-To: <36571f8a-4df8-4152-b078-d82dbff4ad7e@suse.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 1 Jun 2026 10:29:25 -0500
X-Gm-Features: AVHnY4Jo-naNphBnmCUZCCUNQGptd23v8VZulBU6wmiaiHgGY3TyxDIc_hpXI6A
Message-ID: <CACVXFVOSm=VpYfxUEpYk4yC2N1uAoK=vbg_A=h51GXeeArzCpw@mail.gmail.com>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jens Axboe <axboe@kernel.dk>, 
	Bart Van Assche <bvanassche@acm.org>, linux-block <linux-block@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 5:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/5/28 18:08, Christoph Hellwig =E5=86=99=E9=81=93:
> > On Thu, May 28, 2026 at 03:11:05AM +0900, Damien Le Moal wrote:
> >> It sounds like the VFS unmount call needs to have something that waits=
 for
> >> sync() to complete. Though, it really feels very strange that an FS ca=
n complete
> >
> > I don't think this is the VFS-controlled VFS file data writeback, which
> > we wait on, but some kind of fs controlled metadata.  And yes, it looks
> > like those file systems are buggy in that area.  We definitively had
> > such bugs in XFS before and fixed them.
> >
> > e.g. 9c7504aa72b6 ("xfs: track and serialize in-flight async buffers ag=
ainst
> > unmount")
> Considering the xfs fix is pretty old, it's before the fix hint thus no
> such mention in fstests.
>
> Do you happen to know which test case is for that fix?
> I'd like to adapt it for btrfs as a reproducer.
>
> This syzbot report doesn't provide a reproducer.
>
>
> Another thing is, if it's some btrfs bios on-the-fly after
> close_ctree(), the most common symptom should be NULL pointer
> dereference inside various btrfs endio functions.
> As all those end_bbio_*() functions are referring to either fs_info or
> inode/eb, thus if the fs is unmounted before the bio finished, they
> should all cause use-after-free.
>
> The only exception is discard, which is using blkdev_issue_discard()
> thus has no such reference to btrfs internal structure, but that's out
> of my understanding.

syzbot log shows the null-ptr-deref  is on WRITE, instead of DISCARD.

https://syzkaller.appspot.com/bug?extid=3Dcd8a9a308e879a4e2c28

Adding WARN_ON(!lo->lo_backing_file) in loop_queue_rq() might capture
this bio submission context if this req isn't issued via wq.

Thanks,
Ming Lei

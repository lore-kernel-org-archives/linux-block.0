Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C676FC5
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410135; cv=none; b=lT3N+uJzGtKIkfqlKIG0zpfTy00Fk2EXai3mRYJCc3lMWZn+VRvK/+Etkyz4LbIvLVdRu7IF2bjmf+AIXxo1aPRCNceRcciOPDF0L6DriJc/HuQvdbsS0F73JHGpCNdANM81PXTc8/6H24zmQrSFbBF62xB8OhgdjIgmkVdy28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410135; c=relaxed/simple;
	bh=DQHNLnCJMOvA/C6YBw1ZxZdCTkaUBXfe9KJGnju/iQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnsJIFqdVyUsw6LDrCsnE2eNoUdFZB2UAOYGswguvxZb9rfLU/8xpuUtF3+R+192+wR12d55Zj8i9rx2xjJBvxu56FD3baZQNeNXNgjuYQ/SoAj4rV62cfnlzmdd+TMc1OodGGss2N7bg41vIZGtiLa6P1ILuHZUu5jTaf9xnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4CGnW/+; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4CGnW/+"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dd88eef2f3so1389751137.3
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 05:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766410133; x=1767014933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQHNLnCJMOvA/C6YBw1ZxZdCTkaUBXfe9KJGnju/iQU=;
        b=D4CGnW/+X21KQ85W0n2nGE8x1vlHPZTUcHbDRHIiFJD/hCiKzjkIxO7WhPRIdZLJgN
         p7uVFvxam+EqHBg/GjdkUhfqUsZPm9pgwuQsHNde/k6jGOUSPxyu5cRxCtdmr0IFwZlc
         QonVJl9t1oRpI+hT+fRn+Z/a3mQWxHxqyi744pQ0DZYHWoEVNx2T0+KOybpFY/dSdx+I
         UgSTiT6PIjcu8Ywk8C2l4Xg/3aI0OQDUGA0kuhAWCZf2ES/z8kJzxdiOBVnLH6awXH/M
         fD5u5kHGOUsLvac6gFGZp16fwFX3rcFQZ8+5vV2VCTH1ZUlOSShA5c6kHyOci5bijwFb
         oRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766410133; x=1767014933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQHNLnCJMOvA/C6YBw1ZxZdCTkaUBXfe9KJGnju/iQU=;
        b=eNxEiI32W4iojhabdHukNRC1Fc57ggQIk856SbtoOmzopNPbsIEVdP8ph3WX5x3HRt
         OcMB8v8hwuF1Jzd6AawdHU4C1CUyO3+Pc6XEok7XieJDrgP5mI4fvKZRetrit1c/EH3E
         I3hZscCfSF6fbbFzrtvDD4Q/qsrKpYxHcK2WYg6iwoMm4jMDipXFRh18CTzK5anNlxya
         AXtvNVAZ2fPCYXZmu4EZv+sumjTAj6QxnjhoR8ucZJ3LfhqR0/HvT/g0btGrYAW639dQ
         yNMFh35irLAn4K+NDziQd6+fKnKeRxgXrbkcaAbdgUoYjnANRlB90ECJBiyw2uEsb4o8
         zy6A==
X-Gm-Message-State: AOJu0Yx7IQDotqZaepmUCt0eEBIU5SzcROpUbfDSs95hmmd1VpB37tLd
	wK/j0OLTC6coM6uhnDnMQGmB+uTYdpV0Sp69l4AtCteSDqBCsc6WmVKFoigbjCvFdD0J5KGqdmh
	iiRh4HgHLXtAgMi+RdcaUZkQEHIIadDQ=
X-Gm-Gg: AY/fxX5kTo6ZQdLHXYPGQDb18r6DPThwl6IkOzCQVUKM+CZrOKXgxQSkRlP+LcxuX9z
	T0FVMSkTK2OJmg1CSS0V1W1mBqUIuCUFTasv5OS2y0a+pKSZS59tAYrB1klnXlrP7P6J5qpfTbR
	5gOpZpOONV2qCH0EyA5YiCY3TPnzcKEwwW2ErZG1x6TuZrj2FdZe/oZDyDjguyTxfUjX4CkqSkN
	/hCNpCCgqAJvq2BcWhgeQ5G24Y7ailN2YGHJZCv4i0pNczMvV0438MokuihEAXS5BNy16FTgK+M
	xulrwsCMCZhqCVRq2Fh34ELouZ8cyZWKztMC
X-Google-Smtp-Source: AGHT+IGWSKeaCyoidML79ijHHfRkMzw6/qBLjWiWxYaln1qC3rAnMzGrFutr3bncG4QqjlYXnc+jDLoh1XKoiMZWWfY=
X-Received: by 2002:a05:6102:5987:b0:5db:f031:84d6 with SMTP id
 ada2fe7eead31-5eb1a7c48d4mr3410921137.28.1766410132835; Mon, 22 Dec 2025
 05:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221132402.27293-1-vitalifster@gmail.com> <aUh_--eKRKYOHzLz@kbusch-mbp>
 <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
In-Reply-To: <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 22 Dec 2025 16:28:42 +0300
X-Gm-Features: AQt7F2rjOdKLFtEGlcGjuvPN1jag3_np44VzlfGS5b59_jYAW2qeSlSH9vVC2wU
Message-ID: <CAPqjcqqi8uR=RWEpLEC+JiwOg0fzvWvwEOscj-XYHKLuPcnDBA@mail.gmail.com>
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel+subscribe@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi linux-fsdevel,
I recently discovered that Linux incorrectly requires all atomic
writes to have 2^N length and to be aligned on the length boundary.
This requirement contradicts NVMe specification which doesn't require
such alignment and length and thus highly restricts usage of atomic
writes with NVMe disks which support it (Micron and Kioxia).
NVMe specification has its own atomic write restrictions - AWUPF and
NABSPF/NABO, but both are already checked by the nvme subsystem.
The 2^N restriction comes from generic_atomic_write_valid().
I submitted a patch which removes this restriction to linux-block and
linux-nvme. Sorry if these maillists weren't the right place to send
it to, it's my first patch :).
But the function is currently used in 3 places: block/fops.c,
fs/ext4/file.c and fs/xfs/xfs_file.c.
Can you tell me if ext4 and xfs really want atomic writes to be 2^N
sized and length-aligned?
From looking at the code I'd say they don't really require it?
Can you approve my patch if I'm right? Please :-)

On Mon, Dec 22, 2025 at 12:54=E2=80=AFPM Vitaliy Filippov <vitalifster@gmai=
l.com> wrote:
>
> Hi! Thanks a lot for your reply! This is actually my first patch ever
> so please don't blame me for not following some standards, I'll try to
> resubmit it correctly.
>
> Regarding the rest:
>
> 1) NVMe atomic boundaries seem to already be checked in
> nvme_valid_atomic_write().
>
> 2) What's atomic_write_hw_unit_max? As I understand, Linux also
> already checks it, at least
> /sys/block/nvme**/queue/atomic_write_max_bytes is already limited by
> max_hw_sectors_kb.
>
> 3) Yes, I've of course seen that this function is also used by ext4
> and xfs, but I don't understand the motivation behind the 2^n
> requirement. I suppose file systems may fragment the write according
> to currently allocated extents for example, but I don't see how issues
> coming from this can be fixed by requiring writes to be 2^n.
>
> But I understand that just removing the check may break something if
> somebody relies on them. What do you think about removing the
> requirement only for NVMe or only for block devices then? I see 3 ways
> to do it:
> a) split generic_atomic_write_valid() into two functions - first for
> all types of inodes and second only for file systems.
> b) remove generic_atomic_write_valid() from block device checks at all.
> c) change generic_atomic_write_valid() just like in my original patch
> but copy original checks into other places where it's used (ext4 and
> xfs).
>
> Which way do you think would be the best?
>
> On Mon, Dec 22, 2025 at 2:17=E2=80=AFAM Keith Busch <kbusch@kernel.org> w=
rote:
> >
> > On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> > > It contradicts NVMe specification where alignment is only required wh=
en atomic
> > > write boundary (NABSPF/NABO) is set and highly limits usage of NVMe a=
tomic writes
> >
> > Commit header is missing the "fs:" prefix, and the commit log should
> > wrap at 72 characters.
> >
> > On the techincal side, this is a generic function used by multiple
> > protocols, so you can't just appeal to NVMe to justify removing the
> > checks.
> >
> > NVMe still has atomic boundaries where straddling it fails to be an
> > atomic operation. Instead of removing the checks, you'd have to replace
> > it with a more costly operation if you really want to support more
> > arbitrary write lengths and offsets. And if you do manage to remove the
> > power of two requirement, then the queue limit for nvme's
> > atomic_write_hw_unit_max isn't correct anymore.

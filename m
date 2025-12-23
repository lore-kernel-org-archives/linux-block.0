Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D1329392
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488758; cv=none; b=j8BC1c86uCM2dj7KT4H/9yFzqlYyR3fqCdn31jbtkmwEAYcoe80NDvrNgJviXM/dHTgtfLXqSrunZ9v41CzkL5R1OayqUSAR7A2rd9RB1rV9ehuuK35nkvsdJDenKE5YUebatZum9h6uPOfAIR3LwyxQ/m45kCBngR+qgnzyEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488758; c=relaxed/simple;
	bh=j0jCXcOiBNUkZSpElPGCQ9lhDRTu0eKqSVHgceQ6tkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaUcb77fXlZb8AwCrSSNlm4H0bxUBzB0A9LnrYQDyDwwmQ7ChbOpopaHqsQ/LcwZgwDkqqclI9B0H9Qtpt5PhL0fxHAgvBHDsrnMNoOO3EA8GE8Uny7b1U1jXj/sFS7UnxJ74StAFX4G3+5QVAfuSqWFAoKHeMS7VnI1J07NpTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by/CIyNX; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by/CIyNX"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94240659ceaso1369584241.3
        for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488755; x=1767093555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eXdIVwHKelFkhb9Ztbf3aqTek3oIROcOvmh4s51PYk=;
        b=by/CIyNXdvNjuCyTU2y16rOPsgIaUXbVl+msuWdpWYbkAGIsU0pATGacLtTTC/izjl
         RnOjbvUnggLFcpp9X3PcMfE5dqkKsR7V1D2XQyT/a1pv1eADZ5dRB19iwA51GaTW4gx3
         QiCp6f5RRqA20p7k5meHU90KaGIbLydSOI7gVGhqQ9zloWHxbWdLlYvDmNK3p2RLbPsI
         OjeasXDTHNhMQbI2GuRqvsPZ3ysPlW5mKTHX2kTix4PY04TsXzqBmMxLjvWAPBNjH0U5
         IVl30voatKQeY83OeaQs10d9oKZKyb7frvt/79hdHwp/SHTjdbIRr6rsgaTPPz0MatL+
         zczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488755; x=1767093555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1eXdIVwHKelFkhb9Ztbf3aqTek3oIROcOvmh4s51PYk=;
        b=xHp6UaQg0LAgc9MmMm0abG6LoMBAKuoZvs11eiEILjNA4cO2Kok33NDKK9nKskc26Y
         B2eV2m/FswM5WRgwVCRi/aFy/vq8HAL6R5kL5szsfgdkxiJUTg4H2BMnMYkgCJDPkOzD
         bUjjjxoi+NEUx033JyXU4JdBW2vwqcRAo4IHEYTQA6rSY0OOrZOMu133RdliQXnLDujO
         aWOojEY6GByFL0mU/pz+PhtIUlH3EjeJxxVwHJVp2lD6sbeaYve4nvYhtuPdap4jGKqm
         q0E5E5HQUNd9Qf9kFiXQ9reXuQluG6+VCaVW1XOAdmCxs3OHrVOUNIRmqehg45FsWLGB
         zw/A==
X-Forwarded-Encrypted: i=1; AJvYcCUseQsbW8ZH+Ex+/2+3tuUHH9E2uaQJuZDFO2OmoNcWWeHDn/0XpQF5hJyyDfXOHwlEb3Xaxh7Yr5m0UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeBUJhLtYkRspb6kEMGVi/sM16wA214RZvndvoDBhfmQz1qPc
	mb34FZTT3ho96+t10GpeTAUdYq4TCXe/0Wn/e1KRnrzJGexGT1svsGbucnQb7SeaO3VxFWC1XsC
	04odU5HYxq7DXqKSf1HGrpQczHZOLmjs=
X-Gm-Gg: AY/fxX6Q0cg0aTk5QX5o6PB79DKVJ/KyygaWShkRlJ/Xgknc9yWsFQ2azIMl+8mI4gf
	oxtffu1Vi01JA4AVxIYvqFOuHbQCktnsJgksgYs2ibuMHSVlt3v/dYGSvKuODpbsTzH0yvcpzwU
	igWBv3x4UvWAkUS3vQKvbI4yVlG6VzU97FiIoqUIsbDMIE+obZoS3qEHB7gkUeLCyLkOgvxwVOV
	HswDdiSNGPi+ZbPd7vDOynxM2h+JEis9ocWUhmxWRHFuIM0ekDIxRsgMSKfc1m7Djs8/Ux+uceF
	LQPJXyB0MJXrzKoaz38U/6wrp913h/Zub/p/C2qLQXH0xK3C7tHSrQynIwI=
X-Google-Smtp-Source: AGHT+IGqYfuMT+Zwl+tl6UsRAbxMzMDeJ7TsorbHaeD/KnO8N5c6jy8v1pEwVtaIgrR5qFcARBvMi/oUNg2AZwrR8DM=
X-Received: by 2002:a05:6102:510d:b0:5de:31b1:2011 with SMTP id
 ada2fe7eead31-5eb1a663371mr3330211137.17.1766488754627; Tue, 23 Dec 2025
 03:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221132402.27293-1-vitalifster@gmail.com> <aUh_--eKRKYOHzLz@kbusch-mbp>
 <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
 <CAPqjcqqi8uR=RWEpLEC+JiwOg0fzvWvwEOscj-XYHKLuPcnDBA@mail.gmail.com> <9304d77a-7439-4772-a549-5ebcf8bf371d@oracle.com>
In-Reply-To: <9304d77a-7439-4772-a549-5ebcf8bf371d@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 23 Dec 2025 14:19:02 +0300
X-Gm-Features: AQt7F2paTDUpwAoVlsdj8zTzltEorO00TKp7nbh-r7QW6ssOVcfvD3jDLALkKPg
Message-ID: <CAPqjcqrkR7rc+R2+__iH7LwvC=DM_p-a86W9-UdvOrMfzrtB4g@mail.gmail.com>
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
To: John Garry <john.g.garry@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel+subscribe@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What does "just the kernel atomic write rules" mean?
What's the idea of these restrictions?
I want to use atomic writes, but without this restriction.
And generally I don't think this restriction is needed for anyone at all.
That's why I ask - can it be removed? Can I remove it in my patch?

On Tue, Dec 23, 2025 at 12:26=E2=80=AFPM John Garry <john.g.garry@oracle.co=
m> wrote:
>
> On 22/12/2025 13:28, Vitaliy Filippov wrote:
> > Hi linux-fsdevel,
> > I recently discovered that Linux incorrectly requires all atomic
> > writes to have 2^N length and to be aligned on the length boundary.
> > This requirement contradicts NVMe specification which doesn't require
> > such alignment and length and thus highly restricts usage of atomic
> > writes with NVMe disks which support it (Micron and Kioxia).
>
> All these alignment and size rules are specific to using RWF_ATOMIC. You
> don't have to use RWF_ATOMIC if you don't want to - as you prob know,
> atomic writes are implicit on NVMe.
>
> > NVMe specification has its own atomic write restrictions - AWUPF and
> > NABSPF/NABO, but both are already checked by the nvme subsystem.
> > The 2^N restriction comes from generic_atomic_write_valid().
> > I submitted a patch which removes this restriction to linux-block and
> > linux-nvme. Sorry if these maillists weren't the right place to send
> > it to, it's my first patch :).
> > But the function is currently used in 3 places: block/fops.c,
> > fs/ext4/file.c and fs/xfs/xfs_file.c.
> > Can you tell me if ext4 and xfs really want atomic writes to be 2^N
> > sized and length-aligned?
>
> As above, this is just the kernel atomic write rules to support using
> different storage technologies.
>
> >  From looking at the code I'd say they don't really require it?
> > Can you approve my patch if I'm right? Please :-)
> >
> > On Mon, Dec 22, 2025 at 12:54=E2=80=AFPM Vitaliy Filippov <vitalifster@=
gmail.com> wrote:
> >>
> >> Hi! Thanks a lot for your reply! This is actually my first patch ever
> >> so please don't blame me for not following some standards, I'll try to
> >> resubmit it correctly.
> >>
> >> Regarding the rest:
> >>
> >> 1) NVMe atomic boundaries seem to already be checked in
> >> nvme_valid_atomic_write().
> >>
> >> 2) What's atomic_write_hw_unit_max? As I understand, Linux also
> >> already checks it, at least
> >> /sys/block/nvme**/queue/atomic_write_max_bytes is already limited by
> >> max_hw_sectors_kb.
> >>
> >> 3) Yes, I've of course seen that this function is also used by ext4
> >> and xfs, but I don't understand the motivation behind the 2^n
> >> requirement. I suppose file systems may fragment the write according
> >> to currently allocated extents for example, but I don't see how issues
> >> coming from this can be fixed by requiring writes to be 2^n.
> >>
> >> But I understand that just removing the check may break something if
> >> somebody relies on them. What do you think about removing the
> >> requirement only for NVMe or only for block devices then? I see 3 ways
> >> to do it:
> >> a) split generic_atomic_write_valid() into two functions - first for
> >> all types of inodes and second only for file systems.
> >> b) remove generic_atomic_write_valid() from block device checks at all=
.
> >> c) change generic_atomic_write_valid() just like in my original patch
> >> but copy original checks into other places where it's used (ext4 and
> >> xfs).
> >>
> >> Which way do you think would be the best?
> >>
> >> On Mon, Dec 22, 2025 at 2:17=E2=80=AFAM Keith Busch <kbusch@kernel.org=
> wrote:
> >>>
> >>> On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> >>>> It contradicts NVMe specification where alignment is only required w=
hen atomic
> >>>> write boundary (NABSPF/NABO) is set and highly limits usage of NVMe =
atomic writes
> >>>
> >>> Commit header is missing the "fs:" prefix, and the commit log should
> >>> wrap at 72 characters.
> >>>
> >>> On the techincal side, this is a generic function used by multiple
> >>> protocols, so you can't just appeal to NVMe to justify removing the
> >>> checks.
> >>>
> >>> NVMe still has atomic boundaries where straddling it fails to be an
> >>> atomic operation. Instead of removing the checks, you'd have to repla=
ce
> >>> it with a more costly operation if you really want to support more
> >>> arbitrary write lengths and offsets. And if you do manage to remove t=
he
> >>> power of two requirement, then the queue limit for nvme's
> >>> atomic_write_hw_unit_max isn't correct anymore.
> >
>

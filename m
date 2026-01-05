Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121833161BF
	for <linux-block@vger.kernel.org>; Mon,  5 Jan 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639552; cv=none; b=dsdmIjA/Nwkr7WqqNKRvSkQBAKO+qSkPhnrg2VsGNdXhm88iPJNCjekVq65G7k+NtECOC+cQXAsj8uqEEWCxQGDbzB20VVEecE+NRny5v4ZBr0Z54PbM7HnaVsS80eQeJoRJ3couDjINcn084ZHoDU0a62WKpU2lqxO7W8Rvq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639552; c=relaxed/simple;
	bh=yn1Jc4ICLWk8ULaLrztIgS2WchuirD6GB9gytQ0+C+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2rHSNdC0PpgrdGXbwkkCMoD4p0yeN2wAruv/GkMgirKJw89WZGdedeKeXHFi+nGKDQkjYP65A31CtvdqU/G6CMtWTQASbY7F+mo4bkPa7+5I7xOc316bYETHU46rhG4Xa2HJecVUzKlNv5OT8D22E9yFm/QHZdMJwm6gEJ6+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOmBMWj6; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOmBMWj6"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5de0c1fa660so76245137.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767639550; x=1768244350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn1Jc4ICLWk8ULaLrztIgS2WchuirD6GB9gytQ0+C+k=;
        b=HOmBMWj6rTW5E42iN8lyJI2T/fy8wYpRZNif5Cju6iGV+MuwzGdTIvINxPBnFjanWI
         3i/LEwF0uUFVyLSynw8XrpD8YbW9Y1efXJe+nbso4SkDvW6Og/E28bbCwLmRKCBPxzYq
         7Z5x+JBf/VC93IsodLE4D/uFM4RzfyS4RXdaSKjPvJUY6kmfyCV3H4iMaGpFcCzK91Jd
         hQC+b9JffTVVd52eAvrOJA78eHdbn3Dz3PsDrBZXoAzCB3wbRvMGT+OgYxRll2fGPOyn
         usfiWN9vR4htkZ2ruYLwCeiEZ0mpM1SCOZnNVmKW1/29090xg4wcKzwYZCmhlje8hNY4
         GcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639550; x=1768244350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yn1Jc4ICLWk8ULaLrztIgS2WchuirD6GB9gytQ0+C+k=;
        b=egH6wZVlwX+6AZEDUg5hkmUCuEfO1/XBln/J7utGFLEBsayVBLc0RDxj8yHVgM3pDI
         La9L5utM2eZAzruMEQsdG00uFqJFCIImn50tY6D86wmWPDCTOtAaEta4uBaj7m0U8Mxe
         1O59e1vtyabjtoAXTzC6pqeFRZP+QbKna9iPX6XdiXCMSIzwA3j/pgM99XvfPJY7sXiu
         AbNpa+kUg3eA3/jtRUfOdSh5nFDuALmZ4KmgbR7l+qAhCiQ3jh/k36SKVhPZCYred4kk
         1VQxjOBbJD0jn4lc3YZ8XZuxtBEottd4K3+E3DWlTjb4lfjydL0xELXc7yeKCfjZpFL5
         VzHw==
X-Gm-Message-State: AOJu0Yw6FKP+3aggl0fjVAM+qSz+v8g53C0nX6IBAr5DSzBmAeVpDVrK
	+9EIVjdx0eQG8DXsoXVNTKwM/6x2U7qfEU+yGbnVSkqmmog2YrjFhvAOELsRiIYq51fA/GVGiO3
	Rvuwf1azxt1V3HwETE60Qyine272Ltf8=
X-Gm-Gg: AY/fxX5wFLVZ+EyqrKlEGco/kjR4Job9Bqh12mmJvo+iAPJ9UJXYVJdOI8+23EQIiKd
	5zoc/iLGQITj8IT/5wfflbUU7/Nn8DuFpyITS8Rq/k8aK7DdyhVOQa5ubgHKgS/It2InhsKe9eA
	Lf34azKJL3NUONYX7oGVw7c2RP+/dnkzH9yxR7clRoh0rg4JOK+rz37uStVWxlMd+tt81a+sZMT
	Kaf3IjgOY4XHV/RKME+pQwRhwd9JpRHgMHyOQbHMaLWm2NjIUD2zHS8XO8Wh9XFissL9XOl6s2n
	aclQwT6cjzITVYJBuLqB0VOAhiX9
X-Google-Smtp-Source: AGHT+IEK6t29nnbM4KSi3RE2dRptIPsBlJI7+TEZUWDWfQLw/G0JUg7s/X6SseZ/NRhydZf5A+iBWFM2iESPtCJyrnk=
X-Received: by 2002:a05:6102:2ac2:b0:5db:cba0:941 with SMTP id
 ada2fe7eead31-5ec744f41e0mr168063137.38.1767639550024; Mon, 05 Jan 2026
 10:59:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com> <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
In-Reply-To: <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 5 Jan 2026 21:58:58 +0300
X-Gm-Features: AQt7F2rq5lSdRuDrKKO_WX7qlrOIHIyAA4sAGBL3za53jFIAgFNIDCZCA8inI4w
Message-ID: <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>What good is that to a user?

It will allow him to use the feature which he currently can't use.

I don't understand your point about "arbitrary" failures.

Imagine that a user just sends a 256 KB write with RWF_ATOMIC while
the device has NAWUPF=3D128 KB.

He gets EINVAL even though the write is 2^N and length-aligned. Is it
any different from an 'arbitrary failure' which you describe?

Now imagine that he sends a write but it spans multiple extents in the
FS. And he gets EINVAL once again.

Is it any different from what I propose?

Obviously in all of these cases the app has to make sure that it
satisfies all atomic write requirements before actually using them. I
think it's absolutely fine.

On Fri, Jan 2, 2026 at 8:41=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 30/12/2025 09:01, Vitaliy Filippov wrote:
> > I think that even with the 2^N requirement the user still has to look
> > for boundaries.
> > 1) NVMe disks may have NABO !=3D 0 (atomic boundary offset). In this
> > case 2^N aligned writes won't work at all.
>
> We don't support NABO !=3D 0
>
> > 2) NABSPF is expressed in blocks in the NVMe spec and it's not
> > restricted to 2^N, it can be for example 3 (3*4096 =3D 12 KB). The spec
> > allows it. 2^N breaks this case too.
>
> We could support NABSPF which is not a power-of-2, but we don't today.
>
> If you can find some real HW which has NABSPF which is not a power-of-2,
> then it can be considered.
>
> > And the user also has to look for the maximum atomic write size
> > anyway, he can't just assume all writes are atomic out of the box,
> > regardless of the 2^N requirement.
> > So my idea is that the kernel's task is just to guarantee correctness
> > of atomic writes. It anyway can't provide the user with atomic writes
> > in all cases.
>
> What good is that to a user?
>
> Consider the user wants to atomic write a range of a file which is
> backed by disk blocks which straddle a boundary - in this case, the
> write would fail. What is the user supposed to do then? That API could
> have arbitrary failures, which effectively makes it a useless API.
>
> As I said before, just don't use RWF_ATOMIC if you don't want to deal
> with these restrictions.

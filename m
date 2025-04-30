Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2619C556
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028148; cv=none; b=kWsJcTBS/1tOVkjuHhMIFaA66MfTb3jw6u24bLdL3Ssji3HbI/RFFUi4amy0BkeATB2tNUlCVe7bOJISbe7QOdLWFsbzf4MCWrhJoMDd6ZAus75yqmM9dWPyqg5WkNtAVUXJsHe3JEvYpJANOdQ3D7Y8gKrNDtnnUjZpqTLc+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028148; c=relaxed/simple;
	bh=b0eF2QG0t/jDi226E2Nr9b9CI0iYfQ2oAK9rvIWqFPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1+/3KrseUPqOPYSZVry/+Yh7ru0y+t0JZIWEi4m2LQveZ2/ts9hpfyU+2Bj535rOt2a7c1K0A45KLHiqM5HN6drVUu4wxv6STb1gxXc3PrrhozE2Mvhv7ng6ZmzxgvwdqdMGDz1YNZFk4kxuAMYswJwzIR3TvmnRG3RjSCNqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5VizwRq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5VizwRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746028145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NhVebTw5X/YMOKpdnV0vKWQl8FnWq0nBImlPCBFiRg=;
	b=R5VizwRqw7VCRIRIlVli2g3YaFuFRCFP+XAr9gXT9uI3j1sJcvgWoo5Y9ElRITadcEbvOc
	UG0xWcwqUoMUallDHvIgS+q+i3vLYxPz8cIE2DgcZguOjvXpAPdym5u1dLABc1O1WJXUzO
	Yt5rxVq7kpTMhJfHWRlrEvno791zC84=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-W1dM_RR_NuuKFzotbxK85Q-1; Wed, 30 Apr 2025 11:49:03 -0400
X-MC-Unique: W1dM_RR_NuuKFzotbxK85Q-1
X-Mimecast-MFC-AGG-ID: W1dM_RR_NuuKFzotbxK85Q_1746028143
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-86d33b8ead3so1416699241.3
        for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 08:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028143; x=1746632943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NhVebTw5X/YMOKpdnV0vKWQl8FnWq0nBImlPCBFiRg=;
        b=SX/S6ADpXMH4EU0J4cdHlA2XxdOhlkrYPUFWHeSrMbjj/qLbzu79hJ22lW1MDZfIdU
         pIq4A4n/YUnnkjqGV4kCJkPjidZz/0TBtggTalCtWuCZA9FmkDVKM9WM46v/GKFgsFDC
         q2ulhQFP0+5FDSm3AX7eW3DVGqICXxnDtphbAvYFnXyVimuAJiEJYceJm0+3ZUuKYYjG
         4o23iFY2mB9MZvrHX+/Mn0M+LtMQSir7cju5Z3ZpxqsPOqmukMOvYN0fVvIIngXRCk1i
         u7siGK9lhuHG/pi2LAKxl4Lmso0sJL4r9AVU4nz5i6RgtULOzx9GVJczrD+AfrgSutcn
         9dKQ==
X-Gm-Message-State: AOJu0YxbjPooF6HMxpn9EjCYKjGLciwJNf6/DFjGevTGsc3v0IloZW8T
	KmQ/37U4vXq1/K7cZEA887n0AHuVqGM7ZqybDhnN3lPjIczR8bOSpwHuAOuShC/Z06bQ038ku3O
	W7+NnhXSg9VFSFyYSqnwGI4a18R9Uz/y6MIC9ZnFcuCW3uM0giKo4z7ECePjAv7z9auY8lrHNEV
	uo8vKYOOwcGAv+Mhnh/VmhTO0Og05zYE2P4bg=
X-Gm-Gg: ASbGncufEVEUCi7H0dNFw5EpIOuTpk2GluhgDUXJiVAG5voJjrcYG/BZJMeVXCW29H9
	QvGll5G+VtHuL2XhkW7QR3OPrCuL/z3TXudgA45GXszqKJlcopx6p7e/k9P5uc19h/rqYVg==
X-Received: by 2002:a05:6122:d04:b0:520:6773:e5ea with SMTP id 71dfb90a1353d-52acecf4fafmr2499665e0c.7.1746028143269;
        Wed, 30 Apr 2025 08:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmRGtyTQxSDgYkZqBV8D6fX7TV85KhB/fySaJY3KhNzrGxz/p+ZFA4bO6eyuyyvWz+Ka0thPkJ2M+b+PSKTXY=
X-Received: by 2002:a05:6122:d04:b0:520:6773:e5ea with SMTP id
 71dfb90a1353d-52acecf4fafmr2499653e0c.7.1746028143006; Wed, 30 Apr 2025
 08:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8ZO-vBCJOiDvZJv_1mF3WC14i+GY2gwpSycSqYFh6urA@mail.gmail.com>
In-Reply-To: <CAHj4cs8ZO-vBCJOiDvZJv_1mF3WC14i+GY2gwpSycSqYFh6urA@mail.gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 30 Apr 2025 23:48:52 +0800
X-Gm-Features: ATxdqUEl7XxSCmv-3Emw1dSzwMFEFldTIyj8DdjXi7q9Ces0qLp3TVC9ejNBFgA
Message-ID: <CAFj5m9JtMFV+e8+0_McDsXUQKZq9G=-aXjmD48yj-Ox=TL9gAg@mail.gmail.com>
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected at elv_iosched_store+0x194/0x530 and blk_mq_freeze_queue_nomemsave+0xe/0x20
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yi,

On Wed, Apr 30, 2025 at 9:35=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi
> I found this warning with blktests block/005 on upstream kernel
> 6.15.0-rc4, please help check it and let me know if you need any
> info/test, thanks.
>
> [  942.528228] run blktests block/005 at 2025-04-29 14:22:12
> [  943.169303]
> [  943.170811] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  943.176990] WARNING: possible circular locking dependency detected
> [  943.183172] 6.15.0-rc4 #1 Not tainted

It can be addressed by the following patchset:

https://lore.kernel.org/linux-block/20250430043529.1950194-1-ming.lei@redha=
t.com/

Thanks,


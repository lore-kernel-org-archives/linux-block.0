Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851F36165F
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667498; cv=pass; b=Ot0rP0gXjfwHmURtfhDuZZt0p6xMi26AM2h1Kz/5SU+6PZapNZAYAYTnTyO23eO+WcxmH89Ifo0O+sA6Y/W//Zu+tusis1uJUA5j8wICPH6gKWknVJUQcqIQGcSGHJ09k5RDS5Ccn/hmXM9ckdZFLf6m8Sze002fO39aYMCTdTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667498; c=relaxed/simple;
	bh=GUVqvCVL2Zx4zfC44tdviXCHdH/UF+AIGjqgPtlo1Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht0QmwNhn6R4m89fwYOwknlHF7kPPlxPbg7Xl8A1Ls4Us2N3582XvGTJdSLUsyT9JOAGGlGiq4IOOyigaStF1Cr0AyL8b448/S53yW/h5ymd/FUndkxkGG5gaeXr+BFkihQ9z97Dm3HtDX3Vd7qSEBUQOe8D5DSdkht9Lo1omuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKPgE/0j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+sWlEg/; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKPgE/0j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+sWlEg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778667496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUVqvCVL2Zx4zfC44tdviXCHdH/UF+AIGjqgPtlo1Q0=;
	b=gKPgE/0jVWMnV1NTx3LPo7iClLPk4yXb/Cx5WjmhuDXf5BKUtagbc5auuRds602G7ZJx/b
	BZpoFXsZ/l8ErH1NbUnTHjpKqbF5WYUJjTr0bQB6eZrQC65ulaHRxtbZvcdsG0pdtfVvxF
	5qR02rom8yqRJoYsB1R0SKSY9mXl+6U=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-7FtHWFy6MEGb3apDZPlRYQ-1; Wed, 13 May 2026 06:18:14 -0400
X-MC-Unique: 7FtHWFy6MEGb3apDZPlRYQ-1
X-Mimecast-MFC-AGG-ID: 7FtHWFy6MEGb3apDZPlRYQ_1778667494
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95cfcad1f82so3038998241.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 03:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778667494; cv=none;
        d=google.com; s=arc-20240605;
        b=aMRRAZEBCkdAMpzdDeNafeN6yv4O427wk8oWvf4gKP2fugctwlP+P9CNaubMTwDJ/N
         CEYvAO1AG+csTfbHsDzx1cbNrM9NRi+PJtDXkfuA8OVNPYOxHhVZEhULHD3UQzint8EL
         1n/jr2g2m/2GxQaJNXb4tXnRFEBMOvjnjJiZfA4NQYQ6L0AGrd1rGevx34OutbFWR89J
         mByANdismZ4ppE7l/oPg7cm4qG8+wEhgIhEQLuYtm29l3enWrDHSt+NNR/T6aGoqtNnr
         AiNk3n1ZNRVON1FbLxK2BsOBIVPqcU/PbzeltXCZcGqgCQrkZ0AVFkxfmT0rOkPKQp3J
         nSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GUVqvCVL2Zx4zfC44tdviXCHdH/UF+AIGjqgPtlo1Q0=;
        fh=BAE9GxZhdzfEQe9Lcx/9PLYGGRxuOouz6aOuIjzo6fc=;
        b=DaW1KVCv5a3LiQ0eSmpVr79rjtBmSe0nHDWghFeCQkVnPNlp4aCsOxY6PdPiNlT+yf
         3qw4LZwNB/NTW8ExqcRki7QIHM8SbbQ9Kwv3R8hWEkHKNylC6hepvA7EzcO9RA27SvWl
         hUsTCnbQT6CHw5V+eBKX1es0suCm8iq2f/1Rh7lWSi0KovQdLOHW0hEyhwRdKXGEkmUx
         rK+D+xCKF+p6r01vYyawRq+Pl6SnPilPSHjErUNpuZEFwZCZWcwcuHtSAX/jqFpaGfkt
         pCYmZnUeG5nQ/5Wy/Q460ae6vUj62W+d6mwORbZqGUMeMkzeJ9OmAIivtt2WwWxZK9Pa
         Z6lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778667494; x=1779272294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUVqvCVL2Zx4zfC44tdviXCHdH/UF+AIGjqgPtlo1Q0=;
        b=f+sWlEg/3ULO+KP/Vo5WggIHI52cAxjuef9rMIvCwme9nu1jcDhts9TArpJdULZMUj
         gdSiWYn1fE6zEW+d2/mKmiy7B+Yp0Rq8RoUuVuzgoEo+RihJ8eNhV6BT9gbWs1Hf3tij
         iFxxu9Vl5Qd8AwnoRuQMUTQ3qrjSz9g30YHD6l07lopBNbClZ0iao+1JonNncMlYyd6q
         K9DbB5LtyJwvSDdvQdSCraXJ1nkIxjZubuT8d4ovc4REsQrGpxDXiAIu8WZ5w3WE0Jcl
         6b1dRh3a9v6JtvraBS91MXLUt1Mx00prY1vqivw6smhrgMIx0hW7AcfAreC+2VI/lkXA
         B9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778667494; x=1779272294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GUVqvCVL2Zx4zfC44tdviXCHdH/UF+AIGjqgPtlo1Q0=;
        b=aa11zv69lp3ouKku9WVfaT2HmCapXC3PgaxBvBP3tIxo5NuPYo9QqLLzmroY4Wsse2
         keoOchkDmeyGRIADD8z611FoAbx57PpJWygkNR/jJfgr9UqpobJjwAncNOwLThjgOXvK
         uFIo7PkOV1aiSErn2qsgxT6QZRTFmgKKyyr6GLwZqeowGyZA34I8EE+WZRzAy/WhOi9L
         GMwkvblZ4YDqHF1UOcamPQV+TY+29Uoa0/EoOJsDhJaV56kUUISi9UN9ASTCvorMXv+T
         tz/7rPICWtrLF8KI6RD/2OtmMqxqfydupkVvqS+D+KYwZbWti9td5GF5d+h7MDpzflT1
         Xrvw==
X-Forwarded-Encrypted: i=1; AFNElJ+d2gnCDEvhxxMSxRUuzyy04RlbWYxilPuNf+X00qA4XBRRcI7St2pmLjbzNo7w9DKmr17GxW0ugopVvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmKaSc6D9MItsMYCwcX1sszQuI3HMjq3e6RqrCxyAZTg0rU+d
	tsZCHsvIVgCKIiGJaky+qSRt2VfwYf8tMoxqO/no8NRVu+by8MjLCHfBcW9iXwqg8LLhCxvgHoO
	oG/ToZjBvLh+8xhSZbg3Mu+Uga1WzV54R7QpSdDb/gxSq93QNM7sMeec3FAUoEL/rmzHCIPUNS3
	SSJU4fVg9iOvxfvhtZ/5AN1AUSKhvQdlbKY8324TY=
X-Gm-Gg: Acq92OFoDQKnWry6xvdVa68ZuodrSU8rCSfq+QteTUnqx9HrEkAvQqfb/5MRROtMrzs
	2oas/o3x5sCQ7rADeC/BU+mG2KBFt105iolhtDMGa7rQ9dw9P7ZxujLcL51JqVFMFKhle57kiCu
	wJXY5e9ZPVU79EfkHjbqsFdYkL4fxSO0M8zb84JfNQwy21MV2IKg1DqLYiBNxRbVuCNza9wzpzF
	66Bhsm1VyIjfBBx4lZeUdSbJ6Ph5h9U1hneqQ==
X-Received: by 2002:a05:6102:c48:b0:634:5339:33bf with SMTP id ada2fe7eead31-6377423c45emr973469137.18.1778667494207;
        Wed, 13 May 2026 03:18:14 -0700 (PDT)
X-Received: by 2002:a05:6102:c48:b0:634:5339:33bf with SMTP id
 ada2fe7eead31-6377423c45emr973462137.18.1778667493725; Wed, 13 May 2026
 03:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513100142.1371363-1-tom.leiming@gmail.com>
In-Reply-To: <20260513100142.1371363-1-tom.leiming@gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 13 May 2026 18:17:27 +0800
X-Gm-Features: AVHnY4K9fnOJF9ktsUu9weqbfde_7NWtrBXIy4dUHJG6kD2kCNhhOeJ4ynm2i_Y
Message-ID: <CAFj5m9+YuLA7aUn8qv=1Dd2oA9fq-P72JPMt5R_eHBG91xwxaA@mail.gmail.com>
Subject: Re: [PATCH] selftests: ublk: cap nthreads to kernel's actual nr_hw_queues
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Caleb Sander Mateos <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 6:02=E2=80=AFPM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> From: Ming Lei <ming.lei@redhat.com>
>
> dev->nthreads is derived from the user-requested queue count before the
> ADD command, but the kernel may reduce nr_hw_queues (capped to
> nr_cpu_ids). When the VM has fewer CPUs than requested queues, the
> daemon creates more handler threads than there are kernel queues.
>
> In non-batch mode, the extra threads access uninitialized queues
> (q_depth=3D0), submit zero io_uring SQEs, and block forever in
> io_cqring_wait. In batch mode, the extra threads cause similar hangs
> during device removal.
>
> In both cases, the stuck threads prevent the daemon from closing the
> char device, holding the last ublk_device reference and causing
> ublk_ctrl_del_dev() to hang in wait_event_interruptible().
>
> Fix by capping dev->nthreads to the kernel-returned nr_hw_queues after
> the ADD command completes. per_io_tasks mode is excluded because threads
> interleave across all queues, so nthreads > nr_hw_queues is valid.
>
> Fixes: abe54c160346 ("selftests: ublk: kublk: decouple ublk_queues from u=
blk server threads")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Oops, please ignore this patch.

Thanks,
Ming


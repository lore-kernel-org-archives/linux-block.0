Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F02147EA
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357486; cv=none; b=fmDREZgxFLCSlBw8fSa9+JAUbIbCR+7NSbDiTHUhqbGI7fFqNKWNc93EyvVo7/ms4qBoKDBlfGG3Y5bTULc1oMPTcBg+sL+qG+AOhR4M9CGGm8z9kj7+rNSy5E6oQbY26bYtMcCjXWPWxfOlIyqEE532KnyfYcqWDGQCv46y7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357486; c=relaxed/simple;
	bh=JFGNNGTiUPiTbfxJ/GattBF7DGBjvfS9mOl1QlsZyM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r916K8otdWaDzObT/N7N3fa5p13QzFzBmqUIzlso18UdD4JF+2yjd99p+Ev4SRAcc594IBZZ0IyuC3za27uGpxVQKUE7M4Fg/lUQ/BoBIH1nzVQC4QRYjkdQDpTkYbwfV72mWb5zyxEcE7CHhjip8DyRZpbSeF9/H6h39QnSRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jto4Sh0G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jto4Sh0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747357482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFGNNGTiUPiTbfxJ/GattBF7DGBjvfS9mOl1QlsZyM4=;
	b=Jto4Sh0Grarm3XgGRM1ktUL6dOJFwrkxa69o602uOKhFEEiyzd7w+h7OfKut69AtQ+iOSX
	CxPv7RYOjOut/tDEHsJA7CfFcWZFRj9bdit36r4dd2saK8ybHx2iAHW6CBgn6+z8LykQWN
	6L0J9qV8AZ96c3NUIkH1IuF5Wv9HZN8=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-fB5U62OOOo-oVzHFEZBeQA-1; Thu, 15 May 2025 21:04:41 -0400
X-MC-Unique: fB5U62OOOo-oVzHFEZBeQA-1
X-Mimecast-MFC-AGG-ID: fB5U62OOOo-oVzHFEZBeQA_1747357481
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4deeef5a8a3so1163304137.1
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 18:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747357480; x=1747962280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFGNNGTiUPiTbfxJ/GattBF7DGBjvfS9mOl1QlsZyM4=;
        b=gACt3XGaX/9sg0pl8ulKh18En2IJO00Cg+mOIeMipZetH8A7ukzeu9UN4a87UeB8t4
         2BtOZJ3rLvSFV5msmofYG2kXfYER+yr2UkxHBAGQOwFBFeD/B/5wGygadagscal3penx
         CHjNi6jHdsRy6qPLm2+OAH0E9CAHiZrMrGSMAN+ubN4FUnhhazI0FTwYP+Z76hZAmjTO
         sfwMGE7EAN3XM+LVHuxauj7ev2dy/w8KKTANROY/01XUzR8r3LRWGH5dlz4FkMPagtqk
         zkjWFnqd+etvVasodhgu+idEifnz9aY0xXCE3CPualo8+PMrL4TV8/ye+WcW1vQl2HHh
         SVKw==
X-Gm-Message-State: AOJu0YyTbx1wog7tVOqD4PFoF0m9ljRDjH5Ob1iZI17a98blbwBTV6sY
	fiI0TXhhSTgxYmUteqyjnNcBBA5D+Ua2ny5yJamXR8lCQwW+pVX7gF0iCmLXyFkOC/f+UM0T1Q+
	876MT/YW/IRKLZHnak96rFtXewsI+putM2Rta5u1vSdyABV5sPzxuUGhrEwyQ5XJVfPa4eeUu1O
	7urZaTYZ8Ta5S90GJoWdIEY/Yy5Aws6SBiWcT0HU0=
X-Gm-Gg: ASbGncu7x/kz6rG1FB80ojl4LjtxieohlNpvl/Q2YsveOD5/zI97bPdaqJiWii9XwAa
	p40lY6HPg4OHvnsRBKaPfVpQBERiV8V3fN4BDl2iHt6qNshbNWn2gpAWzFFI8XdsjRKu9QA==
X-Received: by 2002:a05:6102:2c09:b0:4dd:b3cf:880 with SMTP id ada2fe7eead31-4dfa6bf8bfemr2768505137.16.1747357480676;
        Thu, 15 May 2025 18:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMNH49vjnbojnSNfvHrWf8Eci4vVJldCREp6tkHcGapN6PuGHpAMAADnyFIr43f0JGTsq0RISak03gCWcH/gU=
X-Received: by 2002:a05:6102:2c09:b0:4dd:b3cf:880 with SMTP id
 ada2fe7eead31-4dfa6bf8bfemr2768477137.16.1747357480360; Thu, 15 May 2025
 18:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515134511.548270-1-nilay@linux.ibm.com>
In-Reply-To: <20250515134511.548270-1-nilay@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 16 May 2025 09:04:29 +0800
X-Gm-Features: AX0GCFs4tWkYVx4tQO06GxG3fZkNUbkGus2hcyICpoqNIIptnbN6vd1WgA4on5Y
Message-ID: <CAFj5m9L5B8rxfA0fieiNut8F_zOaP1eGgxnwAiYdCw0YKSor=A@mail.gmail.com>
Subject: Re: [PATCH] block: fix elv_update_nr_hw_queues() to reattach elevator
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, hare@suse.de, axboe@kernel.dk, 
	gjoyce@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:45=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> When nr_hw_queues is updated, the elevator needs to be switched to
> ensure that we exit elevator and reattach it to ensure that hctx->
> sched_tags is correctly allocated for the new hardware queues.
> However, elv_update_nr_hw_queues() currently only switches the
> elevator if the queue is not registered. This is incorrect, as it
> prevents reattaching the elevator after updating nr_hw_queues, which
> in turn inhibits allocation of sched_tags.
>
> Fix this by allowing the elevator switch if the queue is registered,
> ensuring proper reattachment and resource allocation.
>
> Fixes: 596dce110b7d ("block: simplify elevator reattachment for updating =
nr_hw_queues")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,


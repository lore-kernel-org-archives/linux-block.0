Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AB2EAB79
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750586; cv=none; b=F6fw9YOYufvwfrMJme7N07cAm+XlZdhNH7S9OxhDJ+TiCv4jXcavWDCNPrJ0tkYZE6VmEqKQqYLBWvH2MgWY863sfS8jmNAKEbuBeI9va7Ao0AQYrfaXarPMtaEGcqTWY9pe3c6Q+CdsaWr5XJnQr3QqHPRNC/RVB1h4zeSaQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750586; c=relaxed/simple;
	bh=JE74zTIlDOLc4xSb6wCZllVZjklPabBwGuR/QFTNBCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clWswzfgs4cd14BftQk/gqVyaZMcTm/NXMa36z1Q36SoLEuqB3lUOS5wm/CUZUtE26Mk8z01KO5Y5w+hIzLSoOHK/Erl09Cpt8Q4SX89RGxIpwOecyqcy1ZY7GXsQo7znWeySdHSCVlZ3Uv9KYpYlZst24HBi03+xhofnqpZnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE7Y9Lnb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE7Y9Lnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755750582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yl4xgAbL4PUDjjS9jzEUE1nwoo6oTTM4DZE7J0QQKZU=;
	b=LE7Y9Lnb0t6clXZGWWpfQC4uQCpFvcGmAGm295pqiJPcOdOAOQtOdJeitI+vHNl47qozvy
	GG+CVpEzA6VVkg03lrrWkCnP/sHciqxeGBoqOeJOgL0/Pvg4OQK0l50ASGX2dpWBQzmuY3
	9Wz+9N25udwHAI4zawbqLeW7TnVtpPg=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-YgMUyHwPNzSZki8Fzh5wlQ-1; Thu, 21 Aug 2025 00:29:40 -0400
X-MC-Unique: YgMUyHwPNzSZki8Fzh5wlQ-1
X-Mimecast-MFC-AGG-ID: YgMUyHwPNzSZki8Fzh5wlQ_1755750580
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-50f88eeb320so1121921137.1
        for <linux-block@vger.kernel.org>; Wed, 20 Aug 2025 21:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750579; x=1756355379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl4xgAbL4PUDjjS9jzEUE1nwoo6oTTM4DZE7J0QQKZU=;
        b=ijOEIjugn5riAgqo//w/P7WsZJMSTsTpsatoa5cvWoz48g7mHr9TN3ke/HjJJcq7Rr
         rgKcGJdgYnRgE41nkWBfwoGhKDtQkutDm0jRJC+fr2heSi4C4ctbxUJPJ1GPOhNEr44e
         KUQL9Ko/o6t84nB9D7qvLV621GcEF2ybKyipI1BjEzWLxNSw6zdFgr1BKz4ZSkME7q9R
         XQGIk3+v7HYU8bKUEXjNvjWZnwB4TIRjmoLuNmosTsDcOid4fZ6B7my3B7PEosjguP4X
         WJ2Y/snWu2JdQdrSPlbDDLRflgR9C2NIrr1gkx25Fe+U77W1RUvNK++EIci83MNkZe5p
         tKTw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Emc7JEubgnvA8QaPnzZDL4rO2Hdjr63pFKL+jhJRpPdX7hTSI96D+gNel2vVP7ZjfympdILCKBzSSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2t6k1T4Y1tZxEpmsmNBQyr5sjOaZDciKM8bEtzfThfy5I6JIi
	kNUEzJ0SwEDbZB1lhAX4yLW7Cc1JfBAYE4XUKZuytbOh9qmsuIp8INDwFTzraZzzfaCSvauXCWe
	OQXEDxfdPjVPUSN9b91WjFlX9MMvRoXHopR1gRk8z73IDciNvy/evzIwdSDuGIIoWOhksFVb8R7
	xRZMEis/u/pTJbX3tg1bY0fpcr9CchI1C0cO7c3Myl/aeNa/w=
X-Gm-Gg: ASbGncuDbsmil9AGbgUpyTgcXpUQqDripVclxXjjBvYfpylGMtPikO+4CcJZ/MPO3oY
	A57fFTR3hWuBUHgafmxgmhgXxxQjyLjRkHmEYflHaoF8kvRLBX4wtTiz+meGX7Ra0nswufW2TH9
	7SeIjcHxRhlfnvidQe/x5MlQ==
X-Received: by 2002:a05:6102:290f:b0:4e6:ddd0:96ea with SMTP id ada2fe7eead31-51bdf14190amr327936137.10.1755750579700;
        Wed, 20 Aug 2025 21:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUHIG3AHOjKEOl/h6z7KZ5mIVdlQhZ1Um+4/ieLngZ+xMpRrO+Qa0o+wSwDSIGKbyDTFl4+37YbWcgJdF2s68=
X-Received: by 2002:a05:6102:290f:b0:4e6:ddd0:96ea with SMTP id
 ada2fe7eead31-51bdf14190amr327929137.10.1755750579390; Wed, 20 Aug 2025
 21:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815131737.331692-1-ming.lei@redhat.com>
In-Reply-To: <20250815131737.331692-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 21 Aug 2025 12:29:28 +0800
X-Gm-Features: Ac12FXxbx2bs54JnnPSeKSQR06Sww_PEgHS4SFT9EFOoEc2-UhVJOwEmmNTnZKY
Message-ID: <CAFj5m9J5E5T-ew2csZf-mjRoDEHm4AcxHZMop4oVW5cPHNAapg@mail.gmail.com>
Subject: Re: [PATCH V2] blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:17=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Commit 5989bfe6ac6b ("block: restore two stage elevator switch while
> running nr_hw_queue update") reintroduced a lockdep warning by calling
> blk_mq_freeze_queue_nomemsave() before switching the I/O scheduler.
>
> The function blk_mq_elv_switch_none() calls elevator_change_done().
> Running this while the queue is frozen causes a lockdep warning.
>
> Fix this by reordering the operations: first, switch the I/O scheduler
> to 'none', and then freeze the queue. This ensures that elevator_change_d=
one()
> is not called on an already frozen queue. And this way is safe because
> elevator_set_none() does freeze queue before switching to none.
>
> Also we still have to rely on blk_mq_elv_switch_back() for switching
> back, and it has to cover unfrozen queue case.
>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Fixes: 5989bfe6ac6b ("block: restore two stage elevator switch while runn=
ing nr_hw_queue update")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
>         - fix the issue locally, so patch is simplified

Hi Jens,

Ping...

Thanks,


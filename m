Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C82C326F;
	Tue,  3 Jun 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975949; cv=none; b=KLkR2OcSaiMpScqd/JoUe+uQ2dbcRpJiySNySez7jQnWRVzYjiSdnP+586AIH2x/X39kARQd0vjUsEGxQkVN2mQYWuITPKMfZZ1WFYFKqKgLN3Q8dUdE1CF4cOXdnjSE9jKfl1ce8KlpFfM/JXx6WYIMeS16IQbeudzIrf2dOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975949; c=relaxed/simple;
	bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1EVVYZUNOfCmHp6pre3jeDbez1B6PIBTIX+ZO0aLHjjH++Cs9nyZCWlgUsSA36Xa1qcdoTjH23xLQQMr6CocMK0xsJkhwcNyPYy5G2CbcQKLgRH7xLmlxf7bxCUS21Ie9+O+hKnP2qgLg2BbB4AfSXIrg78ceujJkqHi3kK+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvHnI7lr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvHnI7lr"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-602346b1997so10285851a12.3;
        Tue, 03 Jun 2025 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748975946; x=1749580746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=ZvHnI7lrCZDZIDsTELlT4fxS6/Y+GYHQWjSti0S/Y8Irc+q8060/nwdQKDGFC/9nWg
         nniHUpKMiqATKi2AMIbtSbSA2zS8eoVCDJhc73x0xp+O5dkQ1B3sv17hQO6gjjLAb9B8
         +1BTPOhw6UG85q7HITRjfUS5B7W9QbWIIGWj+v/uivi/bv/9ooyLdzSZII8/T1sZsx7y
         x3opRzY0IEiFknUq6/Gx4e3y3wRgbLb4vvXXsTbKmCSK3vN3L93KiUom43JOLt8RABkE
         I2NAgekh4B8cA8ZHpZlGojKJcmrWpefKhNdMFanpyHwmimjGfK5sTLu6+k8iZUJSF9Nl
         zi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975946; x=1749580746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvF0YtJZCPbcobMdQgE3+ZNHa9Fjrq28Jh3rCZ4Bn5k=;
        b=w1xc2YBZKyzcnmRC05DS9xYgWrcIYiYKu9kOWgY8rAfJas6/9AULyM/UimZb4Zi2nC
         0x6Niv7A5/w+sPFOtGZKrr7c6BBodakuMnlZLgfK+Ot0TyMYMo7PofI0aChEWVtP+UpF
         QSeuPvLGeqpkvkZ+w8niYry3ZlMYRVsRxabJX1kIwpMFcFMWFEitXoN+K7w1comaYEMZ
         0GLSPl9aiaNUUof3l7EWpwsl8Ho9UkCPmcvevvN7vJvEaUKTfpYkxMgOujIns8S8wBiW
         wb9u7JIswgUKwvqC1MtfOe3OgeDLTqEYbpVLNnjkRHbmon4GU3KyADIfSqd0fo2EQhHA
         PY1g==
X-Forwarded-Encrypted: i=1; AJvYcCUHUTs74PEwnFj/xIkI2MC546CHdHzUwMB9vUFI0dIrZrbwgig9Tb3y6zZSbvf5u3W95WSllfp3kMRFzA==@vger.kernel.org, AJvYcCVNdX+2j0IhkkwH98l5tnVQ4fv+VG71agpjvyhHTnSSeALkfRzEzHn6QpuuBew/EjETuH06qFuABRUh3RTg@vger.kernel.org
X-Gm-Message-State: AOJu0YzKm5fUy3Q3aJtfgdHBdWeG3JTsC3qf0YxWdjeROUCvEbChka+4
	OqJUCXRkSxWLyoipoqCwcoRdgeh8R7nkeAt8DQxNxlUoYhunWQMhnvG6+6mO0FVwvpm8RNINHcm
	NmWsbOn0beWdrLFkfLLHUo9o2sLJgBT6UVJxyx5XP
X-Gm-Gg: ASbGncsUE04AdXrBmNe00imkWRREc/oJ9h+MFPm+G+e4B2o4ZzVUKRhDnVOmAEIu/HY
	dXEuwh6KCcXW8ovmIuyWcrrlVLDGoNa0a2D0mfAauMW9IYKl7pb4xTMreAfBPy3jMlGCY8HgPHV
	X1nXEzS4qiL+zw0VJp3QFzo7EAst+WZ/BEPlKSFrfxsCxMkCWgDa4C01fTzlVcNPvpxk9MngN4p
	g==
X-Google-Smtp-Source: AGHT+IEgp/H8t8sDlIVXIDA1/FraKwi1oRyldtr5x1vZua2nW4YVnT3NBUszJUfxL2vsAAiNm9j6P2eFL/ZirAIhC8k=
X-Received: by 2002:a17:907:728a:b0:ad8:9e80:6baf with SMTP id
 a640c23a62f3a-adb36b4669emr1613991766b.13.1748975945874; Tue, 03 Jun 2025
 11:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603183133.1178062-1-csander@purestorage.com>
In-Reply-To: <20250603183133.1178062-1-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 4 Jun 2025 00:08:26 +0530
X-Gm-Features: AX0GCFuZoUS8cWsiQh-fsDFI14gLeVU_DVAcKegZPpEd_gCDbRqctwy_P7wpQUM
Message-ID: <CACzX3AvbOE8CMrDhrJ4=JSd9DDcAdzBxC==jXWPvYQLpSiF2TQ@mail.gmail.com>
Subject: Re: [PATCH] block: drop direction param from bio_integrity_copy_user()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Looks ok to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

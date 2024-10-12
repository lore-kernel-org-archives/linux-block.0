Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD0189905
	for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728743387; cv=none; b=jC7mIJ2edZHBC+9wJSWzhIi9acjEwiEkz3NV6yNlmqw47tEenMlABa/1EzqTEg9u6v3cKBpbruh5EgKpPox8Yl1iirW2xVHHBQK9cWpPhNWnp3/7jHgFBlysvbbTWhjOCd6hWKqKz9rDoKWHCMOthqUyQSn/PX1X8Qi/F3jfL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728743387; c=relaxed/simple;
	bh=GLqubO/OHiubWO/o7l6QtGc2vJ2ffhCQSHKsGcSACNE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IO0ae8w0BCXxaUoGkXN2mSvrRHUANEQMkCwdwa2e1hBN8eqURTQV0V7zWZ0F8ej3Z2HEZ30O6qA1Qj6bVH5HY5hFf8zr7QjK3jA3jmVuuib3Q8K6karCWEjkvFLwFIOHUkuCrBpWWtcLITKIVjKyGMf9RbszpJekkNOlFj1Ddik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+TVCvrz; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+TVCvrz"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4a479773730so39847137.2
        for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728743385; x=1729348185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+JlU8LSPVmd5QCZ1ZoA5gGZAsKAtUGuhhf1WdGm5YVI=;
        b=W+TVCvrzFKyX+wZIZQWgMXNOF16pn4UWKnox1TULDirGW/hPL9E5wDgAOpk6AAbY3a
         FQtwPZI//xRspEckLUZD5/+UBVW6Larm9v6k/OD4SE/M15W+Iwlw48OB9y7ItnCHOFok
         tsMxr2HNf08tvApJgUnjbtGdpJpCw53qj0YFBv3vnel89RC2M5DAXUJ2/FHjqTo7tZNm
         VpxSV++N5DkYzrnI0qP5w0n7A98eNJ90lsgLkTzpK98fP+GU2fCMaF42Fi3437O5pxxY
         6uwuvZIW5uqhmIcOINxQeFEDBaK1o7vJIJu3LlWRYM+Op+5cX7cT0xcJHGtw1r1xRhnw
         91Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728743385; x=1729348185;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+JlU8LSPVmd5QCZ1ZoA5gGZAsKAtUGuhhf1WdGm5YVI=;
        b=ZUw1szihZa6HyWttTbHLdvfhnIIHTHpuhj2D47meEmbV/iAgqIHwfMQizL1YRVDY/j
         uaBVHT8f4BeMc3TbiijnZR2JqxgchAZtJlbB3sqUssrwo28P2XjCL9rZOprzvSo+2v7/
         7/cQc+zORxS3u11O4WMFUQ8w5WQtx+rBQ7J4+fKgEdJCRH0oqabXvhcxMyp80vTh6FML
         r9Kf6bI/sWs5W1XWhzqo+OnhW0g5QO7Fjtjzlsoabyr9R96+MNC4AkyntvnQD1MRpyD/
         /J1sJKbFHqQHAKI8lVJDnyE0NOL9fVkK8Y0lz8bjZv18fIA8587zNb1jP5GLugzI5bBP
         6ySg==
X-Gm-Message-State: AOJu0YwqvYisb3z0VqclpjcpnHqB1MioQwhOzQR9/OtMhOYeA1Whq1rS
	B7IJkrBkL6Zc5kcWILNeisfEpjEdjdmhMAmnC36PltPAlDXfovcC7D7bPuvmEYTtAwWMEJLLexH
	lg84XRbwnZGuaZNEqMtIPqP+JdFSKksAf
X-Google-Smtp-Source: AGHT+IFiZRpRrljB3sGpyEwHmjN8hjx+vMKN81P/yUqc8CYHELIgRjFk3vQbMO1vMK7lvwZ5ir/4xAuwUTjlYRA2jd8=
X-Received: by 2002:a05:6102:304d:b0:4a4:633b:7212 with SMTP id
 ada2fe7eead31-4a4659f8ca3mr4573514137.17.1728743384855; Sat, 12 Oct 2024
 07:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Koch <mr.rickkoch@gmail.com>
Date: Sat, 12 Oct 2024 10:29:34 -0400
Message-ID: <CANa58ee6EeT9V7Q=epoZdqYw3sLh1CZGNWqJ0UcKMp6eRfcd+Q@mail.gmail.com>
Subject: Re: Kernel Oops in blk_mq_hctx_notify_online() using Raxda CM5
To: linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ming,

That patch looks very good so far. I have rebooted and repowered
many times without an Oops. I'm going to put together a script that
will continually reboot and maintain a count and let that run for a
while.

Here's the gdb info before your change:

(gdb) l *(blk_mq_hctx_notify_online+0x34)
0xffff8000807c722c is in blk_mq_hctx_notify_online (block/blk-mq.h:84).
79       */
80      static inline struct blk_mq_hw_ctx
*blk_mq_map_queue_type(struct request_queue *q,
81                                                                enum
hctx_type type,
82
unsigned int cpu)
83      {
84              return xa_load(&q->hctx_table,
q->tag_set->map[type].mq_map[cpu]);
85      }
86
87      static inline enum hctx_type blk_mq_get_hctx_type(blk_opf_t opf)
88      {


-Rick

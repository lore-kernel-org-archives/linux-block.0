Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D50BE5E
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828517; cv=none; b=JEnx9wX2mRA4Cn3VR9nD9rLVy+8rM0v0AiyDn6iHNEKL2RaKhQNCLEkx4OyGjLICH8huOmcVUVXZ3jWvDBnnJOgoiznE+caW64t2J1+mhC59xrvsNhbFd1ouxqLnJQjBa9hg2Acwq0tov+1UYPFdaipCEDpcVCflX82KDjdh4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828517; c=relaxed/simple;
	bh=OyHKg9wyo21QoH7tAZcX4BFsG9Zuouo7GfgqRsHQySM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDRb5D18EKQrqzJSivMJ+CSHAl6CUYZA3eVxnKmEss8lr+7sqWwWXze6RJJSl+Cpd2SxoSHZn2yIU5yXWy4T+P4M8pvFBHHvwlyOD2nL5fcOE9Fve2vC4Vrm0fmE02i7LZqxGYGLM4ke5rJYJfxhyBhVN1nvAOH3/TLRSYW0gZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XIhsxOg3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XIhsxOg3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2260202c2a1so8983845ad.3
        for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742828515; x=1743433315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyHKg9wyo21QoH7tAZcX4BFsG9Zuouo7GfgqRsHQySM=;
        b=XIhsxOg3nIYvz1HS1Y6vNK7vNpzA6oujTvVs6KMzePJrAjIkNwxmQ0+Xdh+6+y/y7b
         gzlcbhWzwKncZNzkzX0kzkU86RYkZ+BoNOt4C/Iai1vjZQJR6wtm9Z02Ct3ABmkQNA0V
         2lzjLCCcqme4Hq+V7jrocOKgv584dh1cOesO2zTN+9Px82lwiY/JYIAq0PwQO8UOuOTs
         l1FhMuUaeB7UI3NHEKLFRRORk/yyEdjgPdjJZ5Xgvhq+P4/afrI6MTlzY0FZi6gcyKCl
         wsxI5bvN4oHkaShheiEWwlnbIGldVB+UYYaCdMQ60yIeyAPx5eYiI0uX+QPNNkQTv727
         2gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828515; x=1743433315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyHKg9wyo21QoH7tAZcX4BFsG9Zuouo7GfgqRsHQySM=;
        b=j3IdjMApmDr+vMY9fBKv2c/fZcD3t+Oz/c7YH82I9fkhjCiNJG4zqR4Zn1yHU4h0Ig
         mvpnQWL7ypQQ23DGJCMXfjsJ9KUyOyibcOT9juQ5oGfamM5lY9hRLwWjJxQaQCGADudb
         skUr+CJfzb0oJxEmGJV1No12NG52FIPbZnT80KfAg3s181NpUaBjf/5YeY9+fxUcK3IT
         8M6eSggrBcUMizTRKSFPiPqEMUQwQJmQ68pjSRlaNaxWnVwpQKhdVcZzBtexugBLYp9d
         VS5rMxtUTyaYAJsglxc54+OH/jeWjMy+9qe8J5KuuwVvGCKYz2I+lctF7yciWox76KYf
         76Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXHyqgkLgifesKabfWet2c0C4if6CFJCDfgFnTQJ168bz6cs/E1kpYDxoMC5WPmwXJthFV50QwwLKhayQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSNujLMsPPpf6TM7N6wZK+QqCtHTvp1XNe76zPcqX/xyw2MnG
	RUhY7vGEAAHlPfb13mGgMUOeeddFJBNBsRWbZdqtL/+9kc/aABnBTIk08wjyoJIaikCFHkvienV
	e8LG4t74/eoNGV0G1iEZqin/BTw4aw8qdzJMxIQ==
X-Gm-Gg: ASbGncs9EfJTmIHH+9WhO072aGdqF3GmxTDLkM+FQI8g5l/D9LGsh7PlQRSPC6arR/O
	KNtMZgDuwE05zCwq6CpEEY2csfxaQ8gitLmnDmquOxtU9SS+/OKYDbuunJNHVd7omTu2kaSpsBn
	RpISQ0RBrAhlpAlJduA2bgvu5UuoFGODOZsqyg
X-Google-Smtp-Source: AGHT+IGt17KtPj7Z1/TiCHVmp0C//z2l2UdDHFz0RFvAhXA6+U8XMeTjKai4tNm0W2U91FnQJRppzmi+1jGogkKrK5Y=
X-Received: by 2002:a17:902:ecc7:b0:221:7854:7618 with SMTP id
 d9443c01a7336-22780d8ac1fmr78311775ad.8.1742828514315; Mon, 24 Mar 2025
 08:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-3-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 24 Mar 2025 08:01:42 -0700
X-Gm-Features: AQ5f1JpBoEXS66bzKO20LSdFtmRfdfKDzqq-a7PXpWkzUyFqcfYctAa1Ff_aUV8
Message-ID: <CADUfDZohS39Oj-mU8nT7BOEX5PZ14ofesR_gnF17_4JQguRv8g@mail.gmail.com>
Subject: Re: [PATCH 2/8] ublk: add helper of ublk_need_map_io()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>, 
	Ming Lei <tom.leiming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> From: Ming Lei <tom.leiming@gmail.com>
>
> ublk_need_map_io() is more readable.

Agreed!

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

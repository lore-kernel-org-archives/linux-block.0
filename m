Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85678632B
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826735; cv=none; b=jvD9cgfsmSCXpZFoyLlOmct7jIB3/knkvLbDtGiiensLQJGym5ZOEo5AZYGwlr9LCz7zqdZqmB2fPCvM3WfCRREgzI+86DvZ93zvlcKPu6JJZxPURdAyovytI6zSR/PNUBpsUDLK92pjwIYrVynvB8XyXImXy3h20uUGAG4GPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826735; c=relaxed/simple;
	bh=NxPrhRyrDLpXZJpfBQ2OC3/Q6rg6UtQDAnXL//6IHm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2hH4CCW1GopDjhyt83kmtCux8TPLuOrB3W6I/2T+944xQSgZHOyQOlR41K+hNnStnJ6Mo0Iu1rF0OXCUb0EL8UEwGdqpUOo+X30jNIe4WouTpOyErYYzYc7ivXdOzRPPhfxEHyLt4136HHB8VVYBs9KYVM90gR7un1h/xlG0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QDbhT5sM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QDbhT5sM"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so888638a91.0
        for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742826733; x=1743431533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxPrhRyrDLpXZJpfBQ2OC3/Q6rg6UtQDAnXL//6IHm8=;
        b=QDbhT5sM1JMG0DdOeb/5iaJtw9gyAqle3f2hJdFcJOMlXIuArIWPBUcHOqlFx6fcho
         qt/rRI3nsQrphhmoiVWxB5BKHwiUq9ZBRV5X7m9M/ZQpy4BtZ8pYFFYIwI7A116XipTc
         V7q+1S9rxD5ypJ3V4hlKXTAIQOX4YfTqb7EuhwIDmgQD3mLxKOL+H9ejalO7mS/4oUgq
         t6pUkf4kG/qt20bo3IKijsjM3xhqW3a+0rYRV5SFxJ8TN2cwoLqTf61lNusoQ7IsEITT
         uUakBqnGmmXaFxsRQLOGKFrK0jTUnipci5aZLCtyiVVEz8UyfpI4Xes4kovbL/ph7SLj
         8nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826733; x=1743431533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxPrhRyrDLpXZJpfBQ2OC3/Q6rg6UtQDAnXL//6IHm8=;
        b=B356Xv9KU+optX7yunGqkcyi5e+BXaN3MlHagTqjha0xgpvBFgnSmbd5hbv/QyNDXt
         VRel7NYxL2k1R587L3ZwQc4oE+9Qfwro3SX/9pKmaqYGCG7Yb9P01kvpYMTjT2klXxyF
         YnDzfs5WIrzygLwqkmIMzA0CdrI1Cud3clkro4q7wl5u/6dLVQvDFsMPoMsHe7vb9Cac
         0ZNNtioamp7glONgquT+65pIP06Fk7UXcPZqNSeuvG60gLO5wn1HPFy3OTXsy0nQ7ZH5
         jHeOD9ORs0/z9rBHorEZGjw4Dqgot0LTpmjqhx//JGJ8TnvjAloRc7GVycawyQ8Fz6Zp
         +u2g==
X-Forwarded-Encrypted: i=1; AJvYcCUamTpC+7xeA0J/4Un7qiavxNk7jrroI4LdF34ThuigClJa+K3wefBAP8QGpC/IerQJHSJ3p795qIA6Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YynSz5lj/UsyGV7Mhhf1Al6OS/di5VOQLkCm/0RRYpdzT0eW/8p
	UZw44Dhei8ivUCI9rlmrWD2mM1YSLrLAWJ6s4GY9gO4z0xqwOlcHYRvr2SAwk/7ztXU6ZkcgHBy
	4RuLod1CajMPkve8PZM4l0Q74L0bdSZ5dKAuRqQ==
X-Gm-Gg: ASbGncvvJ3DYtH2fpdVxjScJVkbast5vPqS7AH0NN5B68HERpV4Ci2GxPy1s1+aM78X
	X1kGrFUcphp/7zC3VPOa8CMwfD+PYev7BNXLr0Egal7mK/dPJt0i9iuJyKBDerp64Ozzk55i6E6
	j/M7ireFN25v11Imno13z+ocOIAHqb0FXGxeAt
X-Google-Smtp-Source: AGHT+IGTGamwekZVyV6SbqYxU1gUMkvRLiiXGaVOXFZvYhFLIbBhOVhwlQKc93GgPfw/4OHJaFEQagnXMe86TYD9eVI=
X-Received: by 2002:a17:90b:4b51:b0:2ff:7c5a:216d with SMTP id
 98e67ed59e1d1-3030ff0e874mr8445361a91.5.1742826732855; Mon, 24 Mar 2025
 07:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-2-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 24 Mar 2025 07:32:01 -0700
X-Gm-Features: AQ5f1Jp-oRH6HFsphWrrIGmvSmlYGprFjvUJuTM_-P92U2GtVofLOGmFAer92vg
Message-ID: <CADUfDZrO11KN4itr2v2ENYAdO2o3UWov6wJGnhAnRiZKo20LDA@mail.gmail.com>
Subject: Re: [PATCH 1/8] ublk: remove two unused fields from 'struct ublk_queue'
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
> Remove two unused fields(`io_addr` & `max_io_sz`) from `struct ublk_queue=
`.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

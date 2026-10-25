Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960953;
	b=Y3/yG/w51BP85VkT5RBhoGujwmxLvhAUhSIAKkrb9k03nmVl4av24D8x2YvlR+Qd/64n
	 DPcAMf+rleTn/vi9wREnhp9fY2EWNsSJvtZXfSAt0atbY6AJCNiDSsSzPTVNcK5CxWAf8
	 FY2vaA5jHzQ/wskt3GI97CSQzEBcbWHzOfHWzJb+ynhd1HN/H5CM+lyqhoRvJqm43fv3F
	 8CUdA9T1Wq2M1Boh5XU1EROTxOABgpcV5NzVHINfAhTQf1kAyXOb0Q9tWnFvoGKnHSReC
	 Mn532WiMy/4Tidf2OlcCQnCY9BKntEZgjZati8n9XKNuuG/CAB1ISVebteI2nPPqiww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960953;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1ZVwpDuEOvVP+5WMptjvGUaD4UnS5xmh0v3my59uo80=;
	b=v+YgQ6FHGH2WrPDpYGfUJo4D2WFKfNAkjP+3WhNHAw41hFzT3ZOyuYUd/6A7Ip5coUBD
	 WP7OSXrukiPZ/PYc+aQS/vYtjK7+M0wg2NviSMmLE5GCNf7Z2K4qFogbuuwBmxszMKHNE
	 MTwGgobzZ6//Z9HLL87iGvutEpYQL5Cs8CPUD/ysKyHIKha6MLVs0dTUr0jSRYrmg8sWX
	 0Afo+WO2ZCSsmWI2ygt1u8G7pB1T5hH8SpXBt1Hg7TY6Q8jWXgrF9zMncJ9TZVB4Pfs5i
	 vX4fOdkx7LRyhIlfSPPbgUM3kwj6Ib/jYNZ4zRAD3FLeEVP+QRwYXg+RUJtKgjINJOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cw6wxqO8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111D606A31B
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cw6wxqO8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75611F01828
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 20:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792960952;
	bh=1ZVwpDuEOvVP+5WMptjvGUaD4UnS5xmh0v3my59uo80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cw6wxqO869ZZJ8vwwoDzLpFL7knGGLPUHbSAAQ1kpxEmlLRSoAcIyI+7nCNkPXtXC
	 /sQV6Nvfef8NOsj/Vee6+JjdQSwsL8eGsx0BMC/21zb7xTzpc9lozSJ7N6zZWF79VG
	 mhefi2f4xhIQUZOWJNQJMiZp57XOxhMYe7hXPq/QPwTT/ClZNZV7lCq/+2OFBWsxrw
	 7Bbsquk/ryxVB+AxDl4L4wPHsfXS7lFVdaIMIGn6/3nH7z15C+TgtIieL9xFC7NZ5v
	 Nf14VG1zxAGC+aQJ4EokIMh5+0zoWQO5PXt/cCcE/eP1BVl+c1l6nRpKjLzjRsrTav
	 8ePHU+mvvPfrg==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f36c18b75so119665885a.1
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 13:42:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwoq4cNfdJHPd1jnlcMEuEOrkoAdZS9AES9EnMzIA5Tvm0rmldhBdyUcnzgIj0Ankg0AQEiEFF/eAdNdA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIHgHtOCkF0e5h2NQavy01yB6ZHvnOwnz5cxxbEZNY1UhNsF+1U
	nP5RdgDnON5QDh/bj/zavYysEtEHtNJXx8X2k1Qr8k41w3EiYxs8VcMXfO4eEXvFAN2kkzjjHMn
	2TW9MOgAdHuk2xVqGveuYzdnGrZGcbkY=
X-Received: by 2002:a05:620a:400a:b0:93e:48fc:aa88 with SMTP id
 af79cd13be357-940ef95513emr790870385a.44.1792960952180; Sun, 25 Oct 2026
 13:42:32 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025021839.1542805-1-senozhatsky@chromium.org> <20261025021839.1542805-4-senozhatsky@chromium.org>
In-Reply-To: <20261025021839.1542805-4-senozhatsky@chromium.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 26 Oct 2026 04:42:21 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wF2YfHwyDSt=B_+duiHCXke8JJgqGJcaw31JunUbxxQw@mail.gmail.com>
X-Gm-Features: AclHuK_u4ku4HYNTJ8RqUHQB0jHfvIpB2fBEVv08j0BZX4fWzV5XB72RUiMN54w
Message-ID: <CAGsJ_4wF2YfHwyDSt=B_+duiHCXke8JJgqGJcaw31JunUbxxQw@mail.gmail.com>
Subject: Re: [PATCH v7 03/15] zram: reset writeback state in zram_reset_device()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Brian Geffon <bgeffon@google.com>, 
	Bo Zhang <zhangbo0325@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 10:18=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Reset all writeback state to its initial defaults on device reset.
> We used to keep writeback related data in zram->stats, which
> zram_reset_device() clears, but commit 1d69a3f8ae77 ("zram: idle
> writeback fixes and cleanup") moved it (along with the newly added
> wb_limit_enable) to struct zram, after which neither of them was
> reset anymore.  wb_batch_size and compressed_wb, which were added
> later, are not reset either.
>
> The patch is more about just being pedantic.
>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

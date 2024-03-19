Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54964CE8
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814765; cv=none; b=SbeFrUifBpZQkBMhswSkPffR90me4PKF8QwEwlEQ5pcR0CJyhtCV/FnEbpe1Htkr7DrcEBUCCHct2EB3Bg9LBgeSojcmsLcKwu56PU7ogAUcMwxhzfBa2h5A14/TURbYIBDWJigdwPJUjtNOZLGqzk5k2nR3XwrxOxMxoAyLzs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814765; c=relaxed/simple;
	bh=4UsYXVxbhMf+OV/FW4NNPvSbwSz00SVAaHaYCxM85Co=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mVYoAYVe4sOVCRXR3iFKeds5X9G15t02sH0TiNS1syybYsCGnhj0uPnZdVzYLsOf9qH2BHfPaqGtbxQ7NJaukJTkEwx3rOeRllxfaexGkXFkNV61Ajd07O2FNzewKPyLAcWdHCxSrh+W5SJZMCKCLqFoeRvNVpBf/n6iZdehEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SmOOOpAu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SmOOOpAu"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29f8ae4eae5so463715a91.0
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710814760; x=1711419560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4wMIVG+oVUy3UqKMWG6v/mHicXada2Vk/l08NSuA9w=;
        b=SmOOOpAuFTLzsbOToAWbNSrsWLUkd93VH54wr2lGIFx4jGOiv5xyYUo/X7MJg1KfLP
         NHx5xJgRp0vweIlsYKgEin2tQn+hgy6BST44io/kJMTwOWmV2C8V+gvWBfCyo0+7VKoP
         o5P2R+6U512rVnN+W82lM2VQt2H8yhgZMzVMmg3YxjXdHfNQpr1zpalUBg6a9dnZZ/LT
         UQCuZMu1jdScDYoTLlGAzhynPyX8ckWrP0gtwYZiBU9EP+HviwIxVyDGL8dI1WUp1JjG
         QN7FzBUoQIHURhr9D6pRjJliRU25ZSk9d5s9sutNaPcHdpK+jGvwIzxblBmEF6TZfUA5
         be5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710814760; x=1711419560;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4wMIVG+oVUy3UqKMWG6v/mHicXada2Vk/l08NSuA9w=;
        b=DRfkmzdmysSIricHU+mie8x7j/yiiiANGhTDKbGhAIzWmaHB+Fgk7PXrWCwJnEjEaN
         u7cH6wOVpMa6+ieHBUH/NoIuhgfFJUZH8fJf71/M0rX4tAobWptPwGT9I0k1wD7Z8zxn
         sOBanoVxMj4X6ntVNSOHoGWuowtjy6h+lLb4rART7r6LjyVltt6Bn9yB3IlXhCyQjsOf
         xajZhWr+n/Wg7hUfXCyT8/qfHctNNulNI2i6gj1T+HpcEX9/0hAiUmDQLPc18FNt+WJ3
         UQMmdfA/ZxR44HUmsKR3+VW50RTQ/3uEOVQOhqC+3k36oZu8oA/itssWE4nJMU10hz8u
         upGA==
X-Gm-Message-State: AOJu0Yw+8c0OhP7A2s1Dp8QPxXcdBroprbynspV6gdKESOF+cTYgdPaZ
	oyQcvWMutC6GscqXI2g8OUG2ai+qqer+FBE37BQyQ8NVIegAraypMrSVqtj3xpR+1JQG1xfN8E7
	/
X-Google-Smtp-Source: AGHT+IGlJKxuZb2lPttlNj2SJv9g4FFHFYBlmbk6iVd9vvqCHFjZh0jWQ5Gsbc0WKH9SW2YHvIvPww==
X-Received: by 2002:a17:902:ce91:b0:1dc:df03:ad86 with SMTP id f17-20020a170902ce9100b001dcdf03ad86mr15405861plg.2.1710814760426;
        Mon, 18 Mar 2024 19:19:20 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b001dda336de37sm10027453pll.240.2024.03.18.19.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 19:19:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <cover.1710799188.git.asml.silence@gmail.com>
References: <cover.1710799188.git.asml.silence@gmail.com>
Subject: Re: [PATCH v3 00/13] Remove aux CQE caches
Message-Id: <171081475906.642982.9710864519144172393.b4-ty@kernel.dk>
Date: Mon, 18 Mar 2024 20:19:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 18 Mar 2024 22:00:22 +0000, Pavel Begunkov wrote:
> Mandate ctx locking for task_work. Then, remove aux CQE caches mostly
> used by multishot requests and post them directly into the CQ.
> 
> It's leaving some of the pre existing issue_flags and state conversion
> non conformant chunks, which will need to clean up later.
> 
> v3: pass IO_URING_F_COMPLETE_DEFER to the cmd cancellation path
>     drop patch moving request cancellation list removal to tw
>     drop all other ublk changes
> 
> [...]

Applied, thanks!

[01/13] io_uring/cmd: move io_uring_try_cancel_uring_cmd()
        commit: c877857e86396576260d12eaae2f777fa4fd835f
[02/13] io_uring/cmd: kill one issue_flags to tw conversion
        commit: c6740905f9862b2780cc9a9a3e1714ea153d6c74
[03/13] io_uring/cmd: fix tw <-> issue_flags conversion
        commit: 17c8e3f66f16256d33a10555d0a63d64405ab046
[04/13] io_uring/cmd: introduce io_uring_cmd_complete
        commit: 23b0bed538ac9b73518c670925ebb64f0239b54f
[05/13] nvme/io_uring: don't hard code IO_URING_F_UNLOCKED
        commit: 1a587b0d65d09d61bd8f0db728923ab68d8fb9c2
[06/13] io_uring/rw: avoid punting to io-wq directly
        commit: 7f3b8125c3aee86b5dea06d9a9738b16aa55cbdd
[07/13] io_uring: force tw ctx locking
        commit: 2a475207f98db597043251be32bb8f16d3617af9
[08/13] io_uring: remove struct io_tw_state::locked
        commit: ccb464aeb6e563d1df179aacbb7c514369ceb8f0
[09/13] io_uring: refactor io_fill_cqe_req_aux
        commit: 39c25ce47d211f4decc47f09f9561b8630aab84e
[10/13] io_uring: get rid of intermediate aux cqe caches
        commit: 1a7520889e02de50c8334e215a3f187ff9a92456
[11/13] io_uring: remove current check from complete_post
        commit: 7af89eaee7d17c2f15e483c859d4fcc09dda6dce
[12/13] io_uring: refactor io_req_complete_post()
        commit: 838070b49a0b1466156661b85f6c97dc4033902b
[13/13] io_uring: clean up io_lockdep_assert_cq_locked
        commit: 3cba2895da4a77b5f555f29821487db42f084324

Best regards,
-- 
Jens Axboe




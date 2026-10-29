Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281490;
	b=vU3P/cYdEl/et2cX6TokHD5FigwUW3g9OJ5ejapOwT5vu9eVccVd+SQGNTNdhHJPiLUb
	 3PsMZsw/UWQk8ofATKW9G17cWZW7gXrr91hELwyG5hXVb3l911lqizVQN0Ok2bfVAS2Jq
	 y0NbLy0DmIT0YqpZM+MlIwE51dgXtSMFZWg9oXAbLou9PQIfqp5vrZuRd9nxzo/Sq5W1F
	 5Jt1KyBaV9ZEb4rXnXe4mNXBePgBGNDaefVA+qC5Y2Lhy/4AVRAjCIRp/9Ivbi66N5tKk
	 S9aFROzz0ft5SnT7H12J5s2wsaJDdEaGM0pECAQaMfO+UGSRPtwHeLncQSVeWjlHF8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=r9Yjn03pj845I6dvouQuyeLdqWNVyS+hRwAp++oHECs=;
	b=Wmk6FfdFCbwIUWgnOJH669KoFkQneYXcNCeP5Wb8THiI1SOlgPteUCCXg37VQE8Y1YR9
	 37cHO3ZkO5mtc/WW5YiHQ0RYQdecdi6AdXHK5BNEiIq6Cm3132pQDJa+48siU4uJBG+nC
	 oMml+mqVXTpOOqp8ZWwmyAqzavm9B9B8QXlx6HP/ebH7/W4IxXrCyi29UMmMBi4WyJQVA
	 SqTkrrozu8vOE2I+7P5ieS/3DxSfxlBcXvDFDw2ZWuOH90bZq4CnWO4U20br3zf8HAUkO
	 I4M2ZkRU+qqh2tne5MAlfSHctpqOrtyod6C16prdnWy2JBJm21dHxpj4dx21I4iFc9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C43606A31E
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C43606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a18fc7a38so4296055eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793281483; x=1793886283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9Yjn03pj845I6dvouQuyeLdqWNVyS+hRwAp++oHECs=;
        b=t1jGd2wP7FlHqhzmTXGMAvuTeVcRzBygvgwkK6YYcGJy//C+hGySWO7TU8DaNDK4S8
         l0flg4KDDpWc8i4IhrrKvC4w+jUb14sMNyjEzTOr0DONkCQzbgK9+8BbKYuGiXXD+Aom
         iJzZhvniayMx5de3s22t6ZyFplh3tR5zb+VEVSKx8hd7VlKyuAFiK+05SA5+wOwbH3KR
         8+01y4WGIUcgwBDY+K5Xek0IFb2Ih32teGQ3smyx6oF2EKVhxectETtW9wNRfLuR53Jo
         wUnYUQyU6/kcrUMZYTwYR5LoTFkyk54tbOoCOzlPzm9a/gZmFWawqN2VXML4AFDfUxJp
         JQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281483; x=1793886283;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9Yjn03pj845I6dvouQuyeLdqWNVyS+hRwAp++oHECs=;
        b=l0IDJPaK42NbmGI0heksqbWKbtjl64pT46Yzrom5Rae0jzCP5CPVomY8CTaqj4dhPL
         vxycvkm766oUIwKOcJIDITG6lnliootI+F1KVavZ9p8H9zoSERGrqpYNEI2BCwedHkys
         PdG5XsnuUWGytsUm9clKMBSshPJt7FJkQBqwcViu0ZJwqGfkZVGxFAotwjTR7pRhsIda
         vG0KxA+thilorkUHMVh3z1nUluHrrAFDaF9I3bxlkaBhYX6JHY+GSqrJmGo3RdJuf+jR
         iRmZkiQgiF9yJDmWXTspBp9j1YjUqMkTNmDmnmbfqwZAgqmsu23iP0tXYJjL+3syzB4I
         8t+g==
X-Forwarded-Encrypted: i=1; AKwUvBz7oNnrK9Ki0/NDk40baVVbFicvoXgyVfTO6v6iRpthzplX/L8jdBuyqIZRsYlEcIvuKL1aovD8DTVNkQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJiSfOwgJEMh2dL+UO9q9mJNVI4kuLdVoCtzeFkP3jgbAczFkNH
	WEaamYUs/bNS0v+jN31nzl1Uc0zLBjhQVWaYY/uYwjsIMepHO8N2hcSnLLdaPQb7P0E=
X-Gm-Gg: AYBFou3fiol7iYbOa4/W4yq92ehdDUUKKa+tO9Z9xwgTyA01kjjqcu5uSJge90F4oiQ
	1i+9jryvDIQYYmyWf0WLv2saXjjbdbNv5/PEu/5M1KzCofhC8vz9P/m0kMjRyMxAAXs624Rj7nG
	zKyr2DpniuRvNKD2U6vKvdKObmLwbH1yTWV2YVi/yUPPX1CTTA87dNAuq2NID1rQjwT7lKPsyzc
	xyGk8P+wgEcDPIXJaojwlJrG5XBFNuherWziiPyYgyOdobuXWzHF+xFaIPG/19goWComU9Or5US
	p4p4vlicZ8fR0xrluF4H30Ll/D+3MpAlyAFGIwe32XlcioatDVpsmpBT/5Cg0fypnAlA+YvxRLO
	8d4UILiKnLJH1j5UmGpaqeqF5xHglJsgkFOjdjSp5S6mpYvs0ntsMQGIdofEUQzedAQikFM/MMx
	bNMM23SfpDJk1dmwEmWfZkqiB08FURY585fDolQ8xZ8RuQ4XFfbUVH66928S5YdaBUbbnB5nIPH
	2Qr2q2BhQhI37LurLyUgoFpjFigJR9eilIfyFo7Ldry73/mbXclcY0mEegxkF/U4oPwfUPBNYrd
	4wgjNUaJ+oyNIvH0TyXRloNQ+/CPLWycQQHA7mC5MLmpqEivGfVANZ/1oHQ0C6zS8lw1fT6AajU
	h1CCIJs0VKusN
X-Received: by 2002:a05:693c:41d7:10b0:356:b370:a0ee with SMTP id 5a478bee46e88-36a2044d2a0mr7712963eec.20.1793281483283;
        Thu, 29 Oct 2026 06:44:43 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390929asm21976894eec.12.2026.10.29.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:44:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, Kunhai Dai <daikunhai@didiglobal.com>
Cc: josef@toxicpanda.com, yukuai@fygo.io, cui.tao@linux.dev, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261019125412.3123895-1-daikunhai@didiglobal.com>
References: <20261019125412.3123895-1-daikunhai@didiglobal.com>
Subject: Re: [PATCH v2 0/2] blk-iocost: fix hweight cache publication and
 donation fail-safe
Message-Id: <179328148122.1447413.1375912231299331612.b4-ty@b4>
Date: Thu, 29 Oct 2026 07:44:41 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 19 Oct 2026 08:54:10 -0400, Kunhai Dai wrote:
> This series fixes the blk-iocost hweight cache publication race and adds a
> fail-safe for invalid donation weights.
> 
> Previous version:
>   https://lists.openwall.net/linux-kernel/2026/10/15/1954
> Replies:
>   https://lists.openwall.net/linux-kernel/2026/10/16/1431
>   https://lists.openwall.net/linux-kernel/2026/10/16/2798
> 
> [...]

Applied, thanks!

[1/2] blk-iocost: abort weight transfer on invalid donation weights
      commit: c810ee88cdab27f443c32270dc7c0eaad2cca3f8
[2/2] blk-iocost: publish hweights as one atomic value
      commit: 0150554a3f38e1850d5964102eb89a720c5fe789

Best regards,
-- 
Jens Axboe




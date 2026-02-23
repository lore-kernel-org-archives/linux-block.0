Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51027FB18
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862095; cv=none; b=qn8LhmPgfIBLeDQ1/IHbRRkycd9HX55efwCu5jSUTJdx9Ahc6d0GaM+UE/4db8/3iS58ZxXVospIXXhJxLc1P7MB39th8zcg8cr02Vffyd/JJGo6SPWsK6PgQNIfQFg3BmcWTd3efqfjhdu4D6cDUFWGGzlFV4rSNvEPwdJbdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862095; c=relaxed/simple;
	bh=R1AUHGXxe3dGgZHbFkQxH0f/b1HLtXH7ZZMS1myvRDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5FbxRkRX4EpFl9WCTWQ+Lt0D69xidHud5bpzvPpcNiBv2vYBPUEs/Qh0S7qzxEjQtyf/5HNtXV8FCWbCHeKeTibHq4QEUEIj/GOrgg+F/mDSf/LPdaHw7uDSMkHVEpVWxPH/SImAqyxPHo2uGPUSIIelwr8/dgJGHQI3xaj0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV/trNVK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV/trNVK"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f92f3db6fso724192466b.0
        for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 07:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771862091; x=1772466891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyQb0+priOw9IUD9vV+F9EltCgHvh5WCMeDq2M8hato=;
        b=AV/trNVK+3bVsOKnp5bahBdRAH07bioQbb+KQdhDdReRC6BRzawScBjHSwKs+AhGUB
         iZ9AQZGG3s1e+nAmEEy0xHhD3d4xIMx8y6Z/yQ+wTJ4cVxHc/yg6MwgGVLPyxT8IAAou
         uhFX6ih3LF71xZRew+arQeEsEDozLUMo0ojuRIG+gJWYkQ5RxV+70Hk9wxWOgbNJv9qb
         MhGWm8RpXByui/rR61Hket8H6wtRBMr7N9b1zwc3gputqFhlSuzGn+NSwyrtYpPRpk/h
         VJ3oaez6xGsaRenOEca1c0+yQ/C/yHzImvR9FrZ7toR2aDszDqjbeA8idHsvmj2D/i1e
         QYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862091; x=1772466891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyQb0+priOw9IUD9vV+F9EltCgHvh5WCMeDq2M8hato=;
        b=t7AS4txJouoAkZqKZijk9Qei6YPnHQrOsjTNVcJZfNl0znZgj400+zWBBdmAGaqNYR
         LGXHVG0lDV6WuiDvlrdO017lOjCNyLu/1p0WSyN1563NADg8yJsoSvzhxlBpGU8eMvGS
         LScX5u9P8k3DwGiNbQlrX5lFKHkQpA2x5OypiVcX9+AAbRnV5Eylr+QOBQ4TXxyQTWQG
         fn+0lP7mYPSD+ZylGvOXAoyydmMvjMuKa4qneR/RASpalfkAySBix9Am1lEm903ilseI
         isZHZ8knUUKX0Sqa7Utn1dyvNp63FtS/UjXzUrndE3dEugq4MnrapZN+tc2EUIbjdAnU
         Yz/A==
X-Forwarded-Encrypted: i=1; AJvYcCWO/ePPHvIkYQtxAQX8REEeRPs9J6xVWGrXzIf57XED2EzZ6S62juIt9VLerC0kB6/AZtZcaCN/lTyvkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0c/dwZOoM+HQuk1RkcJTjWGPE6r3N0BwVn5rs/uJ9KCbD7yZO
	B4kzUQziIx5taJoG1K9sbdQVpR9BoQYFHz9XGI9B+rj9V60BKBFYNeiq
X-Gm-Gg: AZuq6aJCF8e4aynnZyuieTTlWi2BE7mmb5CgZKqMeE1PIluTY5qvkkXhf8bQtgsH1gh
	r3lPmAeqbreT9YNfQU6qjmmmH1ovexiQy526lEcwnPviaQEEp2jLB0vd8kBlL1xyj+GHq6kwucn
	n8P0Qb2wzQmQK0gwN/lHmeRORRdmFCNQdYWJ4L6A7seI0x48qw/p6Qn7ngzFhoWyuzyTMgLh7Eo
	q0lUyi+9DxXNMPY6cJ/QUyU1Z/AyxQvdkBGjNR8PxOslwZt10I3Ye/fYZbtA37s8XQEoO8beDh+
	KifkOIx0eAXFiligCPRLoui+H1uPAirmbh004Z81rFTnSRcB6rQ/Ekkp8qx9e07SkCjpKr1nKpD
	nesGsnX/852FCGJkzxnIvA4oH3PSdWgybsIXwGGHQd+MhqGmIcNCl9xEq/tmK3gkWMGZP9ovc1f
	ZjBVIZH+PGoXi2LjiIv6Or6u4YUxWaasE/ok+tx+HziI7IgpK1EyOhLfc8XD7FPTycnCmJR04zY
	lsrQzI6UYEdPIR0fjiKiYiKldZqJvrVSwprBioqSSnm3WUr7Wa/7IPWJlcd+UYpEmSnySqnSWeA
	mg==
X-Received: by 2002:a17:906:19cb:b0:b8f:8e99:7860 with SMTP id a640c23a62f3a-b9081ba9436mr397974566b.46.1771862090575;
        Mon, 23 Feb 2026 07:54:50 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084a4d6e1sm341510066b.0.2026.02.23.07.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 07:54:50 -0800 (PST)
Message-ID: <7e772d91-a546-40ed-90c0-29e2a9721c53@gmail.com>
Date: Mon, 23 Feb 2026 15:54:46 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
To: Xiao Ni <xni@redhat.com>, lsf-pc@lists.linux-foundation.org,
 linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
References: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/26 05:38, Xiao Ni wrote:
> Hi all
> 
> I'm doing some work on user-space RAID recently. I'd like to propose a
> topic for LSF/MM 2026 regarding the implementation of RAID5 in user
> space using ublk and io_uring bpf[1], particularly focusing on the
> challenges encountered and potential kernel improvements needed.
> 
> Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
> with the goal of leveraging io_uring's zero-copy capabilities and
> BPF[1] for performance optimization. The implementation includes:
> * RAID5 stripe handling with configurable chunk sizes
> * Multi-queue support via io_uring
> * Degraded mode for single disk failure tolerance
> * Integration with io_uring BPF struct_ops framework
> 
> During the implementation, I encountered several technical challenges.
> The primary challenge is performing XOR parity calculations in a true
> zero-copy manner:

I aim at similar use cases, i.e. interacting with registered buffers
from BPF, but based on a different BPF-io_uring implementation. I'd be
interesting to discuss how the kfunc API should look like.

-- 
Pavel Begunkov


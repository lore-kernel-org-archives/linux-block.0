Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF02218306
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018309; cv=none; b=Mgjhh5NLCwIq/WhG72omHAoKlvY3cBFZOPe1PdZg73cQYb+O3BYN3jxm0qWemyFZxfNrfdmyco+Z95kZL0WjBKHkZhTmTGezxveTqVv+f2q2U+VsYrmdugXPF2u3e3SfK9NgYowBQjc6VQ2fn32nD8fQ/vhwzRWvrUpIpra1hLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018309; c=relaxed/simple;
	bh=A0s89LkTZp4qlYQcXSCueb1TirquJIeDVMMJtYmlY8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RPBcZYlaZsIsvpcFkFRMiVvrF0pvL8INy7qGv1Tz7AHH5fdK/QAiuZmOWBmvBxvqyz+H3znkn0zvWWBkUEOZYV6SLHGnMN+DFe6nqWIocYmcj2CgE8iWk7HYBtADU/WGIiaTTivVUMsMBijebrv9VZZAZ18tijVcv81K1z+kOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NNVyo6jM; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NNVyo6jM"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebc4e89240so792491eaf.1
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 14:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731018306; x=1731623106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G1XPfNuNFwsG7zmk4tSO01JI2jTPsrTlLrTnL5erRw=;
        b=NNVyo6jMO+aehwoFwwVC2OeSmm+hWlmRPb0P2Gj0RbkRfIvkXHdmFMRM2xwJYYpYn/
         JXbqRgfm5saAM0bK68BBuTp5QUwJ9SzZmyoYO1uVF+a96lg6qyRHx5q6Y7zX0ng82YYX
         vnBCS/OavELHIEgiOQYuYo9f7lF4l7GxqmdXZyjhA+9S2rL23nhmf8z4mFgbSa3T2PP8
         GjV6F9jgUzIPVXoLE6bzG1fKEfu57qwZt5rOLImm83EM3z2n8ydzJH7MF7k7jVJTb9Si
         yDyvqr7dM4tCQHoTFyeW35OJ/vXt3wLSdR7sl16HYcAMQyMVkXkCkF9o6i75f22dvHKc
         8LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018306; x=1731623106;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7G1XPfNuNFwsG7zmk4tSO01JI2jTPsrTlLrTnL5erRw=;
        b=VKT8phBS5s0OqfRa7pcM2/n19uUT1eamRPuzLbjk+fsOpmDbEQLl0O/rJ9Iv7QbQ0u
         A9gdF49kszVgRqGvZg7PNCN7yIVec/k/PNTI6UMdWPhAE57ChlhKFLVEOMALm/HMpjAi
         19l43vTY4KBmQxLDQpZzLNhdLUuR3kdxwGe44fvigwL8v/fAAaUEc77lB8NFPEHEwg4b
         S5gOCLUMrKmiVNp6XpC5aZm9bWXMbDksIX9BoXoC85RXVjBcvp3MTi8RLASrAi6nCyll
         xeIO5jCOLhpNQ4HQUcrcCiQCxjKPnPDFwz0CXQ2ybXXAo1BgaxXbLjGcXcEB7QjZXDiE
         KstA==
X-Gm-Message-State: AOJu0Yw90ezA0fQ3rVYvKHkxbICOex4DX1zX+aKpKwsaGjrTs60W1ewT
	o7CVd5orVVmO/igKg//UsI7HcePif68qLeJk17TwNfQhOTkRggl7c71rx31j6DY=
X-Google-Smtp-Source: AGHT+IG7NijurTJzMy5bPXstDLDynMam3yc58InoQfYqKZ8cHjic1RBivnR17kuenuzAZXOkTTbSOw==
X-Received: by 2002:a05:6820:2018:b0:5e7:caf5:ae03 with SMTP id 006d021491bc7-5ee57ba7a91mr872684eaf.2.1731018306050;
        Thu, 07 Nov 2024 14:25:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4950f88bsm421226eaf.17.2024.11.07.14.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:25:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>, 
 Akilesh Kailash <akailash@google.com>
In-Reply-To: <20241107110149.890530-1-ming.lei@redhat.com>
References: <20241107110149.890530-1-ming.lei@redhat.com>
Subject: Re: (subset) [PATCH V10 0/12] io_uring: support group buffer &
 ublk zc
Message-Id: <173101830487.993487.13218873496602462534.b4-ty@kernel.dk>
Date: Thu, 07 Nov 2024 15:25:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Nov 2024 19:01:33 +0800, Ming Lei wrote:
> Patch 1~3 cleans rsrc code.
> 
> Patch 4~9 prepares for supporting kernel buffer.
> 
> The 10th patch supports group buffer, so far only kernel buffer is
> supported, but it is pretty easy to extend for userspace group buffer.
> 
> [...]

Applied, thanks!

[01/12] io_uring/rsrc: pass 'struct io_ring_ctx' reference to rsrc helpers
        commit: 0d98c509086837a8cf5a32f82f2a58f39a539192
[02/12] io_uring/rsrc: remove '->ctx_ptr' of 'struct io_rsrc_node'
        commit: 4f219fcce5e4366cc121fc98270beb1fbbb3df2b
[03/12] io_uring/rsrc: add & apply io_req_assign_buf_node()
        commit: 039c878db7add23c1c9ea18424c442cce76670f9

Best regards,
-- 
Jens Axboe




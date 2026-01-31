Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5CC17BCA
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769867351; cv=none; b=M7OdeIsc7btKfQ6nEfwWa7olp0PhqRERnTxnS/Ithvgi/3wPqWKltL6aRJ//DhjDUQ4rIy5H558tnZDv6srGKJDYxZtiJYwLE8GwQ93BCjhVLJ8PkIb9niQGD1p22M4IdKdo1Ja/6BLIUnXEjjR8Ih9L6jqmlYVW1vie5H5E6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769867351; c=relaxed/simple;
	bh=/gOFXD9nThQ0vLPPYxOy2VEWy0lENVXv1tENI9CtWF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lfFJgCGmXxVJ2CSOzkjGkzjon/0080zramP6jJVU381NmjbE/v5xNxJ4bQdMUdqj8bHGmkB3+fWUAZI5NzerbeF5La/DS1ESaaTaGWMR74uG7Nscqmlalh5PYnBdPWZdrrK0nvIZbl+nhzOxRBG7/vMaooelgMtbPhbtccNLy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a7cRz+rS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a7cRz+rS"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40429b1d8baso1012009fac.0
        for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769867348; x=1770472148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2jyQzt8IRTDPBUvo6K1XygSmaxOASgA/JR84N4qE18=;
        b=a7cRz+rSnt17WFGwP924FgAtjfCCmmvVvxntq/WVWlKq3dwZKUxytt+aVENZo2D39y
         KYBy/1U25e/OnvKdYEIChsIk/dF6nlI3ya7U9DKztivpEH6c5KAA2Vky7IJ/vk+NMPWK
         xUbI8NWFcYhymJ2UffrEk568XEd2BJa8/ukh2T7k8x0YtJ8Cm3tifuLJmBi80Hp6mskn
         sqaAOfvWrcYf7dI7kgXtdp91VVy2icOcHSgB03b7To1AMm0Ja8IaQiC5WG8rOR7hY9z/
         D0gYmYFhWXVddh04Cx9cZay8jQwAydbnD/i5g0xwEPa3Uj3q65ddlV4fQ3MiHcFONYsJ
         +e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769867348; x=1770472148;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2jyQzt8IRTDPBUvo6K1XygSmaxOASgA/JR84N4qE18=;
        b=jVuDyQ8s5slRZKRV1in3KtDi0G34IsLzi4ms/4lPgvDLhkDRGoJaf2bnYsOpOwzfta
         6kzZuijoc9N3vS85MzbjmSxd7i5IRpAs4MIyDZDC8i5SlvxcO154EXgA3ZjlF6nhAILN
         Cqf+KTyUs2J2A1n0KAyivHHnmkdWzQmzvWICvE691xziEnDDtLP7S92mtAMaAXqdMFch
         0NV+O+EVJGBAfbyTYP1YjmekPVT7CA4O3TKZL8aWpRMfzuiwcMfyyPJoSIBA+DrnidF7
         6lvsaWJib5mhMNYUlvL9TVZSRJmvmUeo1hwJMUaGbTLgLHcfAawjyGQg5+Yutua7eK5q
         IjTg==
X-Forwarded-Encrypted: i=1; AJvYcCUAMmLxGTFlZyQXkxgEDGBhZ2f1Twn9LbgR6wP8Kz3HkQ2gpjZijeMd4+WV8F9Ew72idinjjrZ6cCM4aA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuu6GY04QvU83Vy3DfjrRrHnsegxgOeqyedTAXIiPTsb8v4Rps
	DYlJ1f06jmkuVGmI7AbEcZHysbNMbN/tDf68XXTc6otMTG+WDM4HIPm7Hdl0xgdnhXQO2rtUahU
	ZcG89CZQ=
X-Gm-Gg: AZuq6aL9r05G6EBWvoPsBDLTfQoIPFy60Mmj4oxEAbATfeHEy+qbppTLPIZZ6n3NpSM
	CPy3MoldYkpd7y8oPGa+JpXyYrMRXl5S3ab8RyCJPtg59zwbk0uG0MuxCCMZbloKoS5hU9GVZNs
	eYYEOx/o7tk7b5MUiK9bYWMPG1DneePHjQ9iRu6p82JWbh8bdkbMyPWMSw7vpuPePm5qmwqzxt3
	dA/cE0h2S1K/d5e47AW5zAriD6YLxshiIUFLsWzfJMsbAmKPOfoYcqyAxXz8JCz2kuGfnRBWiw0
	Ha+VXhMyRlx/HKPqqc+FKfaZmFmLAAqA7B6suNr2wooMoLI5TIJDCAoKKSKxtF0eDy5IRvkuK7u
	KJp7vriX33C1GUdn7gO8cqGLSQd+irRTi36JAUDVyPkcLknCefIRYWcs1gMFjn3O8wuWU2mSmAp
	MymzeMmsRzsbUYmXhqPQF0I13xv+Me/oqMBnj3jAw1j3br5TaN2YiwJdbifOPVVrjL
X-Received: by 2002:a05:6820:4d4b:10b0:663:f65:1c97 with SMTP id 006d021491bc7-6630f651d43mr2115238eaf.63.1769867348020;
        Sat, 31 Jan 2026 05:49:08 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a19cb4sm6575789eaf.9.2026.01.31.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 05:49:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260130171414.1376543-1-csander@purestorage.com>
References: <20260130171414.1376543-1-csander@purestorage.com>
Subject: Re: [PATCH v2 0/3] ublk: fix struct ublksrv_ctrl_cmd accesses
Message-Id: <176986734625.961362.7129018676090960172.b4-ty@kernel.dk>
Date: Sat, 31 Jan 2026 06:49:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 30 Jan 2026 10:14:11 -0700, Caleb Sander Mateos wrote:
> struct ublksrv_ctrl_cmd is part of the io_uring_sqe. Since commit
> 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK
> issue") allowed some commands to be handled in the non-blocking issue,
> the SQE may lie in userspace-mapped memory. Validate that the SQE size
> is the expected 128 bytes before dereferencing it. Use READ_ONCE() to
> copy the ublksrv_ctrl_cmd from the SQE to a local variable. This avoids
> data races if userspace writes to the SQE concurrently.
> 
> [...]

Applied, thanks!

[1/3] ublk: Validate SQE128 flag before accessing the cmd
      commit: da7e4b75e50c087d2031a92f6646eb90f7045a67
[2/3] ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd
      commit: ed9f54cc1e335096733aed03c2a46de3d58922ed
[3/3] ublk: drop ublk_ctrl_start_recovery() header argument
      commit: 373df2c0255da77f0842368708afce771e1330ca

Best regards,
-- 
Jens Axboe




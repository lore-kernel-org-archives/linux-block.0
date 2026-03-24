Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78A3C279B
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364283; cv=pass; b=WGkfXHExsaOC0CgzTQuEJMXvrs+4n2Jj6CiFCc3Nbwy8Ci606yOC5Xqc2QYUNJIlID9cUXAkAdgKB40OfSlRJ6U2uVgHTak+p2d88NtB2OsBvwl6OQbiIhFnjtIc6f90hsmVDWDbzkQr1E/pWT3jRnD7e3MB4uUYVWckVLlMkBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364283; c=relaxed/simple;
	bh=6xljpOJUIZOjxqkc8IsQtg/dDMs5h0JMsZuQ2r9xges=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm9aKR9j7iiqh192Z0sW9JWIFxx6FGZjyDx2BQgLZ/bC3FLM/jFPckK2HJE9cWKOl1K3xeeZi7lkzJU7QCs0pt8LDY7hGiCHJy/TERMTmtaNApQbCYm97g5FEApMMLzSx03mNjaYQEXQEVIaOiGkDxVxHyH4UQqR1ou4FZCqKgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ownxWEHE; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ownxWEHE"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so4363288e87.1
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 07:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364279; cv=none;
        d=google.com; s=arc-20240605;
        b=JVlklICELVtGHRUsHJpWcpfIc3GeexhU2X3AgHILLk3aF9t+VgmqEMxiU4XXovhzh3
         0ucAkJThtD3vYh3SKfqtEyJuL94DdE0DwWSNeEsf1L0qBXAKyB6nsWfEl/zt/oSrDuyg
         FMSrCN8ukhXD8M4fPQCOLFTQVOHuyR17cZi6HMGO/COrhgiK2KyPWgdbqALG2peeHR1V
         /Evp13XHlhurb4Yw/R2ptKRlNuOk4J7XEYOaa45FZ0BFpdk7pRB8pCiGIX5RF2+nYFSN
         exzA4wUCY8Kpjn/6uHglZc6tzWWXNtRPvPsI4zGlzr62PPwkXT+1n9JyCHXSWcoMqB/n
         9j7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7+/JT4EIQokEZ3mYpEqQ0slSjAC+QW8qaLJ/zLQY22Y=;
        fh=DHt/bGoQcTTT9BkgS5akojar6qTOxye1pRTx2wHFGgc=;
        b=azfn0+dZ35nkaOQ9P2/lj094Sq74vz9iKP8gfE62wdmVvNWwl/ZLvRcJYMqPfRcVtG
         g6HoKPsAVleBmnGaQcM9+1W+Jmamn29zPkcJbBgD3VIaF3b4LkAR3D6UpPV1IrCHv9F9
         3rOvbdvf9qft8WuffKdJ0tir10Vn3feOZZ6bRdrvtFHxHV5A35c7YL9tWTzwgV6E1Kyc
         dBDcO5xgBeVQoLTg3DlH++pbwnp8648oCwkxcmoBNX5lvgUHKua8h4Oob1aef6kK4mKO
         2QQNsuuIW9LF6TDHs15w9+I0gXWRKFnaU7Rvpo88Eb3D4I+7bJLhTeQSVN9fRwEe6QrZ
         5opw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774364279; x=1774969079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7+/JT4EIQokEZ3mYpEqQ0slSjAC+QW8qaLJ/zLQY22Y=;
        b=ownxWEHEYYC2jomQTGrwaJXdMgBuFy9zPJHCyk0ZOaVZ7KBxtoCkQi5lcEgK0Zow+y
         gDDdZD0pxLTd1WHB509FfsI0Le28Gq62YegpDITmR/WEc3dTsl5YXqIHorXXuPpmEQ91
         p2tohFk66GYqeWchk5uaA38ZjV4WfcjgBn+QTXcpVnAUlG2MxMuWOwjnmacgqU4kmEA0
         F1HGP/4k3lRGUjCU1xbeNV9ZohHu3RNWNJ5fqnW/XKfi/SZPknR/rz+wvl/8d9Ma44Y/
         1pC4Harh84vFo9O570h8oUMoBSTapUUH5ktajQEAsEoXHFYJsgkMZXhrtt+YxSrLDp9K
         0WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364279; x=1774969079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+/JT4EIQokEZ3mYpEqQ0slSjAC+QW8qaLJ/zLQY22Y=;
        b=j88RbQGIx6DfXf4S2StjLiKgEC2EISzUqa1FbzokSssjo1a/2IA7egjFX6AIlU1L+H
         JgJsa8vpuB7vaTlk6dywXzB+uO79mkDHCtEhQtXLYA5ukWM4MC5aC8jQUgRKZvgsiu1t
         2seaXiqXJjbjabfVqss7hIYgh3NYhLzQUV9JZUng0YzNdxDNH8prFxQriVb/dpw7l7/s
         sdg9TWoEbftnNkSRiB+IxCYZGMIHIo1vcXKavsdrHec68cwNnss8/KIjko6+z+PEYWCr
         0gYs/947FZMp5ys2ZyxfSl4C8Plfn/8SHK52Oxe8E2CGdBbAP0NyFQwbnnShIyoxUQJ2
         qrfA==
X-Forwarded-Encrypted: i=1; AJvYcCUhvWklXEmH+MPQOVAW6a6wxB0nSrRNYtrnqy8mpCyqxpc+yasWmqmYBgDoFicItWFVuWCGGSyH9v+b2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvzxJ94Z9MUxkJRbpasIXWYMVWEBwRauDQwk0cZGskkSMAskf
	EPMVgK7aqMGyup5j3YEBP2fKhvnD/NywiLmDSzgvNoKLoCLq82XNOT5vC7cYEZq3OS84BB79FXB
	Jp9YSLLd1fO6US+0jWwRsm0IQUxGIbv8SsHp1z27F90NEIBO2O9M+A3s=
X-Gm-Gg: ATEYQzx1KPYLnfEsm0xlbuvcl1rxtx6K/Ob/i3dqjK4FuML3BE+bdYZO/dqEeIgRq4n
	tPqOI2zpDscyILA8dhXDjARANdU3EZwXf/OhRemVhjpg/ujmjDnduem7IY+FtHV/AR/A0q26T4D
	pGqJZZ++dRwEY71CpVBtHlc8nX/50ybE0Rwz/VZhaL/qrwpB2r0fB15WLJppeTajB0X7ne7dRgI
	hpiP3d4/hqvke9s+kKrBQG0TJEedsgn4J9tDo9ritbKM6ese2kweyMu6MT2h/sVKVs3F7i12zFg
	yFaruYZ/U6t5sFbjTIg=
X-Received: by 2002:a05:6512:3501:b0:5a1:42c9:d978 with SMTP id
 2adb3069b0e04-5a285af967cmr5754009e87.1.1774364279081; Tue, 24 Mar 2026
 07:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310160408.3976760-1-b-liu@ti.com> <20260324143448.2631888-1-b-liu@ti.com>
In-Reply-To: <20260324143448.2631888-1-b-liu@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 15:57:22 +0100
X-Gm-Features: AQROBzBoKLSC5g41HZ9oD8gxep-eNNKjSY-hwFAbhml6t5GCMNqJZlpxQ2HWs0k
Message-ID: <CAPDyKFo5h57uiym=WuKBLji-VwcDtCiCBu434RpmZdYTWzSm_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: block: use single block write in retry
To: axboe@kernel.dk
Cc: Bin Liu <b-liu@ti.com>, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	shawn.lin@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 15:34, Bin Liu <b-liu@ti.com> wrote:
>
> Due to errata i2493[0], multi-block write would still fail in retries.
>
> With i2493, the MMC interface has the potential of write failures when
> issuing multi-block writes operating in HS200 mode with excessive IO
> supply noise.
>
> While the errata provides guidance in hardware design and layout to
> minimize the IO supply noise, in theory the write failure cannot be
> resolved in hardware. The software solution to ensure the data integrity
> is to add minimum 5us delay between block writes. Single-block write is
> the practical way to introduce the delay.
>
> This patch set reuses recovery_mode flag, and switches to single-block
> write in retry when multi-block write fails. It covers both CQE and
> non-CQE cases.
>
> link to v1:
>     https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#u
>
> [0] https://www.ti.com/lit/pdf/sprz582
> Signed-off-by: Bin Liu <b-liu@ti.com>
>
> Bin Liu (2):
>   block: define new rqf_flags RQF_XFER_SINGLE_BLK
>   mmc: block: use single block write in retry
>
>  block/blk-mq-debugfs.c   |  1 +
>  drivers/mmc/core/block.c | 12 ++++++++++--
>  include/linux/blk-mq.h   |  3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>

Jens, if you think this approach is okay, feel free to take the series
via your tree. Or if you prefer me to handle it, please let me know.

For the series:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

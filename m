Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFE22A804
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614643; cv=none; b=kxA4fz5kuQnQuCZQ67Tlt7/Xwx9JP+FJa4CI8Kc+GgxhmidVFdCSj01ZWf/kmYhYnhYmPm+8n8WRcITgfgtvW2sjhFWJcWWGIVJIXS70x9F1GGZ0hRGBwYFVx8v/l68+3Viz9BiZGjDhifTZ2P3qmyEFCu5d93NJu1Zq13gdTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614643; c=relaxed/simple;
	bh=HDSVjBRDOlDp5ZbJellhnv8UG12s5G7+SzNOG7IEdzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ATG3XlGfQ2v6GsgVky9rft1AMVqy/ss8fgt3oW2yZ3sfU1dujMBRyoNnWjoiP8SGsrkC6fTdetqjYo+cS4TInuT27iG0NNnJyx1Rz9MJcDlwz6UIecmJU9CrpWGIPEvCpFhVTNikpKRruCHbg3uk59vBGePlY42U/qifSVn/q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k1w6BATw; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k1w6BATw"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d439f01698so13466305ab.1
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741614640; x=1742219440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yu9eoktnyx7wChYFY2A9SHj9c4UxEPLe3buR1ZnNl7A=;
        b=k1w6BATw/QlxbYSKumwY/1UMiydKTRuqw8BM+o2dGOw3K/k/m7zACz4jO370tBSBLj
         Jd9KdCMHVkwQxDHS5VrtHxltxhwACiQHIaBDJz82ny3ztvS5v9ia6gIup0eSFxGdcNfB
         W1S5cZCYyeU+tUbNoa7xW7HWo/qKIvy0WmnXVN38MWMLRyHrzXBGNUFmJpHfg60AbYH6
         +fMwKwrEWVCpCz9u6/BuITdsyEHkhATyOc/5ZimHmLOsQUsjJrDzaWVcKi4HrPvcJeua
         gcCVP+sOWEaAgQvLcnccQsB7kp8ViWqKYLo73X+sr91mU23KzFKK8HiGiHXSu4pkpH6U
         ggiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614640; x=1742219440;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu9eoktnyx7wChYFY2A9SHj9c4UxEPLe3buR1ZnNl7A=;
        b=wbsLPh2T8DbwmxXBY7you1f3tcKbaZkaGZrkmMOefsSSh+DSS4+F02F3ov7ufqQtHi
         jPy5NcSmP4vQIyFH0XRWVVlGLNYflvrjQNYN7cpY4ZD9zZv/OJOkTXI2sGB1Ym7xKlci
         nyu0lBmCwdAWTTW1pWmC9o5P5cQCbFCd/6f7OXRYC6hyQrfX9XzqjeMqRYNaeSBGQW/D
         gIv/SmotUBpwYtbV/EyDyPsnIUC8bhLPx5rblXc7cFlhYbfMsGbPMNBJeF50vQkwQ4PS
         qr5xWDVdU5hjHcHLLmJIX8ce7YHay4jqw6zSvbxTXRoA89eg8mlSlbw90fXKMk7uh5oY
         xoPg==
X-Gm-Message-State: AOJu0Yyo6wHvXewDl2oH1jq6oPOQHgOO0i/oLgCs17BWFoolCZJWA4I5
	v42+sqnEQ/10raWGCPSXoERlssovQ1DNkpIfhkrOHmGiSZylAISIdNYAgOE15FXe1Yt6YuTSWQt
	t
X-Gm-Gg: ASbGncsydSU4VAtOKU+VdpXYl/7l5FAg01nGMzmwVOCTpaKs5IIoDXSjVClaG5nRHZr
	uhKZ9YnW5kPJJQfa6rHSZ7FheEQY2XgD0PWLQRmjBfHSsNtZl8DnfHqymbLhat85vCDJXTGbOvY
	/+4qtBpP2MPMJDewD2BPzn7clA+/LvdKXVFwrlpuDa+PwYZPJJsoKFjWGErPPj4AA0xwK0DqeH/
	Z2siipj68tiqwie+RDKhzBy/NnB0GQze2XgLIp4U8DsRYzLCJxEB11nW71sUJ8U93ocPx3a/RZr
	+ftNmqkyXxIQ0HIqrhP7H/KSMLcu+R5EDrEtdA71TmklCg==
X-Google-Smtp-Source: AGHT+IFA3G070Bz3e2F4pxV+ytiqksQSn56Sib0NnFK56DUF5oucsSHDNYC1XrxNF9SaEXkzhCfIzg==
X-Received: by 2002:a92:cc4b:0:b0:3d2:ed3c:67a8 with SMTP id e9e14a558f8ab-3d44aea1c62mr87035255ab.4.1741614640605;
        Mon, 10 Mar 2025 06:50:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b511091sm21350915ab.42.2025.03.10.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:50:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de, 
 gjoyce@ibm.com
In-Reply-To: <20250306093956.2818808-1-nilay@linux.ibm.com>
References: <20250306093956.2818808-1-nilay@linux.ibm.com>
Subject: Re: [PATCH] block: protect hctx attributes/params using
 q->elevator_lock
Message-Id: <174161463963.178937.17538366690761311232.b4-ty@kernel.dk>
Date: Mon, 10 Mar 2025 07:50:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 06 Mar 2025 15:09:53 +0530, Nilay Shroff wrote:
> Currently, hctx attributes (nr_tags, nr_reserved_tags, and cpu_list)
> are protected using `q->sysfs_lock`. However, these attributes can be
> updated in multiple scenarios:
>   - During the driver's probe method.
>   - When updating nr_hw_queues.
>   - When writing to the sysfs attribute nr_requests,
>     which can modify nr_tags.
> The nr_requests attribute is already protected using q->elevator_lock,
> but none of the update paths actually use q->sysfs_lock to protect hctx
> attributes. So to ensure proper synchronization, replace q->sysfs_lock
> with q->elevator_lock when reading hctx attributes through sysfs.
> 
> [...]

Applied, thanks!

[1/1] block: protect hctx attributes/params using q->elevator_lock
      commit: 5abba4cebec0a591ca7e7f55701e42cd5dc059af

Best regards,
-- 
Jens Axboe




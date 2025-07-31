Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAD221FC0
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995761; cv=none; b=hPxoZqaAhY/Qr77k/cNGdSum8dHU9i/qZ35fLzh4eiMUtojOiIwOROSm+wvAc7SYDUXyASwB1u5/izlQEuCtNyJOXjOwEh+mH9O4nJFPUPrDlbsa77XbclxUhKE5DW1KmTHEHB1XNhXxEqmZsrIIlW8Qu/yPqpTfYorQq8TrfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995761; c=relaxed/simple;
	bh=RcA0tByDARY4ObUk7TovauqMLjTKoFyoHSCKJ3SgPas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f0NR2RoB7i3Jy/rdBI7t0lKpchu6KrWAtGI2K9UjxQgQNTgRGM2cNjZnuKahRJtMtg9T8zEO9/wT0OGvFXUH8UE+3kT5pK8ASKwDxY9HBKVgj9ENMYSjlfD6IaP1nvBftSk7W1bgAKYPSMSA/21tdXaQKwF5PMfq5VgF5ZlwkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3XzSuTNZ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3XzSuTNZ"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e3d7b135c2so12880945ab.1
        for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753995757; x=1754600557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gUr8m5SYSIZ52WsmwSsgDKmyRCb4DBvYu91qQUUm/8=;
        b=3XzSuTNZV9eUbS++GMUEaaeWXVi1LYJWAOVG1RAROR5PED3YGTqXjiDPvqf5MlWbqZ
         v0SiDwPltQ9iuQsZFAyChPmg8VLWFGM/fgoBWVABlG8bF1tw6DKwGpZd5IPf5NDXboT5
         WcGhRj6Q7uk6/YADmazibe/PAeRD7swWXhDUO999P/D2Ft3YhVRsnQpfbtQlm/OjBp2S
         FMo2wNpbGgHJBxNtebOHnDrHozgCZEKV0/8rcfkr3aBSZKjUhy5i1sLlAXpTRAqmwlh/
         tuRsTnoVvXuaNBvIxbnQK2LR42wxVpt+Iway/WfusEhMMhkUfdBaqAMkxx3AyIfF1oFx
         1hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995757; x=1754600557;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gUr8m5SYSIZ52WsmwSsgDKmyRCb4DBvYu91qQUUm/8=;
        b=ZXlbNYe6E2LzxsuTNH9hIePJGxTnHl6q7acsJOM7VctSZt45EBzQWt5LLNMp70JYAT
         qRNLBL6fKF83K97kI6ppc50bHhrv0qDWJMCWlVUxxGa32WgtfXKOvC6lyx/E9a92GL3J
         dObJ9O90Csf/Lf+IlwdK+MBjfuaA3qV7qBrhL7rAmBlDPy1gaoYlFddd7K/mnBHH4kKQ
         0wng6zFmjmYONNnMjgZ3nnRpb3VmDWbL0x0OcqkM9e/uOZqQ3L4omIy9DIXsiLUwixHz
         aU+cJXU6YwadtiVsxGcV7YW8DKky15dMzIsxaXwzOOalx1E1vgpidD+TJr083Uo2P8Fp
         yYOQ==
X-Gm-Message-State: AOJu0Yy1caHNm//LNqOAumjDdcuznfxjz5eFb/cS8v1rZPteK5wdg1iY
	dy5PgWYAFZDm7x7t9rYg+TZsMIekjvxQlk72PeBI/Fov7fbUjXhhW2scDPYFy1xjOn8=
X-Gm-Gg: ASbGncv/YKaoy7rA9G4OiURvAdpDeDPUTEPi4x44XxtW10IuVd6Q5GWv003ozICCF7v
	izdUzPBgtjU8DbNlZahixgXpMvgoM0PtBhSarnb3DMCByf/8IpMSqcMbVmrKbhLUdwSwqmMJ5r6
	C2cojjUcEBUiqW7zmhJQOku0fv+z73/dBMVlipw6gauwmw0UJGxza4D0P6hGQ9TMV2CLhKoUzdd
	h/a/ePEgPyWTW44YfNdlyH5Ex4wP8T4PziAgWZ7CrhXM1SXXg3DYoAcc7Uoa+7DwVltjx8PVJKo
	SyJoh/zVWYn0f0NuBmJxvuMnJkdSksGAjlIQz6yB23d2ROZfw2oN9wVFJaoPQ5Ib48I8uSJf9TU
	9dg+9upGVZztTejuNfQKYCWc=
X-Google-Smtp-Source: AGHT+IGKTBJ3sVZro7VYcTArmUMzt5Cfe5lJomYqf+NzxdfH5MMjYwXNevqWHFMZdLGqDYewOqQyZg==
X-Received: by 2002:a05:6e02:1a81:b0:3e3:ef06:674c with SMTP id e9e14a558f8ab-3e3f629724bmr147449245ab.20.1753995756822;
        Thu, 31 Jul 2025 14:02:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55df201bsm752208173.109.2025.07.31.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:02:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20250731110745.165751-1-shinichiro.kawasaki@wdc.com>
References: <20250731110745.165751-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] zloop: fix KASAN use-after-free of tag set
Message-Id: <175399575544.610680.6479185198126075216.b4-ty@kernel.dk>
Date: Thu, 31 Jul 2025 15:02:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 31 Jul 2025 20:07:45 +0900, Shin'ichiro Kawasaki wrote:
> When a zoned loop device, or zloop device, is removed, KASAN enabled
> kernel reports "BUG KASAN use-after-free" in blk_mq_free_tag_set(). The
> BUG happens because zloop_ctl_remove() calls put_disk(), which invokes
> zloop_free_disk(). The zloop_free_disk() frees the memory allocated for
> the zlo pointer. However, after the memory is freed, zloop_ctl_remove()
> calls blk_mq_free_tag_set(&zlo->tag_set), which accesses the freed zlo.
> Hence the KASAN use-after-free.
> 
> [...]

Applied, thanks!

[1/1] zloop: fix KASAN use-after-free of tag set
      commit: 765761851d89c772f482494d452e266795460278

Best regards,
-- 
Jens Axboe




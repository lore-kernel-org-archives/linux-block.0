Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1030274FCF
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642101; cv=none; b=MrwmSV1ipZORFd/ljmnJgCSun4B7hhcwQmlABCJfJp5waZD6OUKMNjvYCPJ9A6nRlRfQQKPpuCO88ZgCfxIvUIP6SECml4ORVZ94mnoNOeywYHAkwmlHXv9StRTwcpXSL9PDY0+bmUDMmhU9P4Mvy2N7oQpHCH7FrY55aJ3KAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642101; c=relaxed/simple;
	bh=OX61iL5ajEkSOB9Gc2sJXRUybR1FGvGqiEtt3A8S3EM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LgoiDAp5INTU07sLaBExJ02UlGCoUw5FNKZvcAZiAo5qDM/gGZsWO1tta82rUb9r6qVGk6KgzJoD2L5aaV/YNKI2kqNsgJI6Fvqbp5CFd9Rzrn5SP6cihSpvT87T8YjqjDiNKDFGKmK7BpA7/5VaSBXVNJHe07XsjpYO3o3WwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rYIR3JIA; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rYIR3JIA"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85517db52a2so80228339f.3
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744642099; x=1745246899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVe49Nk2TmzLUEha9KKLJEtMKi1+QER5gyHF2CtIAoI=;
        b=rYIR3JIAWj4+eD4j8hZYwyr29sxBENBdYuwyeYx/4z8HhPXU2L2n0J3KlgDvzX9DAv
         vPGLa86rWNjbco6lFENk24URfqqujnZkiYFZdIK5vWW9wCrMQMC8IDfOlL4eSiWvUyvR
         OBFJsPerNv8JXm19rYdQvqj0z948iktjt4nHkOAgAbZPhsBZA3DVqhr7VQdLDe4+Nkge
         M7oulcFtczLrUQAV3nD1gMBagec5OAH+u5fnHWCsVR6g+RuQnUyaY5WylbvCLs2+aFk0
         YVzw9yb72lXPUwNMeL4dpDY9ke8Z73Hns/CHqZquDzZnoP1CC0e7j+imiW/deAXcqht0
         UHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642099; x=1745246899;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVe49Nk2TmzLUEha9KKLJEtMKi1+QER5gyHF2CtIAoI=;
        b=UH85lAiHitWpN8aUsiq0fMwmRQEv8xFWzydEOw6gat/0JX4a44BNc3RSlb2kUqAmGz
         cS6djqw9ebcueMRGpEYfAQIgl0+48crwpKv14Gxy9haLyO8FYlqAAMnkhkGs/HIS1OB0
         DyWz+yw2VPdobznyS1KS1qT+aH1P63QcIX4vjmPKh6VcfW0qxxYS4B8xBiDov935JxKK
         j+hAfNd/KgSYyUt7oszKnYmyJZAF0cTasd6cHuo0FW4fKE0nCmzLGnYOv9spQai9bDGl
         kajRZpD8WOAsMob+s2ro9aj0wF7MpLndZF2r2pgDOVxlfncCH9kSvUVwO02B+9SDy3D0
         Qpmw==
X-Gm-Message-State: AOJu0YwQI+S2uO1OPrXj4ep11z+3539+4oIHKfvA7/U9AXgMxtZEWWjQ
	4+nERyGwGpYpMR6QmdEevjY9tm6urSvsN9yG7yY26ZoaLoAoA9lPwRT4OemAiLk=
X-Gm-Gg: ASbGncvN8q1uuPzJTKvyDIEcBGVlw00Dwf2eFdeFVzH9qA63SbIEEnYGr4dM4otIHrs
	74R7uoeKu/7Mn5unCw9JOu3MG9VTjCNBZVU2MGgOQwGRID/Awsnf2f73F1N/4C5oUrznFW+5IzS
	eQk50eUvVFaZSP/ztv/mjjNl55kbA3ZwEFWkDDJNHXMXO6Yz1XDDKZuULXx3Khhu8k/GUsNC9QL
	Ka/uVCIBkCrGO8EDNNZ2tp8r/70G8XiJqQT5EHddgcOCUbz54EB8rsrnYvIsjvwE5LHQFHGhlRr
	NjXHxJHzpoXr1DyZeMcKmroUJvN2Ikp6
X-Google-Smtp-Source: AGHT+IHMgHQ/PWSXNiJrO8XR4AJL92k3mmk5jllOyjLCPSVCmuI4teb9tUAQPnkC1LlSiHdRflNUjA==
X-Received: by 2002:a05:6602:b86:b0:85e:8583:adc8 with SMTP id ca18e2360f4ac-8617cb5e00bmr1416478539f.3.1744642098838;
        Mon, 14 Apr 2025 07:48:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e6bd7bsm2569671173.141.2025.04.14.07.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:48:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, bvanassche@acm.org, 
 Yunlong Xing <yunlong.xing@unisoc.com>
Cc: niuzhiguo84@gmail.com, yunlongxing23@gmail.com, 
 linux-kernel@vger.kernel.org, hao_hao.wang@unisoc.com, 
 zhiguo.niu@unisoc.com
In-Reply-To: <20250414030159.501180-1-yunlong.xing@unisoc.com>
References: <20250414030159.501180-1-yunlong.xing@unisoc.com>
Subject: Re: [PATCH V2] loop: aio inherit the ioprio of original request
Message-Id: <174464209412.57766.10723552188963228525.b4-ty@kernel.dk>
Date: Mon, 14 Apr 2025 08:48:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 14 Apr 2025 11:01:59 +0800, Yunlong Xing wrote:
> Set cmd->iocb.ki_ioprio to the ioprio of loop device's request.
> The purpose is to inherit the original request ioprio in the aio
> flow.
> 
> Signed-off-by:
> 

Applied, thanks!

[1/1] loop: aio inherit the ioprio of original request
      commit: d8ec13ceb917611582b52ecc28c34ddbb61ce0cf

Best regards,
-- 
Jens Axboe




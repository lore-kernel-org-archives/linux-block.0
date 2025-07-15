Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DB25A331
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603185; cv=none; b=drqBZL3V/OtS9ntWGO0IuHm5V2SXhRQO/WTVXIFWKCyR8chKgHY6R7jtNg0qM/54e9v45RB6bl8qpux3WpQHtz7i7qNIhSrP4uzXypepPcSqysCh4FeiNUOKcDBhl/p9F6AZ5sP3goE9Yhl8ug5u4LayZZuZrXqSfmYZEd9fIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603185; c=relaxed/simple;
	bh=EX9IJIBE07MrxbjNekDEu4Bys7YOOtxBGSxYZ5KqQ6g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W2z2vYlmUOb5798m3iNkW0XySAWoBxUdh/YKra5LNN4G1US6lEfKHVvyOM72YIvbiAmm+qI+X95B+TjQupZZmaKQ+J6fXqzn6sWkwVJVJ/KWpfo7KuDDxssBj+WB4rFkBesnvBVjnUAMiiTUYAcr09OItEwp03A0Lucssinn3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p726jWpe; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p726jWpe"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8733548c627so208565439f.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752603183; x=1753207983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD0vJ10NkjciUlBMfv/7NTn82Nio+gQ7e7sXbXu83co=;
        b=p726jWpe5VN5//j8xoDpI8DqEmjurbXosNFytWunlBovxFmm47TgX+8/WStOMS6mlv
         v8sLWU8E3r4NraMW8c7prvso8UucLrTrLVeaXUaJ9REBmRwfmgFSpo92qyeFReEMWi8v
         6EP0Su7ijnQMn+L0a/DzO7cy+qwwjiZCRY4EYmFq9kC+1tHXqKiH9IMig8mXwyMRvOC1
         VYs6IhdvUgeo2stGRBLzue9G+TfciZoPtfdzqmm6wd0q9a6Dem9vvaQshAY8ekoJ4/xk
         aVITGImBGCfSJN/Ta0eQdGoLFlf3X0HogiQbIdh2mtGQrNkWsCTolFSbG52RWbY4NPXR
         m7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752603183; x=1753207983;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD0vJ10NkjciUlBMfv/7NTn82Nio+gQ7e7sXbXu83co=;
        b=vZdyKIXixJ0xxjfk0DMNH4As7gRmh0xMPTKJnaB8I9tOgO3KozRplN77RWjJ6y5sjK
         VaGnfxCJhLMzStGZhzW/RZ1MUQDNGNKtcJURbxbTQDOKMK+s6hOthinWdSWAW/DOuf9O
         W1kfMZK1/23oMFCJpXvYis29lMNuXYurSr5SE/MnnYv8j3EkYRgIrg6PEtEnk1nGagn5
         pgSSkcDT+yEavVTah0xrDCqV6oI2y1tEf3iHipb/lHy3iEItPzQs5pSjtOGOebMXreoe
         o1j4Sow/73zciuTvCVPJyD479RWjvixzgMYj/yESLJvcnsW3sVIiNr86tlJYg3YkAdMT
         W2KA==
X-Gm-Message-State: AOJu0Yxo69niOetAOzFz7QzgtWF5kFaNnW2ffXHGbCF9NAiwIxMWpxFT
	vJzHDapsFKoK1gHxRsAYLgOBzPtH+2/dHpTaesEW5h85IhRfJpwQVWofwRDk72Xr9hM=
X-Gm-Gg: ASbGncv5+xaoHfR97i7Plg3LcJEZl1a5NKQwXcXYNTuiVW74uvxr83bJMjRtKtxO0i+
	gO5mGAefCUZmgHc5OxMx+3Mh2W/YMPcnBvTZZD6wFamQU4Lbnx9gq/GUDpUAw7ZTsrbj1LiyVXT
	bhMkhb/Vymj/GxecZC5ubQn28bNkfTOR565MbhAyxfBnIYTWh4nVAoxdubsrZPmraDf1mLimfxU
	CiOk4x3NdorEuiGcJXn03KTPXFIK3GoD2s972Pq45dI+oUq1hpr8XfqZO9GK5lKquH2OOIYeaPb
	cRKRyhf4cDx0l2foxEF7a+P+syHBz5JrhjYt7ZI5RGDXqJUFLsW6GKPSo9iHQZuuZo9pFBm8o14
	ltz1cjfXW0hTf
X-Google-Smtp-Source: AGHT+IG552JG7n4td8lyOkEY2AdLnq++1FllxqUqpHx566DhENpB4MIn3derfPlgLwY/V4STyhuYIw==
X-Received: by 2002:a05:6602:14c5:b0:879:66fe:8d1e with SMTP id ca18e2360f4ac-879c088b6d9mr51206239f.8.1752603182765;
        Tue, 15 Jul 2025 11:13:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796bc1313asm318097639f.28.2025.07.15.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:13:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250715154244.1626810-1-csander@purestorage.com>
References: <20250715154244.1626810-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: remove unused req argument from
 ublk_sub_req_ref()
Message-Id: <175260318198.192467.13750945616516417106.b4-ty@kernel.dk>
Date: Tue, 15 Jul 2025 12:13:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 15 Jul 2025 09:42:43 -0600, Caleb Sander Mateos wrote:
> Since commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()"),
> ublk_sub_req_ref() no longer uses its struct request *req argument.
> So drop the argument from ublk_sub_req_ref(), and from
> ublk_need_complete_req(), which only passes it to ublk_sub_req_ref().
> 
> 

Applied, thanks!

[1/1] ublk: remove unused req argument from ublk_sub_req_ref()
      commit: 01ceec076ba10cb6c9f5642f996203170412cd78

Best regards,
-- 
Jens Axboe




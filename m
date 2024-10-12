Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806014B081
	for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770322; cv=none; b=R6Xiu4AqxqmMm8ZCpsxBpkAHFXQVdC9pZOdbeo5iVpBua4908Fvewauq3lIqUqVnGoZro22RxAEoBEa0Xbk0LEwRwy9D7oO4r0FAI7Hk0axR7RoeHIhCEwsbxlZeV6PaG9qBQBUySQvXyKHg7l/XGrxTFjzm+Hm5q3hKAcTqdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770322; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=ZESa/xheKkze45a8nodOi9mi6jZAEudwOjxVmhwApQWXKnJZtnYt8nKgGKKeUz/E3UHYSQqLWEbjdq60YfcPK6ftASL7aMjf6i/mNciRTB0VD6C9b5ysLgV0p/lWEgRvn8NXClTtG9lMRkaOMAZqqDnBXyMNQVP4mrEqL7qr8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnL96PbG; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnL96PbG"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71df4620966so2800417b3a.0
        for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728770319; x=1729375119; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=QnL96PbG7eyACAoDyruqJf+xK4LX+tj9jm97LWRq+9B/Y+K1B5bwwxBvOzfZ4Tfdfb
         Q5SoykWU420+jlZcl5NdiBFEuj7DrNhI/OwK2ThTvVKCG6NclFzRDGbJiK7IUNcl/gRP
         hsDGHWkpqOqb46T+kToZNBDYAwfykntbSdHsxxNxFz0rLHamkVRfZP6pnRmHTMQosAA1
         wJnyxKMkpipu7KSSoOQiEqL5pA+AStaBTWLSi7HtA72xXCZXW54hRN2MVcVddPIlEE29
         PvP/dfppj3qfmkrnVMWnaiBidYs74KEMz+SHwqTj/IlFBFP0zlIbbZwucUBJ2064A3rv
         +buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728770319; x=1729375119;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=E+xSneuguKGV6iP64T/aPolcPHRnV2sCqRe8Qb00UZ5zrt66CGHX2hLJtKSt028YoU
         O+hpxsJ4IImgsnC9RzX9zB2bEGwq4rWwIT5WDeuJqKy0UhSA2d7xMZ0DBqTPK2+taDPN
         mCaW8HQXLhlz5cYz7RBs+ijDQI5n5LKp6RtGREuAsSstTNkoWqrwAlDzM7w50g0FpFcz
         Pu12nY3vm8xgtjA3k+v+cuME4FHB5AV4DKjFQj+arF/ZFGTj97ynVuO/hc7t+sAajMz7
         4NVuBjlpWpGHjgTngV5TN4jQF8k/dvYn/t6XUP858eeKeDxLimZNV61Eh4SesWHtiMSl
         G13Q==
X-Gm-Message-State: AOJu0YxmY3vpLX9Nfhphm7oqpKZGFVjpasOAv9qfIz4WUA4nHvBcFcrr
	DTo2tRbZWo/67rc7w2m9GFpLJsZJnl54oYMtnhx6zf3rUXuBNhJiVlHX2j0r
X-Google-Smtp-Source: AGHT+IF7GAorPX0t7z98sppaQ8q2V4l4TNuPWYHZXRl45gjijkvaK3e/YThF3bCRC1WaUYBDbV/hBg==
X-Received: by 2002:a05:6a20:cf8a:b0:1d7:5b6c:303c with SMTP id adf61e73a8af0-1d8bcf3beccmr11032592637.25.1728770319489;
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e5da00730sm67981b3a.15.2024.10.12.14.58.38
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:58:38 -0700 (PDT)
From: Josey Swihart <njomane286@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <d5d6de0cf4a29308349b434bb837687a4881b978cc86e633dbfd25f9ce8d0de1@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-block@vger.kernel.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 17:58:36 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey

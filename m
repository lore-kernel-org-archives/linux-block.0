Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BF3090E4
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696952; cv=none; b=ELXa21Xl9IvbB6PDbVFDJSsrGIwNBGjlZ7Rx8JxFOgP5Fb6EyjEFOu60P+C8vOb2DgVm8hd7KdpGRx4mRKvLBdoGCW/hLmDQ7wBYr2wFszpi6vAcpumV5Xu4dIhF8v/95Ab+RKNagYdrb7ctjfBLd1d5dMH3E/ykEtmK/S8g6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696952; c=relaxed/simple;
	bh=ldNN7TPiitMUXj/K/meNw1Ywd+KTahnUn5Ex+h9BKEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2U5JSk3szLR5xMgVqsEW3z9fwrbx3Iq4+lNd6auViIsAVVOvu/T/7SwAstATRx7/m3tA5SLSowObcuuunAKA49a2hHHZyrg1aKtPulNdpo/LUVJIgZywB35P15/3QkYPDy1zhjAPuAAZYJgS7+myThHg6hevyDLeMO9xXsGBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE1ZJmKm; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE1ZJmKm"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9412512e9f3so240091241.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 02:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696949; x=1768301749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldNN7TPiitMUXj/K/meNw1Ywd+KTahnUn5Ex+h9BKEw=;
        b=CE1ZJmKmYrooGU+MKf2R4DmBRt7fXczWPQ7HqycdAqV/lLSCQ0X3lbwijTNlIGMRTp
         4r9agC6HwDY2QsizbtOu40oijQruYPrkd5lQZtDOLHyEvd2Wah3tClbYG6KLF6FVvAey
         vYf/pYFSOlKJt1ffLi/T4UReMEmOU5ucwPPgsnySUCRNZKVGyL/eiz9Bzn3sHXkD5+3t
         9g9kvTlA/JDIoBKZ2/uTg0aZCxLXaJy9AR076eO7W3cJD1tJ8MmqPv1d2KlUBL+LDH2N
         hVwLlD9LMb1VctCZ9w0rDHPVrxB5l+3J3P+s/+PIVtDrOavlrnv04ZdQo0Rs11AbyN/d
         7rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696949; x=1768301749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldNN7TPiitMUXj/K/meNw1Ywd+KTahnUn5Ex+h9BKEw=;
        b=i/aoNTktiNszOA/0aIEVO5a9w5aKR/mYfUVzCHyROphig6l69IOGUrsKbd1+Wcfx2r
         DYE6g1ZDIMx2+042LnJzB0LEGX/CEpeIGOywhxqkTdDeWUTii6SnCYFwMQblONb8c6KK
         yC8evBKg9D3sAJhT8fJt2vNLW5CU/sm0dovhWbAT69it9GPH354wlX0W3efQWWHRjqK3
         zM5DpGA3TA9bwPSRsBxg8KvdLxQ8VYNy5CTtMym+IWkeNXPV/ON0cTc/c3OvaiBrePl2
         RA6VBbUGIU62hv0WYICmqJOFYmAsNeFAVpDKKe9HijzFHIDCedK3U+WSjfp7GLS85SsF
         /iVg==
X-Gm-Message-State: AOJu0YyvkxJAgVdWbWHjAfiNDQVgb8szcMRji0gUTCDU9N8jO3q6p70h
	0xfUvH9fGHLkp1LaEB/yImyNTHzJLH2zTIcCylmuyfle1e5J3Vt4kV6UulYWfjvY40+rFWc0XX6
	2oS5UNQfXv+R1w0X7e1NzOXI8E7V8Klqqw5FM
X-Gm-Gg: AY/fxX4ybQ7fnp39zoCrMFNqXOwxlY/f5WQgIrTY0QgM6KxSN6/Tbwri4v2trfk/bIn
	uVHolKU90w5EfuSQMddH1tZO8odghzIkE/IMCpCSwYVu9J3flKdJlQPLRa5Mgghc3pCcf6o4Ztv
	cglVVBkvaWpnJYHqXzx9jSUlrvdrNppDOBRSQo0MfBgrIoZFBPlqG5hKhga8CassHyFuNhUVw7y
	ybHgfXqUgSlRga834RcCJbZppjtfhMxK+NZFtKiy/ckrekHfu48wojABokmzWlZabbatj371+Ki
	pIruZR/+AZh2B038EjtgLpGhmiMm
X-Google-Smtp-Source: AGHT+IGFoH9Y84rpaN1l+X8UZbyzkaeW4wOIDyKYcl6PbmM/WLSSLClvmnVEPUgHWsmN62CLL5qGP1Eub91pxNSTXvo=
X-Received: by 2002:a05:6102:e11:b0:5db:dd12:3d16 with SMTP id
 ada2fe7eead31-5ec742e6215mr607418137.6.1767696949542; Tue, 06 Jan 2026
 02:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqquxezUTTQJyo+dpbXEUdg7iS6GnQbCs+ve_i-Qp5MbiA@mail.gmail.com>
In-Reply-To: <CAPqjcqquxezUTTQJyo+dpbXEUdg7iS6GnQbCs+ve_i-Qp5MbiA@mail.gmail.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 6 Jan 2026 13:55:38 +0300
X-Gm-Features: AQt7F2ovahLl9KL2Xz_JUwgXquri70znksxVq8JGoQtF9ppZ5HGcl0niTpSm_SU
Message-ID: <CAPqjcqpos-RE5BF8To0BXkO6BtL2oNADTEa1qUzpGUGoNQ6KiA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> We don't support NABO != 0
> Also, what do you mean by that? I look here and I see that the boundary is checked by the NVMe driver

Sorry, never mind about this message, I confused NABO and NABSPF of
course. And boundaries don't matter a lot anyway, I'm not aware of
real-life devices with boundaries.

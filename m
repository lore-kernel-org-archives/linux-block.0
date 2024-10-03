Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EB2232A
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945086; cv=none; b=oOU83cWLfOmIyl49fjULe8RZ8kBx2+V4GRXDiwOB7/Z86yJEDFQGcwnop/Zed0wrI2F6FM7IfRlZC1PklDvjKEX/Rqp8pzVzlL4pWRbOmbcswFR2iR5jsmaWdvGAP5BTZ531Vkqr7zFood6T9pVC89sWNvYG9u5Bg02XNlcOT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945086; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEY6N7bkS8MBXutNwbwfYlYlC+FN1efVHG0OpAKuOrqa0ExBvCMQVbC+fttxkyCmAPG4R3VQrPfYUM9s1X+5bW92eFlYRih2OSfULaO8DUrZlroY2KkFVDIFsYVVYliyhj+5k6XXPfmpmbg/QTdd6PsMhbxvwSG/iiqK5CbdmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3wjpd9i; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3wjpd9i"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-502b6e2a0acso213944e0c.2
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727945084; x=1728549884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=L3wjpd9i3OlcMopyqDKR6PV5kZ7VD6P0nzBK9Zhes53r5AS1p0QP0XFXOmm5L080xM
         wBjoVRrgyQkJ5KDl6BHUqnVDoPuY3ZVy0CUzvoSbvSjCATuc1ZXn0Wrj7xVFYZztfT4/
         HChLD2Vx0Osma7ZL2VFCE0JkZAwu35/HsJt1vQRMAbRtxH63CjxOd79NJNr7Ssmj0Q0B
         0F+Q6OEVNhX7pH4DFMI5KyIO5Gn5mdhpjPVrcOpZdIXiQyXQ6I4PNnyKXYRtBgVDTokr
         DdqwORt2VOjzx/mATdTf7GtknBekFrrMFEob79LkQZRz8+fMbdu4kThGDzjtEYYDOMae
         3crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945084; x=1728549884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=XFaS2RZZ4PDX0AigJHt93MvqEU3kLC7CNh00TmPpBloYxodzlPVC41C7ozbCM8A7D4
         DjprFPnHHgTmVUG8UFhm14YPTlYVcLnlTEmdVyRNkBuyurKnOWQ6aumqKyh5GB3tdMw9
         eJdLzwwDBShA+4+DXFY93jfVs54PO8Wz8o/HdQ2qajHj21knZQiQj2CpnbLecPearNTX
         Y3uhQCzlJX3KNOTtzFTyrK/P9bpED344vyqSTMdQPIlSaLolxnlWhvTB6WM+UQxd1+g/
         5XG8YCK7Jhq+B4d2IsnB3JuyZ6dP181mdZlOrqiX0TlSTizcy/ehpxkTivDKDxP/Ykkr
         OXow==
X-Gm-Message-State: AOJu0Yw5KzQIwMAQxo4Xq6OwXaVOtSkvNSNt1okSjK+UlqtMwcPjnr3U
	yhuM5w4k/tzq1w5FYZYHyPkQ5C9PQAta/IArvFpCHq2udlSACd8czti87Jw877VGmXmVq0cYM9O
	qaVSN/wjrElHoZmgz882fvFb3MA==
X-Google-Smtp-Source: AGHT+IEFOkekfj4m7odFp2x2hP72EsNTkGdvddfZnTB4hr0TXFbVXjhy3ws57J3izmFSIGZMTiHl7sbocVtJR22UIRQ=
X-Received: by 2002:a05:6122:ca4:b0:509:197b:3e6 with SMTP id
 71dfb90a1353d-50c581775femr4651185e0c.6.1727945084186; Thu, 03 Oct 2024
 01:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>
In-Reply-To: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 3 Oct 2024 14:14:03 +0530
Message-ID: <CACzX3AsfDcpr9mwmApMvxwC70MG2ixh24x=N7KyMg7yFs9na9w@mail.gmail.com>
Subject: Re: [PATCH] block: move iostat check into blk_acount_io_start()
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

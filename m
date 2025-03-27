Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C27E9
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091807; cv=none; b=fIoweJFkoAwr6FrQUIRlPfeqLiPxSvFnDxgyqTfhc5b3X0EkIXv+A/j+eFhLVuS/ZEWlR5o2YSBENH3H30xyYnb0orsSZ5o3ne9CwywaFm7dcIRDAf39QqwAcDlA8NpjcJ2QJIvhA27Cs4r14uwQ0ca1MWcIBkIe8viO6wWPlJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091807; c=relaxed/simple;
	bh=oYcVLKug1NvbCWc6YfNenHP8GX6nNXCZieGYqtS7aH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=am0UR69LB0U2LeMYGSdBDFXisprF/z/BVc9zXPyZCRzodiCWMG4Eae3p80qHbtxoIxYxk5ZwmxXYEGTUU9Bqyjce918R+n/ukqGtMAm15VE9260Arl/GAceYDeBKDc9lm58CNa2A7itw1/5otYuQttzb03t+mWV8pU8BFbQaYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ekHAKlwH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ekHAKlwH"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301a6347494so268477a91.3
        for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743091805; x=1743696605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYcVLKug1NvbCWc6YfNenHP8GX6nNXCZieGYqtS7aH8=;
        b=ekHAKlwHs67AoE+PMjfgeba8K1wfYaimLxXXAk6by1aQcPwHY+IRTIzADvkDNGbiyp
         EpknPQnvSlJ7L5cyIjReGwmk9qOKNCULMhsv1dUU2cmDagsXiZWaoEHEkjfGMfx8cxtq
         MykGcfD+ulfW7/xoBEkIBNwqnomCSJBg9k4DjjCqml2KBvnhj9kqi/Tlf+c3Spbegy3w
         tmbOiGaeKXOEb8zFrHbo1mXlh4jDP5kwQMw8lN4tWf6aljAVpty7snwAQRblgxvu/alB
         fsvPjjMcm57pMuEb858GfZDbvEKvlG3LXicObBRHiDgXi2H7aYmSTKFWY2n2qI6dtIr9
         sxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743091805; x=1743696605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYcVLKug1NvbCWc6YfNenHP8GX6nNXCZieGYqtS7aH8=;
        b=CwpHKqXB5e1jdp+A3xssePpgVU7ek8PJtgldXUiU1SYycwrKZHqRa6fN+JAZWTAtbM
         wtPizdN4KkU2gXRZ/jPb7K1oVPNxCju//kRbHtnk0TTS7lectHoCmID59xhVGECnfkU3
         C3DyXOcpHZE1UtHalKRNNf9St6iXES2gjzEXcpxGxqRwlv0aeArKNiXM5A2gtEmINAcl
         pSLZVPANYIGZZfrR/Y8T+aPcyYobPiiVK5OBLXFWf1YofV3QbB1H1pXtMk2Lzrh08o0t
         gLj5zKhISEit3bHfb5TeAdqQsCVTxwV4scx++uMtn0LEcBrTAPwKM0qTTytSjwK+eUFU
         IZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlT7XgLobpIRIdl9rQXDxQ9d3Rrl5BXReHKiOQjR9pl+Yxkz1tFdZdlTCLO3o3yhhP/ezPfF9IC2QE2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdV7+WZN6d2WiFCAMzZl0v8si6wf661XeJbmsHKvvyGeLGewU1
	FSJnw/KeLx9fBXmwcGfB8/y5joyOJmNbM7NdJ7LaDTU9TmNs4z9ezJkIZ8unws0gEXSRvTntePp
	eSGkkxX48GLbLC68mPbAJxPKfb1oBfVIjyrCCxA==
X-Gm-Gg: ASbGncszm0kCFWAA0ZJ+6OoUtAeRr0KDEHeJIzdiiO49/HAm4B6/WlGr17LxZI8UFQE
	cv36Xbb7jEUjkyFbDdL6mGQhkb+WZe6kbX4Y1NHwMWtDR1p91NSoAg9x8EULCCYR1yY1PWt/+wR
	AgZWAJ6Z6eOPzDOvWvU1MFPtTs
X-Google-Smtp-Source: AGHT+IEeMH0CdA6HrYzfY9K6PdlZzeOV6sDhFCrq0tJotsdefl04/mHBzwcjPpugyVI20NSSkx56dJRdd3habJ4jva4=
X-Received: by 2002:a17:90b:4d09:b0:2fe:b879:b68c with SMTP id
 98e67ed59e1d1-303b2754d5amr1790462a91.6.1743091804533; Thu, 27 Mar 2025
 09:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327095123.179113-1-ming.lei@redhat.com> <20250327095123.179113-6-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-6-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 27 Mar 2025 09:09:53 -0700
X-Gm-Features: AQ5f1JpIYXfr6QMbLl_c4iZ-ARmCuHN0m9d4ZENpnJ2-PcbqJKp-nH5RslNV-Ag
Message-ID: <CADUfDZqi7oOvM0his2Jth8XG0S=NZUUriBFncX+fZxn_1pBKWA@mail.gmail.com>
Subject: Re: [PATCH V2 05/11] ublk: call io_uring_cmd_to_pdu to get uring_cmd pdu
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 2:52=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Call io_uring_cmd_to_pdu() to get uring_cmd pdu, and one big benefit
> is the automatic pdu size build check.
>
> Suggested-by: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

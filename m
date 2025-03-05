Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74A221F05
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185930; cv=none; b=eVZHB0id+fPHfBRiirz+h/I6EKSF94a8kRpMm0mDYlR/TRnli5lwGb6uAtyJRYp6vdI6h79DH+ytlK8+ssnKRcpSj57mLKeZNiRo2C3RhX/C0l9eBHSp5wB7VfbvW4PXGuc5mM7JEQm4c+bEymIRyJzn+8VmueBgjw+99WsLtDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185930; c=relaxed/simple;
	bh=Cmk1xtK9zj/mZKksRgzAj6pkbkT0aOMNt6bwRChxyTg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X0PET4IZNa2t2Z7n+7uQkfHZYmgVVBU7C0RNuKi3ubFPc4vhfeKuX8ZAc5fltLg8T0fvNde1MnwGg4ZW99omzJlKYkCdNdRDzT0L3uZolC8JZDByqpjvIfkBHCvMD8Z+o+yQUFACEraMoIdZEGkgu/tsBf6ozPFN+A7AT1OgGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GpPv39p7; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GpPv39p7"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d2acdea3acso20517095ab.0
        for <linux-block@vger.kernel.org>; Wed, 05 Mar 2025 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741185928; x=1741790728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mtFeKx17Yutqyl4iJJ9qPun4qwlSidhHSO6yuTK2pU=;
        b=GpPv39p7F0jzsUxYCnv0nOJcQ9gfdwlfXpTmD4Q567NUXMLjqYXSHZIUnRQFlgwJAl
         rRUpaVegoC5lloIXI1KkLJvkMWE9yaW7tWspFYimbzhXuDVD6ZvgQRuBZgxB/kdOvsDh
         rpRj6aZawoHM2CQzhk8tHGFVfODLP8scexxh5HWBS3ejchXwQzg+bfW1QYJ42vEdApQ4
         Rdxn5hwPf2AFWaMTwx0sGJevA6ZfD2bXABUz8AwXQe/KHzP9UGO558mCjIK0kElq8AM0
         p8CXXGFAnaBNnumJ3qrr2QvA9crMfUKteDhIj4qqInFcr2Bav935LFr0FykJqFDCOQ8P
         bXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185928; x=1741790728;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mtFeKx17Yutqyl4iJJ9qPun4qwlSidhHSO6yuTK2pU=;
        b=gkJ3wYQbsEYc9YP1wnS3EEhsSC5hIJ/dYieeS44CWafidOBKTDP1mNFz9Krf3sAj+U
         k79GZrleKsgAI2CC2AjMIouK/CuE5xH4n4bjq8gcGYq7xeXfrxMUCtL3kqqyH6YviX56
         Y2BZdGTr4HkxO9dimQQ2fy21JazEuRcNrpBgwRQRZN9B5r7+Fs6XEhmVerN1N3x2Vvk6
         6QN99ekVt9wgnyXsd6VyHgb6oXOXDxtkCwiAAo0Ntu+HOHF+DYrktvYWVbo8RPkI369d
         ZWQ0Wbcme3fVanwmNWhlzpBIyDlVBS0UxL6QABvkxXjMoKMKVrqsW/omqdJ57tA5XgXn
         BP1A==
X-Gm-Message-State: AOJu0YxRTSYDubljv/8vu57NfU5LPh6g7i2gTWdCtg6flgct7u5JKUx5
	UXmlyoCCpB3gU3nXuvmZOsdpUarmwGRZLBG7Ira9mIizz5gr/g0LalyEA2A6m8w=
X-Gm-Gg: ASbGnctElgRO3cSO8ZwXlEEtAHx8CqkXE0tERncr2FRX9GuxGFjsIkk/le0XV1nQ3ue
	9H1S3fMZkw2L9edGALqc7qOnm2l1sYkOkIDT21ijaQSbTux9qvCTMA42o2HX6HQgoNpZ1nCvo6c
	j9XPi39FfvPIucDJjS+EWlIPyp3op/EM4sxxkGYhtNhbdbvUYtlsI5clFbliBHysZGawQjqw0dX
	nzQ3SV2lkbn03HgxvFpf1jaWj9mh2U2xqfYO/An61hbSZpl80vO5txOLWoq9JiIoYA2sOMLvfRn
	X+Jexc6paaixURJ1I94V0ykRdhM9l0MdPKc=
X-Google-Smtp-Source: AGHT+IGsBmYSs3QMp0F/1K4jts+fZHuzb1nFpuhkf3zgDvndXF+r7uxykpB9Nima3gyrxwD3OUT9Eg==
X-Received: by 2002:a05:6e02:18cb:b0:3d3:dcb8:1bf1 with SMTP id e9e14a558f8ab-3d42b87f6bbmr41882915ab.3.1741185928232;
        Wed, 05 Mar 2025 06:45:28 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c07b73sm3585381173.23.2025.03.05.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:45:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-efi@vger.kernel.org, Olivier Gayot <olivier.gayot@canonical.com>, 
 Mulhern <amulhern@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 stable@vger.kernel.org
In-Reply-To: <20250305022154.3903128-1-ming.lei@redhat.com>
References: <20250305022154.3903128-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3] block: fix conversion of GPT partition name to
 7-bit
Message-Id: <174118592720.8596.17751872254586866019.b4-ty@kernel.dk>
Date: Wed, 05 Mar 2025 07:45:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Wed, 05 Mar 2025 10:21:54 +0800, Ming Lei wrote:
> The utf16_le_to_7bit function claims to, naively, convert a UTF-16
> string to a 7-bit ASCII string. By naively, we mean that it:
>  * drops the first byte of every character in the original UTF-16 string
>  * checks if all characters are printable, and otherwise replaces them
>    by exclamation mark "!".
> 
> This means that theoretically, all characters outside the 7-bit ASCII
> range should be replaced by another character. Examples:
> 
> [...]

Applied, thanks!

[1/1] block: fix conversion of GPT partition name to 7-bit
      (no commit info)

Best regards,
-- 
Jens Axboe




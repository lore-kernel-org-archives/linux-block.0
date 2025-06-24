Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813C26CE3E
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782204; cv=none; b=E6LyLc0giCN6XJYBc9GNqEIh4leS+kVfd8dLJaUaTqovWIuIKP8rxuX8pAZ9O7ANa15syFg23p4UQp2HgjADXDbpHE2GvTqiAf/cVFPwLjNSVU+ZZm+TfTAcCKr8oFQz3kX9CgbfPVkuxm3mgtIbfqSgfwM6x3mrhC4hK7xTVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782204; c=relaxed/simple;
	bh=aDi0Vgk14N/TErecWOoe3YwY4EFuJq93N3qyc/izNu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GrdG3XCGEy8jawXt9CTHJq4kEfR7Txki26fWiI8W3jc1EYWQRdcVkTCmOF7IBCJ0phNQ96UJLOky7608kMoCaVPXO2CA1ddpTREDhUi8CVIEpCgit69EH7F15qmA2pGQar/NxoXV85q+jJQIeQKuZImLIpQ+T3XrXJ4yFHsiiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e1DU5eON; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e1DU5eON"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235d6de331fso81365905ad.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750782200; x=1751387000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDgIzz0445rJFkF9WBKjKIssJY4/maEq8KVuwWNN4jk=;
        b=e1DU5eONJohYqN0/OTxvRHBlqmKpRexmzvr08sXbGeRsuwkV7oGfABlQEOfgjqmShz
         TsNlJ764ix2347C+pTyxa0VIqI1/dM2Ng96z1wxH9nmJNGgD6hB63LFF+EYKMSkUWqGx
         9gu+1+UoFDvwg3PbV64mxLfjz2LNeS0P0ojj4rXlLuK4DDdPpFiPsEbu6bKVBx5o1BLV
         RQXk+dULZdL2YZOLnNkZRKY0dYXxdbp83rtvLz9EWVfl1FaoH9sq8U6nqIy44d/OMMT/
         cKt6QkLAr4S3HrFp9jsuAhNMvk0qVdMAPZ3cPnKb2bLwhajeEy6IxvyF43NvNsWV3mW8
         h83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750782200; x=1751387000;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDgIzz0445rJFkF9WBKjKIssJY4/maEq8KVuwWNN4jk=;
        b=m+81KMGanRt4N9KaxdjT3eElWdd1fA/gM3bNKS2/9FsBaHS/8KzFRcLzoF8g6ZTzTO
         8WSmiDcDzikiYGmqcSZxC6d0aupL+uKbSkXMmnIYz18x+C3nppklbs+krQkclADrvRic
         i1dWKhS0MF5sLDIa6io7PKFbYJ2Yiz/+najoIqzilrEkcVzvrebs7r4gKdtQeb7bsdLW
         gYGAM1/0cznl7jOIUtNjY1yF8N2/gWkwdnKJc083kG1KqJYPbtVb1HW+5UF6HsfJXARp
         UcN1f2OB4bvvbipdomtDcWwvA56iBKPyH+VlnTZyAlbXy5jebMf0s95e4cR8vFw75tOZ
         +u6g==
X-Gm-Message-State: AOJu0YyKxy8gWx2c2RWBbYQs1OCXg/uiffkVbA717bKkU3/2NUf9fZpX
	qlDNQNYYCYz7RqffrF3LWhR0gaOfqv846Kp1FyT5eFQMmNoj0UNnPf7prXCg31lN+Zg=
X-Gm-Gg: ASbGncu76VkGE1puLDGuhuS6k2EmKtTPqBXg5S8BySEb1ftt91LBPCA1v2QnOWtDeaH
	lS5gCk9eyyjqtyWKC3aVW/jysa9VQ8On98AEX49ofFE0X3rirP9YsoovV/M3bfB+N3pcUfXNPB1
	DioeLmZWEH81vW7M64d2Qz9dFQTg6Nr+HpxW8a7/J5NryvNmuxTvFvP3LW+a2iIiSIE7zIZoOd9
	oi+XcZESSScgX+NSba9ChxW1o1UBO88Ll9FBaOGf9Zfr7h27+PCZF3FrMFpvemethe5IR0BdWeH
	irW3rXlQZHRTjXNEx61WjiHjRH3AR1Htlcgi/tZ0il4XMseWppMRc0aAd8g=
X-Google-Smtp-Source: AGHT+IGuttAE/ofmRM10I7Ggbviyua4Cd9wLezKY+qgFxx15E3kxX9iArtibkZxqAJ2SlNq5QxOe8g==
X-Received: by 2002:a17:903:1a83:b0:236:6f5f:caa9 with SMTP id d9443c01a7336-237d9a74d34mr274785435ad.32.1750782199818;
        Tue, 24 Jun 2025 09:23:19 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:8633:3524:a756:ef64:1aa1:6fb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83efb71sm111656135ad.75.2025.06.24.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:23:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Changhui Zhong <czhong@redhat.com>
In-Reply-To: <20250624104121.859519-1-ming.lei@redhat.com>
References: <20250624104121.859519-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] ublk: setup ublk_io correctly in case of
 ublk_get_data() failure
Message-Id: <175078219772.77142.7466986183368042874.b4-ty@kernel.dk>
Date: Tue, 24 Jun 2025 10:23:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Tue, 24 Jun 2025 18:41:21 +0800, Ming Lei wrote:
> If ublk_get_data() fails, -EIOCBQUEUED is returned and the current command
> becomes ASYNC. And the only reason is that mapping data can't move on,
> because of no enough pages or pending signal, then the current ublk request
> has to be requeued.
> 
> Once the request need to be requeued, we have to setup `ublk_io` correctly,
> including io->cmd and flags, otherwise the request may not be forwarded to
> ublk server successfully.
> 
> [...]

Applied, thanks!

[1/1] ublk: setup ublk_io correctly in case of ublk_get_data() failure
      (no commit info)

Best regards,
-- 
Jens Axboe




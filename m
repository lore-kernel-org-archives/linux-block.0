Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BC3AFAEB
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849767; cv=none; b=E8uM0sTyDxnzlwEpmKmXUi5lSFW0Yy6X+Roq7lubZViLON5nHf6v1ANi1tBx4/YhvnfPv4qVsZcYV//h0IPGxbc1QB8LFS1+zQsaXhsOPOv7gvFq1WEs2Nad80/RtUcOx+RAhqlB4CUqzUNEMQYlbaW73WkLeDHUbz9WNbEVvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849767; c=relaxed/simple;
	bh=FevyRYJfa7aLcNPNfj5fxSj6PUN+bEmuYe7JDXhkGoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pzqlqh6Utaus6HOs9uCj/ekr7EybEEEEe1qpXcEMFKgEClug/5fm6jHK9ga288bNYgjNeKFkcCkaRVbog8k7njgSlbAS4H81wY9S/S0kwOxnwoU4L5ks6khs5iKUYcmdEZU1KNRKVJ+u3VBLCYnn3iRPm2gVf3f/OXyHvDNMmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bJ4ZY/ys; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bJ4ZY/ys"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ee125ec926so3048060a34.2
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785849764; x=1786454564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Son60ydP+iiCgzZN46L5iW0372a03THY3apQWLtWwgo=;
        b=bJ4ZY/ys+X2o7SSyKlp9gqCf8RVnaQ5zsDFEQ27YYGK28uNgXTV46FwE0smb13wj/V
         2nDJtcNBflNtDJryyeurU8qEf89XELvXurEsgy75lfhuxBBFdCxqMQyBJ5VpJJ4mV29C
         YPUbngxZOvMG31Air0dco7372BJmSxMdCBCVg+zg/pFEyecYz+bDnQQTx4TbAhmb4NqU
         TtOee6dLO5krN1QRMW6X7s2AySUWcuALiGmoty3Ogdqrqb31fandqog+NAxaSivkeGch
         PF+gk81dc9bRgeTqSOfYf6StizOVZt5acNy7ZbxTO8WIXuChFtJlxWYVYNrhbQPPtSy/
         YvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849764; x=1786454564;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Son60ydP+iiCgzZN46L5iW0372a03THY3apQWLtWwgo=;
        b=jX3DEO8TAhCypDUc3+zqtyNCC09uvLNBxkRYjJil52Re9kt2q0II5Mb3Zy811LxS2b
         J2fTp3x17SkOmNu95RDkMs/iHhLiTrW7RPmHN533ZFqdDg9oNtMTPi/ukIC27xO4zmMY
         VDOrRzDYjt/bXWdHRfONl9N/SJytki74CsFBXDwC9ETB7jeQrVxzW57gRoQ+6JayOL3p
         JFpJ/zX2MC0Aa3vuP6QSto23J1HHeHMT1vN5WiCDx3Pz7RAeZkG55iAD2mzlJ87GIqS5
         dbWWhEmGiURe4t/q8v9lBTEoPv2lrUwibrPlmMKIHdgMhr5x6ApS1EF9FdBq9txCXd/C
         +vdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpooyCP1a8fLs6AVu5lV7jDlnYTcQ7En0nJYDW0ztpdMnyVRD1Xbh928aZEeFvw8rzhKVCa4upgFdHMgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMJxbldb3MsWNkQyGqTxwsIR8Lmfzev/kFExy7QDotDRrN4+a
	EXe+vc9LDtASNWcP6I+da7HSorGtpsdEeSBcgr6eBLe8AWIIXI3Iw1S4j9yLwcfufak=
X-Gm-Gg: AR+sD10Hfn+AqsG0NPxAhIBkDLOnuIGs7kOSpMR0wN09sJW4R+QefmG7+JSePAaY4HY
	T2pbWFxj5TUKdc5zLqPlWTMhYk8134069Ah6uBTGkVhy6ut6biHzBZ4vM0jcp7EroyF3uC7v6+L
	HDzT2XsuDtud4NyvhTZM1dIGPgWuvEcMZSmIRAwOY2QBRSFupStbbpA08YVdMWCUI25pftnK2GS
	Fj4XLnyXCI39YISzh0QMtwCB2LdPBxdDoN+zcD6eOl4VzEc9XQPB0RFYwd78HPlHR3shUPaho3y
	cc13GTQdiOLTOWeXfF9Cg6QDKO1VYMShaY4xj4NBSnnHArP9+6MsJWkBeuwxxuEeztaEVkI2Lit
	3aiQxoYS6XQnRTMIlnJOONUtQL6HDpbZaPyqbo+jC/SZoFHt5cqw1VY0NNARGieeNzGWNN9EbRf
	hFma4Z4UZd5Bu6pPgz0+xj0LzMsGcZbzWvT18B/EbII+kxpIuGY1h1J8rYmqUm6uVxqfu9A0f/e
	hK6kMjPsNkO6oqB+tdz4HGYP1j4RKFNxFkoGohiog==
X-Received: by 2002:a05:6808:318b:b0:495:f85b:d08f with SMTP id 5614622812f47-4af5e31fe13mr22655308b6e.18.1785849764329;
        Tue, 04 Aug 2026 06:22:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af60f08b56sm7447037b6e.1.2026.08.04.06.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:22:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
 Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260804123928.736596-2-hch@lst.de>
References: <20260804123928.736596-2-hch@lst.de>
Subject: Re: [PATCH 1/3] block: remove bip_should_check
Message-Id: <178584976213.949603.6178092261493847339.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:22:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 05:39:23 -0700, Christoph Hellwig wrote:
> There is no benefit in using this helper over the simple flags check.

Applied, thanks!

[1/3] block: remove bip_should_check
      commit: 6c13180dba60f835d6909e2a3b4f50862de156c6
[2/3] block: lift BIP_CHECK_FLAGS to include/linux/bio-integrity.h
      commit: 738f01912a1ad68c81a6aed06cac94e09b5f609d
[3/3] block: handle nogenerate/noverify properly in fs-integrity
      commit: 3bf9a21e7bccfd8c35b440efd114c61cc9838a41

Best regards,
-- 
Jens Axboe




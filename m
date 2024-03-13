Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B64E1DB
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361654; cv=none; b=shyiiI4+QAVcnLdMqsABEuisbkLGC1u/fqb5muSUufX7S7GcLLcq4ivmuW1y0murXNWKB65305qJSzTq0xj4f2FsinALYAAYl/6JDls4gxVIrDq+YPThI+g2U7iC00VWbML1vNLZat8Tm+vrjKPYDFq6rPybN+gDPz3zunLJ/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361654; c=relaxed/simple;
	bh=6KYs3BQgjwZsV5TdSedJLoIrS+8iHieLsZx7y+UPnzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JDldH6SlKEAbTr8ob7ulNMPlDX8igq1LAoC8r4coQBPsPRuzHyfMWBLlm9LC8i5fEvT/U9cLF8clp8dmQpEhPXDCGkAeXmzOXcG5+Lg6HpQ2yScLQP4fLFpQNzBHP98m9KnjjcuWPm0iCHSoCgaMzJ2PO2/M9rJ2VojbaDNCylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a9W3afKE; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a9W3afKE"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36649b5bee6so426945ab.1
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710361651; x=1710966451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF2DJ3K0vqdhNLJam1R2VnPzYiUW+uxIa0Tf2briAJ4=;
        b=a9W3afKEOxvSY4kRgWoH8PtJzVJNFleJdFpn9old5/tP8Smm2aSsM0K0/N/2Hghx1q
         uOR0RZpDk6mUtd2x4o63GtY6wSr2zWDtxIhmyEhkVaIV3re1VFSlu2+Sreuzaj0/Y0/x
         Xrd8yc9wGEhoSDkHQqmY8G2YZ+kSETC66vzlPvagvvTvK07HAOR/TqVFRNFykAnysI8G
         /a6ICiNZkNY6bTJfqeJ1Vn5SlkdqqkNDklV0tNPSl9GVS4LOEZVow3Pm65V1jO3qPcYi
         ivclXmBUHerME7l2uLTyALkGXpOlZ44+Z7bHSE70cozdlLy3D9y6tsmtZmFpge9lEO1E
         K+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361651; x=1710966451;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF2DJ3K0vqdhNLJam1R2VnPzYiUW+uxIa0Tf2briAJ4=;
        b=iIRZ4/rfOC9MnvP0SeAeHwfNIjBz7AwhwHYqHNaxGxma1QTyIA+IhhC1gWXDHsr5+3
         a0UqbK6t7CZBkdR8co6BFJM5fRyUu9ds9CL/bnl0UBI+0tamR1PhItjjJ8Wk2BkxYPFW
         SBD9nSxquGWdFhAzKIIjTXAKMz3SFUdB0MQRb2FY3uZt4Rtyl4XmCckE4cogkdGmk51o
         CY9yNUzuQ2e+EN+Rw9g5o/GxpLBqWQ1jMqSFzzMeZqPj2HPVawtnoWCmVHBKMlOecTVH
         v4krgS+P+X1lp+eaDzmrXT3+57SW782qQUqV7x36+u9M4jstmS+UNwHFPR5fzt3l0YEA
         HDpA==
X-Gm-Message-State: AOJu0YyEPkNw2qAfKzfg2w9WZQeOiMOp9K0CbFfZ7FNDiKGOYNFJQ+R+
	rP06mfMML+xHx9fVAMVZLir7yh83KEMJfzKEYZzLwdtT9pTBy6cxi5uFiDtL2KPZVIU+TglJrE2
	R
X-Google-Smtp-Source: AGHT+IHrpTG3IyrY66fdBdCSOtK8R6pRDlYafTxhW5d810MFfjPxeOohqUqtft8HGNclAFoVpU5ASg==
X-Received: by 2002:a6b:e914:0:b0:7c8:bb03:a7a with SMTP id u20-20020a6be914000000b007c8bb030a7amr23560iof.2.1710361651366;
        Wed, 13 Mar 2024 13:27:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a42-20020a02942d000000b00476cca7d5b9sm3081057jai.166.2024.03.13.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:27:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308133921.2058227-1-colin.i.king@gmail.com>
References: <20240308133921.2058227-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] block: partitions: only define function
 mac_fix_string for CONFIG_PPC_PMAC
Message-Id: <171036165065.297831.13967283119583163229.b4-ty@kernel.dk>
Date: Wed, 13 Mar 2024 14:27:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 08 Mar 2024 13:39:21 +0000, Colin Ian King wrote:
> The helper function mac_fix_string is only required with CONFIG_PPC_PMAC,
> add #if CONFIG_PPC_PMAC and #endif around the function.
> 
> Cleans up clang scan build warning:
> block/partitions/mac.c:23:20: warning: unused function 'mac_fix_string' [-Wunused-function]
> 
> 
> [...]

Applied, thanks!

[1/1] block: partitions: only define function mac_fix_string for CONFIG_PPC_PMAC
      commit: 5205a4aa8fc9454853b705b69611c80e9c644283

Best regards,
-- 
Jens Axboe




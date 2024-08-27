Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265F1C6F5A
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771925; cv=none; b=vFrUbmSGd/0uKl4L+AR+qAuRkGh8XRx9ytP9YZsnVtgz1CGCx29z6+0YDBQ4WewLW+CUFFfKMdpAV7nchImadq2RVwdHxsGpLLGaF07mLzEq9JkvSHZ3hWu8A+pEkQJmwQIr/2Axkyn6ezx3OqItWpPQiZMOUNm0H18kTZH/bkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771925; c=relaxed/simple;
	bh=FWrbAG6P0brsbGn9M+o5zlQjAT9566YEYTljPVMRvw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h0uzaQretnFLM1HZ5LhH7lz/mDW1hs1fe7A53BchBCGhd8eRsVAlfqpxqGDkvY5r/JXSmPB5MDNj/aBeKMbOdStJdDd9UP6aCYTL6raN/Bgc4f4tWGnfFtvkZ67Y2xbzMWrFSJ7nNHOp1iPjNbw/Hko9deWL6zYJIO5Bk+h8uYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kP3YyR7y; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kP3YyR7y"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d2ceca81cso20816085ab.3
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724771921; x=1725376721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3sz91txppRRQol2u4InUNml7heTRN8PJYStXnuBzvI=;
        b=kP3YyR7y+7NCLk2rtx/assH1rpSQhu4URr5cV0zDDPiXN2VHQUHipmz8D4MP7K0wiO
         SSrAZjHmcPfvnOUiWDEuyIyB0yCLKL0imCsofdGb19zlhHzZR02cf+/vys4mrwXruSwz
         erDGuo3qJIeMrUaE4kkzOusBrhcs2RSLr6nKYNPM4F+zutjrSr05psBa1Z8ErigXzDp8
         VoazsmtS6n1n8it9zO5C7dGlvhpb0WYpsvW1VlcRUpcN5vNOfrXSrrJWcjvJHWKQ4j+Y
         XqYn4ltnJEyX9tOcKfgubYgk6VMjAoUcqfKbypVUQktW9wmD89lYnOizE+0U0xgM0AaX
         afCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771921; x=1725376721;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3sz91txppRRQol2u4InUNml7heTRN8PJYStXnuBzvI=;
        b=BlII7iQnXpmPy3dx6NAehhK1eW5TfsCDYsuuM5d52bTTT+ITSdGBC+48gwBGQ46xcm
         Thx/10PObuFTKBKyJt542pDkoiz846yXZX0wn+zE+ybYx3ZdN5x4w0oWpD2Mgoh2z77y
         UsPHzmHrBjCzHFFAVohCZ1lulrftX7akHiKXj4tp6MAqMxP6wkRUPzrIPzdTsoYHGQ8e
         J1ppP3nt4tc553ITY0q8Aa8v9y58cWyTG7aBxLh4dzpH6GLmeoU5+duf0VRlD/O8VY0i
         UHPMBaMKY/JqZ4ZGcoMuWuqnh1VX7lONgyA99lFED7g5FahmLVL8jaA+fUvxtepoV+5y
         flXQ==
X-Gm-Message-State: AOJu0YzrRjnLr81+ypH2MN0N20Z8B9kUH82uB+HCDKQWMlOA2Fk3HlVj
	dfohh0q9YW45mK95kSw60+nYuqfRukGhPIiOR7NESFnfLrzrfxAkmnXrWI2/ZFo=
X-Google-Smtp-Source: AGHT+IGNdx3hQSl4CkHtRMaYkJu09zBIn48d6ju/aGa6VCD7Sery0aqS73SHIK0b0MExvGSMVChjYw==
X-Received: by 2002:a05:6e02:1749:b0:375:deb0:4c28 with SMTP id e9e14a558f8ab-39e3c9757f5mr159333585ab.6.1724771921413;
        Tue, 27 Aug 2024 08:18:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d73e67af3sm40028295ab.16.2024.08.27.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:18:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Ruibin <11162571@vivo.com>
Cc: opensource.kernel@vivo.com
In-Reply-To: <20240827022741.3410294-1-11162571@vivo.com>
References: <20240827022741.3410294-1-11162571@vivo.com>
Subject: Re: [PATCH v7] pktcdvd: Remove unnecessary debugfs_create_dir()
 error check in pkt_debugfs_dev_new()
Message-Id: <172477192076.295209.520219847740395596.b4-ty@kernel.dk>
Date: Tue, 27 Aug 2024 09:18:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 27 Aug 2024 10:27:40 +0800, Yang Ruibin wrote:
> Remove the debugfs_create_dir() error check. It's safe to pass in error
> pointers to the debugfs API, hence the user isn't supposed to include
> error checking of the return values.
> 
> 

Applied, thanks!

[1/1] pktcdvd: Remove unnecessary debugfs_create_dir() error check in pkt_debugfs_dev_new()
      commit: 752a59298ea9c695ec966fc5ba7173897a1ef361

Best regards,
-- 
Jens Axboe




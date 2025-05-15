Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA71198823
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747347967; cv=none; b=o741u80YKsJwt4pmyCT7aEpP+O6roc7tVv34Y9Aa0tN+IB6RfJa/I1z3ieBzMciGoZ06912/VLGaCWreGK578XYaQpXKi7Bz9qjXsEDagxkeXUKu8qrs9HhW5rU0fpyJhez+aM7BERUWE21LZTeiniLUZPwGyhtvlkHfldCMNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747347967; c=relaxed/simple;
	bh=U4EJmwC9duHU8/Q5hvTBoF/JP8lSnNtOW2hjMenbpiU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EhkhFl9jgl7zMcMK7vcb05VrVKVJlsTDBBU6QNJvOrJ6NR1lmIsDf5vSTKxNpC5Caq3wILza8+BeKCPuVUSL7wsqnsuJ96E0vXycE3GVT3Jixsi97iomV1ZW1sQ1PffFl5y48x3i6ACeb0eQho0eCYih9cujf5do1FyY8rhB5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SVDXlZKM; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SVDXlZKM"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso36325339f.1
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747347962; x=1747952762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLSemPzwtvA1Nnru2YlFE2yixeKpZGyEN3IB/Q1/HO0=;
        b=SVDXlZKMxGFcIKHkcmliomBFW7JYUWmxjmROV+IJ/eXGbKTf2dTXEpoTPIbmbFZ4U9
         aCCAPz1fd5umniIL2cFlEJcTb4GWLPNb9bDJnwm1DRMavzF/05JnDlefPPzNSfjrc/SF
         Oryc+CwDk01GDGu6QK7a156dIb4NjEdV5hASb1IwWom+2osMBvnfL7LbYvj7iXayVt99
         WyBwdeWkuhnGi3fpWskgkS1Obri/z7Opc1dv+45JEV8fBn/3Eejdw/IVEAGpJ5q5kHur
         vJYFyQCOlf70EMlnE2r68PQMacPZv8k01ZfsLFMSKeRKonSSOwrg1gy7a5dch98ueu2k
         8RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747347962; x=1747952762;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLSemPzwtvA1Nnru2YlFE2yixeKpZGyEN3IB/Q1/HO0=;
        b=XUO/+Kck+JTg+R9bq4dFkIXSkjqZK0x+gP3T89DSC0+Cnl51zZuPrvGefFrhlw+vi1
         F+Ct3kQHG5i3yb1aEa0+PA2+FIEf5D3xGWvgZYuDxnhkHBVXEGl7STJjsYLxr4jWhVQK
         gsfM1SBjoGjkTVRp7hZoNtEJTT11TYdS/n1SO87IKry5vMsjZ1LUe1hEG70EoQgmaLjT
         yMnhJOm3aTfxAnQnKbjPSSawH+tWZRFLFJqPvOLxu5iV1hOH3/ck9zZU269cqciY5eP2
         CBylHL3Fmr/QTiqvBBoC40d2jnvcc5GcjsjIynwTFca4oVivD7b+pFkgARLQutb3j09U
         PATA==
X-Gm-Message-State: AOJu0Yw327eslD8RT0eL3JDuUN5n5gVrXKzuDUFWMEDwBTSLACxql+EC
	AKhoIOLsKuItq/JSbCTGykLUATi4r5IVMwj4vFBspd4XHcEP+ckak4NRjPNvijXdG4hd19n0ie8
	wYDLn
X-Gm-Gg: ASbGncugITenFu57GuWhLfpj50FlhvJzj4aE+B08HHGVtXWYE4hQfM/I0JgbFxz65gz
	3unDYimbfm0HD5NYooE8/M7GyJIgqN05MCQV3eTP5ee1My3ZA3bwJYnBpLEyb0WUUDuMfbcBTWD
	hYeLRWHjNGjzkgmYtskC6HDd8bNuqx6ef0pqBeudaQ0TcqJb63ImFTh+H/M9bOTDofV7RzRSXJr
	7mEkHWWq+KTOAIPHgufKzrXuZHdeHk1+d40cOsFADgVQ2/wwuD2woKslUBD3zSTMHYfNYlCOROy
	aMDekfrRFyxEfPibBQvqYDMv551ZwGlT1vCNyOgwSAY=
X-Google-Smtp-Source: AGHT+IGVUoLIn4FuMAFI8BcBxqWLHXj2kN6YFoJwntIWy/CDsKHWuhfPnDHAqa8VARJNdZwkzDm3Ew==
X-Received: by 2002:a05:6602:4019:b0:85b:3885:159e with SMTP id ca18e2360f4ac-86a24baec5dmr86951739f.3.1747347961593;
        Thu, 15 May 2025 15:26:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a2360bb3bsm11709839f.22.2025.05.15.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 15:26:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250514223354.1429-2-phil@philpotter.co.uk>
References: <20250514223354.1429-1-phil@philpotter.co.uk>
 <20250514223354.1429-2-phil@philpotter.co.uk>
Subject: Re: [PATCH 1/1] cdrom: Remove unnecessary NULL check before
 unregister_sysctl_table()
Message-Id: <174734796039.324356.6246117815019899079.b4-ty@kernel.dk>
Date: Thu, 15 May 2025 16:26:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 14 May 2025 23:33:54 +0100, Phillip Potter wrote:
> unregister_sysctl_table() checks for NULL pointers internally.
> Remove unneeded NULL check here.
> 
> 

Applied, thanks!

[1/1] cdrom: Remove unnecessary NULL check before unregister_sysctl_table()
      commit: 7ee4fa04a8a27c7790a8fcd3093de3eb51aebb95

Best regards,
-- 
Jens Axboe




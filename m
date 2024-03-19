Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D364CE1
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814814; cv=none; b=DZ6Oz1ztBtLDfCbTCGYHNWg1GjGPh6RziWj87ufPL3JduuNN3V9e9Wv7xW8UnUB9I+wWLFZGwWDrRN8wDkv2AKMaI9hdvVyhAiUc1POop//Pik267FdqpxX9z7862/NECgch0+jiClVzoqx0Wf0hFv5Rw3LkQC5u9+ZjX26Rsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814814; c=relaxed/simple;
	bh=NkB88W5odC1JOVEAvvKJhHDlY4baHLv2+zt6C5wYeU4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TbPsTo07Sz0lC5U4kdbQ9vEjluRcUr7zTtL2hYL3UE4rvDu/05l9ejf6MqjaAkKkRjZ+VCgipHr1r2ixk9SozLbKbAapfhb5VoGYcjvX7POV0v1/HAHWqZiVH+wuqOgFVqEfg5PYgLfa8tHUDQHEAnF1DauTH3WNfac5WhZ6Qwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1OU6lEyn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1OU6lEyn"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e694337fffso1263531b3a.1
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 19:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710814812; x=1711419612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6rINp0way2lyVv3peFrobuPlDokerF7vmkwEfe9Xuo=;
        b=1OU6lEyngpVvbebxokTite4Ph3MAyg/wB+BWB1xnerJHDGHuqVSmwTWUkFNQNUUxBG
         JvbEWeArhs8oT4FEu2brMF/V7suKaHvx/CRmH9NtxERYfYQRQizTevL8040l9Xxhukmx
         9F5aTFkr9B2Roo2ODvzlzMtJi3uhXUTJlGTVVg7aLUe4prZgXvr9BL0T+89CvBMY3pw0
         gbrSCqJkmSRMhqosmcA8CXT4pZO38Jb3/mfD/TPY/Fx0oxegW4oSJihHi4JjB9AaSjlJ
         /rltEE1BfT4DCLcf0htIUgj96YMs9FDCtHx1v5GezzYmOW5PWh+H8KVvvET3pMEJzVdA
         OtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710814812; x=1711419612;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6rINp0way2lyVv3peFrobuPlDokerF7vmkwEfe9Xuo=;
        b=pP2gmHUJwG0OsmiJov+NKJkMGr/Yj19wJttFQsO+GvRAbDlT5v5NVAaDMwCl5SUw3g
         DAUh/7HCKkjNQe17g2AIEz4Hz1kiuQJdSxeh3rfn4J4hxdeN6xkoZAsrijMeEi2EAx0P
         PQWSsaW+tlc+yYea4M+1/tBRfAPC6X3ATt5ymsbxSWuKHgldJtFfMRVerNnxwiLvYWgR
         Xk3AGRL1BtWUQcjRwcECrDjykicBvlyF4fyPqONrr57dfUK2yyZ2huYtlnRT2sBcQiPc
         G0kRPOGpxH57GQLo1HU137GnxBzjtjhHVUb7SXisMurgRxIDZgxYO9eRZpnFKHfk1XWR
         UjZw==
X-Forwarded-Encrypted: i=1; AJvYcCUE1EiC02mVk2eHWdp4pxgQyqreuRnNAvTGdPypa8h3yRATWbIRM+/cM5BbIYuSm+Uli95IGr8R6fRGPY71on1X4yF1xBh30mYMc1I=
X-Gm-Message-State: AOJu0YzgcBnnu/u2bnCDLApe4q6S+cgiUfLatqGaa2ninX9z3un6Kc/i
	Ih7fDB2H7Vr6eBwubMzgZouCVIqrMfaLQxAqwHfkotqiZEMdfrpDHAFSOAplvhA=
X-Google-Smtp-Source: AGHT+IGW+uH6FebClXKqGEQc72uKT7oc9xlJzngrxaJXnCi2iuB+/iW70vvT7zCn43lAmJr8Fpz5+w==
X-Received: by 2002:a05:6a21:9982:b0:1a3:713d:1059 with SMTP id ve2-20020a056a21998200b001a3713d1059mr1022446pzb.4.1710814811772;
        Mon, 18 Mar 2024 19:20:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001e00295e3dbsm3062473plg.149.2024.03.18.19.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 19:20:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
In-Reply-To: <20240319014219.7812-1-wangyufeng@kylinos.cn>
References: <20240319014219.7812-1-wangyufeng@kylinos.cn>
Subject: Re: [PATCH v2] floppy: remove duplicated code in redo_fd_request()
Message-Id: <171081481063.643317.5474387504952434927.b4-ty@kernel.dk>
Date: Mon, 18 Mar 2024 20:20:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 19 Mar 2024 09:42:19 +0800, Yufeng Wang wrote:
> duplicated code in redo_fd_request(),
> unlock_fdc() function has the same code "do_floppy = NULL" inside.
> 
> 

Applied, thanks!

[1/1] floppy: remove duplicated code in redo_fd_request()
      commit: 50171b8667733146f139c773d8f00866ceb4cee4

Best regards,
-- 
Jens Axboe




Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568452;
	b=P4zlp/LfVQoQvnwCdKEbR+8+fKJFbSR2q2suobh6Bs+TEwfzyWoyMplt8g0sDduJv/Bl
	 XHNcsDVkUC0jVYJbQNwyy/g4rk/xHAyRWy92wQBWs4tJLDu0wAA0AJv7qX/wuTbj18D6b
	 ky5rxGWx8nB9dTUTaOBPTmFbNEx+wmBDbJg1IX1CR/5IEVOjYpRRxzrfKRUjGJPd2ChIP
	 /tZhhPKBKQQJRAmGzMSgMqBDari7RZarjfwqdiGtDT4PyiEeulawJ0bBWI3qKneEM4rnM
	 sAWm39sDyRa3PcIuEKn8CWRut9hcCWuBbCHtmCMb3LfgszCpAlAml5PVMZkJt02QE0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ezeDFgt+7atYRovKBFaoESCiQDt0qKhUHXV+O9nHsvs=;
	b=ASohRggd5xlqTeqoikQNlFfO356vqNVEPQV2Bv8v5FZkMaVCOxX7elsvxo9AQLe3Ves/
	 hyXenYNaDrQjQIoeawr857MzMDJJdrfOrB4IjL+IuN/RucKxDVrylvLYCBQFPs8zEfujX
	 8LMRs/AVInayNQwLmOtnr4hwhBcauYW19Hg5kITRkmPgkLE2bZPJCINOSSkLOu9bvXFiX
	 2cWPDiXd15/QYlgM6OUMfJV6mGB5XRCg/a3A6klC+tthf/P5yVDPEnL1jIUqwILzD3vH5
	 6bS042EyGfIChrE2MQAgkjxVi4fFx+KhkdYn5+vKZndCDTV78xbr13Kh3mvrI8EywqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A12qJRHs;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD7606A31C
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 11:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCD7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A12qJRHs
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdb8e8bccdeso446934a12.0
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 03:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794568451; x=1795173251; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezeDFgt+7atYRovKBFaoESCiQDt0qKhUHXV+O9nHsvs=;
        b=A12qJRHseNOEaZYx7qBqIgqcM72XffvjFu773eJzQFdnDXjLpWlbsW65cLMMiylJUC
         5OJkBoZgGBcppTv0mukKgKItiPpleXt3HDGGYgZtbFDM20YjJ+4TU+SVd6ya7C+lTpV+
         02q++QeyNAK8alM2Qy12Vms74lJeZ6llIWGvHkOgF6EpDpwwcmNBYLh5MknmvbTyC7/K
         kDqi/zZRhBREu/AGckP00Anj0d1sxzxMpr0oL+HoKoDKsgwEGYmcjFME8uVi/87r2HlN
         1r72D0fAksCrahsOYS86wIcJMh+3Oh+pigF7QAPQEF5lbcL3OoD++vz8qgo22mOLDROr
         l5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568451; x=1795173251;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezeDFgt+7atYRovKBFaoESCiQDt0qKhUHXV+O9nHsvs=;
        b=rPP9Z35LJXIfGtv+eM0hpwQ+CPaYKbZTEdw5jQjZsY2F4ynMBYVfO4GqHXJkMzzOTz
         Xep+UT8WXnzCmIaQUiou5mtSHfXRZs6fz9LsqrGpqcLhYD0peQ70ulUrk3NopFS5xPFP
         xqpGJWG7UNC5CmWisSwGFCl2fNmZ2HVlnid9exXoCqggRsBc5PM0Hw6NeeKOLL3hWSlL
         fs7FhrqH/kDwmUjewwDyyVWgp7v7fifXzKLgCsFDwm1k6nY7Q/+yMU1sq3Z/Saa3tJqs
         FiQosmenuxRozAyWs5MS6i4iCGujtiQV4RychaVE0/T/bOtGzSKxv8cfseum7IpdR8Q2
         TGtA==
X-Forwarded-Encrypted: i=1; AL+hErEJqZnBqWirlh32IodTtqRzp67cbzYTO7wuvFBHxeV4HT1Ewu303eRyaAnlTx96pHvG9lESr3QF56pxZg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/PdyaKEqUxrufO3mknI5akWxabKxJJKkki7LNp+ur2JYjzXzms
	sfpeMKxioUlLrKpPRNaqPFz8jTMjbhJQyNZjG33CstVieY/IAq2nSjCuPgrdDLHGdJTdBwEE1DK
	U70qZbUGss4xhu9qkh4c4mA==
X-Received: from pfhk7.prod.google.com ([2002:aa7:9987:0:b0:8a0:941b:f002])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d043:b0:3e1:dc9a:56cb with SMTP id adf61e73a8af0-3f7a72babf9mr1889436637.17.1794568450840;
 Fri, 13 Nov 2026 03:14:10 -0800 (PST)
Date: Fri, 13 Nov 2026 19:14:08 +0800
In-Reply-To: <59c577b6-4749-4edc-9dd9-a83f2a124adb@acm.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112051542.1539779-1-stanleyjhu@google.com>
 <20261112051542.1539779-3-stanleyjhu@google.com> <59c577b6-4749-4edc-9dd9-a83f2a124adb@acm.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113111408.3567353-1-stanleyjhu@google.com>
Subject: Re: [PATCH 2/9] scsi: ufs: core: Defer link recovery on reserved PM
 command timeout
From: Stanley Jhu <stanleyjhu@google.com>
To: Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org, 
	"Martin K. Petersen" <mkp@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bean Huo <beanhuo@micron.com>, 
	Peter Wang <peter.wang@mediatek.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>, Hongjie Fang <hongjiefang@asrmicro.com>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, HOYOUNG SEO <hy50.seo@samsung.com>, 
	Brian Kao <powenkao@google.com>, Jens Axboe <axboe@kernel.dk>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stanley Jhu <stanleyjhu@google.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 12, 2026 at 07:19:32AM -0800, Bart Van Assche wrote:
> I don't like the approach of this patch series. I think this series
> changes much more code than what is necessary. There is a much simpler
> way to fix the issue reported in the cover letter: instead of calling
> ufshcd_link_recovery(hba) from ufshcd_eh_timed_out(), remove that call
> from ufshcd_eh_timed_out() and instead call ufshcd_link_recovery(hba)
> from ufshcd_set_dev_pwr_mode() if the SCSI error code returned by
> ufshcd_execute_start_stop() indicates that the SCSI START STOP UNIT
> command has timed out.

Agreed. Recovering the link from ufshcd_set_dev_pwr_mode() is much
simpler and avoids adding new driver state.

I have sent v2 as a 2-patch series following this approach:
https://lore.kernel.org/r/20261113111202.3551341-1-stanleyjhu@google.com

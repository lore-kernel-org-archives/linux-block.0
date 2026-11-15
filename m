Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730808;
	b=Ap6nCz0fp990Ux1qk4R9KfPkepZNqEDAL20GfH1qRzBZMlqiLpbz7y81tYi9rbHxRK3G
	 qd5Um2uaFqAEk31Dq4SWYRrfeqYMHzhVxImwvL7tUZfKXPhRXi0bdI6grgNo9k65CS3Ps
	 vy31hD7fNNLRFY0Lwsj3MTzd8/4P3b4oAIY+7oJdtb2AA7uxMH5hIHZlPA10btarW8aN+
	 M2y7KPsr4F+1yRm+kJNPRW6mpde4K/UG6KbAbulqjKhcPNwHMJ0Z+b+qEiWiPBZGqiY3A
	 HOObTuhtmZlQFfaqG7J3J/k7mZPXt+c4jmOAXhWHDmExYqPMkFfs37+OuHsiJzUGGtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:In-Reply-To:
	 Mime-Version:References:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type;
	bh=cvkRQ9vTEHp2sTanBdWux8S9LLOQ1dWCdfqy76FCS9s=;
	b=K6KDlQtGkrWiVh9WR6XRQcYJFbOjarOGUcghz0SCz9lzrlNsFwXNR4J/N6qMhPpD7t9V
	 5A6F/UocDBc0HCuanAlcMozyJ1tCUgMUxRSHVJRabml/gFvkIABtKqbtKcjb2MxfXjYib
	 0r8gq9teIqCIPFvtiwrFZtwf/Fy+bxGdTyOLl69qKrw5lk0MzNZMkKdWhPIdLqLMDNm0y
	 8/d51BsvqnNIo/w30CsVhZ3do7NlrQBwde9pDc1uMM+0PFHoNa3JOJnCP/jR5625/l5Fq
	 JnBJ0cm4f2OMwh2V2M0qGbDAVPS9THGuWpUaWw5Lec8ZIcT7yeWJZB0A31FOHaRm2yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C0LwxZF6;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A777606A329
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 08:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A777606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C0LwxZF6
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ee1ed68286so16281485ad.1
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 00:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794730807; x=1795335607; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cvkRQ9vTEHp2sTanBdWux8S9LLOQ1dWCdfqy76FCS9s=;
        b=C0LwxZF6+BFl6wgUmpOceGqyxcXU3fj+WC5/Cgs6h9OMxjU5KJcHmONuMZv7DiZX5Z
         7ouvr9YUsPYgzxkRzA4mIrwal94AZW2LseWerMZqopLEsTqxJzI1UcZB+T9yluKFSTPm
         UEEy8X68/7sEeMFquUJJm96w1//g2IJMsevD+D+aZdmp+7KT/om3YmAI7ZOYWW7CagS4
         bRb+DkO7jzmcyMQmeL0KlKD5HBmRDBaf5Ebid8numYxRfknjg6YjPuOKNUY9sQNBMb+n
         hxcLz9/8jxxWvwXJ/40Mp+TsPK1oQ1QoZkCToeA3YpNdmyNot8c1LKjDn5nUgsEFsssG
         CkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794730807; x=1795335607;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cvkRQ9vTEHp2sTanBdWux8S9LLOQ1dWCdfqy76FCS9s=;
        b=KGEln709fEzPZ88cTGKwULucli8bX8flD9Nv4sDrtbS38pzNclvpGfxewifBdHEouk
         66yEppBLU6gjzUEzuXSQlwy4bgoiKxxnLnqg17hZqE0Zo0ChyPvAtLuI7eR6b+nzPNj+
         a5FTxfPFJMzpeOJVtajVF5zA04BRbKeCLMBqQ3BnSQ4ESRNRju0g8LUGUuxGOYfG16Vp
         syN9alYUPuFH6Z/u13ZzxqIMJCA4iKXo5vAQiaW/PpRMewXgMPXnlDrnxmz9vZOqiF+C
         ubSbzHHH0VQ+DLTI2dm3grE78HIz4+1TL604BdCGX6ajOQ4sZ3jjdzSgGxQvNvIc5Oxe
         /CMw==
X-Forwarded-Encrypted: i=1; AL+hErEzokcuf7EArVcDSsJXe4rCBV8B4Y0mebu7Y8umsnigfl9s5HsYxToGPbBBGA/T/RlSpWK8Du9GY+J8vA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8muEWUYcj+Jhkih7DgMu2amgnmhQI5udGQbwu7CLCroEXbo88g
	jZ4WNpxd33cvplAzzIP4yWIt59zZitKD3VBJMLoIYo6o84bqv9jyD89Ptj3SUtOyIyb2f5F8e4W
	UsFSg+uyxKpQrSv7ECCQ8Tw==
X-Received: from plhn3.prod.google.com ([2002:a17:903:1103:b0:2ee:20a7:da27])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2281:b0:2e9:55fc:ded2 with SMTP id d9443c01a7336-2ee0dec63demr78859485ad.52.1794730807271;
 Sun, 15 Nov 2026 00:20:07 -0800 (PST)
In-Reply-To: <99108d6b-ce90-4008-85bf-fef12204faef@acm.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113111202.3551341-1-stanleyjhu@google.com>
 <20261113111202.3551341-2-stanleyjhu@google.com> <99108d6b-ce90-4008-85bf-fef12204faef@acm.org>
Message-ID: <18e82a2906bde9db.3137322e31362e3131332e313435.7ae79.0000sendgmr@google.com>
Date: Sun, 15 Nov 2026 08:20:07 +0000
Subject: Re: [PATCH v2 1/2] scsi: ufs: core: Recover link in
 ufshcd_set_dev_pwr_mode() on timeout
From: Stanley Jhu <stanleyjhu@google.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-scsi@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bean Huo <beanhuo@micron.com>, 
	Peter Wang <peter.wang@mediatek.com>, Brian Kao <powenkao@google.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, "Bao D. Nguyen" <quic_nguyenb@quicinc.com>, 
	Hongjie Fang <hongjiefang@asrmicro.com>, Praveen Talari <praveen.talari@oss.qualcomm.com>, 
	Hoyoung Seo <hy50.seo@samsung.com>, John Garry <john.garry@linux.dev>, 
	Hyeoncheol Jeong <hyenc.jeong@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On 11/13/26 12:37 PM, Bart Van Assche wrote:
> One change per patch please.

Agreed. I tried to fix too much in one go. I will split this up
and address it step by step. Please drop this version for now.

Thanks,
Stanley

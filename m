Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C808821
	for <linux-block@vger.kernel.org>; Mon, 29 Dec 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017692; cv=none; b=EMtt2FZ4JOyrp7Yd/VFOD6TINS9/RPWZalzkG9VgRM3ffIuK0VNTPwNlnCvJ970OaGAsIpt9typ1djw8YZIAVw5oTAcEk2grJwX5L4HFlsZDHU8zF+UZ0/q2JUyVhi1vA9OzdtaYbBSxuJzNG4xDCa0MWnbo/JAZWOmMoNxNZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017692; c=relaxed/simple;
	bh=HJVwl1CaDVLW+erte6hu3a5BEERQa0opJprKRwEHhdE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=aek4/iyZbsRCj3YRDMIc7VqtguJIMRVoxJg5KTqY8W4F4GfvuoQorEdplCG5xAghQrM9H5Lm7CX1knv346zYTfeS4ythGsP3SHEGkjQsg1LkkBaooOlFrRicQci3UUmb8g+ugsHT85IaetZkRrfJshVdDsN6YVo0BMiZ6bM1mtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nKD3RBAo; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nKD3RBAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3si5tjs3jbfthictbrcq4cob4u.protonmail; t=1767017681; x=1767276881;
	bh=+m96644OkSv7RLjzsOvL/YHU/lEl80AShHp1mwc4Zqc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nKD3RBAooNw9l3RWuc1IcEev0VN+BO8Pd4YQZ0eu0P1mlGox592s0W4Jyr3QQEgxF
	 RUFr3bXbHUbdEvyLhGsmrQV8+2pQOlc0Xnda1JH3/IPOYKjXmy/Na1IqjbD0xRCwvu
	 4IVVVfjf1wBieHu8/F0WhSvosPMjElcb5FNgud8Iicobt6/vvFQ9X+UsmtgZwrOYm0
	 92J/oeemUqRANxuCEZcUOwzXCborTpRCJaalSafnNlH8w+l71JQF07bBD200CyKePY
	 wbv6RvARPuoH4WavFuZ5KzvnQTU8/+Q0bqYXPneIlZdXFw4etGxEETWf7Cusw2EncB
	 WxGVmQwDhOobg==
Date: Mon, 29 Dec 2025 14:14:36 +0000
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Cork <c0rk3d@proton.me>
Subject: Heap info leak in BSG reply_len handling (bsg-lib.c)
Message-ID: <0fvb44qiSfIUN9GLgzoLAA6TumtVVQ2P3JAJATl03GPwzRsvnKvTB0v-8uKCM0EFxepn3crpzwH-WhdgzR-gGVfOrqTVLlfemAUmAafeewQ=@proton.me>
Feedback-ID: 121452778:user:proton
X-Pm-Message-ID: fa2540e5a9d5ed55f1e34abe720bd7c8ad0d8fec
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

  There's an information leak in the BSG transport layer where copy_to_user=
 can read beyond the allocated reply buffer.

  Issue:
  - job->reply is allocated as 96 bytes (SCSI_SENSE_BUFFERSIZE) in bsg_init=
_rq()
  - Several drivers set job->reply_len to values exceeding 96 bytes:
    - bfad_bsg.c:3188: job->reply_len =3D job->reply_payload.payload_len;
    - bfad_bsg.c:3534: job->reply_len =3D drv_fcxp->rsp_len;
  - At bsg-lib.c:116-118, no bounds check exists:
  int len =3D min(hdr->max_response_len, job->reply_len);
  copy_to_user(uptr64(hdr->response), job->reply, len);

  If a driver sets reply_len > 96 and user provides large max_response_len,=
 kernel heap memory beyond the reply buffer is leaked to userspace.

  Impact: Information leak (requires CAP_SYS_RAWIO)

  Suggested fix: Add bounds check before copy_to_user:
  int len =3D min_t(unsigned int, hdr->max_response_len,
                  min(job->reply_len, SCSI_SENSE_BUFFERSIZE));

Cheers!



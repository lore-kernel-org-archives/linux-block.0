Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500311;
	b=fgAChHwzzHOGes99nOKDWRxu4fBKezE5u/+tZq/gWOiCe2zL9V0fZmmkH0iuAwUW5PUH
	 O6YKFRqmjwUl7Gy97IuQAF/jnYDz5Pdj48Kgx5VGvFBHRDPai6sGfaNBlC9lHPRlrUZoV
	 LTkzaP10gj/YSoz8yfcN1/L9EHUrheBiLMWTgWDrARKAc/QTNSyLqlBjovfh3+ytUMlER
	 BlyYnS4UgZXBfiMZ4GGMXPwvSZ3n4TolF17ncIFGZUzPccoD8vGAzuQyqWbVD8dWO51RJ
	 vkTY4PCWeM54U2fKH6i7Hdnnoui3JEdisZbrDgFDlSWgbptVroQwpvSloUzLC81wBRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=D+wwjazAct4IZB2YuQKwqi24Rar1lXO2vO79SPb/nCE=;
	b=GwfwLYBr0lbvdYCsSwRz2YLrFQPEl4YsetDvICMDn6AKPlfq2ge8D+zIQJ5qQ6LJs3TE
	 R3PjqyHuNNKyd6vgIQu3wu77lzH3M1xv15ovuDS4+jh6lwG0kkk2CMJ18Ikak9OHvnCaY
	 58ERd8PDFdTPqmEHGNXgr8MXYwIOYv4ExuPjE+sYPlPSmtexoNnrfAVR1BzUuhj2DitA2
	 1Kclxia7B8Tjeb+MVfxPD6HGk8BENlCZnfsnoOMQMF+eohHqvd8BxdGUq0abClzrzcIjA
	 CorsLIFhRVg50hD3i8Mlxfu3/pAONGoOwUearXisW7TxsJXZrntAPOqLdKvx36k2dYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XIDnrxIo;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B7606A321
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 16:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3B7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XIDnrxIo
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-170135e43c7so3223203c88.0
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794500309; x=1795105109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+wwjazAct4IZB2YuQKwqi24Rar1lXO2vO79SPb/nCE=;
        b=XIDnrxIo8sdAfxBpG12mCoHmS3PnwLDutuMW741oRA+n9e4WbIIvTqMp09b9XX+s4w
         QSbiYy99el4yMTlCueAcpwrBbT1woLxB5HEXiSpt0WUh174EE8//peCgTpTg5gcQSCJX
         2Rg5y4uJVRHqrj66Qz6uqfGwI9uwy2nHgTkG8PCe2fVAZ/gY4byMVm1FEbRFDBzyC2+Z
         m6EJNf6UCceuTC3cdgeCVDtir/QZ6N3RkyZXKJz/z+zXXL5VaApjALhpCqLMF6MlG9JN
         4qkvZPUFw0v8dB0LXziaWteP82Lg6O0UINHqU+CQ7wCRfG4I4/Ms5fd/nLIXB2MF7NcZ
         nskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500309; x=1795105109;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+wwjazAct4IZB2YuQKwqi24Rar1lXO2vO79SPb/nCE=;
        b=gNkor1nf2TgVITwYxVD8xx885JwBk2fLUKskDgmsucuswhoxdbI1B3pSWm3udr5aI+
         MKDgAx7o16C4mIkUlXawIT1RO02VAzs5OBOCG6XHl4EaxSmwrrNj52uoUX6acYHMrBIR
         HgKBLoArf6quXkzUigEZu0/p/kQaDOLx66rGjKfaPYW754UHYDfof2z/ifD6jA5k12Le
         Qxc5gG7iNF5L9LXD4XHiusL0a/IMg+KdnexsJoe3yN4mVrYmd7X2mAzCmzuUoH/yVM4q
         irvb9VrzoCfpAPBmHw9nlMj9RLAsDvxtntFitvgM4znq5PcLHu9C/ScQRS8+ogVuqkKF
         XRYg==
X-Gm-Message-State: APuU4Z+oHwU5BzmF/3/YNt1LqWLogT9zAv3+6MRQZvnYWSxSGR463OB1
	RkMs7v9jkt0cM3np80IyA911MYocuEuOkFrjLkFEikmKnXq8VSIrOPLnYdOXqU/lo8I=
X-Gm-Gg: AYBFou1Ct1s1Abr3/HPEakGryRaNeWqLRBbRKB2Kt31NeCfbeXlvQFUPOksu1N8efIC
	s0Xe/PW/kY6QuNwMmZxYZep10qKa9EOK5xovbWvryLTPF3fyMc+G+1EE+oJSmY5u+oBMfZIm4o1
	q9lowTV6O6Ww1NyfsM5r4VW52w95rb07/YWhjT506sEItbZO68mNQHXTThQqs640yOa+GXISUTp
	kHKHMF8J35Rr7ffXoJUHQ3JoMGOkjAMewJ0la9jv2bbXq6otm7BoQvtd8+dGaQgETy2b6UUcvEI
	N7jHCo/v095CEKOEE2bgC2wpAxbQGIH/O886utqtWWelUwqvzcERLLFwvG6g8Sm0YhPHvm6dN4A
	mkBNBf8Q/Tq4psl9ruKoZxkAK2gaq/btNtxLFCdYeHKquPcDo9ZS1jQCrV+qR0jr4tBDi1/EEgv
	fy8qjL67p0szQoWsHl6KU8PdohQpA0Wmwhr2F+x5kpu6P18k3mVrXnzdfqj/5QAtEY24AxmMovG
	eCVAfpZAdcAmDXNCC10AtWt2aHqmTfR+aN5QoFIwML1EgQC9dE9Zi6oanVbA3XP3LXmg6zV489d
	VcJJtXFhDwcJSon4wco+UKSDx19qmL3zMy8V/F7+s2S5pwMNE68rEUYwWHtk5Okn92BRM8CYZwk
	w2yJbplpX3GrmIV0IUomQzbGmf9zagi7Yjw==
X-Received: by 2002:a05:701b:4554:10b0:19b:39f4:88c9 with SMTP id a92af1059eb24-1b503115701mr40021c88.10.1794500308848;
        Thu, 12 Nov 2026 08:18:28 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm63092c88.9.2026.11.12.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:18:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261112102608.1057852-1-sth@linux.ibm.com>
References: <20261112102608.1057852-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/4] s390/dasd: fixes for RCD retry and BIODASDCHECKFMT
Message-Id: <179450030814.6809.12199806849669724692.b4-ty@b4>
Date: Thu, 12 Nov 2026 09:18:28 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 12 Nov 2026 11:26:04 +0100, Stefan Haberland wrote:
> please apply the following DASD fixes.
> 
>  - Re-initialize the RCD buffer magic "V1.0" before every start of the
>    request to fix a condition where z/VM omitted the UIT and the paths
>    were wrongly reported as leading to different devices.
>  - Two fixes for the BIODASDCHECKFMT ioctl, both reported by Sashiko:
>    a wrong free plus a refcount leak in the dasd_eckd_build_check_tcw()
>    error path, and an info leak caused by trusting the userspace-supplied
>    result field.
>  - A typo fix in a function name, dasd_sleep_on_immediatly(). It is a
>    prerequisite for the RCD patch.
> 
> [...]

Applied, thanks!

[1/4] s390/dasd: Fix typo 'immediatly' -> 'immediately'
      commit: ae6f19236b5ae4eef4df2780d51bee19add0eba8
[2/4] s390/dasd: Re-initialize RCD buffer with "V1.0" before every start
      commit: 25cdc1f63227a1ea69a1ec823a8a860e33299169
[3/4] s390/dasd: Fix wrong free and refcount leak in build_check_tcw error path
      commit: df56f7a6c20a5eb2794c0a7391bde50ba7c8c54b
[4/4] s390/dasd: Don't trust userspace-supplied result field in format check
      commit: 7cc2dda4f7aaf596c1796184649007151ff98f8d

Best regards,
-- 
Jens Axboe




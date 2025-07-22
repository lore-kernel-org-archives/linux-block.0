Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836027EFF1
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226345; cv=none; b=D6MkG8yueByw3UODscPYhjeE16C3LBik/qd7U7ylEKcoMTePLyl9/HeYOb+CEd09KVLH/w93M8dxYs+5uLhMgW28vEZ3v5YZYtLRxoEoXPOqC1S+OtIQmbVRiKpkRvKw43JSC9J2zqs9S7mfGLY3aUkMRlsc3NJesohqq3PxsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226345; c=relaxed/simple;
	bh=MSxXn0dB6/IHB+ZYG+YDB78UkEz/Gls+Dn19p9fQYNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRkhXGfNcLewdfxUS3b/jT2Dws7kJX06WKPcPd34XAXgXZXnayap0rSRopi+qnSLRR1gDm4Ofxy1ApdBqWTykqn6S7YrKTwnmMYQ6wV/0D+1+6E0uYZMbI9L+49LGv7SOFOR1clTYZyVRhGcfn5cyOb6Wh+ofjOSIbn5cfR5Jio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=TUP+mQYv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="TUP+mQYv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45611a6a706so32475715e9.1
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1753226342; x=1753831142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=imuadDIhz/CvXR2Tdkl5GWcp86oNP1XJNPdBw366Ddk=;
        b=TUP+mQYvwIVRBSSKMV5JKKTsLb9sw6UAg/o56u/154o9mEfi/oQbIx3yKdxHnycjRs
         eZhirZG52aZo9F4qhLzZ3iqCvXnMMC1hun4jOWmpYPRNlEPs1FDOwYG/oAZ36ibmpqT2
         iZlAtmI/Y5ZEv3LLE5sITXmsM20qDLGtUj8BoL107FVoxD3vqbOlrl241/VwMO6+AD85
         Ie/ukqLlBfMyL/pts+NnBZYKxJzTuVUeO2s9KcQ5/sXQ6ZeEQO2u+CGZAhZaJ99uhKCJ
         vA/X1cIxBadymY76OqzFYJebrrvK5vbcJGYm5sgSJh9mQE+cW9u5OUYMYY5sGucsT8FX
         ZN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753226342; x=1753831142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imuadDIhz/CvXR2Tdkl5GWcp86oNP1XJNPdBw366Ddk=;
        b=DQ1nXT5Lkpy/0I9af1UtLUIdb1dK0MCJBbcSWSUrOp31hfJbRfD8V+oBf624my3E5u
         sruANbyIvReyZS3dZDWy1b8KRrDyAjTQOKedh35S70rPegDQQ1OxscNTRuD48BLuP97H
         lPK2BcqY9dkXK18pXhPo2v5beypbSjpkVR7DQPCekLjdxSMNWqBcOHj6ad8bpWBtbVzu
         ItsAQdDRF46tfFmwmGGiBakn3c60v37ZJHdAV//QedjuK6p/0a2qQlHbB3oIECz8N+GU
         Ca9IF+U+Qr1UC8CRB/RHm9hBtMK+SgaDVRsSX2N2WK2vOsB1nowOWPVCBeqD48u1vmyZ
         dEEg==
X-Forwarded-Encrypted: i=1; AJvYcCUN8YwLy+pkV9o5ODeCFiw1LdI5qY8/nRG2BPREBERdQ9x8c02g+O5Vwr99C3gYOsO2F7evBkMFWv925g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZFE/MxK2q5153CEMN1/P6vKNReXYBhlAUe5Dz5Hm8wzDawu/
	yPYwxDimIr1SjPqu62WDAYCD6NQtcaMqqg2ajuIcw8xy6/Bn3gZ9K3tONg824Vf5lyM=
X-Gm-Gg: ASbGnctoFW4oprGxLcQISaua+s8uFmNSPfxkLbNl5+sg8gDQjG//6j6Vr2xYYTKYCAR
	thL3R0c4g37R1CLA3jVpFzfagYw0FzKTEjxXE1eRVLOKUcja5/MhfMnnQp7k+FhC7v7+drGMEfN
	BfjcH/Is+Om1A73PJkubXKDWjILvHIKgU5sdBMBfUhVl7pF+ouvT4O445hhDid9OY/FEmp85dkG
	PMMnuczIGDY7FzoRBCaX2XD7fTl9J5yA5yNY2neK/MIGCu7mnJFSVuMEWS7VCglHw8fAsYHA1Rk
	RcmH1WlJLEGSAJdqVTcDFofXA8fW0tTwzSliIsNccFg4bCeEf1v5kYvZBd5tbC7DGXWxNNnjsRC
	PW5V+ycGR7aPvWQWdtq38/8SqlFCOPttdM8dTKn1b3UBunR1nNR9Kqp0fcHctdJSYnarzv/WxOF
	EYgT04aQ==
X-Google-Smtp-Source: AGHT+IG2qASGJl7xx1wYNbrfYfn0GiPIEqhvcX8qqAgX9BDh+5khYLwkiRvXjcl8BFrMboiIto/yoA==
X-Received: by 2002:a05:600c:4509:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-45868d2dd64mr4402845e9.17.1753226341980;
        Tue, 22 Jul 2025 16:19:01 -0700 (PDT)
Received: from KernelVM (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691aaec8sm4071965e9.23.2025.07.22.16.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 16:19:01 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: senozhatsky@chromium.org,
	linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: patch for inclusion
Date: Wed, 23 Jul 2025 00:18:59 +0100
Message-ID: <20250722231900.1164-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please apply the following patch, suggested by yourself and credited as
such. I have tested that this call does not make things actively worse,
and indeed that optical drive functionality (and in particular release)
still works as expected.

That said, I've been unable to replicate the issue seen in the report
thus far. I have tried a variety of approaches including just yanking
the cable out several times, and in all cases, my kernel does crash or
post a BUG, and properly unloads the driver - this is both on the latest
6.16-rc7 and also on 6.6.98 LTS, and including when I am specifically
inside cdrom_mrw_exit. I plan to do more digging regarding this, hopefully
this weekend when I have some free time, as I'd really love to replicate
the original crash.

I still think this patch makes sense though and should be applied
anyway. I've also patched the unused exit field out in the documentation
file, and used the 'Closes' tag as suggested by checkpatch.
Many thanks in advance.

Regards,
Phil

Phillip Potter (1):
  cdrom: Call cdrom_mrw_exit from cdrom_release function

 Documentation/cdrom/cdrom-standard.rst | 1 -
 drivers/cdrom/cdrom.c                  | 8 ++------
 include/linux/cdrom.h                  | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.50.1


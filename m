Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6BF48032C
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470758; cv=none; b=NDT3jxkqYhaOnkSS8ot+wNl/8OnTFuZ38N0B3kLv9asBcsVG1low/3edHeWYz+zlE8fxYtVLPh5h0dGDAxzXJdjbL7sjr4XlMySEhqGtojFxtA46iNEMvBN9FBOVLQ5nPwZ2Yb+eH8kdPEQSFQrrl9tcBXF5Sl0OoEGFOTtgicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470758; c=relaxed/simple;
	bh=QWiEB4RSp+V5dH/Aqgan5cJwk52VX6Ezefo/QbSJRDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Txgrrcpc0z4aiypJQwaRneIN+of8ucKJYu0D1+R3+2s5GRlPu2hQXCHi4jhql8X1jtT3XExUqsVVgARMLu6U/7r24M+ld7Ex2qjXIkY7pV7Wvhbgjar228cLn5ZNyp3wEVI2CSbUD7ow9HMNRmoNcKjirtZK0sCmy0ZZ/vMw9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjcKIrXu; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjcKIrXu"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-34c4a0868b6so4907157eec.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791470746; x=1792075546; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j461oAza6kS+xdmD4uBj9+ZclxkG9bJ1dHy6LksUEcc=;
        b=IjcKIrXuDd07i4JEO77UIWs+t/F2XhdlV87wEUaxb/jFhJA9sbLeb8pWl5blS2YDsi
         biJKt+hz7GULWp9p1fQoPR3lX29DtuUWcs/AH3VAIwBQUHW+jzl1afA38CNVK/OQzIb8
         +Z3Zzj4w+niFJ+AJ1mpmkg1zpY4nzeFjH320u0BjnjLn95Bc1KBoyWBh/yAsSMR8CY+5
         MlMtY//M306gy7jQglNwvhijXN/VeS2abtK6DNWyNBO7ZEXrFwE2FLmltaWqf7JI4zoh
         KgAs8xPvC//dJK7k//s+bI+8kmsH+NhYKn29TY9KAeSZqerKTK15DBCjmHuzAs162+BA
         yx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791470746; x=1792075546;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j461oAza6kS+xdmD4uBj9+ZclxkG9bJ1dHy6LksUEcc=;
        b=wD4bC2IElQ/fttc8S3DeTSx928LFwXcx3dcwFgL7mo3ZCsfQ5FO3EZyRqjwf2j42LQ
         LDMvNtQFogRSdq3FQVv+crpAFe98etwbGLxSuRMU2qeQbH68BpIDkckzLBWSIkaztIQC
         4zLPCvE18jxYUqb7DdPg0DJEZEk5/ouD5uHV3bJ20VLSzbrrs0yam8STzkDWau8jHiyo
         4JCRir15GPgojzy+ewNjL7KjEuFQA/IvY2IgfjQGK2TqpvZuQFF+XSfeEv81Ebi96ogZ
         vT+McGgpzgcQTeqbcYRtrV5RfrTngQ+Zrp9KJ04Mv+mdXRIDK7OJkTr9tX9Z7QC/B9Lf
         oyHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwc2zR5nekrb2eHVGXOAkEJQw3DgF2NjdQR3ZWn0bd+lKOMejSKMjSGCQX4yCQ/99fKqthGIOfFnonESw==@vger.kernel.org
X-Gm-Message-State: AFuF++kbZ50Llt4oZQJ1tJUqfoawwz1WrsvJmRceXjYuRtGV2CJ2gSQp
	BOhqp7wUN9++f7MGxnJiaTjK6LWw7jdtYF4DBvM7YyPJ2A/U9HYClFjd
X-Gm-Gg: AYBFou3CEynEHSBdKZ+iOBCLph8PhD3h4pStN4gOVg9D9EKWl80IsWvQcPPfv/UXXXn
	B+gw8BQwimoR47CsttKUM8v/tiHTkp6ygpBJVFhOftx6C1qgoBD8kV/w2l7JGVJJF78Wk8Jw4BN
	JYIgrqZOvdPyBAL5VdQCCmdoQFSoBukYeBaNqsMEZSKRLkA1FyISNXiGU7RZ9NewBHnTD3ELbbv
	od5Z3prAdJP6XnkBBCN+heAcPBpylh42bFlI05kyNfX49Qj+Hkcpmqju7pdAfCvYcOuLmdalF4D
	4DO5Pl3NXBAE0q/RFe6uQHD/tiLTZlau6eh5RfYiUN0tZfGm5EPLHyfR5/+H5BewAjSqWLYjDpJ
	+4sP0zKAttMWdSe3WKmLk2PNEjF9W6Syhq9gUNI287CF/6w6VVLLtP+pY2bRzE5hb5fve1Kx3kd
	SEE4LKjiLXS02jMXGeW9XC0EJHFY0+F0YWloedzKHEc7KeDsAikvsYZUbDianCv7sppw==
X-Received: by 2002:a05:7301:1291:b0:343:5f5f:eef0 with SMTP id 5a478bee46e88-351778bb61fmr4464528eec.21.1791470745880;
        Thu, 08 Oct 2026 07:45:45 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aff5dd6sm17913731eec.26.2026.10.08.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:45:44 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH 0/2] selftests: ublk: fix the fault_inject delay
Date: Thu, 08 Oct 2026 22:45:38 +0800
Message-Id: <20261008-bug-ublk-selftest-fault-inject-delay-v1-0-a96af7ead06e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKsx2oC/x3NQQrCMBBA0auUWTuQhBDEq4iLSTupoyFKJilK6
 d0NLt/m/x2Uq7DCZdqh8iYqrzJgTxPMdyoroyzD4IwL1pgzxr5ij/mJyjk11oaJem4o5cFzw4U
 zfdEHJm99JOcCjNS7cpLPf3O9HccPoattinYAAAA=
To: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

The delay set by --delay_us on the fault_inject target is lost in two
ways. Its timespec is read after it has gone out of scope, which makes
generic_06 fail, and any other completion on the ring ends it early when
more than one I/O is in flight. Patch 1 keeps the timespec alive until
the SQE is submitted, and patch 2 makes the delay a pure timeout.

With both patches, a 1 s delay holds every I/O for 1.000 s at queue
depth 4.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      selftests: ublk: don't keep the fault_inject timespec on the stack
      selftests: ublk: make the fault_inject delay a pure timeout

 tools/testing/selftests/ublk/fault_inject.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
---
base-commit: e1274a6bc40a4618f6fbaebbdc51cca865d51bed
change-id: 20261008-bug-ublk-selftest-fault-inject-delay-46ea414ba226

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


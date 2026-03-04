Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826C23F26A
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626659; cv=none; b=DAR+rozZtSAuexkTSFtesSsvOFezMrTTrq0lgqiuHvD5oXJ0bEWj7x5idIwXlyOGGuY5yTeD5YCG6WTjnEKg8XdgO5NV1/zLOI8a6kb9CD0KeVILK8DWpsh/Cy+2ZvCenbW0tSCatenQaaiRSJqWU+zpRo3g0XaN2AJZETt00iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626659; c=relaxed/simple;
	bh=Gi8vIjmxw30nPsVfY5h1SYrFPO/Lza1eh9E6GrQ4rtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MnO8HU9liOEa58w7fZ89PXuLbNU8CApuqnkl4ofBcxdNX8Xaz3bIZ7Q/QE/UH59v3/owrs6aKJYQi09HooMyX6rLW1ZYVRGaSSOLXPEUChsuzuqdV4tKZfey9L18rtZDMOMeP1/yAcTV61GFpqG2t7PcKW3cNMgMbuvS46fbL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UBnoObBy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j+sM9UOi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UBnoObBy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+sM9UOi"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SOEJ152521
	for <linux-block@vger.kernel.org>; Wed, 4 Mar 2026 12:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LUNISlqFvuqnxUOZI9HzNX
	Af4XHNKIKzsl1pT9nO+Us=; b=UBnoObByL4ZxXEE5LhlbH4Rr6fXjJZCjp4Clvv
	rDAiMZhWEgGneIRJA52g2soGrhK+GhmQCdrrybfGCUopAxoBn1YFgstmheFskHCb
	B7B6yJA5k3VkAu1fmEJGlWbFBB/Cy5gsGSX4Idh+0o1OqxH/vqcB7CcGgBTPAvpa
	me6N6CzZbVa+0O/Q/+jxM2EAz0D14ddGQvfr3N/jyHMS30t8C0Zl6SRe4x4i/DcV
	svizXjD+zU1ahBhOTalnknxDE9ThiYrOxdGYs8aSSOrChehadtJhdlZ1OeK83l2n
	DKNE/MW5fm1ZYoaS6UopoKpewLMNP3WWY3F7zLCQ6smV+YOw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvkj8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 12:17:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1277896014fso118512049c88.1
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 04:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772626656; x=1773231456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUNISlqFvuqnxUOZI9HzNXAf4XHNKIKzsl1pT9nO+Us=;
        b=j+sM9UOiY8oY61pkgY5XIZ0ymsj6jaXUQHbPgku1yrJAaKi0blq3C6uP2GUDTFUtsT
         N5w7WbBxwNLjtO7pzIVBRwfZlw8Rh7Cu3uWqj4h0P8OqQfHqgfiELEDS/BRiJN0wgcyF
         vHQTH1UJj9SCFOz9ZhUjvDn8rRTm5kTb6h1kL5Vd2VDduaVJFT8b+y5z+UIUo6U9H+6N
         qMsgYG6o299Wz9KSXSKxQspQF2y9Sv7IgQ9s8KvuZMTgwmBopr69BMY+2eH71AEq05QZ
         wvkon3waQratIRJrl5MBq/X6sveieN2ieopT0meuepmfVr4le0Y0Sg7Dt8DbBRdJyhAE
         +pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626656; x=1773231456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUNISlqFvuqnxUOZI9HzNXAf4XHNKIKzsl1pT9nO+Us=;
        b=F3tyxqc8eLM2QWDjus/YYYzFrowv4l9y6wcBcAh5OmKcSXh9u+KcnEh9b5DedQtwYH
         zd7UKyhGeFHnZc2CB2hg7uHAVQJrNRJx76fnxN6jEGzSvjoMtGqM82PEZLtIwMmMSjmJ
         ClwZSMjq3eQivxt6ngQinux0ER9CR7Axa+HYe9O4qllj9OXp7v99V+gUCH2uCFWsIMeE
         Qfj6AKUlp2sUBbMVALHr4PEUvxR78/QqtCJqqOdk9hqBcehIYP0lj0I6BrXS3hBW3atj
         K+wMCuBkoEMczn6ZRbIVq76Wl9InAsm2MjGj65aKPjC7zE8Zv0mqYEP4e8ZBd309Cot6
         p5NA==
X-Gm-Message-State: AOJu0YwvVAmaJ/sMSdOn2yNaem82Eh+cFW5k/d0Ig3751KXdAfl1WcG+
	q+XSXlEfmX5zugJy6Gqo1lSwUy63tGFOC/tSQW6ukMh4WUnyph7VMrHvjizPkWdQZlUbrmuPV/6
	f/+iKxLKnuqCGCZeU38BPxQr4FCB0jBd5inqXSLU4jDRvvZGL9lIoyrToWGZFORCGDM02m93xEn
	cv
X-Gm-Gg: ATEYQzxVK+xAG+16mD1WDhL/IXNTKbqCbO+nc51vwqGQGnfM+heEua1bP/GkuPrvJFo
	TIF42E40gl8Z9nvO6Ts4Ab0py8ghOv0y+lvsGhDi9b/LaySgbFq+3dTGvqEynjn5fF+FK63JAQd
	Q8AOxGfF8Tag3bl4GYeNMbl1iQ9B5syA+lRyJ0PR0OUpGwLPjqag5B+ZMx3vmkprmTRmQc6J07R
	MR8cE+M3QY77rUCqBSWyN4Y/5QbPTe//0ykwfW9iA2lvCK4DDF35QdZqX5oKM02PZ4WkmwIf4oF
	nPnV6B/Ic7x26IAvj2rLAwK55N17nyniZfEHRc9NgoYeyKwfosYXePxPinssp5FbBZRXCRmH2dj
	jxP30i3/zIJXE6ylUYbnjmfgCmGAOKqenRGfLZe4IKq8yxX0GSliiu5ZV5HQXl2gFdcQ2lZRrSJ
	PpNPxg
X-Received: by 2002:a05:7022:6ba1:b0:124:9acd:3b15 with SMTP id a92af1059eb24-128b70eb80emr744122c88.39.1772626656371;
        Wed, 04 Mar 2026 04:17:36 -0800 (PST)
X-Received: by 2002:a05:7022:6ba1:b0:124:9acd:3b15 with SMTP id a92af1059eb24-128b70eb80emr744109c88.39.1772626655800;
        Wed, 04 Mar 2026 04:17:35 -0800 (PST)
Received: from u20-san1p10573.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899dfc47sm22171276c88.6.2026.03.04.04.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:17:35 -0800 (PST)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: linux-block@vger.kernel.org, ebiggers@kernel.org
Cc: linux-kernel@vger.kernel.org, adrianvovk@gmail.com,
        dm-devel@lists.linux.dev, quic_mdalam@quicinc.com, gmazyland@gmail.com,
        israelr@nvidia.com, mpatocka@redhat.com
Subject: [PATCH v1 0/3] dm-inlinecrypt: add target for inline block device encryption
Date: Wed,  4 Mar 2026 04:17:25 -0800
Message-Id: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA5NyBTYWx0ZWRfX4xD4dRSMJhv5
 Cuv1B7qkyYFdzTNhI5s7saJwagmYpsjde84EwwDrld/tAkYvryEwKJMb8eCYB/OeZxfXV9jGDtt
 qbccZepPX5QFX8612bAfORUGhvA9twi1IOQNJnGWt6eZa0LgosfxMSjrIohbt0ySMsMScFhglHs
 j1S+YajuH+tuJ73U3RlBLTzKriunLzZ5O/I0RWy68ZArauZV1HF+GFCMQiHYcK/alunfzWcX8Oo
 Um5R1LYfjb/ZbQsdK2wZl9kFnJu2vlPPM32QHKEaD+66053itpUvitYwzKIq+UUZY7s9pukrZUG
 zqL/XI8KCJyVaFSOtVkas88XQb6knwOrzMrelyvO+eIQTPlDxIlGKnTo/XFfzbojJHN7A7glLKU
 E8RujcDjL5iXiIq8b6BghY6T879YAs0A5I6W37PvQr3XLc2BGefUyF6PgcBzk1AHRwV5MMcq2Xs
 l4RThqcJ38Xmvq9MVnQ==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a822e1 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=RSN1029XlG8FoBkqcK4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hOXsbcmlJ8kh6T3U_gLTtbxb7EQBdjoc
X-Proofpoint-ORIG-GUID: hOXsbcmlJ8kh6T3U_gLTtbxb7EQBdjoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040097

This patch series is based on Eric’s work posted at:
https://lore.kernel.org/all/ecbb7ea8-11f6-30c1-ad77-bd984c52ca33@quicinc.com/

Eric’s patches introduce a new dm target, dm-inlinecrypt, to support inline
block‑device encryption. The implementation builds on the work previously done
in Android’s dm-default-key, but intentionally drops passthrough support,
as that functionality does not appear likely to be accepted upstream in the
near future. With this limitation, dm-inlinecrypt is positioned as a
practical replacement for dm-crypt, rather than a general passthrough
mechanism.

On top of Eric’s series, this patch addresses a limitation in dm‑core: the
inlinecrypt DM device does not currently have a block crypto profile
initialized, because only DM devices with passthrough support can be associated
with a block crypto profile today. However, dm-inlinecrypt consumes inline
crypto capabilities itself and does not pass them through to upper layers.
To support this model, this series introduces a new consuming‑crypto flag.
This flag indicates that the underlying block device exposes inline crypto
capabilities which are consumed directly by the DM device, rather than being
propagated upward. This allows dm‑core to correctly initialize and manage a
block crypto profile for dm‑inlinecrypt devices.


Eric Biggers (2):
  block: export blk-crypto symbols required by dm-inlinecrypt
  dm-inlinecrypt: add target for inline block device encryption

Linlin Zhang (1):
  dm-inlinecrypt: Expose inline crypto caps to the device

 block/blk-crypto.c            |   3 +
 drivers/md/Kconfig            |  10 +
 drivers/md/Makefile           |   1 +
 drivers/md/dm-inlinecrypt.c   | 416 ++++++++++++++++++++++++++++++++++
 drivers/md/dm-table.c         |   3 +-
 include/linux/device-mapper.h |   7 +
 6 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/dm-inlinecrypt.c

-- 
2.34.1


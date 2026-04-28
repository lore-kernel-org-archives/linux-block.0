Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D543C07D
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386195; cv=none; b=r/hjulHy1xR0Odud+xk3T/A0/fp07tcjNjBy75ovKVzpOOq8jtuQmD01ugp+g7uWWXaR4Wf7HVqg76cqL10MiYv/kvCJCQ2ZaLW9Lp6yWjxedhLG06JW53bTEWnm7Tw2SivXq8OK7n79IEtyVlNr2J5DI04awORWc1pQ2l0WeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386195; c=relaxed/simple;
	bh=LijrkjFJMpmtl0RFSav1RQXDYuIS2GNEp12OlC/fnQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n58e3t/n0y6pdPBMluZAxrsKS1Z/Kke1WEjjyQGvAMMTr354tkXFOX2bdJADwJlM5OxefOIWTY8uGOVqtGOigxBdvisDOHqZwpgrW+CpYe/keRDrFCsfJOpH/nmd7/tyOkzpQKS3ICbDFdkbY5GVLyrrEopMiELtvKaUvZkWIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9wFGBxw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N5qAoWPK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9wFGBxw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5qAoWPK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SACOdN2928897
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=n4/CmuMpXrsR4zeR3KixXM
	kaiDP4I+U9UFoAoRmEES8=; b=C9wFGBxwZbGqSpHYgzveA7EzaOmjjhvoKBHZZ8
	EZIfHBft9olSpK+OhwZGiP8bPv1yK+KpIVsBI5PUL5E+mu9jB6if/7LVM4B6xmv5
	3hCmLavmsPtblF2qJN5Z1NOuhRr0Qnbt34yW5yE/2skFuZby1sOPsBSR5O7KO0DW
	gLXSq7zvnCVtvzb3q7hj48z9bx1EFTSYAM3m3VgSDG4yMqCqRNW+5hMfKXeZITx8
	nU+eLTWivLYFiAH3TbfvvXf60/bZevkdcOt22fWAwFXS1Q5IfmAaVvBcgp00F08e
	h2DNFP5BZWUTJ1aBVvOKg7Oc1ynB5HzYRSI7gVi2vr4rmqig==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttxh8wqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:11 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6961bda4505so5745684eaf.3
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386191; x=1777990991; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4/CmuMpXrsR4zeR3KixXMkaiDP4I+U9UFoAoRmEES8=;
        b=N5qAoWPKOWvmN7/XT95+5mHqC85xQtO4FyTcWhG0A6lZSOdalWGFzKopMwVKZxWF7I
         cSTbfOhLa/a4+NqasONV6MSBPVWk2bIOdBwImacuG53+KCcdMG9JagefA/r+vDJBhxue
         E9Un6ln62OnBdD+yvCZC7cQT4SMWsm2vg+3Osr3jzUVllXE9kpq5FT8V8wesItkAacef
         KOAfcK9Nv2G9JFeOiVGd81/kC00XQirgO/9PeeyWE2l7xKv0jASOxBVjeEJym9w1UYJf
         ja/ofkXvYIN5Kl0BiKbi6EyamR87IHQ3gXr1ZuEm6JrwtDnMJXCTilPcVmVoorFd2Pe8
         LPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386191; x=1777990991;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4/CmuMpXrsR4zeR3KixXMkaiDP4I+U9UFoAoRmEES8=;
        b=NlUYmaAgvW50FvwOLCiBcJx/TVXrPKt1KPBfhb+CBkn+AOcNfwwfXoJgq6865vS11y
         7cos7AQMFDTJgsuP5XbZXlwTyHJ7XdZVhK6EmhXNk/Vmvf2VhHNOQQOW8NPgsl6sN9+D
         8OZZzFmRTV8VsnriU8L5R+IKFrJrR8VMrSxBRJRc4SlMRpM5c3uETCWhAVbaWQEHqL6x
         QAmJYpPWJ9ewyGI7RzZp0X5uwlkoOB82wm0k2qKPuppQ4TOMCzG/9crYMrKlcgLMkdbH
         e/iVO9rMIuueZw/2hOVOAR86R+K86UN04TQODR1ugXPcjqma12q4tc17egImIsEeRWpB
         8fWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nVzBJ2o5//WlAo3jzn+MVBRK14iTXXKQAew4zcdIA5jS6eY2eqG29jzPz4PnOwPA7EvhJz6yJ45pMrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycI5kDyF5/FDyJfqB3YlWvXNn4qMtczLw44ztrrrG+1yCVODpH
	4hmebJBduty4FQUewhJr2FYIEXMraiJp8Bhmp6MpUrI+E+FAguakMue2HXBCxJDnoeNZtssNwfP
	JtieruqSi8v88ZuqCuW6ng88VmJy+ba8NNCHLc5vRsIwVyIzxdfIYKHN2OXGi11kMjA==
X-Gm-Gg: AeBDieu9KdEX5TOelfVgXIOg6uSfqYN77deJmvS8/kNKkqeSVcAI3Ap1HVAXCazM9aj
	QJvS5I8uM778wtRcNQvs0n10UOlSgsRtZd4SQHwRBbdyVKXQpe6PVc2yNltMlIANcVd/FrGpGE/
	h/d4Yb2taZIsFnst+/kONrNKWwbovQpthgcrqtRJsshg5LYIF5EjN1I+L34NTb6fLZX88b9R5un
	qOFkVjnIW+f3xIm7oxxeXcvFFJ7DMux5+jCa8QWzLg4X2WbbNOouF4fHZZe6g4r8p2UhK6NtuWc
	LgHyqj2O7AqchX/xP0Psm6i2n/RWMk9rndtBaFQ/Fpq/yz+Lr1pgIB9DQ6gmNlOuwhNNQ3CG5va
	psUXwLGlnwDkrmMKiB0ICgttGXu0PXpYpZ4cOi3sx+ki1oWU5i1cArR0Nu6jSliKIeB6ABdncuA
	1uR+pPz5F1ITHQteE3OgmSVLCMG6M=
X-Received: by 2002:a05:6820:1ca6:b0:694:a339:43ac with SMTP id 006d021491bc7-6965cb8b5fdmr1505731eaf.42.1777386190989;
        Tue, 28 Apr 2026 07:23:10 -0700 (PDT)
X-Received: by 2002:a05:6820:1ca6:b0:694:a339:43ac with SMTP id 006d021491bc7-6965cb8b5fdmr1505690eaf.42.1777386190463;
        Tue, 28 Apr 2026 07:23:10 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:09 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 0/9] Support for block device NVMEM providers
Date: Tue, 28 Apr 2026 16:23:05 +0200
Message-Id: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMnC8GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3aSc/ORs3cRi3byy3NRcXZMkYwOLVIuklETLRCWgpoKi1LTMCrC
 B0bG1tQDuQjwMYAAAAA==
X-Change-ID: 20260428-block-as-nvmem-4b308e8bda9a
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX9dxtdPjP9rAY
 OPSGHhTZXSjtkqHZAfuoZr06Bxp9QDG3lYymZhqpfGVYB9VWryzKzOBumo7rJfQmoJrv/s3Yr9x
 GbOcvMMCMq9h3ao6xhkoqtq8hud5yghEFr7ghg04FCNB81B+Xk+C0LE+fGVe0GC+XGjUd4PvdLu
 5sLcHUJda39GB+50dXEyDiju/SHtW44lVzPQy4I9YLpxfO7l4CuLaxNoBVILJQrDuC/XOdnzuTN
 R5NT/HfP9iVPA+XtCIQABwGkxInOFI9cznBLNzU5haI9D714pVRqKRUqB2GxxT4RxexAuhXUnEw
 jIHQBOsqgLcSfLDqbkYnMWiTXn6qasmOLtTww6nCphUATOUIKsYFNkJm3QDyy1EmIfYoGzi76ys
 rmNLkYA8IyzouMxpZ4rIiEwLi8w2VU2VgvR0FhLFX21KjF/iB/kJRtoYJHkV5lXX0TRKC3Qr8VP
 9vIuQuN9qNc7g4bl9pg==
X-Authority-Analysis: v=2.4 cv=Uu5T8ewB c=1 sm=1 tr=0 ts=69f0c2cf cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=d2RCo21-rtVxI0NFAHcA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: wEAXj3CXfTQkBLmokVJdK3-wHfYHuCN4
X-Proofpoint-GUID: wEAXj3CXfTQkBLmokVJdK3-wHfYHuCN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

On embedded devices, it is common for factory provisioning to store
device-specific information, such as Ethernet or WiFi MAC addresses,
in a dedicated area of an eMMC partition. This avoids the need for
and additional EEPROM/OTP and leverages the persistence of eMMC.

One example is the Arduino UNO-Q, where the WiFi MAC address and the
Bluetooth Device address are stored in the eMMC Boot1 partition.

Until now, accessing this information required a custom bootloader
to read the data and inject it into the Device Tree before handing
control over to the kernel. This approach is fragile and leads to
device-specific workarounds.

Rather than adding a new NVMEM provider specifically to the eMMC
subsystem, the new support operates at the block layer, allowing any
block device to behave like other non-volatile memories such as EEPROM
or OTP.

This series builds on earlier work by Daniel Golle that enables block
devices to act as NVMEM providers:
https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org/

It also introduces an NVMEM layout description for the Arduino UNO-Q,
allowing device-specific data stored in the eMMC Boot1 partition to
be accessed in a standard way.

WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
Bluetooth requires similar support, which is also addressed.

Note that this is currently limited to eMMC-backed block devices, as
only the eMMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Daniel Golle (1):
      block: implement NVMEM provider

Loic Poulain (8):
      dt-bindings: mmc: Document support for nvmem-layout
      arm64: dts: qcom: arduino-imola: Describe boot1 NVMEM layout
      dt-bindings: net: wireless: qcom,ath10k: Add NVMEM MAC address cell
      arm64: dts: qcom: arduino-imola: Get WiFi MAC from NVMEM
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Get Bluetooth BD address from NVMEM

 .../devicetree/bindings/mmc/mmc-card.yaml          |  20 +++
 .../net/bluetooth/qcom,bluetooth-common.yaml       |  10 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  10 ++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  30 ++++
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 164 +++++++++++++++++++++
 drivers/bluetooth/btqca.c                          |   5 +-
 include/net/bluetooth/hci.h                        |  18 +++
 net/bluetooth/hci_sync.c                           |  56 ++++++-
 10 files changed, 321 insertions(+), 2 deletions(-)
---
base-commit: 47c4835fc0fed583d01d90387b67633950eba2b2
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


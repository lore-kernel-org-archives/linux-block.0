Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3C3ED3BA
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270463; cv=none; b=ntaDH0nW4mg4Ootb5a4f8YvQAPQKrY3oAg6P7VQ22AARWFicLqvvaOXI7SyIk2TpqfHQ5QsPvDJgbIGWIrfkQyRo/+5sshvCLnJXMzSg2kinm+HLwhpsxUntGTUQl9bssEFW1g3VQbHfJx86bewPE1UytPHW/f3c23BOyoQSnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270463; c=relaxed/simple;
	bh=GA2hcEO9oG1ygBpxn2AFU64V+84wXeyP6S4shCbyzro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AEomMQMqSCmXxjS2/Qfbf+OrRcr5B/NZkj4VhMwCNyFHgFjVj3EvKFnbA8LgdTmnlG+CM/XxLogP2lbW6iTBtn0NYsaVHce2tX/c+q4VZEhdIjGS4jSfIWCUA5WCkxRp7Rraue732P1y31lOWEVMToG7rZ6MUB7v48V9jquc/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oaJQapJL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dJk7jie0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oaJQapJL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dJk7jie0"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCixIC3748918
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N1CimfNGzeKqFKCWpq+lvs
	mNvHBjXLnVmVAB9wSi3oU=; b=oaJQapJLrzpwrAd1P0fqL/Enj+7GGiLmyyIkgE
	IpUoFqTTWP10vsWx/Xg1UOSE4POfkZYqAILg19xsc1JQHg08RGu0ckRWYak2OUMb
	nXwBOKdplLb8F/C7uPC7wofZZy3UwQprLAjDKUasFbS/qoo8VarphtlqwUrI2EWH
	pWOEBWoBfttfxYnl5pXNq7Bu49adNtN9J1QN5d7OhmM/jBmm+cMRQQGaMGP2OkbG
	1/WZp/f4Sf4GUJSB74sJnvoEAYS5Ln5sN+dUd+rZJhuJQeM6uqszs8vy1BTN8xvF
	mH7zIP2wlG4foxVhYPJ5lWR1nWv9+lx2FO8eN0CiR9UgHj9Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2u42vpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:20:59 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-963a02dca36so928175241.1
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270459; x=1781875259; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1CimfNGzeKqFKCWpq+lvsmNvHBjXLnVmVAB9wSi3oU=;
        b=dJk7jie0ALcDuhuKmQRiZ8I8FdfOfQSIjY168uPfedE2WH7WAr1LVBMgNfjnehE+73
         SLNau3j0jcK77CBa2wJJ3VWyBlgK8y/a0QP1PecuK5Wm97duRo5O8+mlA5W4OIcEk76p
         Urxf3rPngq8wcGSvc5hnJRf79qPfC+dDPPcaUdgBktg/FfYMRAG47gA7Es/nSEo03+xN
         dnRewhXzwMGFBuiZMEiRZl74tmD2HZtItmJTG1/wCg//sNqBsJjAWGFfj25xig21D0f6
         epHCcnlooml8eMqdxkhiz4Fouf/lIxBibfTDAMDw72XR6ixipaMriovaAn8J7dZPQJzR
         J+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270459; x=1781875259;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1CimfNGzeKqFKCWpq+lvsmNvHBjXLnVmVAB9wSi3oU=;
        b=f5ViLXz8q8MNXUHDegguEFGzU7hpdUzHxWviW6QqsmZfXrxF6bqffP61KmVoBhCAy2
         6MZN+IX9ro7n8alPltvaHEH/6wtM+cnQsreeHQxmhE478/0nx8pjSKSqALQQR2qweTFq
         ShoPBgOKYCx/7ndMm6K61xC+IMc+J5QyuzHnxZEPaQvTvCH3X7Tv5d0/GUEAxRJLYSv2
         CuSyH3jLZ6zXDvcK+w65aDF8Jx80LikRVo2/ClWzninbetsf6bMENmgQZwxD2UpOnYmF
         IMhenATs1SIa9p0LSLlFvIvixH1dQJWsU83BnOidLtNd7aI/Tw3ojNjQR/iNLCtSISuv
         zaUA==
X-Forwarded-Encrypted: i=1; AFNElJ/hglVhZo/s+C36nJa6aLFAiriwY4o5wdGwjOdfDow6ZgsU45L9uvoVMcV9PmXaRYcF5dQIYsB3NObA2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9bbN0JTppM+40xSmZ2lpRVzGkhla0G6x7J4A/RaBx/XTpBBa
	MaoI1QyYlY+4fXLPSEQnWSRYSat7fE7BEF0y9IxTP+wMx0CTDgmwyTIzCkQZrvsdBeADZTN8nTY
	Fj/4wEMlSjnlDC8dXA85F6KcivXjOjhl4MqpUVsj0T1n8vr6ZlFFxcTi+1MpKHP7eAA==
X-Gm-Gg: Acq92OGVbCYoZMyBqqIjl5JIepQpjtcivtskCZhW9HwGcmF7MFVVa8iAX8WtoKpD7hM
	TN2hImTowJldTdV+Da7aV0bFhk6VpiX8LtDe7rSuNnauPvPGCqGzdrFl2LWeIBvlPlHWeU2VL30
	xYsyTmF5scbkLCG4WShCiddxcA5iI+BvZFDMy+p1H9BgX4BWINYmiBGhYj7Biz23PzzVD8H1DgE
	nwi7e7B9+q+CliI9k+2aQWzDYqQd3spXIFru9dTJ7Ks7zj633rsnhCHhQ1YR4HzM6kWLWrqumJb
	TYZTP2HTm5JwJODpYP1Yt/Oxcjxti+rMmn+5lo+3XJMWi1Z94u6WHaY1SF+8hWrHoxFMTdhgJPT
	BYWvzSMxyHqmWUeuZfE/q4/QaDQ41Y/PLvNF9WIqfeGEIhZ2ZmWbKEM/KWK33wCYpc8KxJx9gGp
	mgQnsf2HHNEAg9xMr7wp8zKBr3auNfov2b7KJdg4gYS3kChZQsg6GktAzPbSHVQAuWsJnRCLZY
X-Received: by 2002:a05:6102:580c:b0:6ef:dc8c:9367 with SMTP id ada2fe7eead31-71e88adcb08mr1374108137.5.1781270458899;
        Fri, 12 Jun 2026 06:20:58 -0700 (PDT)
X-Received: by 2002:a05:6102:580c:b0:6ef:dc8c:9367 with SMTP id ada2fe7eead31-71e88adcb08mr1374007137.5.1781270458425;
        Fri, 12 Jun 2026 06:20:58 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:20:57 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v5 0/9] Support for block device NVMEM providers
Date: Fri, 12 Jun 2026 15:20:52 +0200
Message-Id: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUHLGoC/3XOzW7CMAzA8VdBOS8ocT6actp7IA5O40I02rAGo
 k2o777AhUmlF0t/S/7Jd5ZpipTZbnNnE5WYYxprmI8N6044HonHUJuBACs0OO7PqfvimPlYBhq
 49ko4cj5gi6weXSbq488T3B9qn2K+pun36Rf52K5SRXLBLQZQ1BjZCvxMOW+/b3ju0jBs62APs
 cBLMaJZKFAV38uGQjBSaVpR1EuxYvmLqooD62RvBKIyK4r+r7QLRVdFm0YCWQ/Q2TfKPM9/L61
 ZOoUBAAA=
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 7YkJRNw-QXPwFbjOr_N8tBsknpBWGqLm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX7bqeKtKjV49C
 hfaR6Fsg7nHGrxs1rgupCz46yhd3eSWtZsAnY9KduUtvryeLFduLP9X2MtGSbTE+VLERw4TfeMg
 0bT+4WldOTIrG0UWmJNVj8rpDmNxHrA=
X-Proofpoint-ORIG-GUID: 7YkJRNw-QXPwFbjOr_N8tBsknpBWGqLm
X-Authority-Analysis: v=2.4 cv=N94Z0W9B c=1 sm=1 tr=0 ts=6a2c07bb cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=H1RoBJpM21yDxn_SvroA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXy6iLNtX7v4ik
 YXWY/DMKxf3N6flDHwY87MmWiqmxR8rBq729vm4yAfdo1rVz0hj8yTGizKe6CipquJTB10Xhd7f
 8jDzlfEI7GRRL5fuhLSL7qsDFEmX1lkryvLUq/Scs0rQ8R0lvQx0VEXOAoyjwQ8TvhR77Yz94jv
 SGP1ZK8SqqNC5B9rsBTYiaHEObq7i8+1GkJus5feg2EcClZfqzN2mtPrscMPk9QhxWmcdmiC6M5
 FTNqhla5zQP/DnhZGkYCh4Of+DwmVvaVTSId/yq7jV/dUg065cCHWBs3qStmLOLisvfqZqtihQ3
 ToqkenDc2KejwZDqtt0G1MCIwduVpJJz+JFQxrBg+O2gqPggazI61Cruk7TmAy79RZjutlCEeqd
 GW4gLU8ryPh2yv7SlXajFM4EqrLU9tShJ4QTxu6SQfREUSJZes1F+i75VFqmUgVQTueiJDf7zXk
 qM/gpR9HFyvbEl1FrZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120122

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

Note that this is currently limited to MMC-backed block devices, as
only the MMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v5:
- Fixed ath10k binding issue + extended commit message (Krzysztof)
- Moved blk-nvmem handling to block core instead of a class_interface
  This allows correct/robust integration with block device life cycle (Bartosz).
- block: partitions: of: Skip child nodes without reg property (sashiko)
- Link to v4: https://lore.kernel.org/r/20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com

Changes in v4:
- Fix squash issue (dts commit incorrectly squashed) (Konrad)
- Use devres for nvmem resources (Bartosz)
- use __free() destructor helper when possible (Bartosz)
- Fix value return checking for bdev_file_open_by_dev
- Link to v3: https://lore.kernel.org/r/20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com

Changes in v3:
- Fixed missing 'fixed-partitions' compatible in partition (Rob)
- Fixed clashing nvmem cells, document calibration along mac (Sashiko)
- Remove workaround to handle dangling nvmem references after
  unregistering, this is a generic nvmem framework issue handled
  in Bartosz's series:
   https://lore.kernel.org/all/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com/
- Validate mac (is_valid_ether_addr) before copying to output buffer
- Link to v2: https://lore.kernel.org/r/20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com

Changes in v2:
- Fix example nvmem-layout cells to use compatible = "mac-base"
- Squash WiFi MAC and Bluetooth BD address consumer patches into the nvmem layout patch
- Fix possible use-after-free in blk-nvmem: bnv (nvmem priv) linked to nvmem lifetime
- Simplify nvmem-cell-names from items: - const: to plain const:
- Factor out common NVMEM EUI-48 retrieval logic
- Reorder changes
- Link to v1: https://lore.kernel.org/r/20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com

---
Daniel Golle (1):
      block: implement NVMEM provider

Loic Poulain (8):
      block: partitions: of: Skip child nodes without reg property
      dt-bindings: mmc: Document support for nvmem-layout
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

 .../devicetree/bindings/mmc/mmc-card.yaml          |  29 ++++++
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 +++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  39 ++++++++
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 109 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 block/partitions/of.c                              |  20 ++--
 drivers/bluetooth/btqca.c                          |   5 +-
 include/linux/blk_types.h                          |   3 +
 include/linux/blkdev.h                             |   1 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  39 +++++++-
 net/core/of_net.c                                  |  49 ++++++---
 17 files changed, 345 insertions(+), 21 deletions(-)
---
base-commit: ccb7390d6cdb23b298a6e2a7028ec134dfc4db10
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437892;
	b=VajKgOdYasnwd53lvIepg78r0MvC2i3+ZxP56zYGXt2v4ZtMzLVfmoRHqk0tgaOWLHf2
	 5t6ZoP2pkLmRfqYDl7qZndUeeUA4mJuIMYZz8TZ3veJws5PtxscFwRX9C9+ew9o5cOJjZ
	 v6cD3OTJXTG9cDhRotkNdQcu3lsoankHzIodok2BtTnq8G53euHMpxJ94VFCP+aKbFJS1
	 RD0P6J3G5NjyV9rCYLgzBlwDPWFurAu37xa/6lqV6APQr0DROWRnH9Uf1ItGMDuhuvpA7
	 ct5iF2xu4Z5fNsd7VKK9XQ6mf5DSP5kjwgUpoMgOFNw6/tP5Ynz3r47RtJmNFezhK5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437892;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UXlVpOLiSO5S62UBB5qFydN/m7fwmuZwW+kaCTezLoc=;
	b=yd1rhKOLXtnXgiUT2iK+ep5BsXSxvzfWsGSl4uaXff+hwBvm2ykYWQ9Llv2oQwS46Khl
	 OVOCJzeEOoPVQFPrQ9Hn7lAMD7V2fUIlsOL0+n1RsSeNKuuH/sq3qN6KIOHjwnjWfleRp
	 SrohlwZFg1vDlnOa9+nGh9ggpcikr1gANOn7bCGFiTaKtdM1DoF4Y66eAELX9nmPDQK5a
	 f1Na1+64+0hSg69JV8kUkb7mrgod30HwNf9Hm8vlNGZxkTDYyzI5mwTTyuylHuSkK4gP6
	 E5WyRUa4erKegqRZxNLgvRkkXHTi+oB3tC017snrQzS16rHsVZulbOSmqnKo41rhm8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b1miocEQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bYwdmFKP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4331606A321
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 12:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4331606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b1miocEQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bYwdmFKP
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCG1p2301764
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 12:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UXlVpOLiSO5S62UBB5qFyd
	N/m7fwmuZwW+kaCTezLoc=; b=b1miocEQQqILL6Olob3/bgsy8jEJsnBMIlfLPs
	DW4MMqstjg81wlOiEXMcLAy4GgpbkiEj3A/lAmYp6qiXCaF03Dyr7dZFiZrpbHYQ
	pJVE1Hke4J36LvfLN9dsaDJMzcrp8egZzIKLa7wa/LZXm9oujA4Yfmua5Ih83ZNw
	jrXNv9Sly4xNUMAbaQKlxlSfp3mmLYEq1VEKSJobaqvFYSpj57i+m/6wRx2sWw5z
	kuyPrlpps3cO+u364j/NE+q/Yz8ooF7UnblCblcetN+jY6ffG0+dmSGSiaGuA9yD
	oIwS/cnfTZoStWKX9ee67C+TLKjgxFyxa6YiuJv7O4qea22w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g741dfk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 12:44:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9212335e257so68709616d6.3
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 04:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795437890; x=1796042690; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UXlVpOLiSO5S62UBB5qFydN/m7fwmuZwW+kaCTezLoc=;
        b=bYwdmFKPp+Hk0x8THolRMQpoGPMaCILA4iHXkFMckf7Gr+dyLV6sBtQgSkEX4GvO6G
         b04hcwAhHkCJYxEcgolnJF9NfVF2xh3x1nRFaTUOhqz5Je8Q1szBmN19Difqaz6+20yT
         jm8qBQbd5kKrTD8dNNMvBVn4gv5j53IeDhQ+i8x0YTZu5zs8bwg2stL0Yjcnt4oFR9R8
         JYlgbMyNfDu8MH02sFMP6UP51PwtSiwLkIuzbEJghZt+3sgmXXhl5IjedYlLp0aVzXnY
         oonQSM8gvf/WPWO8Kd9xq9xmU28glDZY4vBSE43ARrKWy/0xXJz8HJ0GBUrYhTzqES4w
         UoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437890; x=1796042690;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UXlVpOLiSO5S62UBB5qFydN/m7fwmuZwW+kaCTezLoc=;
        b=b5F5kF8yBt2Ua5nJ2cKIcff2egTt4MijqJmOeXDdTBs4iL8EHv09Lwqw8VU9quC73E
         C7/8P3p+qimwIvqZCFY3J5z5CmPXl1qbVvnQFKwYJ4KOUlROIRGKcisOvpDjbbwivcZY
         daqG8Vdgqhl2xjMlTo+aE/2b4ZoyAMm9kQ3OjoBwF9PZ78WOon/nxCX7hXa2TetbjVvE
         VsgnnaZHjR+7SbF1qWSuNbgAZcGSbbP6384UJ2kfIw04jVActiDv6IXJdp1JxjYOGKJo
         krJAQDhkfMIlUa4aLKJ5kQh8SPhP3qupwXPnQpUzxngyDTFfCF2tXrAvctCUCIGEiPrC
         1Z0A==
X-Forwarded-Encrypted: i=1; AL+hErHQaZi0FvU/zzsosgoQ9QGBiXcw8gDdt5GAItF2LuEfZXl1wlmQtJW0UAfeymmlQhHLwRxaYIhaYxRDhA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dlfpAmHykpM6NOE4qY99NXToihyHnFHXdD1+HvkJqVQ7Un2f5
	5pkoIAgv+gdrIyT7A/Bdmc+855yyr053VrVYuLIshniEA31u5uVij75elzzi3bjA+/4vwBd5cBV
	hH7UQSvPeIh14MhaOVWBklvd+K5saa1Z7p9DuCZg2kGIRFIqrErSJ1vKsp6BnmsnXcQ==
X-Gm-Gg: AZFdTZfbkhEzYeHOO2taYkltHvdg07VQ5WqhYV4zQOKM4sH7F1Ll9CrY2/rEMC0nsFw
	+MLGUgj9hGRk10noJhr9TNflDLuH8KxlxDdZ3a0ZvH7csqJaRXNe6WD7vFf+1/5TPD/5J/t/Elt
	uEmHwUp3uV/tU67XFc9KgBdw4RdG61SZM3M5b1d2Ue/PBoUnjOSxPyXgZ0YTMk0e6vhTdI/r+uf
	OoudyKzOxobuzJVDjioi9kgoeS7GAh45YwnrjoPAKFDZDDVOLuVtYlxQn7JswcEUSfBF29QBl0l
	O/MI5AEbWnrWaUPB/j2E4/+5q51zhuSQwMAm4ae4g3oEbT2grXcEKZP1t/LICFxk8+532De19Pp
	G2XfFpwmDHLUNgyXeLs0zOg0hnDm/GhXFx77u9ey60N+ctINkgatPfxqqP4aJ2mxzH2AMl1xfXc
	GqM7MEjA2JxlHj0wy32N2OZ5WMRa2T6N4ypJqEPKULo5kjW73qE/UI9QTIG5ugIiWOgOVEMu+KJ
	xFDVK9FJqBq6KQJV5agRZyMnEjy
X-Received: by 2002:a05:620a:4106:b0:949:61c5:73a5 with SMTP id af79cd13be357-949bab4dedemr1955822085a.59.1795437889688;
        Mon, 23 Nov 2026 04:44:49 -0800 (PST)
X-Received: by 2002:a05:620a:4106:b0:949:61c5:73a5 with SMTP id af79cd13be357-949bab4dedemr1955818885a.59.1795437889192;
        Mon, 23 Nov 2026 04:44:49 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm649355875e9.4.2026.11.23.04.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:44:48 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v13 0/2] Support for block device NVMEM providers
Date: Mon, 23 Nov 2026 13:44:43 +0100
Message-Id: <20261123-block-as-nvmem-v13-0-96ffe1f59332@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADs1BGsC/3XSzU7DMAwH8FdBPdPJdr458R6IQ9o4rGJboYUKN
 O3dcXdppZBLJEfKL7HzvzYzTwPPzdPDtZl4GeZhvEiB6vGh6Y/x8sbtkGSjISALmnzbncb+vY1
 ze1nOfG51p8Cz71IMsZFDHxPn4ecuvrxKfRzmr3H6vV+w4LpbpRZsobUxkWJnMEB8Huf58PkdT
 /14Ph9kaVZxoU0x4AqFROkyOk7JoNJcUdSmWCjfokTxZD1mAzEqU1H0XgmFokXRxiGx7Yh6W1H
 MTkEqFCNKMAwy6pxzgIpidwqVb7GiZCCZSeqTtqmiuE1xgIXiRFGZPYHhDNFXFL9XVKH4tSMfW
 VGXex1qPx12ioJCCWtHjoIyHl3qckVB2BgPtowdrIlhE3xH0cjwas4WXwQ0pbPmN3sJbu909q4
 2YdwCjAjld+Oa4KwjRYkf/O/cbrc//KVE+rwDAAA=
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -mA6lN81-TsqOY3BBNOc-tydkMq3Xn69
X-Proofpoint-ORIG-GUID: -mA6lN81-TsqOY3BBNOc-tydkMq3Xn69
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX8ust0wd+Pmhm
 J/uz5Cd/teePBPXLGVGYiBpFQRwBNEX2rmJtesVYS6a3n6YDygxqOk5xRxfVjxIn9b+qOWQZh/C
 Dkq8TU4Agz0zgGfCahoj7RPy87sS4po=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b043542 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=AqFB1GJ6SRIpTNvHVg0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX/fgcOHWaklIQ
 62kLolrSjQSfjc9Gj67ESHUbtg2M3f0K9cAQD3luIZy4eqP0czwbw7JGPgLwabwSdjFCPsm33mx
 qdPwjxFFvAKFvLylllVhlCSj/LvqVekKuOvlTQHQWfMJtLUnZH+TY1zlHkAvhZnLu6wtUdcqWlO
 GtI2mIV6FaW6fAcSrD1jHVoFRvCGvKmYyWS/jUMTBU7i9VMTsOuzIDoC4O3j5osP4FRsPPMsn+2
 Y8lGdKb0zfB/BYVxXaJgzBTqBpVKdUEBEgf7r5ADfwpPTvEKXmmndwPT+UieonpLnm5MPSZ60OQ
 q3r1/v3oZzGKRFItE2ZiPR86pqgpuEkUQsgE48WIZUYDVTNvgPaAB802Vt7f2FJsDEuJQg72IWj
 5CTaJ+qZKEB7XJrFUqK6+P7p4b+hxGD/4bw4CE787DA/MMQaiBbsNxIJB6707jzqG0REW6iMkE9
 emUE6Fb9IWGShywmWww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230050

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

Note that this is currently limited to MMC-backed block devices, as
only the MMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v13:
- block/blk-nvmem: defer the NVMEM registration and removal to an ordered
  workqueue, fixing the self-deadlock on disk->open_mutex when a layout
  driver reads the device from nvmem_register(), and the ABBA deadlock
  between disk->open_mutex and nvmem->srcu in nvmem_unregister() (sashiko)
- block/blk-nvmem: use bdev_fput() to yield the exclusive claim
  synchronously instead of deferring it through fput() (sashiko)
- block/blk-nvmem: sample the block device size when queuing the
  registration, so that the validated value is the one handed to the
  NVMEM core
- Link to v12: https://lore.kernel.org/r/20261102-block-as-nvmem-v12-0-f4a2a681087d@oss.qualcomm.com

Changes in v12:
- Simplify the series and remove consumer changes (BT/Net) that will be
  submitted separately.
- Link to v11: https://lore.kernel.org/r/20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com

Changes in v11:
- Rebase on linux-next + resend
- Link to v10: https://lore.kernel.org/r/20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com

Changes in v10:
- block/blk-nvmem: simplify read error handling (Christoph)
- block/blk-nvmem: verify dev_t wasn't reassigned before reading (sashiko)
- block/blk-nvmem: drop __free() cleanup for explicit of_node_put() (Christoph)
- block/blk-nvmem: init static nvmem_config fields at declaration (Christoph)
- block/partitions/of: fix fwnode ref leak on skip/abort/error paths (sashiko)
- Link to v9: https://lore.kernel.org/r/20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com

Changes in v9:
- Add nvmem support for partition blocks, not only disk (Christoph)
- Prevent concurrent exclusive access to the block device on read (Christoph)
- Add comment about nvmem being a side channel for block device access (Christoph)
- Link to v8: https://lore.kernel.org/r/20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com

Changes in v8:
- block: Fix bdev->bd_nvmem on registering failure (sashiko)
- net: of_net: of_get_nvmem_eui48() now also rejects all-ones cells (sashiko)
- Bluetooth: mgmt: account for HCI_QUIRK_USE_BDADDR_NVMEM in
  is_configured() and get_missing_options() (sashiko)
- Reword blk-nvmem KCONFIG help text to satisfy checkpatch
- Link to v7: https://lore.kernel.org/r/20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com

Changes in v7:
- Rework bindings/dts so that the eMMC boot partition can be a nvmem fixed-layout
  and not a child of fixed-partition. (Rob)
- Add Support for fixed-layout as the nvmem device node itself
- Remove "block: partitions: of: Skip child nodes without reg property"
  This is no more required in this series and will be submitted separately (Rob)
- Add missing linux/cleanup.h and linux/device.h includes (Bartosz)
- simplify nvmem_register() error path using dev_err_probe() (Bartosz)
- nvmem_device forward declaration to blk_types.h (Bartosz)
- Add hci_dev_get_bd_addr_from_nvmem() kernel-doc for return value (Piotr)
- Link to v6: https://lore.kernel.org/r/20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com

Changes in v6:
- blk_nvmem_add() returns int, error properly propagated (Bartosz)
- Redundant if (bdev->bd_nvmem) guard removed in blk_nvmem_del() (Bartosz)
- Size guard changed from UINT_MAX → INT_MAX to avoid signed overflow in config.size (sashiko)
- BLK_OPEN_RESTRICT_WRITES removed from blk_nvmem_reg_read() (sashiko)
- Link to v5: https://lore.kernel.org/r/20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com

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
Loic Poulain (2):
      block: partitions: of: Attach partition fwnode to the block device
      block: implement NVMEM provider

 block/Kconfig             |  11 +++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 197 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   8 ++
 block/genhd.c             |   4 +
 block/partitions/check.h  |   1 +
 block/partitions/core.c   |  25 +++++-
 block/partitions/of.c     |   3 +
 include/linux/blk_types.h |   4 +
 9 files changed, 251 insertions(+), 3 deletions(-)
---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


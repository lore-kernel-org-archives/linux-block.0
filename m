Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22343E4AC
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427242; cv=none; b=X1zXTkIpA+loPZ5sr15QgfAD6c/0SNYnjRJQaCXcEHT+3Cc0w9dMLEJRs78+mYoG5UizjpvzBzv/U6MHVKbhIqRy27V0GHsbxbLQSIebzjktQsS2OFix3rj4R5b1/YwzOL0w/Bx1ZhGLIf4LlXsn8Ao91Wjas//w4la6+DCh+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427242; c=relaxed/simple;
	bh=4ezF0rq/B5oz9iEhUrAxzneVFMYGirpP9HkYZfMOtR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c0BepX5uvniLp2AVJ4PzNP2Lo7OGzoBD561I924GO7eLOO+yotLfiVhJ98HpO5+JcfKbMHT+xXpToKnWm51mj9mMLPX/9gE/zo65NojPwKqvJJ3FnPWClqIj4XAQFimRFbGeC4DVuMfjYYsGd7hMziDMjvFJvCfdNFHitcQSWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kNdbGaEx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DuTvZbrz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kNdbGaEx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuTvZbrz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFRD8s1088697
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=B4zwD6yt/500H48+4ETnP6
	OGaSwFDNT4rMvE93Qd9n4=; b=kNdbGaExZTGsb0OciycAs2Ibt11TyFMMA/hOfU
	nEwR4Zj7O0NKp3BKDXZgCROzPJ5SeYdpPioCR8/xjyLPEQnK3zLnqojpfwMjKQAy
	wL2UeDPOCHXqF+KmD2kUogWrcpJXb8jyZ5cczDbs3NwmalJJosvTyGnhRuBHRsXq
	HKwD2Mio9kL22DPaCIrK0vxSBsgyUyAuYqMqHOkzcVyHK30z8/rUQqvb0vXtb0dQ
	VnP5Lp5L21e/SRgQ97WrTjEQQmafCMiSs7UVzAe8kQ7TZStU4Ez5MNDOZTAvWNdv
	+8Tajc2N9Y/02ZXVpjEXz9FuHkdAQSIMDxIvWrT/eE1Tw50A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n38crv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1a97644aso25861371cf.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427237; x=1786032037; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B4zwD6yt/500H48+4ETnP6OGaSwFDNT4rMvE93Qd9n4=;
        b=DuTvZbrz4Iu+GkvYkFi72IPUlHVcPKBgwqQYqtSWe9EEgCWxtDPu+HVKDhXS5hPW34
         /V+JOySfdVX0lr0z7HUhkc8bDk+X5acY8J9HM0Qx45t+lMHxQYra9m5VoS5vnsCbu+ZI
         FCqy9hVDNATXeb47Epg8duvbuWt3G34YvvLgllY7C6YBAEjPQLzoaKVdUbrIfkHS4RFs
         xjB9G0Z4pOKdN0U8wDX252Rjiqmmz0o02qg9CQPdNpKpRFne6P8j3L0mCOiDbE5gq5C8
         4R4yfPd4OZ3z/mSGm+f1WQUtWh37rUuW5dGpsd2Wml+0RvlGmQcgoH4OmtXkgJlhGHzT
         hmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427237; x=1786032037;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B4zwD6yt/500H48+4ETnP6OGaSwFDNT4rMvE93Qd9n4=;
        b=XPAbGVjnv9M5Bh1RQprzErnw/Bywq+uvNsFnWGvWD8bcu+ffsw0HuV+PjOwqAq9ivs
         1OXQbqxQ3VzhkEoFQUEZxjNP/yJVOB0z0EYsAO9y+5h+j8XDco9W2kfGka8s3497G+7u
         GlX/bih91TP73iUcDRQgAupNZrCQlOW6Hf4NhmMIEmQRb/kr8QtqRHJFp/Wy8FBJx5Le
         wSm0zVz95Ysw4Yorw+DaRgPCyjtkyFe2RE6elnRbJ2CdUqX1zdGWIPcbshqH7D6ASQzI
         xueXA/eGjEJceQ3SwzoyTVur5KxMpItDqTwFiLxDqzdp2513pksY+JitZF2u14hMG5wJ
         plhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp39fi1xHwwsoWF/W9u+Uq9L0SZqc6U+dfbI/ujQXxS6adrfRtNVn+8N8XU1j8NOvooZ8XvKVAjhzw12g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9sVfrnGLHl81TkC1cWuu1f1WW1fczXixNCk2c5YxdiyDcWtZY
	sw8PHDSWaJEHOQ6CBE/wfsigh0imA1oYn2tjUTz+ZhjmhFsMgO6Xfx6DVqU4b4pRidYW1fstovs
	QhXDjJJEyjfhA/DAJoOmCkAbTG1M25qjBRhJzJM/ET53u1syYCvQkgk84dzFcoLQXeA==
X-Gm-Gg: AR+sD10e591l1lNg9GixsMXRNvA+mMPpntWGqRIlL8KSJKGNTK0xLFMyoGeGcZskjQ3
	XG+6S4b2kteh1Lsv+dyQhZdhxnquW4i7FV/CezZGECPHao6wr1lWS9UKzDlqiO8WrD44jYVfPJ3
	dHsTkgKTX7gj6JmB9Ac0QlSbKl9LevcMKOAkiyl92iOsSvaM/FsrotymPy0ESF8SsXvVVCEDw+X
	iN0QaxE5eum8eE3+Fe2chmXOsSnWvBT4kL4WB5ok4G61hwmdMZabGMx+CdrdetmPMVbL7QOn16P
	Dnu26ztEUBVsh9CJURx2w8jkCC4QR74AIO3o0mG/WLPK0IzLPG7hsbfGJCO6Q+0QUNxDs5lkMA4
	pzPtx7kEvSqBYJZmvzF8HppdK2bss9NcdfW+ILcA4EsuZTLX7AfGqZBXQMJyIx0GbzLpeO/ivXT
	yjCwfW3aYILrqBp7caRJHSdCxc84coAy4ljTobxQ==
X-Received: by 2002:a05:622a:111:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-52b386c3e76mr34024181cf.65.1785427236295;
        Thu, 30 Jul 2026 09:00:36 -0700 (PDT)
X-Received: by 2002:a05:622a:111:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-52b386c3e76mr34022661cf.65.1785427235260;
        Thu, 30 Jul 2026 09:00:35 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v9 00/10] Support for block device NVMEM providers
Date: Thu, 30 Jul 2026 18:00:30 +0200
Message-Id: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB51a2oC/3XRS07DMBAG4KtUXuNqPH53xT0QCyce04imgRgiU
 NW743STSMYbS7+l+TSPG8s0D5TZ6XBjMy1DHqZrCf7pwPpzuL4RH2LJDAENKHS8u0z9Ow+ZX5e
 RRq46CY5cF4MPrBR9zJSGnwf48lryechf0/z78Bex/japRXDgJkSUZLXwEJ6nnI+f3+HST+N4L
 A9bxQU3RYOtFCxKl4SlGLWQihqK3BQDdS+yKA6NE0lDCFI3FLVXfKWooihtBZLpEHvTUPROEVg
 puiheE5RVp5Q8NBSzU7DuxRQlAZadxD4qExuK3RQLolJsUWQih6ApQXANxe0VWSluncgFktilX
 vn/Ln2/3/8APLF6V50CAAA=
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Ar/eGu9P c=1 sm=1 tr=0 ts=6a6b7525 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=B2QLtKVpp-MixIsELHEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-GUID: TNzbhO8vE4du9Z7UjRyIizFH45aLImKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX0ogYmLIbQO1N
 dpOWwsI7S+A0CqwYR21GHvBGV1TiJVRhsGIElcvVrqyzkDGpLsvYO6dTfr0xEUgS1W9ZZvuK8eh
 G7ArThlmYljmdTeY2fUQmm3KdjAYLPjSX94uGyot7yH1LQ7hBsHbHe+AqbtvYnFLEhpIVimLZ5l
 l4cj9cBuG+FrlWcVZtKeYECCb+K9aSwjdpYkIQeySigXtHCFMLwzwQdOmrWSKLnEq5HhufZJymV
 nxWcIxEkmbqW1AOQnscgPh20NIZ3HOhdjQC7PpdZulSCH2IbA9bJUF3jDbhON4T5EiEMrNuiwdh
 CA5M3Y0slA6g+SOt9sL8e78raiPEJirnHk+jHMAADhk0+azQ2gYQFmKFA/iFWl9CMIwNC1FPYPl
 g/1Vnxyihx48U+l+leQWRhZSJ48K1mjue59fDU/JUm//NIurP1mMUxdPlcYNTmUghxbuVO/VtJp
 ArbiwJTnOUtRVsFmDqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX/gXzWrGM+KkS
 cRojySX8SgBi71+/g76xKWgdkkl0cJtNCg6yzWixofFRcqTkZjQwQqaFrjTYHrYkmW5sBQyC0rb
 KJkDzDrM3qXHB8n9Ga62cJ4A9TDhOU0=
X-Proofpoint-ORIG-GUID: TNzbhO8vE4du9Z7UjRyIizFH45aLImKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

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
Loic Poulain (10):
      dt-bindings: mmc: Document fixed-layout NVMEM provider support
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      nvmem: layouts: Support fixed-layout as the nvmem device node itself
      block: partitions: of: Attach partition fwnode to the block device
      block: implement NVMEM provider
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

 .../devicetree/bindings/mmc/mmc-card.yaml          |  23 ++++-
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 ++++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  32 +++++++
 block/Kconfig                                      |  11 +++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 104 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 block/partitions/check.h                           |   1 +
 block/partitions/core.c                            |  15 ++-
 block/partitions/of.c                              |   3 +
 drivers/bluetooth/btqca.c                          |   5 +-
 drivers/nvmem/layouts.c                            |  13 ++-
 include/linux/blk_types.h                          |   4 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  41 +++++++-
 net/bluetooth/mgmt.c                               |   6 +-
 net/core/of_net.c                                  |  52 ++++++++---
 20 files changed, 352 insertions(+), 21 deletions(-)
---
base-commit: 5174c725cd98c717af2a4fabb7615a11b3ab4b9f
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


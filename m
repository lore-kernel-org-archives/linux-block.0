Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF474657E8
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167509; cv=none; b=Gx8fTyZ6eMHCGkqKUG9HJF07fQtkZ7BurHWBgLvM54dm3TdvXKZyjM7UjQTdTHpctBRzv2VUWfhCKjpZ2unmVkImZHKIXINTAkAHXZDxLpJKapUv6KXHofRl+nm0F2Ew1Y0oRm0ES71HTYnZg3o6Irtj5L8g6NEsY1MbApLknjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167509; c=relaxed/simple;
	bh=/5JSpbZRWY5COHZDhN4gNF7Jnw0iPmpuvearF0ixaPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfUXML4qcqMh+hLBZXNGSHlouA1RDoi2T91hlxaW1B+F574Qc7D1Wrgiwn+kPB0KHuauCt6+gCd5ApP2yVm5zrpXkAGo1LE3BBnCC2WSG5RJuQr1csR4UrGhB3OHuNE9m0FfuU25HWbCt8H07R9Ea1NsRCgNBZaXEzuZ22EdFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OBsau1YP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DHONmrzn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OBsau1YP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DHONmrzn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647B9HPl682782
	for <linux-block@vger.kernel.org>; Thu, 7 May 2026 15:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=; b=OBsau1YP7Yy+Iv0k
	Uq5fle1uCLNF61w2iOsc5BgnzsyKJrCSbaMr3P4ys20u8HSD5tSJmzwaB3UsTu1/
	65eX6tYgK/vJ2IVXY1nORGIG2vRygbP9teOOJffIvXS9DQq/l+CTaCkjAQPuPRXG
	1ScKblMYBSjQFTZjjKwMpQ8ytpsegGBp9EB0LwFrONQgBdA8et8K4uclP2xCXQio
	f6cC/i5TRqDx0gumanbzk9exuVFBX0rmg9+a3QZ6CUuFWfgXkx5gnzYYGO+Aa+co
	KjEk5eF+GrUEiIC+/d3AGbGi+HC8STjRLvTuU8aN+urzheNgt37w6Ospq8pnDa43
	1SueFg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhat8b5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 07 May 2026 15:25:02 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-95d1b7487caso1524040241.2
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167501; x=1778772301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=DHONmrznETmLNj+/HA2W9VThA2sxk1CHvggZE5NPbGJ/OWjx0mZcuN7jIXRDZv1u4f
         JbbS71anhoD2uxxG6+D4M2TRl71dW1twRmWC0UJEzBd39A45NN79yvolOeGEAJmo0mta
         7QliufA6Zb8fnAKDPx3jOpUEUPmFooQW1a4YwG3pvgsWCoheqK/BoHVT0Bc7gwed4kSU
         zOHQM7rVvIh6iT3+zhAJ4gPonh0g32ROILXv5WoKG49HL1tEx088By3w717gjm3S8sPo
         QV/D+DgbeMUGP3LTx0xqp6UJBHwV3hkrccMpf0Jt0QJKLFUXJ5YcXWQOEZeWqgGGcTuy
         2uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167501; x=1778772301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=qLuYgEGbKGdywthGZnBAPwd/1lhffjlefavdi2YFHPpR/eaRi7tU70/WlliWUllPwp
         wj295sqDJUjnM9GVl6eIZTQzYQWOuK7y93Cr+RBEYNe/8DdgBrLJNyAu/dPEOCNXluyj
         KVdJ9VkGA/CMW6R867z4ppYIhXhZrNgWEx/8NnOPbumCekVVjx49hGZRjGSe0BZ62WfA
         nIjOhSo51l6+TFqzgbmqXlVD0j9xqZdcjY3cAKBLMut4Ha2enKK1NohF13yhWk1gohQf
         FsTYwYBv0ch2qZBS45ura7O40KSmXN4EqYo8BQz0SnKHZfm620OwhuG85pavWVvks1W4
         +Jdw==
X-Forwarded-Encrypted: i=1; AFNElJ+HN5iXIYUfQkUdGXNXc7hiDOxuRm7LTWbtP0c3ZH/O39XYVZzRummchv7XFiaFNeG24ikszNINh2N3Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoLfF/FUdliB3OR+QSQt85DcN1+58O70u4ZOJKHPdWWKqcZrTj
	uc2BpJrDm/ATQGJ7YsS2u/tNyEIDzKRwiW3Cfi+i1pokQuGeVzyYSeJAWKY4M+3IcpSfaatk0Q4
	/12rFQOOtmByTOCif3iRjXlM3/1OIrIBMc05C3rsjPNNcuuAM9L+ggO+/v7Y8WNdQpQ==
X-Gm-Gg: AeBDiesLCSI2R59h3F0nrbJUSX4yC3hADT/o6y0/6w9ld/sNmUpis1rFAeVCEPyxogL
	9OxqndodBmp3CdQTtqxXSMstAIwuRHPLWVioVuMjYZI4pp1GG81QmS30K6bVHNl9EdOKBzsRt6L
	QfSj1K/gSZBVXmos7lTKOjbfQBMugKsxXhayNLVdAQcR9VLTxFHG5ByDlKp4f4d/07yt4ufipxK
	bZpr6GqHXt2+Bwq0fUlF+J74sKCdcjZw77cRnakuK5sokQ1zBQY+1HGzz87L/Y+FZucZ+9/9aHt
	08uPce3Es2UTmHKXKmMnBhJC70ucx0btnav+LyoMO5rzkRtYseeOWWu+62KfNn/a79l3RPYYJFn
	T94A3+5KaKD1VjZUBKtDPevYWdamCXo4daNQrYm21+C8GYtK1URgYVZK4LUm12q9r8xF4wFQzQh
	ckL4V568CAvPLCPgK18VYKJsdMYLY=
X-Received: by 2002:a05:6122:a07:b0:56b:8e17:25f5 with SMTP id 71dfb90a1353d-575595c4094mr5143484e0c.11.1778167501266;
        Thu, 07 May 2026 08:25:01 -0700 (PDT)
X-Received: by 2002:a05:6122:a07:b0:56b:8e17:25f5 with SMTP id 71dfb90a1353d-575595c4094mr5143393e0c.11.1778167500580;
        Thu, 07 May 2026 08:25:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:59 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:41 +0200
Subject: [PATCH v2 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-6-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfXwIel/z1ZodOG
 xzUZSXmeBcsdFJ7Ppia9Nq2f5aWrf4lYT7kvxVeqtTWFBDLpEXHCC5RrmNtedSpELz49TQ8vT1P
 Lbf5vYnjKLI32oYUGv3FmSWc13w3kMnLHwv3IJbaSGBid/aPs6tPjwhWQely2r78aDL+fht6ys+
 FIXS1WMzlX1PLrIXkP0Jrgh6BhARWlVvHTrj3YqsbEGkhdhBAbsV4sWYcXkxtn0g4TAf1CUXjYl
 /XMx1rC47+VJ6fy7eoFfbv8YqFkR7EHW0CdfdTR92c6QnRMfYccfM70qVafd1oCBU3KaENgz9v+
 tc7uieaaUqifAd3Llx2RM4QQ0mun0zAuRIbetZWYtFEQgrRi/vucp56BdMBsd/TuF9d4q9JUDWJ
 8XUNxDuF6DV9XqOd3JwqNmFRrdV/8IU3gXJdvAgOlNEWterfZNIJ6XOjqaaTB7va6X3VT+xlaMU
 n6sRzZVd7aPP2DzOzSg==
X-Proofpoint-ORIG-GUID: Ewk-gKyQWFxN7HtRXBe7XZVWN7leyCnX
X-Proofpoint-GUID: Ewk-gKyQWFxN7HtRXBe7XZVWN7leyCnX
X-Authority-Analysis: v=2.4 cv=ReWgzVtv c=1 sm=1 tr=0 ts=69fcaece cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070154

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -164,6 +164,24 @@ enum {
 	 */
 	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * retrieved via a 'local-bd-address' NVMEM cell.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_NVMEM,
+
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' NVMEM is stored in big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_NVMEM_BE,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..589ccdfa26c1281d6eb979370523fff0d7920302 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3588,6 +3589,37 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell in the device firmware node.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device_node *np = dev_of_node(hdev->dev.parent);
+	u8 ba[sizeof(bdaddr_t)];
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_get_nvmem_eui48(np, "local-bd-address", ba);
+	if (err)
+		return err;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+	return 0;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5074,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * its setup callback.
 	 */
 	invalid_bdaddr = hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
 	if (!ret) {
 		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
+		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_nvmem(hdev);
+
 		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);

-- 
2.34.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049F4FDE60
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374943; cv=none; b=JxJlUH3e1qcONRPPYEFsHUWZoElem60OO13Ve0yhh2o4ZUteoYBqBhHTf0N0vmRQZEHZx+RQnYfUw4tOBqRufDXQkh6VsgLyBruDJfUEM3Kj2h7sZPbeVKWdDqJyjtlbdEVpNsyXnFXd8CEbAEk6i3yEnKXQxrxHV20d16G/q70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374943; c=relaxed/simple;
	bh=WDe8Nwp+8tXA6JvRXC4djLa/L7jH5WXFM1d8o/bcDuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mULupCb7fV18X1anybpbyBT8YaQtorJiyH7QNnNSKi6DX9donaSP2k1VearlvFzrcLwmEp1rKifiQC1Mlp4aDOEjO1dV2BP/WvXYOMw5LZrlbHJhhF+OT7IjK4+o3wP2fEu4xl24RSAm40dLaqZktLG5WKwBCUqeiEVLl6+M148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nwUVcUn/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wam161OC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nwUVcUn/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wam161OC"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PIoJb52335489
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 22:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=; b=nwUVcUn/sbesiu89
	0Im27RQQaQxZOJOZMyZhBMAlzBzDobwS2C6op74TgxAPFnj0beZHkqBa7c5CLnsS
	+Onoxmf9CEV3vB/unKZ1YOPE3UGaAQQU/n+S/XnZQKzMLu3prC7rS6/ezNBST70E
	lxl2cAsYAR5I4wGm+pGzk80ICPrSurQ+0Jp/sifqFF0tvKD0k0VwPb2X+2CBrIq7
	5fU+OdvOD5/6+FBxw6szO0tHDhKX6Z+Qe/TOce1QmxOqkzIL9Eo88G8qrh9Nq1Dl
	8/USu0aI7xJje5ILNbZETQU9yXNHd2S6krTrFoFibLz0iIe3VzodIXzYDnvPvoWo
	TouHlg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvw1h2ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 22:22:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2462863eec.1
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790374938; x=1790979738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=;
        b=Wam161OC4FjEx8v797jE6nE0PGDipHtia6ibmP9wy5jfoPbYVocjMXnwgsMKIAmP0Q
         wMEhFNFPSSJTZFkqmg1SnRz9exJ7rCK0qO9+AYUu1U0Ovxp8rIYZ8rVtRbp2lzYeNFOj
         xA80xKABD4js6FYQSncs1zxKuzSy+qkIIwn3GGgJo/5gyAwwr96fkijazBag3F4GzQ27
         0K6hsR+TNANWGwZHZ/wcEiML1odAJWS1g8wVyQSo6LKcTecnwiYvy5Aast0QPzltJvKS
         guzcH9YB9qcpSYhrRCAsVZegwg67veTcxQUNENAadWaokT2UHm92Waq37hnEacJj8p8v
         sllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790374938; x=1790979738;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=;
        b=Ws1cE5zvnqDUE6ubHHQ83L6D4tiizQGaefm4NIs89/HiWmZ8B0HG5H9qtJxV3+nTVw
         d347D2/ln1v5ohzl7eagdOJ2LoLT9VDw54ZTkqci6YK02Z++5qDbpwUljfXiqVSKlPTh
         XReNcbacTFgbZdgxGgxTnjRu0hGjTxtDMyT0ZW5AN6oPKoYGeZ2g08S49PnsQuuO9R5Q
         KfHTx50QsKEKpqSbaPPTKFTNTr+KQ0Fg0Kf8iq5rT/mpKrFKZQUv4n16edofdiELkrM4
         Tvw+qY7g/hS8F+rNgnm1uha4ZbcCxvgMHsYNr5RsP6rPP4xFBl+fY0MmZLrGy60CqbKP
         mEpw==
X-Forwarded-Encrypted: i=1; AKwUvBx89UaytF4VtpV+ID0G96A0e1PQrZ+5Qolzu+2V3a2cqNDbPFd8PjSaa27+MWN1dlHMrUlTuGM3BDDSBA==@vger.kernel.org
X-Gm-Message-State: AFuF++mXa8PPUCj41qWyhxrcOQO88EuEm21I36e8u1ipZW7ca+TgQn8q
	rbFui/IyC+U5/gIEpwW8Z4YLETmUZZmeFfVVmfG3b2PpHeHkZyP/6KUKDfkcxSqwc0dliGTKzkS
	VT9CKiL2ag3FuP7SwXY9rC5PqUUUHA0koDz09mFoyA7AvgzT3+btmm2eHFFoUXolLQA==
X-Gm-Gg: AYBFou30t9Gq02AvyVtMoRxM5gIyAMwNY6Qd1jgXGgThwhnE9NOaxWD1c6JvAOCRbFF
	HIdLdnm4e0Wt9YR8Rp0/Zd32gIDLpbjfIZqHKwU4MIDj8Glr3Sn2AaXXybUaBxsSN4YSCeKGLIb
	HLZvHqrBi4lqWT245d9YpS72IEuwb7pEv8jdVdVgnWzkqqrYINcUvbAXY2802yOWFmNT3bLf0Ca
	1dhKIFtm0pWQaYRDisLEpdkAVkDfqoDCyb2P20pdXcwDZtFfYK0DSSUKFDtOYzDnodtmf1Q0iK9
	qRw+RynDYMHyrIR7uC36+2vMwnDNVTwIN6Fj77QZqmiWLi3h8MoPirGlQS7Gme5/Tc4TaqRsWXU
	Dd8fv7VF8OJ025qtevDOmz8VhXcRY3R3uYVYNTsjxOMEAKguWA+OG6g==
X-Received: by 2002:a05:701b:280c:b0:143:296a:c862 with SMTP id a92af1059eb24-146cffbd728mr1187756c88.26.1790374938447;
        Fri, 25 Sep 2026 15:22:18 -0700 (PDT)
X-Received: by 2002:a05:701b:280c:b0:143:296a:c862 with SMTP id a92af1059eb24-146cffbd728mr1187736c88.26.1790374937815;
        Fri, 25 Sep 2026 15:22:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-342c9c245a7sm1273621eec.11.2026.09.25.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:22:17 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
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
        Christian Marangi <ansuelsmth@gmail.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM
 providers
Message-Id: <179037493652.3059844.6860403127536084948.b4-ty@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:22:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 9tsnXX7Meo8NuCrnXo1bmt7D2KSv9fms
X-Authority-Analysis: v=2.4 cv=YqCa1IYX c=1 sm=1 tr=0 ts=6ab6f41b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=3vxmhWUQDq8JHCpcIj4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 9tsnXX7Meo8NuCrnXo1bmt7D2KSv9fms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4OSBTYWx0ZWRfX795vZB5k4g++
 V58mAWHhglcAKpVx9hCUKljp8Fni8UQTAk655xpQCCio7n5VCHwBH8azF6ghrxc9etYhChVOxbp
 3QBb0G4TKHu4AZkY3u8NH2U0LABY/uDzUSe1mpDeEexNtk9zHzChRfBv7yNwreRfwhVSmpbArtB
 W9l4EigxAkxMlR0hlWHURoGEUWLxJrVTHfgA/iMKi4HXSYU+KOP5E/VMXmzkrWjGdZNUNUScJN4
 m8eFUiWMBXa2PrLztTZYuMu9au0CXQYUy/t1WcVuonvkTo7N4uglxXVVHK9XwnXVufclirHOp9P
 8RIqU2Kgd7R/P0+Zyn7RDY2PA5d89w06HY15BkKiRg+sxPXsV7pd1mU9Uve7Ay5WEZLycs72FZA
 qo2tMF4uOY11WZMn55urHF4rvnwnCWpGO3E5NcE87zsawAU0i/KDcnAxKJ/yeEGZ2MKdTymTvD/
 E7mJwjzRgJd+ul4Lw7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4OSBTYWx0ZWRfX4e6r+6HjZ4OO
 zhrJtwozpCoUR+MWqdBJ5hKQwk9G1nAcRemqf04qFG/eQy92/epImNtzL3r/5XE1AL9zXf4AA9P
 hJbU1SWj45KyU1NlB7dT4LJJ3du1leo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250089


On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> On embedded devices, it is common for factory provisioning to store
> device-specific information, such as Ethernet or WiFi MAC addresses,
> in a dedicated area of an eMMC partition. This avoids the need for
> and additional EEPROM/OTP and leverages the persistence of eMMC.
> 
> One example is the Arduino UNO-Q, where the WiFi MAC address and the
> Bluetooth Device address are stored in the eMMC Boot1 partition.
> 
> [...]

Applied, thanks!

[02/10] dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
        commit: 753baa59527f8e606c49eac25692b8b08918a3a9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


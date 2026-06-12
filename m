Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93063CF95E
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251087; cv=pass; b=s0EC+jTxDi/b7IQq9fO7p3zoQ0VEk6nBy9uS8jhKRGCjwxLJVZLQBX0s41N702Lfy5QFzBhaNgTwbcptbagTeAH/d8MbHtgz3ZF6Pu+Mp4ivcAjkFw/otCiYO3rq8yUIB3qZggZuWJ/wCg1s0AKiSK0+anqtLNoS02IOK3/zBC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251087; c=relaxed/simple;
	bh=qE9FqkhndnGAaai2XsKnxnIlLJwWvj+Km/dAKpVTNrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGadjkC3+tchJYSZY7Z39NEUqyaViBQM2SkrwlS5KpVRl9Y/JNLiSCj26PpaglWWiNrSO1hd0f4zVDfzaRqugPFeCRwnDfCtrLKk34pmQQnQ+4AplGRq380BKtgIaa1L52edZi2Lp+097AP7K8jd+pTEfLgFCWfLuE/HpDHzuUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Be5VGx4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=POCygWzX; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Be5VGx4g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="POCygWzX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39LUT2495825
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=; b=Be5VGx4gTUql8Vgx
	MQd5cd2DNjjeytK/wVvLvtoz/4GCK43dIUZNL2r5LzQm64n2OSWrhgsu+S17nxAi
	biRk5OxZn7ZLEuhzG1n7N1H1hG/Hvyl2ZjPusePOMwVKv9m/jpnfo1fPGG08gdKR
	qjpflDb4jHHwjQa8Hms9E7dNyqZ39kDJ6WjummOJ8TE1sUe+W1gQWbbpKqallgw2
	orSXB+5jHzb3rVakigr3LCMzzfgBUFMlcjyakZw0BgPrmAKnvLwwQHbUHdJKNklW
	3TPJmVF/kb7CIXaZBB5jiYLL1964zpfhv1RNhb8810SNEDTCKV+lesMe5jgvamy9
	2ZUL6A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7jq95-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 07:58:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915757be497so100457385a.2
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251084; cv=none;
        d=google.com; s=arc-20240605;
        b=Y+NY52th/Vqa6o0Ef+/pXnDOc1tZH6XBTDDkwqVJeEYkSDExxVnrwK3UihMismC4pf
         7KOHHw2lvXzW7CHtb00bUjEd2CHvdUbJoySKQzhdFVEcL6T0EKXIUii+ZE4RkLyBZozd
         rIyBRdAU9DhVTGnpNDMcVL+hxfvpHN6NF1A4oqFsNh8foeyElMsdPjLWXcs7DssJSpM/
         OFesWBT4AFv4LhYfaOKUSKVsm9qvDdP4kX1KIIISLaoMJH8Kg2ptTHxQ7/HfEQxxtkql
         VY4Ksq9cnIKBlp1U6123NsjBDbXjiCVFq8qJxtZG8QbnSiwr1L3ZClraxuARMOZdv/Yn
         vo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        fh=uwgLWbXC5tRg5h5Njy7IGln6WpEFwB2+ApxUN4NdByM=;
        b=SQJa5SSA9mLqy1vmC5EhdaWurnP0/Z+ZfljsdACzywcRTdzpSO23wQYv3WpyO/wrW+
         UpyrPx9Yvp1o6c2AtbIee/ICi8LSi5dwvP9Dfl0PgPYR9+ewhykl8subfOxEbgTQ8dhU
         t08gCytXWJaxpD8DUXZQGWXSqlC9eSF9CmizEq6lUdixIlPr+McBFove/2EKxXHxTkbB
         kz/g2rQ/NxIVkUzwkBNWyvNR5c6fcDcAjoBVssiOiYi6C1i+w8/fj9e5y2ta1mzexs1t
         bazq/hXUBDB29wzQe0JtmyJL61SBDymNu0d/DGivNKlYFTwjnCXXb9YzIQOz8+1Cr3Q1
         WBOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781251084; x=1781855884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=POCygWzXRhSGiDVOhcRBLv6GKKii028tspR9dtQ09i0fzdtpSdNHuDevaXhLi6vHss
         ygGYWvQZbhMAC81YgzG4ky6au+Aua6+am2FqMiJhu3Y3LaJ4FGkhOEDPcjsrG6m1KBQQ
         yNBwDK9HoxMy+koaGykJHN6A2niBDo0j5ZUzA8DHNa59qy0PB3Avr7UeTSut7kbfmLGo
         twkUgFRDoX/IYqaGw5P6zSSpiraKk+7uAdgurVbxgLX4MiLriUXStmObAM6S8a8BcDSC
         DgcbBvyIHfUbBW3qxP98JRx1PPzmyY1kgcRfeq9GqcxrtlQqokXWNRSyrn+Yxc6WtzJr
         aTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251084; x=1781855884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=XL3it2CFnCtbxE0aIEbgnRkEeGWQGl2qnQZFscnls8M2/qZBU8wEmBqKzuv5SUlekm
         aD9ngVUqgdT6hc9HzNDIBDfpwXybTwG2z5va6YfO1vYl2o1YOx5pq7BvnMzfWApkc4eD
         V2DQ1xsZqxg1XmvdAGXUK2O5dGyhTkXgWGX1p5PoU3WzTbBgMcxEaTJmKztti+F/5fVf
         PwUdeCLMSbv0ue4z7tHtCuvHb40JbDeIxPN6GN53GTFiAEI9yzebWJMLZcxEvUGNlrxv
         kWqTLaqYcR4QK6t4tnRMnkhWqSSMBrLyagnHvqQ+UfLrOfT9POaf1PIK5HfrGTDx3GxR
         am0g==
X-Forwarded-Encrypted: i=1; AFNElJ/k04FVnWrdrEEszvND0sNwDBfYyOjLwQv/M6Rbbf9VsMEXvpepgmdUtQtd75AMRBBYEc2m1NiTfWCjag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytfo8gikH7vszG5xGX9lkx7ES4ynV/ZEvEQ6psPfyw40dVXL2m
	olnuvZE+lwatzb116PEY4/pMsCXTkOVXhsEru7KMBJv04WDOiUQp3o2nBdNy51sRuCIqdcMT1GW
	YtX2cDYLkYR0O/JTHzH7CvzbwSVkzOoTCS2j6Or8Q3O0yJGv066elyq+5rHPim7e6k5ajc4fTS6
	o4ONXwlR0d3uHBHrNrYT3Z5YMZq44TtKZZH5zonhkW
X-Gm-Gg: Acq92OGQu2YpwNZzEK4EnNfH1gKkB13SLIxuYg2/thVsRgyW4+TCY85Nuo41ngj8aVB
	7yQibrMIzHytnnjtHJrRmwfOosZAfRYBNei/wrTqlRZIxyPi/8ayvU7SsKDpQBn/THsZi4bdZai
	ygcwFD/QQSoK20/YhBs9FtKYR2zwuLnCrAf0ToE6bRhYesCDUizixniIVHxzDLeHR8J97YwRHhw
	g6lDq0ZIzTyguKByYkHy6TxKYM9WzbcAMC42tTfR471a3LkTUnaVmBoFz7t5Z9E3DV4S6ne5ggJ
	jfhCwqAqJWADz4NrjdhJ
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id af79cd13be357-9161bc5db30mr150536885a.20.1781251084067;
        Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id
 af79cd13be357-9161bc5db30mr150534285a.20.1781251083533; Fri, 12 Jun 2026
 00:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com> <20260610-funny-paper-warthog-25fa0a@quoll>
In-Reply-To: <20260610-funny-paper-warthog-25fa0a@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 09:57:52 +0200
X-Gm-Features: AVVi8Ce9FPbWU1H1fFzoHrS06e66vPYKJ71XBeMTddYgFQq0vpvNpz1VnR725W4
Message-ID: <CAFEp6-0Jqw4HqTu89QVOVtWEYMpNdnd0vYxRyZDgn6oMENCqTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 2afictEcm0l6x0JAnnEJlc-GrXqmCb2U
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2bbc0d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=HRdx1Oj2DPauqesJAvUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX29plRsOCRPG6
 2Gc4zc/spiibxkudD9nDsk/9YrVmDercxxuJlNZnoSIsYHVaeGlj+I1EJ5icPxb3O578booLlic
 2cKqTgHmTe6q6HJ7o60g/Bdwnjv9yyJmSpfdTUKig/3sx463T6iVd8yV81AqYRh26BIWgLRLPyI
 nNT1zTV5fMkCoIBL5p4VwAnTpPCYGaF9In2LhZT0gOQIhAexpuKxykwCckav/WAnAt9x3/zY/N+
 wHjPlw8i0qnST1Npw07o5qqk7T66zm5qUaKl7cpv58ltzvJ2P69IxlvvciZ1/q/VV4U+yyaCDww
 zqtxIXA5FXCm4b9s8jQnM2ifo+CQNeTQ138y97RqrQEkOH1HchJID9sWlo1p1YIFH3klgOBDM42
 S79pOm3f0s6SCCMdH83yRfTLNdPeAAl6sXbsf00eqpd6c2zmkuOJpGHDYFWL/1RB0fBcrPAt9J+
 MP6AdxR92dlpE9KpcDg==
X-Proofpoint-ORIG-GUID: 2afictEcm0l6x0JAnnEJlc-GrXqmCb2U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX/M94270lrfKl
 gSurHjvi2mroMfzmiEtbHKFzhKRZdGP8RdNqiBbUf4JlTTY3/3TCo0cXelwJjahIlKLwCOnnINh
 zLI61FDzV8PJbMOeMAs5xEUaxpF8ZNQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120071

On Wed, Jun 10, 2026 at 9:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:27AM +0200, Loic Poulain wrote:
> > Document the NVMEM cells supported by the ath10k driver, the
> > mac-address, pre-calibration data, and calibration data.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++=
++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k=
.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b=
9919d48c41ac09f1e 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > @@ -92,6 +92,22 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  nvmem-cells:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: |
>
> If there is going to be resend:
> Do not need '|' unless you need to preserve formatting.

Sure, thanks.

>
> > +      References to nvmem cells for MAC address and/or calibration dat=
a.
> > +      Supported cell names are mac-address, calibration, and pre-calib=
ration.
> > +
> > +  nvmem-cell-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      enum:
> > +        - mac-address
> > +        - calibration
> > +        - pre-calibration
>
> This means you expect random order with variable number of items. Is
> that intentional? If yes, please provide short explanation in the commit
> msg.

Yes we may or may have any of those cells. Will document.

Thanks,
Loic

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CE3793CC
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511757; cv=pass; b=ebn9U5a6NYACtF9lql/BWcbjtmnulAHhrSMgpJPJfBnjOMytR2injWalKib3ybOO3FBE9kKWXBs7ITcjWomuNZKIDf0Jz88j5iL7ZASU/imBeZHob/VboWclDW+Qgq7WVE3jkBt2/OiXnJb62A8+HMiMLMb9wNFBRoVohptwtzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511757; c=relaxed/simple;
	bh=3ydj7XBZQ9qjFikBAdVfbnM6S28yhAGg+f/PA2X9pwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml1z+IlFX5VJASmTa34ppZWwhTjGvUfJp4pCoMRERpfS2OMYrbFotveNv1yoAqxtGP9GxRZXlV3s1WdXsmMqR3q4VZnk2vVD/IrvqC/Shh/a8RZl6slZ89AXN3R1oEsVUYgS35oFh/78Lo0BCC13Stw71R4fjAUGhGCHmB2GksY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LLLWgy7x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AyLJFVfn; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LLLWgy7x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyLJFVfn"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mjsJ1770369
	for <linux-block@vger.kernel.org>; Fri, 4 Sep 2026 08:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OrXIcuGfiLa9DF8zcyadO4YQ6mRqklnE1QeIxy+wnqc=; b=LLLWgy7x5kHSkJEf
	cKUpXSkYGkLubmh33Qp1ekl3zR4KPpk8MrHnMN0GSSstVS5gLOMsisTCzd/08KgB
	+w7EE0lYZBQID94Ka80EKQSn4C7KMZH6iivHtoVjKTxEXgTZNCHq6lKuQfvI5rSB
	Mkqip1Hfrq2rKNSkjV19duUZkHXbKiqub50XxgcfzoUdl4JuPBK5cZUx8mCpyjQp
	HG+SQAgl/fdh/g/H9Eo/baAdCSHZ8jekrCA31dMZb4RwFkLik1E793hGiuMwCZd3
	e/TR77OzaVLgdZhwzy6ouWFeVJanyqRop2MboGj2L9Fit1v6dapoEftLimQsn5Q1
	3HNWVA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfpmqrvre-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 08:49:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so10838585ad.3
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 01:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788511754; cv=none;
        d=google.com; s=arc-20260327;
        b=Spb3cglsRPT4JC1IVP9Q8AnZySojlREZ9lwgCbGN9yBfI9mv8JX1Dtz5cp6shXY9Gz
         ZI8q94eKuI82S+tt90XX2l3vS4zuj2dUtyJlJRdoGE9yIiQhC4666lPC+4ECHoWCbQtz
         DXQU3gkoUMSu/Kr8tmwKUrOlsnM2P2uhZKr3zrGXMf6h3chEuiHpH6vJKOqMUoDoS1ol
         VW9J5NzAgRlCauqOZfPGYvFXJB+Jc7st82h5d35MkTjHTazI2ftVvSbiabQ9UFvaa8+O
         /xazMjHez7FRpZRd3DD/Dg0qyRspX28Fa9VlfCpH/4ekFw+L6uJ3h9SO5aAOb5Gtu4Xh
         CC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrXIcuGfiLa9DF8zcyadO4YQ6mRqklnE1QeIxy+wnqc=;
        fh=1CwbEIN2M774wCwx/bjZ0XR1/HnQodibkPilz0TAa1A=;
        b=a+FCE+9w38PuJOTKGK9oJ0wQocPCyUB7Zhq9tTqUQv61rJprwW4RfhV51H8gzoSlEW
         5EYQNGvF9t39rX0yUwLoCr6v/jrrQJMDmZk+4hP2qN5fWhnkBhRaex3KXrIUxc3e/H2k
         QcGr1TZ24ECsGTy814Ycdlt6k0dnLnmjOwpcsvAVM8AvYNZBdRSJ7sZtd6sE1u9PG+rJ
         lWLV3gcMMEZvAdpSy1aE6kw+6ssL5jOciOMhIKViNRHl2G15iqjUQR4xnF5fU5LlWUk6
         C7VEQYamoeV1Jk/fQqYSo9C2SGunh/ov82jSSduLyoFk4kusLX5U0fea3scnSinhrTXY
         +5mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788511754; x=1789116554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OrXIcuGfiLa9DF8zcyadO4YQ6mRqklnE1QeIxy+wnqc=;
        b=AyLJFVfnSOsJPnVa2eMP9v1XYmaKZaaO171Y28gEiS7/8RvG7aasmY9GKHTgFudz0L
         LhRDYYExx0/Px2Wu6unChdED87q3wrKB3AoeQMpE9RuU0I/EUqv5EMz4na3OXdCvMu9t
         mhbQYA54zhRuuZI+9dDOlnO0FJEedi5zsAIOhmlY9PYNRhfVg3d0A9BzOgeCsa+nEZYn
         ojOn8eBE4VAX6ADmXJt649dUeiBj1IE2vezoFVhw2wD9TR3I0t2yYAEjhuB2TByUJb3C
         WXj3NS/v8ErKBoBbDDP/fTgUil+5jTa9PfCXcEJqZoInkfs0wq640zTNn6r787FbJBAi
         V/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511754; x=1789116554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OrXIcuGfiLa9DF8zcyadO4YQ6mRqklnE1QeIxy+wnqc=;
        b=WsfoIMavpLSR9LqISFrk5PLNTG6jEsf9gjz8MYwTMysvBv+exzgkbCbm/SJlv4OwTD
         YW4FK0k3G/Pxyk1Fy8leU0btRktZCTGmuAPX4UJ5TNqqw2Bx0Q58eDVebuIlp6s4AWnm
         htiJ13KVRQUUFMbpLBfk/pk/mnXGKlWa2cUcgMU5HkGh1wLqwAnnMAErd5ACbfylHqq4
         fDPzrAoVLjAwxStu49ZdHW8JuGJe9DxbdUKsu9lSo1aGO0II+hYKPqrubpbDZKUGUz2x
         THmq4cIWDHtVyLzqb18JngqiIXzLqf/yfeo81aTD3tLaN1UQ8Bh30mrdZXDupOpzKd/6
         C0rA==
X-Forwarded-Encrypted: i=1; AKwUvBzxD3ReM1TMxKvr4RjQ1SDv5kbohv8NkzCGPlT3Uss2W6fmY70Wyb0Pj2vX2qsEOeRcfpX4EcFw3wg5LQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l53Qvr2eWn8uRgKdtMkahyLEVsZv0ixccVzvCqLsuLPNjTnAZx
	20qfSGos+6R7ISQfG4Z7LPkM3t+2Mm3MCiq1iAM076v0dMqTLvI8Ov7cHO4XaJXYlyhmy0+DrDd
	sTNOOKPfqSV2AWPcmlJz8+/qB63j6e534n7oJi3qdfX+ZOaGRrNnI1WY8XkBBS+3m/LPpc8g6Uu
	ZbdFeecf7aks+ivultFy/rrdziwOKeOgmpa2d34tA2
X-Gm-Gg: AYBFou0uAV9AVRpSaS7EZZdtCj6RJjAsNQXOtA0y2CnuxtpIMpKMeY3nqeiNTb4Chs1
	BGR4brPjNIMpfywJYc8BEFOiSoU8tEUoDkWi7Br5DDSiWqJ9ILO77pkeufjRjBTPDnBIkp9JEDC
	fv3XB+U4q6a8flBNjToMMnDm6Izc0uGHsjqFtpCAsfeV6khJIcikqyatnvfA==
X-Received: by 2002:a05:6a20:b418:b0:3d3:adbf:7777 with SMTP id adf61e73a8af0-3da3a066ef5mr7202831637.19.1788511753692;
        Fri, 04 Sep 2026 01:49:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:b418:b0:3d3:adbf:7777 with SMTP id
 adf61e73a8af0-3da3a066ef5mr7202771637.19.1788511753245; Fri, 04 Sep 2026
 01:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com> <20260806-block-as-nvmem-v10-1-be598b2a5606@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-1-be598b2a5606@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:49:01 +0200
X-Gm-Features: AcwNN1Uv_B6HKhzdhsS9aNd75U_pKuJYfQt9a9aPW0x1SCz-kw1mAB0yNJHs0Mo
Message-ID: <CAPx+jO90ut8ZPh51BPyJLpTT5u1i9HTWKyNUWRsFdH+mD1uqgQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/10] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX9JsOt9IgAac8
 By+3hUoDKuZDixPccqKGxtLLxUDxJELNR29kWsjBG9bYX23oQGt31sUwZGw7Q8/pu3e4Ek+9Z1z
 JSvYl4MbUvksaq5+A9KKuaF+5xa3j3k=
X-Authority-Analysis: v=2.4 cv=eovvCIpX c=1 sm=1 tr=0 ts=6a9a860a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=_Mn6x9y97Zr2TNExHCMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX1HXA4Q7HVWsR
 H3yeMHxguhKh5KbDURmD/xfm9pnnJG1Totxmzd2+J1X+6uYqouTMf8Fqk8X1SJjoONufg3DITZK
 AuVVc9dyS/QCG3GnQsQtPsg32ZW6Ee82x1L+Thsir6NevbZLGwHxwNLuihoAkpT3obIujPFHqBV
 7QavywZtfO0iu3ALwBjuOYkJW2k4g+IPKdcsRO9QAfz+xRWFq8FCA/GPBs11soWI8d9dgmqqeM3
 mYJ5BZmyBmK79YeE3ccKfQ3xh9+Hs0r2qfavz6Ok4CzPm4zkt2AcM1Us+ynCh3P4JSt17yfYc1g
 ocOkBSoB6Rk3Y23RqCatUj9t53kBND7FbdrLCpvbuHCs3xvjJf1nX607WAK7/aslBiO0050ra/H
 Xg3CfamXZfX1VQb/Y2+ENPFtU9cNfsSwjAmi9M0vdTi6iVtnLVSIQdJhvUgRxa5lUhWKdK7f/dI
 PzmkGpkt08Gy75eVCVg==
X-Proofpoint-ORIG-GUID: E-tT1ZkFKFEpOj9IhQMrr9APBq-3ewv1
X-Proofpoint-GUID: E-tT1ZkFKFEpOj9IhQMrr9APBq-3ewv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040080

On Thu, Aug 6, 2026 at 4:38=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Allow an eMMC hardware partition node to describe an NVMEM layout so the
> partition can be exposed as an NVMEM provider. This lets a partition
> (e.g. an eMMC boot partition) store device-specific information such as a
> WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
> cells.
>
> Accept "fixed-layout" as the partition node compatible, in addition to
> "fixed-partitions", so the layout can be described directly on the
> partition node.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

FYI, this one is already in v7.3-rc1.

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml          | 23 ++++++++++++++++=
+++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Docume=
ntation/devicetree/bindings/mmc/mmc-card.yaml
> index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b=
58a5fdbee218358 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -38,7 +38,9 @@ patternProperties:
>      properties:
>        compatible:
>          contains:
> -          const: fixed-partitions
> +          enum:
> +            - fixed-partitions
> +            - fixed-layout
>
>  required:
>    - compatible
> @@ -86,6 +88,25 @@ examples:
>                      read-only;
>                  };
>              };
> +
> +            partitions-boot2 {
> +                compatible =3D "fixed-layout";
> +
> +                #address-cells =3D <1>;
> +                #size-cells =3D <1>;
> +
> +                mac-addr@4400 {
> +                    compatible =3D "mac-base";
> +                    reg =3D <0x4400 0x6>;
> +                    #nvmem-cell-cells =3D <1>;
> +                };
> +
> +                bd-addr@5400 {
> +                    compatible =3D "mac-base";
> +                    reg =3D <0x5400 0x6>;
> +                    #nvmem-cell-cells =3D <1>;
> +                };
> +            };
>          };
>      };
>
>
> --
> 2.34.1
>

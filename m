Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD8472764
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849564; cv=pass; b=FjOBGlc90t8zeaMEN1VHouKIhXpQUUPO9uuzxwlN01q2OFvJ8JA2xzudZivohLW2jiKpvaeASEJycLNKFP4rhbIdCwfQGzj/cFOCHYk2/CZW+mbSSBcrx3TGvD9orkaxAu283jHFcbRbiGFpxRHU1SDtHP9sPjY0jWpmVwwg1s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849564; c=relaxed/simple;
	bh=RiKwOhz2rdMC9/aebYm1g33822i4EXTv8wYdbkHCerM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cohp+UqAbA8Ecl5DAZEIkAVoX1LEHGwe1rfDtHaCxgjnFRUxsuVeSqhkG5MgQRH35TVso/4VW2EfLtL29b1zmmWiHS+6lLGLoz0rtDVB9uUqDba7vHTNzwcwyn1o5HAtt4JgPCuAPjoxVZ88jF8/7zqfIKXBpctEfuKn9hLAbJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdR8HRwp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XN24c5TU; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdR8HRwp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XN24c5TU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDnpF2947205
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 19:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=; b=cdR8HRwpOL0F5KGf
	Pa72vskx0M2kP/Z35S2cu0vrb4j+OEKIt6KMM7Th6UonX+P19BpjlUhTk5Li1d1Z
	Y/Wv59ciZPfT/RYaiQrRsZFm3fZPcDfKBwaFfoTbWjAmnFyZj3n9bpk2D9uAq+as
	Zefne9lZYGQzV3whovwFyt/TN8jYz46vzYj5NL0+/lOGbG9MlNpdo0tsMl5xk0yg
	fCV3pDFQVQuR35FiZSvIftsxLo2l1P5E5HN15BL52dlkXhgQkdoSVKvLPz9tpEoo
	i0SPA3tzquu7dDbPf2qsPBmIKC29344dcx2/YoqDcNf3SztycbPjKCqS4n+bRngs
	SWWdJg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avptyg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 19:59:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e9489f62bfso105277486d6.2
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849561; cv=none;
        d=google.com; s=arc-20260327;
        b=aakPN9yR8ZxU6u9a4s5dQGWgonxHGbk73el0dBOggTFAV+hPd8f62lywie5oDNTXfR
         3w/gDZ4ytW4YtT4pHZdISc3x37qUYgH6NA0c+XKS0gvXxBWK+ThTfZIbNxpN2Jv/7W9H
         jo7IovzC+QPwE3sztwAuYFmGASP0DDz50LkwyspbFylbuqkJHWLT6k/xj6P/u08rJ+3S
         l5RUJn1F8qZHbfiQGFfcfbGggYIqnHuj0E/jkkUBW4lo6HeWI6lqz5IK73vEqweu0qHU
         i5AfJCzj8M+06Ap+SSQaGeK1m435JcZXdY578P/AuQIJrcMEgQYQO+HXj6EYmr0Ryz+T
         EGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        fh=SfIp9om2V47+Gt/roMsViuvFD7X10TveZVoVYmj+KX4=;
        b=SaIAhFYVt6NPdzxYENax72odgAS5ZJtDyadaq+ihthJpZXyAeEfxfnEQbZbl1rmUNc
         H97AbzgbfBLxZltvxBhKVTftBG0cu9BL78Jerktd8/QB3wU5Jid80g7ueMK8tjzBRP5w
         RSF2BawIb1ecK5LcnNNzNKhHkH/79O0gjxxpVQ3Zp2dFUQYlyZ6SV1cwUV6/uXUhGE09
         tMKuy813/kBAOsRbNKca3wxh6zWKAj05oJCarAZMM+tPPF4523NvvgHMRIr3HE9wAXHw
         hwQn6e9HdixMhFAz6f8wgGYqSnXfFArBxhBAmAGMIg6tNKPUynsp7pCDCmemKi9aCmrE
         hYjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782849561; x=1783454361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=XN24c5TU1mLtMwwVQrpsA3cb+Ec8JVOKflkTLwTXGBmehHakzQGPaN2aEZbPFpbD97
         LJXI7Xi/LFKLihPbM/Ozc33AJiWJHQW3D1ngB20cGK4F0B+mw1KKlsWOORfLOvwYsoe+
         pmnAxjzZ9/JjnTdkln0XJbGOPCH4QQHP6a4M2/WUsRbPfukntEC+Cb5T4b5ddzPzo/1E
         Fgqd0htDz4EopwjnY4LZMQlSDeipFKR95uSEQi4bnEoxNaYVXOfOSGL1EIqOhDX1SE0p
         xMUobMZUWaIXPebd5HgAPV046c5JKpeaohJhunSH/eiRKkNKEPKNFA+8OSveeGfCXZK+
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849561; x=1783454361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=p8hDk4YBGiWiL5wERwvlpSomgzDv9GBORhCXHkE5/xE2cQVaDraHySNFEJlCfXMsHr
         8/sY1zXkW/PKJ2Zav8XimWRjuIBNJNd1A81208VHPjW+kiKbxTgibFBxf7d51kloMGR0
         x0ehzV5ynWlE8otaNfRAgpA1XYyqE4bUAdafPS0dGXALoeBeWK2JtsyoeIdtulIf6Kas
         xj6rk11p1QKh/hZvkaMtttWDowh/Dj9bDdS6se5EXMSNMcbJcAQHVD0T2vA8GP4gtZz5
         Cv8BohYMFsprG7pRSWVi5/2ju/Z76f5CSzh/GbaIhJ9yhLn8emzm/PYsn8asIZndLfzn
         7ltQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXvS5Ul4k+b8ohZI5CNWVH4+xQM0pXj4/atsIJk7G4I1W3wxl7oQFTAb/sqVbzADy+J0SYg+g/QNk/GA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZI4IihIYkMqxYe9pX2+yTkPwJsFB1PFHjZQmngdqvuK63JalZ
	4foF8MDeJyOqK18kpeoGvDPMHH1lFxPW7gWZ7itNRvd8JbDQcfm+z+SQQYUqDC//pnkHCbU9UJT
	S34grMX45x3VU+mQTo1Ni9/WPZmzjNW75CD1s07w0D7bWeH/dNxIi3NZfFESMOqOPZpn2wlcYPQ
	OFtjL07+e5dmFlZTdrUrzzCFU3kylM/EdtVldVJjdq
X-Gm-Gg: AfdE7cnVSWGPK0M75BqKvz3+xe1LByZV4QzR6Q2wrpb/IfyykuamwsAjF318T3x0Ug9
	CAhvmCZoAqdD+jI/Z3/MRnXwhZB7L9HkstFBGwvcKgeSEvAkGqbZPbWWDUnlFdLuFM8IQcjeq5Q
	RYyIm4I6yfvoU3alxzYBNSpk53Up0DqnkPVdozo4lNtLQutkYfADDu9ei4qGWpdQ8PErWhsyh+d
	WSQS5F7Gc4A9bfLHFPVShKgQN9gYOucpNUBZr3YsKVa408VaeRJOW93xowhIl1vJ0pS2fHMRXQl
	rtE2fw4ynYE=
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id 6a1803df08f44-8f2d1343d13mr25863636d6.31.1782849561030;
        Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id
 6a1803df08f44-8f2d1343d13mr25863166d6.31.1782849560532; Tue, 30 Jun 2026
 12:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com> <20260630180219.GA4139943-robh@kernel.org>
In-Reply-To: <20260630180219.GA4139943-robh@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 21:59:09 +0200
X-Gm-Features: AVVi8CcrbqRCRkmYSZLH_ub9JNgkd2IUQmjyz1dD9_QoekOgl29FSB3CCebEUbk
Message-ID: <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: oSG8qhU4GfMnF6xAR8C1X_QIMJMQP8Cb
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a442019 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=2sLY7anfMaDELvqluMMA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfXy5NNr3nRPz7N
 D/j5slqfgXSznI9YbXzoIJxB1jgnHiKFmlWfwKkl21fL8gf3mwotqbQLQ4jXb6KatNVcYWwAaZk
 oA5XvaqZgXahGFo/OPySfybgDDFOp4cKm+M9+ArweEIgtEigRW9VYieXq5Rwdz5Y+0Zu6VL3JOo
 YssGunagEwGMGLSYAvykK6JYJcRKn/VguZPuV30DohQjzYyE8I04z97/Mz1G8Z9EYiShtDjr/E4
 ly6ES2aC1vydCFJng9XoTEyIhEsYCbcsWzVN/DFr1JgaCUnnoIcS0plK/v5NLZKmT9amSzSJh2f
 VGWupZiKYesuplrNuG8WXew9/rfzQcdPczxx46YWXZY8Er26UiCQLutWvAiVZw5zi7P3sq+Ctkb
 exnH5vbcyiwqlJfkEOsPwHgKyEjxEuXoOYekPfiWyZBuk5yDrIlSSKLfz4semW5bTqJuEB8jbp5
 uxncdiH3ljKvjYkqoJw==
X-Proofpoint-ORIG-GUID: oSG8qhU4GfMnF6xAR8C1X_QIMJMQP8Cb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfX2Af8jMxmn6Ea
 em5dOe6nJU8VlOXNxXnIS0sQpAmwoGJY8aRf3ykceZX5ckIlZhkBX+hAWvdo989phjunHtF7Jzt
 rfSU4X4yeIr7SITFfKU/iBslvY1o9KI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300193

Hi Rob,

On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > Child nodes of a fixed-partitions node are not necessarily partition
> > entries, for example an nvmem-layout node has no reg property. The
> > current code passes a NULL reg pointer and uninitialized len to the
> > length check, which can result in a kernel panic or silent failure to
> > register any partitions.
>
> That does not sound right to me. A fixed-partitions node should only be
> defining partitions with address ranges. I would expect a partition node
> could be nvmem-layout, but not the whole address range. If you wanted
> the latter, then just do:
>
> partitions {
>   ...
> };
>
> nvmem-layout {
>   ...
> };

In our case, the nvmem-layout needs to be associated with a specific
eMMC hardware partition, nvmem cells can be a simple sub-range within
the global eMMC, each hardware partition (boot0, boot1, user...)
having its own address spaces.

That said, your point about not abusing fixed-partitions is valid. I
initially dropped the compatible =3D "fixed-partitions" from the
partitions-boot1 node when it only carries an nvmem-layout and no
actual partition entries, making it a plain named container node. But
it's a bit fragile if we want to support both nvmem-layout and
fixed-partitions.

Regarding your expectation of a partition node being a nvmem-layout,
do you mean that the nvmem-layout should live under a fixed-partitions
node? Something along these lines:

partitions-boot1 {
      compatible =3D "fixed-partitions";
      #address-cells =3D <1>;
      #size-cells =3D <1>;

      nvmem@4400 {
          reg =3D <0x4400 0x1000>;

          nvmem-layout {
              compatible =3D "fixed-layout";
              #address-cells =3D <1>;
              #size-cells =3D <1>;

              wifi_mac_addr: mac-addr@0 {
                  compatible =3D "mac-base";
                  reg =3D <0x0 0x6>;
                  #nvmem-cell-cells =3D <1>;
              };
      [...]

That makes some sense, this would require extra work for the
emmc/block layer to also associate fwnodes with logical partitions,
not just the whole disk/hw (hw part), Is that the direction you'd like
us to go?

Also, Note that regardless of which approach we settle on, this
specific fix/patch remains necessary to validate the partition node
and prevent NULL-deref.

Regards,
Loic

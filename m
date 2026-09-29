Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3D3D1AB3
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673385; cv=fail; b=M8EKiDPw3lJEAN3ipnQ3Yye0z7wQOnH5SoM/xZ8no3/BoYH1TxEkJ7e9TC79Rv8QUB/RGAzFCZ4ZP6yvzbklukrorNEpe94PvwbpzOC214AQVGazUR23dSh5kHh70yjQTZMJgvrPCRX0bc3XNxWrPoi49UsnkiLrYq9O6kRDVwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673385; c=relaxed/simple;
	bh=BNVccYi1LnLrZu/mffNsQ0VeGIIlEsAHZtAlQgUKSho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiZoez4U6Da8Xcp4FRxErwBQ0q6QNOLBrGNrgclHcXYhNZp1CDTsSC4MhNFR6H/OWXmv6oNxsOE/B5lAcnsT48WaSS8V4A8QEvjeB5KtLM7YgY6o0mbZf+p98oi96csMWKFQMvSfgDaHxNZKh4Bv5UlRg3HHY9WHFL8XRHJdEys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KWF2oOLW; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KWF2oOLW"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7TgKC1533349
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 02:16:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=UXOt0DR/qucJrjzcbWN633PqrJV6/4ZYqTTDG
	6UnQU4=; b=KWF2oOLWZqV0qtVOV+RAoOj/bKInEHA2dCJiDhdsxUn/NCwq6IWJK
	Tz9cgDhv3tNVxM3VJLUJOe4yxCcEK+JG2p7LZE30TQ6S+jz4iogQ/XPcGPCUoHpl
	n2OZjxjDadiP4BLSbClNOosKwfwSyLfPFHvexb8nKGF1xK7HnOT/hpbdziidMu0V
	eQXF2tvCjJaQ41VREWyRlkPJTDNG+C/OAxmLb/QCFg+CQzx5lSmaJozJIeLxDsN0
	KEdLb0JNvn4tAmjuRaLLGTRdHr5jcwsnR4ZmzY89fKCoj2cdHLguRjp7XGPQw5D0
	PTPMWHscS0t5Gai/UfjzDBFfpPbvpuoUA==
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gxbsdjxmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 02:16:16 -0700 (PDT)
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c29959eb71fso405353566b.1
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 02:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790673375; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3vxbHO00DcFHGSzX689cC0Qc/JDj2JUtLVD+x/r4bEcmG+xf3ykKMXKSQhpbaz/wy
         e62NX4QOmbJPvSLFyNs2nKtJmKwoujyR+HZVpdyH1MpCHEPOcBe1xOgLWrBT7Ca6Lh6A
         eXsGut189yTEWe9YcR/UT5PmGNIYzr1QLCoxTNu+dgt0wEYbdFB+zWFuQlqIJWhizqU3
         +OGYJh06ihoregtf8BAVnS0MaXgks0q34Gr7yZ1s8yNwC+U++0QpE0oWTzva5dDGiJhH
         UVYnOH35IuKcg20/BXoNVLGg5+xJmtcuNH5+tbrhY9CKyy/8I9/0b4cVoGYcBxMojJ0j
         O49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=RutqN0XzeZ2DQTMI7Gduqm3yztWbS2+NpNwUibf3R/c=;
        fh=itQ6EYgSpdHCR9nyEMgGJ4GLGUZWhaKC8RMmkxy+vM8=;
        b=QNGE97xGknYRau6xT14ysykwzu32sSNphzA4xBRfQiH5vwuMQhOElSWH3wc/V9eE2H
         jyePNdewwRTVT259Lpzzd+/h2dW8WEjUL19kzIwuOBn2WqAXgWcOrbAAqwXVdmnM1jeu
         9WFYBMyRL3BnQkuUXtSdqG2upgB0rDMTlnSaO/8HPkYDMkx5Hrpoozo7fv4DSUGaHAfp
         Zu94S7nci2oTRTyOopWe03AcivADwpIpHPhm3h4ejuU1gYsnrTdQvoTRypt6+7cb3ymH
         53yOQ15k8XDmhSlt9f/ExHnKIUIN0+ocroOivAR9gKuvVEf5lVu4hDFwODnFeO46hJw+
         4BHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673375; x=1791278175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RutqN0XzeZ2DQTMI7Gduqm3yztWbS2+NpNwUibf3R/c=;
        b=xN6BaBPQuBY3x9UyEUYD7gBB/VYRvgNcBJU6ZAe9Di87Syk80fO8qMacpmWJ515och
         0sPqf89w7n5lMlWWDwhp3txBRHULfz3GM1za/6xzwKS8/p09t8yNfCFLJpaqDF3DZbQx
         k19kbbvklBZTOPWmB6R2Bk2ajmnPSp9OVsJ02IJ9pluNnRjNoQXCD472CBR48oRMg5yk
         hp/D7ZWJ3tu2BQOEu2YZsNJsDeWftOeWsJBGIqsPuFqC/2HfpRRC6ME+nSqzNtXgFOIy
         2SM0xEKVM2t/o0E3egAV0dyMD4Y47WfURXsEb5kdpZFE+zYlFZo0/YhEk5Iyz1Wm2GLv
         AYSA==
X-Forwarded-Encrypted: i=1; AKwUvByPulXRSl4y2DbaIti2F6wEseahPB4mo2ueBDko/ju9EE05y159dh8QlBHwuOHq3hlMnjP5R7hIJGGPCg==@vger.kernel.org
X-Gm-Message-State: AFuF++m2RNqkuxSMod8ZoDcWf9rd8FNTFJdnBUgt19gi88IK/emaS2cX
	Lv1HjGWJu3oQ49tgU6Mr/WecXmcokJHOf31piqc2VP7w3DZhvgn8fU5c/rTcPm86KsPocd/CVlW
	nYdZYLW0eOeBdUy4XXGny5GiKQ+MYxRYdnqWUbmXAcVJD8jIlD7gdyRzcEriIfUl8NzLxRvcLy2
	H5wcWUCztnFQR6+AWsosIkm2QjUqZSDn6+I1zRnQ==
X-Gm-Gg: AYBFou2xoRFRzkWKkPqNshf0BmUSdCbL5gSWxG3NNC9fsBB321npkd27d0K1XQIZjjR
	3/XK8AGpqZgsIlZEam/+HLmhyHgIgaOK7H0eL51Qo4Cl1mwZwWOSkJGDu0BVs7yQSRgRuUkLOkY
	9kHDaFG/FB94OHBK1985E/nyoj0eWqYtyUYcIjpMccAswfM9tMvkDs7QU3glVi4tAsfGCkYT9DP
	3kxEedYLGJwZB7KeA==
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47af with SMTP id a640c23a62f3a-c2ac53cb0afmr1291012666b.37.1790673375168;
        Tue, 29 Sep 2026 02:16:15 -0700 (PDT)
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47af with SMTP id
 a640c23a62f3a-c2ac53cb0afmr1291009966b.37.1790673374768; Tue, 29 Sep 2026
 02:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928081900.4187482-1-alex@ghiti.fr> <20260928081900.4187482-2-alex@ghiti.fr>
 <aro28ZGuYgmNg_n5@infradead.org>
In-Reply-To: <aro28ZGuYgmNg_n5@infradead.org>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Tue, 29 Sep 2026 11:16:03 +0200
X-Gm-Features: AclHuK-D9BofbMEsWSFPaoMRP_iu1F-Wj4thWHCh7PID9jFqkf7sbSb8Hc_0i2s
Message-ID: <CAEmasaX-6v_EpwAxHtnhA5SXk=jGW8+Lm4m8zAC=+f0yXmiCxw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] block: do not issue background swap bios as root
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        david@kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Chris Li <chrisl@kernel.org>,
        Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzNiBTYWx0ZWRfX2lDVnOyc+v3v
 B+GUNtjTDi7MktfgKeX2D/qmB4jwBUjrA4W1YUQ8XYkO6V2gJgteveT5yvJomK4VykKact81EHj
 Sy69gTKyUj2pACJ4jFXPpDlXb+Z13VOdpi2yWwlv0wmY5ucYQIb3NIK1bNBqXY8NUzy0nzlREVj
 1xJCC9Fyg1NKz/ho80XwxSlSeaiGHiC18Smz4BUNVWWHy55LeA3cQ1CywLI/lmUqJLPbRX8lRI4
 0/Lsz1TAJGy2wf62U5Vew3ihmHWrkMooEDKOXi6IrLVWhI4pTVTotMEfIcIFHj0BpQ3JdhVHbou
 Sm2cCctCGjrD6v1efKjdMTNEOSrKRPl8w9RcLnKwp6jpeOd4v0S7q7R91GIsajqjqfaZjo1UV89
 4Q3F7TG1W178ncLtZatx0VlfUNp9WCPwilOQ6/eDuyqWoM7CR3JOmOTgGMUU8Ladhp1qadrh1IH
 aS5b9R5fajG+5PaHkkg==
X-Proofpoint-ORIG-GUID: eP1MVfv0FO_zWcJxRlWXVVymybNP_X2_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzNiBTYWx0ZWRfX7ybbfS22GBG0
 OV2B2NMe62JHUKj1z6x01hiBfjZVjjzzeju5CfCZkE2rJT+BbQT5dy9xBkefBwcvnmeMJQGyytW
 dB/aXVGyO/llmSdNRThfJ1xfShzO9pY=
X-Proofpoint-GUID: eP1MVfv0FO_zWcJxRlWXVVymybNP_X2_
X-Authority-Analysis: v=2.4 cv=euVKXYpX c=1 sm=1 tr=0 ts=6abb81e0 cx=c_pps
 a=jJvPsHQLKLf2UdvVr97r4g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=JfrnYn6hAAAA:8 a=gdocsb_8Clbhv9H3gegA:9 a=QEXdDO2ut3YA:10
 a=q7aydO1c4wibL4nb3gNS:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01

Hi Christoph,

On Mon, Sep 28, 2026 at 11:44=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> >
> On Mon, Sep 28, 2026 at 10:18:36AM +0200, Alexandre Ghiti wrote:
> > bio_issue_as_root_blkg() issues every REQ_SWAP bio as root, bypassing
> > the cgroup IO controllers, because reclaim cannot stall indefinitely on
> > swap writes. Some swap writes are not urgent though: zswap writeback is
> > best effort.
> >
> > Such a bio cannot simply drop REQ_SWAP: dm-crypt and dm-thin rely on it
> > for limit_swap_bios, which caps in-flight swap bios to avoid a memory
> > deadlock, see commit a666e5c05e7c ("dm: fix deadlock when swapping to
> > encrypted device").
>
> Is that true?  REQ_BACKGROUND very much implies the I/O can the throttled
> and thus better not be foreground paging, and thus the caller should be
> able to tolerate a failure.
>

Yes, I agree, zswap writebacks are only best effort and in case of
failure, the compressed entry still lives. I don't see how
REQ_BACKGROUND could be an issue there?

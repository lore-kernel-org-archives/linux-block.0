Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111899;
	b=4dF8g4E5peOVjEHXSFCFQDCbypTI8HSG1+RgmXSqu+M4OQeuMRKPjnw8zoA1slLc+Mn5
	 c16kF1Xak/B5RPamEQ/fY4BZa9kIOWfzBt7WSbXHukkHkhqxhlhri7C78zIN6VMUKMzXu
	 kxaALNyB26Z1rX1pp/8OdGm7xxk+JRvXvTewOUj71R1/+zDiSQEH6fSJEJ5cX8ssmuhng
	 dgtBS5Jqc1G1ajkDJTMStkRqFRdGjlxQ3Rgwwtuzwrc3rQR2WtfeUQhYIQW6mp41B9Qgb
	 GrL2Euipw+MiAjTSOqH9SLKu8Nh1a61DN1dl1Tdv4fINucRVGK+b2J+z9HHr6iWHVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794111899;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=K+8Bg6EUw3TF1wR9YyKQuQJJAgHFmn9Yf5SnbT8zOjA=;
	b=Xlq19Af8HPJWgdlBXpz7OtNfq2gTVy9HTlQjNzzbySKt29sh12HneC9js9PxcuQDzPDw
	 KouGzzsQ+vWh5NsQgOQaOflYP0PYnU0OZ0+5E/J2Gd4lTqTExCidCGwmC1PVPWpYlvkM2
	 09/2DjVAFCkA98V8aFL6ii+q/kh11PDeIe+p2iEsrSJbHc9rhx/amiLykG1xjkVrgxrwY
	 axruO5ubH4EiFWGcnS1uk2xgopd0QX7sMVDqBIs8lAt938kNJTQJGqvhvUU3a98GkotMn
	 4rFhDf3JA8hyFJYBqSICRexHI5v7Er6lkguoC7Ejma3mN12prsHkCVwCZUmOePaoZ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NA+eMRwy;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=M6UZqeGy;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFC606A31D
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 04:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ACFC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NA+eMRwy;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=M6UZqeGy
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A83e3BQ1316078
	for <linux-block@vger.kernel.org>; Sat, 7 Nov 2026 23:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=K+8Bg6EUw3TF1wR9YyKQuQJJAg
	HFmn9Yf5SnbT8zOjA=; b=NA+eMRwysoiN1QqrWsbt0Rr0FUO3Ilui52wc1rcSmO
	en6V7Ir8uKs8LkuguDrcnqd1Kcam+Batzv2jaT1PfxF2nygaoL7XUKJiTz1pry6W
	8B1CVmCDU7meCThFXHtqI1Hzt41QT46OxMOpdeTnbljnl/R5wxhlMeYnriQ3RToJ
	VyLusS52dlctIy2ZDmYtjCfGmKV3URoK5HgPEPNk+6rY6GsYcQEkmDeNOET3wur4
	vS5gdv0f9/sFEGJcIVzbnI8WzF9dMCvDFa1zsOm7jaHtTXo5cXLtQH4KyAGB0hbp
	xpubgBwv3V2nH1+Qq8/je55ze5OKg2jpfWGHBE9C+3UA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ht5myjy1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sat, 07 Nov 2026 23:24:57 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91e98bada22so3247826d6.0
        for <linux-block@vger.kernel.org>; Sat, 07 Nov 2026 20:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794111896; x=1794716696; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K+8Bg6EUw3TF1wR9YyKQuQJJAgHFmn9Yf5SnbT8zOjA=;
        b=M6UZqeGyCCs71GXwtMsnjxVweAjJnJbO98QMbCdn3nrbyEqFpypYPEN83l//wHMfDT
         6oacT/xFjTsM16dMuPHGW0o5OoKNHk+m2OB6/LkbrpdEYHIt1ANfZ3Jp4G1zaVKBo0a0
         4xNWOz+MURlXYb+r5HWe1axQb9aRGr6RfZJ/R0PHmgTQlzP733QwJLoa/j2zESUoykfL
         J4CbKibCm0hs0WRCYaRaNSIajE8tQudXpcN7uHMI+dXPw9ALS7jPjxaHGMxwgN05zg+9
         a9I9OyXKwTYHJQSE3DDH6qSA//SMb6VraQA+19N0z9mXTDth4RfOEUfg8NOxbKuY6WYU
         7Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794111896; x=1794716696;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K+8Bg6EUw3TF1wR9YyKQuQJJAgHFmn9Yf5SnbT8zOjA=;
        b=Pqu1IWd9nc3RDDiMPfW0VQEblzJs9Nf/eGAeBf46MHSv/Dy9EmKH2CaVbyYB5Sd9gu
         gTLfLbpm5fdpOeao/XY0Vcsgezlf8KRHf+sKtH4NPyysRqEHgPUwN6znyvnSPJUTppPv
         CRbck99bTr3E5e4uNAc4Dshn4dpJTjPvepy9lMOojs8SQLeBOQKoYPD7LHkbbRu1LWS2
         H81Bzmh9jkrEczOiI0EeIEI9QP0LYC1xwUw7evO+Nto3/e2K5RgKyToZEbZPZd40h4Kd
         PM0LZI7Geu4q5ooFsYQttr/5SoPh915HZE3MpW9Jn81hCsGFy2+F4e6Z8zO7nBDrCosX
         ZGKg==
X-Forwarded-Encrypted: i=1; AL+hErEfwiuVLaNtX0BPaYstjToxQlS13LuuSAvwcR67f6EeZuduEPkdq0DpZJ+fNkETz+WYfoYzsp0v4BRMIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9odJMmMdS+YMM0CKaqbsXWAdLth+Biudx0FxuSR1j6qA8RLIwb
	i0S3R7QAuPrviOZ74EQ9qG6yI9RV1+a84LnTIZKhn4quK1CubDlePboFiYMQ8AqF34B5/9546Fk
	1x4+KdrLxV4KE7yY+cXgiIXMaO5pLmMxfDlgUHZxpC9eEyRCPrRr6gF5OfP06
X-Gm-Gg: AYBFou0YXwCpz8aNpxIq+akY9r/9JBEWLkPM98xG6/9eNm+GHiFKjQohYEdNCpKHS50
	FoiyUJy/qoosVf4Gl3IIlmI98Rmyw/QnS2pPUIAbV38qX9OZRe4ALa6AAEI4A2EBP5xfkwIcRQ+
	gO+igu8i/h+xuQQXq7iNSNf0h0QBk2cqePT+GTn+1MeOWJepou0p3uQfyyZxRr0mlj7OSuWSZpZ
	7IiJB6L4uOTOt32QjaefJJSTNLCf75m4CCAqYcGwY7J3MOZulVVBbBDzT7xuOsjldfvb5HZqqBe
	2c7TuLNm3j3eZp/8/NRowtlT+pLo+9wSjCaaGUX4bX8r+exit/fBGwFj27gMMv2bWxUwXauzdJa
	ihaV/AsQOKCs5uf1ihVe/z+XjH2Dn3+b27E75ZGFC4TRPRdJOlSVh+vfioUQdN2y9HVbgOLbUF+
	jOlY+DDD8tZbZgqq1OIg==
X-Received: by 2002:a05:6214:4b07:b0:91e:8ed6:896d with SMTP id 6a1803df08f44-91ed2476a9fmr5970706d6.41.1794111896367;
        Sat, 07 Nov 2026 20:24:56 -0800 (PST)
X-Received: by 2002:a05:6214:4b07:b0:91e:8ed6:896d with SMTP id 6a1803df08f44-91ed2476a9fmr5970596d6.41.1794111895960;
        Sat, 07 Nov 2026 20:24:55 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb56290sm10085586d6.1.2026.11.07.20.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:24:55 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] block: fail short atomic bounce bios in
 bio_iov_iter_bounce_write()
Date: Sat, 07 Nov 2026 23:24:34 -0500
Message-Id: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIL572oC/yXMQQ6CMBBA0auQWTtJCyroVYwLOh1gAFvSAjEh3
 N2Cy7f4f4PIQTjCM9sg8CpRvEvQlwyoq13LKDYZcpXftdJXNONgecV69h8hNH5xxNjQg25Voar
 ClpDSKXAj33P7ev8dF9MzzccL9v0HmrkbengAAAA=
X-Change-ID: 20261014-blkdev-atomic-bounce-fc9c583083d7
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794111894; l=996;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=MQysUVjlstPiGv0HFbdIIHEKVGY3qk9oBru4ywVAac8=;
 b=ZFIpiuUVZQBRB9X/AYDUXtP1xkrxSWzeG52xXn4uDmJFAT+3ouMLtp87i4lyR+EjUxAB/zX2n
 numf/QkOPTuDfVi31ykeyiHjhEgiSSSyJiFjO0NEm0fExmh7ItRJ5Yy
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfX6Xruawyjaph3
 sfBayMZJxowkS57NtQtTpNmxd3Mu4Skz9EHt50F60v1SD01ZkTFhAl2xQ9sc3iKrNmnFaW/Fdg1
 Zrum1FTpqdPXV6RiruNlYPfykx6UTdIbpRs4NnbRRLWcEZ3SKGg8CChC9QuWERnmaDiuMxAUMrq
 Y/fJL1zF9z6fbYLany27W2tPu9jxi52povFYkdj3CUzTw1OXd8ewWH91CMHKTYnPbaLjBLY7cXE
 JgffFgq7c5SJojMrMsW9ic0UjYbHTOqAhJR2WtuftjdrUx6vqUTilkyaL58tmsi8QqGO42Z35QV
 8tZjFnhOPNHoTINfwA/vry4qBaHpV9jBEDxT/uxSKzmvqtK7KLf6Lz9ZYRzgelVBI5Q8cbwxUVU
 NEXL/ldk23LX+vaXGjL5a2f+kJuAgBrL/oWBVYPfFZE8LEk+kWSsvcv5zwqFc8qcQ7fg5JITzvs
 gSvZ4aq8Ev3Sl6eZZnA==
X-Proofpoint-GUID: KBr_Hsfirdx_Q54iCmAoHYr1kK9eaWkj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfXx3cPLRrJX1BX
 PPtjQVHi4X8gNIPOqPZm4INWR8hHgnoIjCu7ew4kq0nhoVhq6WJ/psm/2JUSdE2CwoiITaumeLx
 yLGI6Yqd6hdLOWlOCtjCl23BN2SQ3B5RN0HeBXEkEryJfAo1E9dO
X-Proofpoint-ORIG-GUID: KBr_Hsfirdx_Q54iCmAoHYr1kK9eaWkj
X-Authority-Analysis: v=2.4 cv=fuVJ914f c=1 sm=1 tr=0 ts=6aeff999 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=kv0fz9X2Bfwy0Ckj0RYA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=10 impostorscore=10 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080017

bio_iov_iter_get_pages() fails a short REQ_ATOMIC bio. In contrast,
bio_iov_iter_bounce_write() doesn't, so a bounced atomic write that runs
into a folio allocation failure triggers a WARN_ON_ONCE() in
iomap_dio_bio_iter_one().

The first patch makes bio_iov_iter_bounce_write() also check that a
REQ_ATOMIC bio covers the whole iterator, and clean up and return
-EINVAL if it doesn't. With both paths covered the iomap check can't
trigger, so the second patch removes it, as suggested by John Garry.

---
Tal Zussman (2):
      block: fail a short atomic bounce in bio_iov_iter_bounce_write()
      iomap: remove the atomic write length check in iomap_dio_bio_iter_one()

 block/bio.c          | 10 ++++++++++
 fs/iomap/direct-io.c | 14 --------------
 2 files changed, 10 insertions(+), 14 deletions(-)
---
base-commit: 839203759f536e6ef1267c80309c3532a7d588cc
change-id: 20261014-blkdev-atomic-bounce-fc9c583083d7

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>


Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230643B42C4
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564631; cv=none; b=g0gTVdBvNzsDY0fFikDQhqd7aFB53qi4/EuKq45WMDLQhOwSTffhscpW1LdkdNXUr8buer6FjHbgPQ92wKm0yKrWN1HqcLIsHljoD5jTOpYgHd7fT/F4Ie+oNYw8eK25C/EEKT0FFDedObeOCQH0bceKIc795Uc1gL+zyfz2reg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564631; c=relaxed/simple;
	bh=dQNMb5/wuPELUla+30Ybhb/m9cvIEvZQydg6aWFrln0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJW8BHCdhmddW9DO80Sh3aYIxOaiju0JtBIn7Y3qMgZhi4rLRJ+Nyuvwc5kCCZPPTvu6pwVT7YVdSkqlq+CkggSz7aN29zMP/DECLUVzf4BlZ/AD+kh84/N+qzWWJmK0tjWlK3WZgJAN5Mo4/o6YDIcnUYjYa1Ie/lA+EkD9b+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=t03+EVHC; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=yf1xfgJ4; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="t03+EVHC";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="yf1xfgJ4"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYGer304219
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 12:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=gkwv
	Z+/1V1m7k2kzWuttuR6zzSD/UrFPm0hpOSrXf4w=; b=t03+EVHCUxQKMU9i7Sjy
	R5fIxS90owqI2qKGbcd/+gzzactoRAkxe8q5wCAK+GhywScGPa6GjN75HuM+wCSS
	2C/eAL3k+zsvAyF00a3SA20/rlJqN740egm+ejqT4c1ShAy5n/5TTsadWWu6Q6md
	0F3+Hhs331ktNy+VQug9cpb1KR2/K0URo8tsblmqUT48Hlv9RB4zRL3lO5/QkCCH
	fFBADCezOkHJC98/ukqaBcLKFVFVe5e7giJJm7SdYdqiBVMc7nd3hzqmsDB6OFDa
	kc+CsWtVtqzuskrQTjFVJIHhtn73mnfyV9Q33j1qRwS9xjpXcHD0MWXQ/Tn8zw+g
	GA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h6y3guf08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 12:50:28 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5350ec54bf6so123729461cf.2
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564628; x=1792169428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gkwvZ+/1V1m7k2kzWuttuR6zzSD/UrFPm0hpOSrXf4w=;
        b=yf1xfgJ4/yk2q4UhMIW44lwT3SXmDvwRvRkGcYHVUTPVC6tFbm57M4v8311UfWBoWZ
         jjLYSCPqQpGLG+P53ciREiX7DGghB3+BQo+u+ur/qkka9RNNt5+f2eA8gpKLZow5fBGA
         Vbd7t6c5cO5iwTMnkLTCl7JXWeYu9O/7Mh1km+1NGglHPFxTfUianmOOmrN4oysZT1CL
         h/chPQJG+TBDfLnbf6gycIvFjqh+a1VgecOYqeDYvmErcjPUBt2hSVrzi9zs4gphITOT
         PAfccyzVk3/iVgj0Z63BTSUDIU+Lkh/z/T4wsbDiUssPT0PUZN+KYRRYHl1UPTV3KzeN
         uzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564628; x=1792169428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkwvZ+/1V1m7k2kzWuttuR6zzSD/UrFPm0hpOSrXf4w=;
        b=J+q8I+BO/+Epdc0XbBt/XgoSsWs9bFx0L6lct8+xBh597RHJVD7vTBCKuwIS4rar1r
         kh1ft59e2czue/GwuUTU0pdMPjPylPbfxAEj0rmyz0/l1doMps3cbXlU/oh0G7S0aUTp
         cMfg//fKzDvniT5iRfsW5RX2kVKluvZeFiubWRX6XBYfRLRsAUZzp3bW1bgOuNm1PGsG
         LSI4urpAE85+MnkOoMwPLMDzvOIBulQO60biY3DHBqRIoFLVKDy+Ka/t/0iCM3BQv+Qc
         7aMmtBc4l0cIG1+wMPuWTnhLhq+/UEwTJyL21J+xrz27CZGliygS+VFkJJSpDeX64qzW
         pw2w==
X-Forwarded-Encrypted: i=1; AKwUvBzH4exbX1ZSzZs4Pkbuk55MwcWfoD0t6NqOrVRV97W8+0SW1qtjW4ChI/ZQewzctHA8i9Ivfb5tY0oz4Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l2uhyclHxXNaVDgido1kbqE9xwP5pj825yb/axcxlWx3WNi09V
	Bh+1m+vyeFKWYzg1T46EU6iDJILrbi5026Fb+ltKbuyuifRri0TL7BlZtDmKIkDPiCkqu20+JkP
	hy+ldgdKLm6p/I6AWrpvv02yCJhfwnli0jnFlEC/FnMwVeF+Yahow96EYl2q+
X-Gm-Gg: AYBFou2vfdyW/IscWQjGQxsVFav8AcK6SJMZ8Zj3CgcC6xd7hOx/FeUuIRTxMnRzvj/
	eoUKD0zzrjyi5NnInXCrju6KUsm2jMgAsZ2XoGtgRr+hRvZSOwywHZpzqFrGPgVJgG03sTrea7W
	KDvgQ6Mr5WeqoJZwECD1c9GHsCKii05MB3YGvyMiqIdbhm5JMepeiOZgwowcOlEFEVtUCIitX6J
	EMIEYFFdhA161sldShkFAWFnTCoez/g4cT9C+//zzSVAYEJkBzJwxwV50URA09I1k6SNDdzpHP/
	92rknJtAPi7MgXKExf/N+P2UyKpQ3ZSvsD0DJr1hOAEAhT4cNrNviHdfuScfv+vvLGV/5l6F0XE
	vzgG/HXyVvN44dE2I8DC6AsqRWnzSO5kJux7h3EYjkcjV9Fw=
X-Received: by 2002:a05:622a:8ce:b0:530:e1b1:eaeb with SMTP id d75a77b69052e-5359fa73749mr37098771cf.21.1791564628469;
        Fri, 09 Oct 2026 09:50:28 -0700 (PDT)
X-Received: by 2002:a05:622a:8ce:b0:530:e1b1:eaeb with SMTP id d75a77b69052e-5359fa73749mr37098041cf.21.1791564627857;
        Fri, 09 Oct 2026 09:50:27 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:26 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:15 -0400
Subject: [PATCH v6 7/9] iomap: reject atomic writes in
 iomap_file_buffered_write()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-7-307939c387df@columbia.edu>
References: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=1258;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=dQNMb5/wuPELUla+30Ybhb/m9cvIEvZQydg6aWFrln0=;
 b=WZGuKbqgstXPQfB88htkX6didpQHdTq8xJ1ra6e3bXkVqmC3AAsryMkhYBbhxHoVysg1omLol
 13qicZ+RfMGDf2fzWd785at2EVFZXPrUx3L88zIp/oAJyI6/Yv8cEDa
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX7zt3vd7lp6/a
 J7qnpUhjy+nlDeZw9gZfsTZ1wTMRVxmmO5HT6ogcDu8L5Gt9t5RJ/RIJTlIk5L+SsoxiojzrrdP
 YAGV4Clmmu3sTfQtV4thnWav2UsrkIQjpBkbYwp/iqGHveQq+0Oa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfXysNTABCd5emX
 WE7E1I/RE8PgPCuCoyMIUg+AtX+x/jdIZpwFNyf5tL9V35v8YJd7wiiqHMMK+AoStk32qm66Lnr
 YpF0USSzVPDxEiRlLqlqQrhC3ijZiu+XcSxaSkKUFjreWXe0IbzWTMoGm0/veNGEfjFiUjWY4Zt
 SOt6D4mCRdUbQVavtmwmFamsdNfCJm7OA5w/LPYoFj9PBtqviFQOwJbumYZlutuh8F4BFVdzFKt
 D6OJ3lxkhDff+Lb2VezOLej3xPm7jnMaYohV8Cm9TjrykPJT6oAzUNDLJJw79Oxd+sHIJLMMmse
 x9ZiabsZBblyoa7uOg8uARSvaAYxWET9J2miYKo7Y2RnaiLJC3gW6u0zToXwh/wowqzikxvEEmM
 JoTpOdg3+27a2RabOURoCx95ZUNSn4lQ7cKXRBN5cWRgNGmFA3XtOYk8lf+Fm3taxKguY3qprjY
 yFMdTgFLNX86wP4pomw==
X-Proofpoint-GUID: 1pcevzi0I-U4DW9iTpVGU9Td2Gh9GdZK
X-Proofpoint-ORIG-GUID: 1pcevzi0I-U4DW9iTpVGU9Td2Gh9GdZK
X-Authority-Analysis: v=2.4 cv=bovZl0ai c=1 sm=1 tr=0 ts=6ac91b55 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=ASVHLkjgWNnnwhGXR8EA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=10 priorityscore=1501 phishscore=0
 lowpriorityscore=10 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090067

Buffered atomic writes are not currently supported. The page cache
writes folios back independently, so it cannot guarantee that a range is
written atomically. iomap_file_buffered_write() does not check for
IOCB_ATOMIC, so a direct write that falls back to it would complete an
atomic write without atomicity. While no such case currently exists,
fail IOCB_ATOMIC writes with -EOPNOTSUPP, so that a future fallback
cannot complete an atomic write non-atomically.

Suggested-by: John Garry <john.garry@linux.dev>
Reviewed-by: John Garry <john.garry@linux.dev>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/buffered-io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a5ebfda90f1..e6654cfe1cbf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1304,6 +1304,10 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 	};
 	ssize_t ret;
 
+	/* Buffered atomic writes are not supported */
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return -EOPNOTSUPP;
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
 	if (iocb->ki_flags & IOCB_DONTCACHE)

-- 
2.39.5


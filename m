Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111899;
	b=AGyKTaO/IzCJnUu+F14WTuJg6rKb4R/LWkZAtWbCiI9DrwgKabay/132UE++2xdLbUQR
	 ZwUe33qUhfpNZq9u0KMbPYoe3Km5IX6Q0AYLA+GFgcq44ZY6f4a1hupW4yak2GP2JigCu
	 YGOd+CkIq8U/0OK/H0JEJXkKbMlEatC7+wUP6QTvWaI6EWYxpx7MNieWEOdtoatCfHqoY
	 bhX6eMLji7+6QhWaEwALhUDbQ6BR5CHSs0qBdXoVqxP372O2tPRvdPph+XfHiee6PmZ56
	 +HzQJbVOIn9RJBKaVsnMvL+8zzrwAuyZd/WHGNDg/a1DuMPekD/PDV0RW73k4aGHTog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794111899;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nr2Wdm4cU+m3pqBJ2boexNpwuovYPWeiRQ6Ijfa/2ao=;
	b=dvC96Sg6e5mvS1wOEjVoPFqWj7UnXNqaZQXUURRi+54Zv5coIZlnI4MU4clPwMrH9JWp
	 Gh8Zrc91PAbqDsUx7G/1aEJuwvXH4JMfW5k2TeiUctXl72/JlIalKw76Xr8cXEbEXL59k
	 ayW6m2sBmusykmEBGxjwSrmm/xjS42oxIhwxnSKfbk6ihZXUG8i6V05fLa8AYkXZmnbFr
	 uwLhM3k8xRbu1lfPDS5RApbilkSpFcgT1UpnsIYuKO2isG+NbEphciYdsCzAjQ80B7DSH
	 qIp8jXqLvmZtT9fhPdH52ZjbzXAwQHzYcUW8I2EMKgbXU97KJEa+mb+23pm6hP3mxLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=r0Tut1ve;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xTksu3W2;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118A606A31F
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 04:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D118A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=r0Tut1ve;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xTksu3W2
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A83fjla3571794
	for <linux-block@vger.kernel.org>; Sat, 7 Nov 2026 23:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=nr2W
	dm4cU+m3pqBJ2boexNpwuovYPWeiRQ6Ijfa/2ao=; b=r0Tut1veybdZKVhIjzNS
	f/LbH4m79onai7u+naDj1RMu+HNEuFy4EW25wgHYDwUimFujDwGDDoGf6N117nf5
	uxobIRKETpZGhznp3u34Tl5TgHaqv0bnQ8Wuzu7uZkKLM/biJeU7cKhNU/33t13Q
	WN0PyPJrrTIUmjAY8gvvn1HaK9/iKxwCbfbfQuMH2BKmEpafDbP0y4AyFwysGrBM
	/p3onW7+72iw/NbhjSgF9lWLBEUhinDoL7ACcEGUSGewPnLfn9RvyFZAjUcKzz7r
	3d9LPmAppzpzs5jypgm2G/Cf0Y3WFYa+F9wr7TGDC2fzDzKBNEpmXzUYEoaeif/I
	PA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hswyuma60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sat, 07 Nov 2026 23:24:57 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-536720195ebso5076711cf.1
        for <linux-block@vger.kernel.org>; Sat, 07 Nov 2026 20:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794111897; x=1794716697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nr2Wdm4cU+m3pqBJ2boexNpwuovYPWeiRQ6Ijfa/2ao=;
        b=xTksu3W2zbddPSvYXw1KCEPKyQ8qBoo9EWhExte8YiKEgvH/b1uqj54lAPkSUtshxz
         R0nQWjqIpjdswYs1BztX33DSElMaiTU3SOLuC9DUMt3IKglPtsTtvi85lBSBRqoD7n4r
         pIe11e2KTT/0akPhVzS6SeVzTcPXY1RAuiFrwXQ/6pgfHtqq8BUP+89OHUX+G6NddL+2
         1A0+Lj6OambObz9K8O2BuQhPGgvuQWVJnKC0mGnhSeg7/S4JZqAzjFECylaVaWgZQCKZ
         E4O5SAuehNTnsWNfYBMLHvjcPujC6u3iqbDA84/Un2enK7AH6GttY6Iv333XOhaB6GTT
         bQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794111897; x=1794716697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nr2Wdm4cU+m3pqBJ2boexNpwuovYPWeiRQ6Ijfa/2ao=;
        b=zkNBsPD+kpuQlP7TsDdVyYiVdl4429lp3+9xzxqjDZRP26nYrpu+/NIjy4xP/z5Ho5
         1MNMr8ftcsSkyt3DxpbiJGF37G9Bk3Cf/1hSBT0XG1HJhArdoFWwXLqhb4vfn1dGRpTX
         WjTcW8MxT7SMdkYq9Z1L/v8ln4ykhgSXiHj5LhlbIEr+Jns79W2MFS1oQ+2CAPIg3xkP
         3S6HJSZ70JWy8B/VZVQy38qNRY4vNlSjRfdaL8WRP360TPu4EOmwIo2I+ZGZB2pOP0qP
         uOdBQ6M8kB6j4+MAe/ixWYDgaMM5WO4dRESn24jMvt9FQMtsa9AjMFmxM6PPuetvr5lm
         OaxQ==
X-Forwarded-Encrypted: i=1; AKwUvBybpynARVXkYRDRrN6GTWWVofTZ+MN/UxppMdy+RZzBp0WWzplUfTWIs1+P6hJCNkoRwf013EPE6OqrEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8xa4A1eqYoo54JeDqgDAoPPwGjVGG6jNuCSGqMtetXX5qVPYpx
	uJ4CnZNIdwkRWzyS7JeU8XrodCYVCIH4Qxoah8oFE1Oxe9R7PXuQw8l9e6qoRnG2UFVRbVKBtaj
	6fm6P9JNYkKm1VeWOsx5y43tw3imrEC1hxOP/a2NMv3Rk6LQXFrTgIRwwykPQ
X-Gm-Gg: AYBFou3HF/9NS3v0oSJ7cMpOZKMyog6dW0iZsp2cKDHZ2nbfOUFKmlsVa27RUIUZLjP
	OC8zqNvii1Q9BZ940FaXh80H9z1OLg59x98dRIpCnNH9V1NybkV8aYZdJjEU4Nw7oGeTJIF9swz
	t2d3I8GJln07A/2TLEF8nRObS/EGLYqt2IZSFDIkriZEByItc06Z9FGa369xAPsa+A8mgDvU+uu
	m18pQyMiyWqyFLcVurFgftUH3JFP4xyPe8Tuo0FdbuRPck2wejoRuQgLAl8jK0q3mvvHUzKmLho
	Uc+W3o8NgpJ1eDBu7Y4wz4SvJJvtye4/+T7okR9airwqLBbE0x0oIokPwWwkEF4jOGGQhGTy0RA
	ebzEvYa6QM5QNisjJMiTHomhwUMeV+u1nHPCb/UAWySjlRJ+X+CXwRWM4OuVCNwL0jHt+qleyGE
	vdEg82RZErVjb3Rljb7w==
X-Received: by 2002:a05:622a:5507:b0:535:36d:dd97 with SMTP id d75a77b69052e-552a50afd9cmr5945761cf.48.1794111897258;
        Sat, 07 Nov 2026 20:24:57 -0800 (PST)
X-Received: by 2002:a05:622a:5507:b0:535:36d:dd97 with SMTP id d75a77b69052e-552a50afd9cmr5945671cf.48.1794111896856;
        Sat, 07 Nov 2026 20:24:56 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb56290sm10085586d6.1.2026.11.07.20.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:24:56 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Nov 2026 23:24:35 -0500
Subject: [PATCH 1/2] block: fail a short atomic bounce in
 bio_iov_iter_bounce_write()
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
Message-Id: <20261107-blkdev-atomic-bounce-v1-1-f66344262096@columbia.edu>
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
In-Reply-To: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794111894; l=1259;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7TVx2/mnFenAz9IetxnT56jaB8MDSx8eh+EB+HeZVY0=;
 b=gtfq1Uu5lL/o51CiwuZdW8JnZsS7EQmgCr/CjLWHC40wFPmi8TmuWNFXBbg1XMM4G8/JGXrcj
 IRjI+Ygqmz+Ci2lYcH5eeFDgH5zKF0bslDSMzRf7bm3ZBsZZc9/7jcr
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: nIVeSDS0_z6xVFFFTWMTJjiwCXsOujjQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfX2sp1MgEkdbzT
 c3oytnCPMhPagwSl2ItBbxFaKQZlqg5KRzP05PFBC4/wTECOWwUO0H85Oj9yTbEP9A8C6ncbSo1
 ImOvUmqWDgcDNcFy11Kv0j0G0V5Hb73VxnC7LadHtDgr+2PKT4UxZWU3hcQNMeQTojNz7qlNpnj
 6wGYot8+2/JjFhfHjSbOpZqJiNY4JE4wK68zFbz9glj5SY28HdhcLenlnsyD7ocX0BDeWTcCLiZ
 VCB3hZHnciR+dNy+PhEYfPGYWmGWYIcfq0cKwllL9+Prtn6bxWpwzz4ri/JcjV2c8LzM/YKRuQA
 ElqQPGSXB3tmOnEekjxASXKm/wCyZgItvmylg69yDn6ReBDYHp0qEU6a1Cjn5ZIZz3EoBntPACg
 P4hRhSGRqL5W5L290rW4yJwU4/xgpW1xTEbHNCRnfxFhqYyqNfg2awhS/G1IBQhVxsiU4xgThbg
 2eSIhDDEs5MWKt+HdsQ==
X-Authority-Analysis: v=2.4 cv=bK+Ds/+Z c=1 sm=1 tr=0 ts=6aeff999 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=zEHqqOqeF9Yo6E5rROsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfX8DI892wB1Xwm
 1qX/wJsbXJCxGTYkr3BHJPl97BYA6mF+7PNzow5fnrVDHIN2+jWhnMA68oBeyI29PL/rv+fjtIy
 uJQV2SxxefNnZ+9C2Ca1ShJAdxv+kLoedoEO48sUWM+BqX2uw1jb
X-Proofpoint-ORIG-GUID: nIVeSDS0_z6xVFFFTWMTJjiwCXsOujjQ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=10
 impostorscore=10 phishscore=0 bulkscore=10 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080017

bio_iov_iter_get_pages() fails a REQ_ATOMIC bio that doesn't cover the
whole iterator, since an atomic write is submitted as a single bio, and
submitting only part of it would tear the write. In contrast,
bio_iov_iter_bounce_write() doesn't. If a folio allocation fails partway
through, it returns a short bio, which for an atomic write triggers a
WARN_ON_ONCE() in iomap_dio_bio_iter_one().

Make bio_iov_iter_bounce_write() also check that a REQ_ATOMIC bio covers
the whole iterator, and clean up and return -EINVAL if it doesn't.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b0fcc69de653..61a3812520a2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1523,6 +1523,16 @@ int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 		}
 	}
 
+	/*
+	 * An atomic write is submitted as a single bio, so it has to cover
+	 * the whole iterator or it would be torn.
+	 */
+	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter)) {
+		iov_iter_revert(iter, total_copied);
+		bio_free_folios(bio);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_bounce_write);

-- 
2.39.5


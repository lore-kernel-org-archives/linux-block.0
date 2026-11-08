Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111900;
	b=Sh5XdAlUgANNTG6YrB5DClifGfDrgjnhlxaoXB7fmKjjcjbeejg3wu16TJLDAatywkN9
	 oLXHmWgIULE2I3jb1NY8mk+Br0kgAdmdTgIzJbeoNz6qXKOSLqamwUp25uE9+kIzL5r53
	 VFARrHVp2nwIpGlztMWg6go6+ttxdYGANsTTJlYnPj4AoGwM+WqEoUCHJj82jADGt4Gnq
	 RMQLyABjwioJA+bzHu4COg7QFO5IRFm+c/tPWzDQncnyAmoRjtU6aYaZzRZM2h4fROiRW
	 vgU5/Lb3AQtp8mOtLitC6SvlckbTHrAxybWVTOkE5+MJj26cTF7C0Q/91OYPgYGFXIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794111900;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KZJMLmuXX9sJhrtyIz3QqrKY753KM/thMo2GKlgX/ZY=;
	b=NSbjPRFauHwnZ+fDOs6/WIY95JffHfcnOKIy8Ua2/Q6ijKojhJLISu0Wx135pD6bRCnY
	 NalUIexguw+98daulzAyyOI3YN9s5n6XyTlXxk4l61v2QU/zOBi/iIZmXbltH+Kn8pDvX
	 U4NyYfFr8cezRSHu01lBrB01V+BHs5saG2wXfiwcjrR/dmq0uH6vhGPk15LNEO2fLTo+9
	 dV0ScPl9W3Jcwwk9wXMZeu54+12m8OqMFYZs1FlC3FbpUIwZcoHoILIQic5MSdHuXyYFd
	 iCFxNzQbyNjsmqD8rfzUh1sOguEdipjY8a/cSSUFI+YPx5R0+pVEmuW2vcKBONOL5Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=QTlZKnSq;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ii601FQr;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F7606A334
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 04:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC7F7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=QTlZKnSq;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ii601FQr
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A83dbua3568599
	for <linux-block@vger.kernel.org>; Sat, 7 Nov 2026 23:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=KZJM
	LmuXX9sJhrtyIz3QqrKY753KM/thMo2GKlgX/ZY=; b=QTlZKnSqJMb+trqFGS6U
	AZ7w/DFE0vw9ltjPsMynYi1Q6FrW8Wk5UVmjUTI3JPX0b00cd58UJ5A/0KHMBDYX
	nS7qmIwJA8+eZCe73U2OMUC6VdJHJWMI2dAh3ISkk1IocjjsNwDi54rXFvac97Rb
	FDXnK/gJ5FJIzupP/v7mHqfwRDVXcvE0JakFvXDoWDmM/pmvV/ic7IO3Xq5PyyeQ
	BfPe9Yecxap6gs5+hzDJIiMufH1TNCHF9meVL3X3n871YusaivyUhy/e71tGi/PM
	Y0Jm8LAvs4p/gPZrWroGX6jp2nueUC5J5uPipq2EVvj129G0C++goEgyLu5RM/3V
	Bg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hswyuma61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sat, 07 Nov 2026 23:24:58 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91e7f61a26eso3206866d6.1
        for <linux-block@vger.kernel.org>; Sat, 07 Nov 2026 20:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794111898; x=1794716698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZJMLmuXX9sJhrtyIz3QqrKY753KM/thMo2GKlgX/ZY=;
        b=ii601FQr7cfN6jCjSyEFGn7xpVfcpuK8gVH5oYBBcOx+tZH1NLMzB3WxGcC42516LV
         sW2/JO9v4jtqVdGUWAPF9Tp6X70eWK+L3P8F8f6Pm/X694jF1q9hCJHZoXqoBXu9cjAX
         lhXA88TJLN95Dd/HRs5G2jPykW/rRCR2QLdhlZ6MxxB0TV40zivfMhQfXbMYMfXKGCOI
         OMMD0gDKPyzFPyxjBnal/4/0KBar1smOlan7iAzSOU1GdkC9u30TvuifluJapWsdxJ0u
         PVU/Z6yi2PDPSD9qXXcYIQRxatJweYei9mS1XimdS0kCU60d4wGkbRfS1TiHZFzIVBYE
         PKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794111898; x=1794716698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZJMLmuXX9sJhrtyIz3QqrKY753KM/thMo2GKlgX/ZY=;
        b=xtq5tCCD4Wo/Cv8iuPVR2ofD9uwKl70N9l5ZBGdv2kGE7Qm+jgHEMxaJbcfb5IRfUP
         Q2aYQIQxFt73qX+UfWnu4C8B146QpXCOfgcgeXoGxvC2oIqfy8xS+RJg4BmuXE1JAosK
         77UZtTKrbdN6I/C+1KqhI5lg99Fh68aTq5lvzbU2+VHMALjHbbTETqA6oJbWkj0y5kGB
         O6J0asxAzrRJyQCyvUynxejr98aIaHOhZS0JoVbmWu10QjSrjWYQAw3Ix1CieSSEqfZ0
         iXy5iAdGstS7/PPAhl2C904Z63oaGNrc31WpeL4aPW2XwJ39unyWep4sOA3cXBV1XYSI
         nc3w==
X-Forwarded-Encrypted: i=1; AL+hErFJSGgbs7cpVlcaH2h1lLZ4JxEwkYiSA9havvEQYHF3hpwsijm3DM6Ef3O5ON7j3e0nOttfwp1B0Mo/rQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/st7dpC9qkmXPo9kudf7X4BAbL9Vakz1VHSH4PlQg+puy2gJrm
	/RCWfaPgIogWy3kRVLeE6I/uG9yykkLCcyYCYSOZ6XzWGV+yqFw82m6VJQD01CfXxFP8Kgna4dc
	V293xQ5W71RG5lVOdyeOpdiIFSY0kRfCK5pczbI8AfkFojbfmL1TGhXUambxC
X-Gm-Gg: AYBFou2uwJsOwIISr1wz+e3NI1D6SBcWMwcKtvOQqPoErYVEg94Bl6Tjb0s8pC83pv6
	N9NtoQ8XI/12KSmlW3dBIqCdbfv/Zl9beeFgldshEAuYPq0AXfl8i2MfPVxShyAuOyFc3kniVYT
	FgDAGcy/EuwRBwpYzD+u9Vlfv7LRFKkNKaO/1fgGRqItI6s/T7oZ+4baRslQikMb3NFfJghfwca
	JwDSSeTR0l9RPlSAykd1t6+EjpfEDZSLb3LPUxJl7QgXuKc5gcKr/6ccQ3GTjEVYea1xhNJmtMi
	UvZ5ApDKSfdLk0LAD0Eskt9J+Qm0Yi4oN1bEWeQDlTTIb5hY0wgouBdG3HudMMowru7KM6gcuIw
	9/HqoRYicyluHAJki7MfLK1seNxMXkEHTGNFlxZuUUj7d/ZeJlATM9KpA/pbLcDLvB+kJUIlyqW
	kMhCvacH1ymZInCCFHgw==
X-Received: by 2002:a05:6214:f2b:b0:917:aa8e:474f with SMTP id 6a1803df08f44-91ed241d308mr5684306d6.23.1794111898126;
        Sat, 07 Nov 2026 20:24:58 -0800 (PST)
X-Received: by 2002:a05:6214:f2b:b0:917:aa8e:474f with SMTP id 6a1803df08f44-91ed241d308mr5684156d6.23.1794111897712;
        Sat, 07 Nov 2026 20:24:57 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb56290sm10085586d6.1.2026.11.07.20.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:24:57 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Nov 2026 23:24:36 -0500
Subject: [PATCH 2/2] iomap: remove the atomic write length check in
 iomap_dio_bio_iter_one()
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
Message-Id: <20261107-blkdev-atomic-bounce-v1-2-f66344262096@columbia.edu>
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
In-Reply-To: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794111894; l=1480;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=raAZDoGoyOUdBE+OG2rr/mS13qUOspHTisqUqAlpy7c=;
 b=CLzcS9Tl3wtyGtCIhcgXJGXi+GUmlZBXZqeULwvnGRqHuLjZlROfZcK+k64yvGX7pHkOtdT0O
 kJ+c0z9sJP4BJNuptANA537ABkv5+MZNClcxLmCZoYiCbzo1pJK+689
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: Fzqt_Gb0KUDpI_mGNlO3eE6itCmR3YaG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfX6Wn0ot2cAHvG
 lT6pziQdQcTbZeeBZrvAZ4N/b18TNeKeza5Akn1ToF6ZAaGNnBIicY/8qjZrroOOJHbirYYgMHo
 tlH6hhGm4DVFU9rVqdFtPmi1MD6jhuk95GbuzQ849CTt7ucIXUzIyqIwMVVfeNC3fGGUny1Pnlw
 Sb8hD9krotzVqQc0wx8dDn5Fp563cUrOA8AiYi14dH6lmf0AR0uv5Rp2tf1kRfVbOuY9QyU+a65
 lhHjjsMWaxJbCamGrdSerIZ+Utox/duT5b1NQ83z88Su01Ja0g6sERE4K5tIzzOQK1dLdehmM0P
 kWGiRyrBtI0iiah7end/75EYX99BVG5IHG40UznXulEE1KXhDDuIE7yl0mRngYevEDySDJRHMJ9
 pWgIUHjEc3+8FmCxNBMy/UtqT+m3hZxO15Pz5UkbKMqlpeN8pJeeDXcCS32WLJ6/1+NsCqERYH4
 pM9onKtfPEjpsCrEa2Q==
X-Authority-Analysis: v=2.4 cv=bK+Ds/+Z c=1 sm=1 tr=0 ts=6aeff99a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=I7NSszDGB1yI4--CJuAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfXz4QSIKvvwPWf
 fEHLbtjdW2JQDiAaktIuQ5TBVnopyjBHfgliGTYVM3Wx2FQ89Yf0rMpdOYI+tIwXgS+Apz7jQUx
 F/vD6P7E1sLgs4o20kXa/JZfK4VsoMXUucFLGaJyafIVSqHgyjLh
X-Proofpoint-ORIG-GUID: Fzqt_Gb0KUDpI_mGNlO3eE6itCmR3YaG
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=10
 impostorscore=10 phishscore=0 bulkscore=10 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080017

bio_iov_iter_get_pages() and bio_iov_iter_bounce_write() now fail a
REQ_ATOMIC bio that doesn't cover the whole iterator, so the bio here
always covers iomap_length() and the check can't trigger. Remove the
check.

Suggested-by: John Garry <john.garry@linux.dev>
Link: https://lore.kernel.org/all/82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev/
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/direct-io.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ad041ac3252a..aca7cbaea4af 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -370,15 +370,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 		goto out_put_bio;
 	ret = bio->bi_iter.bi_size;
 
-	/*
-	 * An atomic write bio must cover the complete length.  If it doesn't,
-	 * error out.
-	 */
-	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
-		ret = -EINVAL;
-		goto out_bio_release_pages;
-	}
-
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
 	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
@@ -393,11 +384,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 	return ret;
 
-out_bio_release_pages:
-	if (dio->flags & IOMAP_DIO_BOUNCE)
-		bio_free_folios(bio);
-	else
-		bio_release_pages(bio, false);
 out_put_bio:
 	bio_put(bio);
 	return ret;

-- 
2.39.5


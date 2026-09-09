Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC253BFACE
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982789; cv=none; b=kEPRDTWXUhnZNz94GCesLzqgveqIEvZfDjEPTM3hwLr9nLKPZnAQz573XWOBX7beQQ/I+6KuVIpgQycp/PI6GmGi21AIDF4HlNvz3GDAsrpj10jfl9+oqkg9IrZqDioThGsheDjcZmmznkYfpizFdYyStDf6P53uXYWp4IHkIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982789; c=relaxed/simple;
	bh=aQznoNEJaKGJ2Gsktn+SsBCWRFCw7tOypI4unUi5/nI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b819E7xJhxZnoWTwsOkIhlJNBK99TppozslBg0/cSdJkxC5Of5bW9Oh56NzlvaQeVcjyWK8zNcJ69HNAfv0Bs6wkwrZdWLJRAlJ3ajw0Xq/df/NlxSWjKKuTZaHiTxdxhT6/KacMNdHlBVa3krA/Gl1IGO/yUPaIs9Cwx5cyKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=idTUXb0I; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=BJOptJDD; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="idTUXb0I";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="BJOptJDD"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689IfG5c850134
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 15:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=9y9UpH52v3OlDKKtahqsmv8F56
	wS1E13w6NkrRS/xGg=; b=idTUXb0Ii/vvGCrvl2kZpIA1+klBdvFZauTnpzuLUt
	Azf7tvbRqGbtUqa7mfnYc4MJfMw0iv92eg6gVkwsEKqBhprNOJ2C49tVWRGa1/Au
	LB/CWY9HYmGhNgiTEbe0+ZGEcWz0cMEs19m4wizOWNOLxya0EXqIrSkLiXo9FQNw
	7Uwg3bmWsVUMwwhL4hzYhPWySrdTo19K7zb4A1o1xmGXx+teXJE+qjlgC2WTsr6n
	rPoFN10mb/DD9KDbdou0GLTHZTu6x4ArPA2y8FRrSpCjK9uxnTBkvz3Aaui1BGic
	vu8qxJiZua8P6xMRNMje+QLWJI4K7Chf6repzt9bEfzw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcy10h3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:39:45 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c26012cd0so106637031cf.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788982785; x=1789587585; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9y9UpH52v3OlDKKtahqsmv8F56wS1E13w6NkrRS/xGg=;
        b=BJOptJDDEie5/hxqtM1XNfXMVZv+1joLV1Sne63rVZRFo2oTTXbUbqNFlyCxLCmwUK
         uvVwtBmlmPAz/n/33v5F1U+Q7FCVLee18sBTCj9vVD4mfmYyPqg9juEmP2EZXkkmBytk
         SWqq04n8p8TXa479mqwS+YkPlCxEEBetSvEV+iucb+08T/6Pvrupz+nHMa7NBY9GH4Bg
         aUJ93TSYj3EY9czYU4X2/jVRnYfFQqM0D/6TH+GTGDMr4Q/RYe/x3MCMXLFga6LQN0Kw
         GhQxH3nOrRPBYFJG/Nj+PVc0AEsJ4rZZv9cBuN5ZdduJQF4GMZmVgnKJqDkTSDnqGa9o
         4grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982785; x=1789587585;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9y9UpH52v3OlDKKtahqsmv8F56wS1E13w6NkrRS/xGg=;
        b=pSM52F+9wMNlP576kGLJe0S1I/Me84oFduJclq3RU4YbOOiqwiMzhCezwPy+xMzjBA
         J6t6UbrWpbTAvXH6ZHf6b5FqaLYYxoYx3oW6m4eFilFEFS7G1W4lT2d8BbnVx5LUj1+X
         n1jURdCSf6u/7g9ZytZoWfDsx0Qw8LPUM6OfoRDY0WlUFekzQHaOKIigXll/AfFXxgcE
         a5WKQ7Xrc0rHTArUcvERTmgo4A4SiU7HMHPMqNJX21JAdFZXSPlpe8IQN9shUoUKBMP6
         3UnyORuwNE18Rgpmm8P0AUxYSwQRJyhtPjCZ5xizVxHzzr+3K5MIOIUo5QCKmTf9GpSu
         nsMg==
X-Forwarded-Encrypted: i=1; AKwUvBy/PkW08KSxwoU7xcRQmhHOtn/Bvin5+qJOBDBOeL28Z4r1ZpJltpiHlYV8jz9jdZ9yT+KkwULCT86KJg==@vger.kernel.org
X-Gm-Message-State: AFuF++mHmTmbf4EJ7ehBovHZIh0Bso/cMOl5dq61h9nlB5grbcx6QI7W
	9cFI7gjvDK9UFF4U/bt6+XKA7yaYDeVx7/0AeiAetRZVK6wqSdhhV4spMqXi0XkUm/X4Jadc+s5
	wfFhYd8ihp2RPAXN6Rya88wNOxljVMkqt/pb0upwZs2TcmManzGmiyTZPJ2bIiU320UCiFnU=
X-Gm-Gg: AYBFou10zELulJd5zjGWssuvpJXyFsh+aLY9gZSOlcI+WOhixWRwBYDBKdVYqXhkb5a
	pKccvmdWWPEufI4JFyhYpQBsFPxbO/9giLjjYDzMhuPXNH6Wd4UIcP9mPUFgwh4PcpFFkJJOOZ4
	xknWdv8NUDcccgqfH/I3IeviSRmcoAdIBMy0ShH3k75VG9CgjmDPnQnTwPXTrwYgMqCxbdSEVPn
	AZ+XVqLudDHWGW/7G8Wvvxb0Drb5K6IdVGBXvvLphgK+bxBQD89YL8sED73CGpOtQy9ttRD1HZo
	SEo2W6vzcU3QMqd1+34zWsoDgWQsPo3+EVMh0uRxAz2JWrdrtmb9kG9Re5oww6sNkTT4oy5dXHK
	L3tSiIxkIgo6NCp/tMwCByc54Q5zUgGgrmMOGUTJeVQIr3oSq
X-Received: by 2002:a05:622a:258a:b0:530:430f:630a with SMTP id d75a77b69052e-53054a1f457mr443008311cf.48.1788982784653;
        Wed, 09 Sep 2026 12:39:44 -0700 (PDT)
X-Received: by 2002:a05:622a:258a:b0:530:430f:630a with SMTP id d75a77b69052e-53054a1f457mr443007101cf.48.1788982783531;
        Wed, 09 Sep 2026 12:39:43 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530868ceb68sm83026191cf.29.2026.09.09.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:39:42 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH blktests 0/3] blktests: tests for the direct I/O fallback,
 splice, and bio trimming fixes
Date: Wed, 09 Sep 2026 15:39:27 -0400
Message-Id: <20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO+1oWoC/yWM0QqCQBBFf0XmuYFN2DX7legh9a6NhsXOJoH47
 436eLjn3IUUSaB0LRZKmEXlPRmcTwW1z8fUg6UzptKVwdWu5uY1dpg5yg/KGZqVQ+WiDyH6ePF
 k4Sdhn627kfm7Rfdj0W8zoM3bJ63rH+9YJBuAAAAA
X-Change-ID: 20260909-blkdev-fixes-tests-670f566f5f85
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788982781; l=1693;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=aQznoNEJaKGJ2Gsktn+SsBCWRFCw7tOypI4unUi5/nI=;
 b=bG6NV6SZFpzgjzMZiTukB3/wZs8wObdqQELldC2/PZbmHx45cYoHoljgJUKM3r8ZoaTF6t1QW
 aR7qc8YpxxcDnHHkJ33w80IDRovWm4PuohbyTIl1d6XvRyk3OkSFE63
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=FrWQbGrq c=1 sm=1 tr=0 ts=6aa1b601 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=Ncn71mQr2BTXJ4py16kA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIxOSBTYWx0ZWRfX4LwdEMkbWTAS
 G+9Tggd/Lva6kMoaLDLAPd45Legv51KLSNhHMsdxawigSFfvkTLwx/OCxbRACuCB4iXmmrazkFb
 s72lBUiRn3sWzCNNX2VRJSz68bMr49ap2N4LWZnlcJlQ6KPkJ0s6
X-Proofpoint-ORIG-GUID: ynFoLdFcRlRMDZd57hPnxZW4FWOgyxWd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIxOSBTYWx0ZWRfX2sGvpik2DkIk
 A9RlWvJ4fSLIXo6eO9J4j8KPQf2Ii5hJ8tONUc0/ia9m0A5RUOHSgXN4OrDZdPIGWksKHbJ5HE7
 xeqbRN6bV9u/s100L16y69xlpdOUmhxB2AS0RofFZXQvUtZd5QY7UAnPmWE/mydPQt06h+ov4Fj
 cYArUqU7GsHJBeP103Uq4Yw+y+7ljyAam7ihxW4fmrA3tMom49dmDj+BO41G041vYl4FL0oqZj9
 RN2K7n6Qql2xSNqk0rPCyxV9PN8kgnAwZoNE66adeJ6/zVuaUZMDMdOCiMFHlg6tggLLWBhZMUA
 5+jj1Rojo604eF1gHhmuxU94ToaI2grP6x9R9xeQ06B9C5BKmPBVcUn6FgS37d8FakN0ClXOBAv
 5lWEDYMEhWFhWurSRkBwCqlwvfdhBH8UDqhVZvMMlqTHOE6zaXCZdTSgk7uAfkMlRHWGaCAemL7
 cme3HKrFHwOpBT0iucQ==
X-Proofpoint-GUID: ynFoLdFcRlRMDZd57hPnxZW4FWOgyxWd
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=10 lowpriorityscore=10
 suspectscore=0 impostorscore=10 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090219

Three regression tests for block device fixes under review [1],
following block/048 for the first patch of that series.

block/049 races partial O_DIRECT writes, which finish through the
direct I/O write fallback, against BLKBSZSET. block/050 does the same
with splice(). Both need CONFIG_DEBUG_VM to report the folio order
mismatch, and skip on kernels without a 64K block size or with 64K
pages.

block/051 issues trimmed O_DIRECT writes from a hugetlb mapping to a
device with a 64K logical block size and checks that no huge pages
leak, covering both the dropped and the shrunk bvec.

[1] https://lore.kernel.org/linux-block/20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu/

---
Tal Zussman (3):
      block/049: add a direct I/O write fallback race test for block devices
      block/050: add a splice read race test for block devices
      block/051: add a pinned page leak test for trimmed direct writes

 src/.gitignore          |   3 +
 src/Makefile            |   9 +-
 src/bio-trim-pin-leak.c | 191 ++++++++++++++++++++++++++++++++++++++++
 src/dio-fallback-race.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/splice-race.c       | 171 ++++++++++++++++++++++++++++++++++++
 tests/block/049         |  57 ++++++++++++
 tests/block/049.out     |   2 +
 tests/block/050         |  54 ++++++++++++
 tests/block/050.out     |   2 +
 tests/block/051         |  64 ++++++++++++++
 tests/block/051.out     |   2 +
 11 files changed, 783 insertions(+), 1 deletion(-)
---
base-commit: 94aea0684058ffcc91e6de9c2fc85fedf1342a39
change-id: 20260909-blkdev-fixes-tests-670f566f5f85

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>


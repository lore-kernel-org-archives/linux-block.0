Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34073BC668
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045671; cv=none; b=lBzSpumsrAcDi4Nrf8fCd4iaMkXkAWBMDLTYZV010w2Ti834J69+1AquxNUlaq3epl8mZrwS6GKzOWfxk5i75MXFN7tHTQAVoU2m65N25KwLDFxRXQtaPaB0baTBv34bY2SVcYJIpPt8SQz6qMUfd4tLZ2JRqNoQp/+CklceRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045671; c=relaxed/simple;
	bh=omRobIYeubqYt1ShRwO+xJfwqyahvimqDH0UuCrRjvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0LYZHN8wQF5dXCTb7VeEQCbw6hwYyYnqqCWQhxEzIcGMctiqU0y4GPZzUC+uVzMsZ+xmShifUGxT1s2k6zIpc/UCzU/UwMmfuoFfJD7rckO2HGSnOwckszgRJU44FeM8pQMAjDRh+mkMbA33Sjj+Q4+fKrcmbCI0+rgRqVPXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=M5ppccQw; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=tjZJ8eIk; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="M5ppccQw";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="tjZJ8eIk"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M2XX0w1444914
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=6i89
	u0mptbr+Jh3PRt95XNfEgizrGGtLlz3J/in9MkY=; b=M5ppccQwzXRPdg+A6MrJ
	2W07ZiSmF+OaQvMQb7Ib09TkPNR0F5F2/zctGnpqTZZvonMpJHzsZpk4wCceBiRb
	DFB4bljXctP6LWA2rCLpYXTY5FiXV9XWDJ412589AHPeiA2xrd3n2V/wuz8/WgKD
	bknjvCEOwE8ze+x1SMNKl8F8JYY59H+aw1P4vO1HRLLJjipUWtWcNtbsEASv20bv
	xFmiSccNmmYaiaCXAgiNuUktE9CeVcy6SXQfUfQqq1be9z2JmiFHIAzTzo2IiN7k
	kQWTopsFiGnI5iFeqBcu4fHiUjwPfXTOH3xHgkq2WfH6xy0dTZJ6fX1izPUjdhQK
	VA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gudres2te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:16 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5329e965ba3so46657221cf.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 19:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790045656; x=1790650456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6i89u0mptbr+Jh3PRt95XNfEgizrGGtLlz3J/in9MkY=;
        b=tjZJ8eIk+rESZb+/Ih2cyfJ/35TOIkbNjJWWOsH0qqvB/QwY3PsEtR4LGtHWzou7cP
         CuJX2hTslfsoeJEMrlL9qTKZnMg3qaW8/UUFt00ZViZ5zZpZgdFmzortiGPq94rgZHLN
         i2Gte/X9veOi1no3s6QD97XIb40OkDXKWNL5SFFv3W0y8pQ+iyqXFiAvFHvqVaX7TwXj
         cyjL4YDAX4zMUNZr6LENYZDAY87Ony2eMK6FTcAXSZWcvrSA/COW2h97dItVEpSd5cRT
         mvgw3cyLi+myA8FVHsQlM78hi3mu/RQQxDR4yJESfUeHhWmwLF7systyXy+e4s5tZJfI
         e4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045656; x=1790650456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6i89u0mptbr+Jh3PRt95XNfEgizrGGtLlz3J/in9MkY=;
        b=2mitMunCSX9IsL0V8pDzrMnTUmIeKA4SSKroQjqO+2f91l/tIEXFhWVE5HiTAoqD2u
         dlU+fEbE168f5QKyGiEhIpWOQgL+dovpTgfZlRtPvpgLAvA9FmFjfIq12imXoBROAcrA
         5LTOYcf3n+CNsOt3Lv6gZyCqj46sSc28GwwNvoglOwHX1GJzl1d+ak8AjXcrjW8sASEM
         hF2T46hojUYzFs9WRgrULH4qUEChF+xQJCD6J9vrExhqm6KQVe7+r18Jy4zaTfiWBE9P
         v0N5E6TApIGgBpRWtB+370W50/rla/dmT9/1dJ3pGPWbMo6HqNCWN+oDJRK6AwQkjytp
         GHUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUePPk2PvNqp7+ZS/doDQrwGdwTAN0Yz/zZ8Phdw8Qj+UcG9+YnQUWYE7wB/jXGxDL7UWTZZpYcPYdgQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ls1iPK0THx3vTJWcI9nJhzQ+e8dEpbl4hOWW4sPMHaotMzLFh6
	3K8MlcBBXH3ZY2JOLTCk4YFQxINU9CT/iZoCNmY9jQpSTD5rzSAxxIUy4Ux2rSGp3ZtVrnlOCJL
	qQNDAxcRKqsUrNfXyJWZci4Cznbsx0V2atZSYV53vfn+xWTbU+S2mYh85k9XBzvngTo32
X-Gm-Gg: AYBFou3tusdkuxLNQ+TM2DfqCzvREoY3u9oYVj82woa6kS4LwtfFFXUIdsLoD2wnRGz
	iVOsZR1iBK8K4hdbGK9lVqXHhAvU66FC9VN1kvbav4JCfUPNwg4kjfXTz4LOvgVjUDaKfYUrrnE
	emSIC5927Cl+Yd0MrMGfBKqp8WpVCn2w4veAEvgrVlm5J5lwaFW192LpwsxxShgDvkcC4kyHK4P
	PDvJv4wpZrk9hf7PRzxUUoSmDXAiTqQF5E9T8iXyrVqJWNW8FZxsZQtDjjW2GmV1otDmSMJCkq2
	bcn4lJKOgb0PKWa+UxHNcANNAcwCGoKWSyfSdNcWgfp/VDUCxYgha03uZUZ84IPMxDIubOcLw7U
	F4zsehog2uF5Fd+qlPYOBsuHQDXnURzBGrLZlQ7qCX9DM
X-Received: by 2002:a05:622a:c4:b0:530:e1b1:eae7 with SMTP id d75a77b69052e-532d8e42b59mr41695411cf.47.1790045655848;
        Mon, 21 Sep 2026 19:54:15 -0700 (PDT)
X-Received: by 2002:a05:622a:c4:b0:530:e1b1:eae7 with SMTP id d75a77b69052e-532d8e42b59mr41695171cf.47.1790045655381;
        Mon, 21 Sep 2026 19:54:15 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18fce9fsm2048421cf.15.2026.09.21.19.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:54:14 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 21 Sep 2026 22:54:01 -0400
Subject: [PATCH v4 4/8] block: honor IOCB_NOWAIT in the block device
 buffered read path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-blkdev-fixes-v4-4-e2801f71ede9@columbia.edu>
References: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
In-Reply-To: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
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
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790045650; l=1869;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=omRobIYeubqYt1ShRwO+xJfwqyahvimqDH0UuCrRjvM=;
 b=qT/lrNi5zaYhd+JzSKZI4UKN2sLJXIRxjskBolny/l4uz282lj4csoNWpPL+3fzZxW5WMp26w
 3FhmTJTqeDiCYNpmkWWzFqRQWANMWALonEgRf/JAAZKtqJmq1ShLQl5
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfX5OS2v5VwHNKZ
 GViM7ao/vs5CoEvMMYXvU+M0oAV5Gdl36pB7q52YSTrUa49foEy/bt4wq3wvoS7CDJ4GXNdvEPZ
 lRqZe9kiMs8uqd1TxrJssq1UUkFsnBpYiBAg3mav5IQme5O6R0CZ0/C3tZ6jsF/h15v1IBajr9A
 XqkoluznZm4r23Dc5OSKMTxFtZLAjg91pqJj0o5FLCImvGmBF3URh1fCZo0HP6r1ar4eXTTFJ6e
 L1DfO4sSrG0uATd1uCrSRfubKWkmriF05JPQHhuJTdqDJINfem98mMhtg6jwzNqfGBIlUb9WYFz
 H+BtIK8ST6qpsr2jZwjAAsE7IBbaOS/XopDtRgQyI1Eg7CgdY3/fVZRVZEdLa8NHByNsr0jD8vv
 /oJ7U2ym4sFGjWDS2WFAbvhAjhNVJwhUfZmKoya/2EVx6d98PXvbMWSJTDA3u1H+v2lqOR+vcTH
 GLSA8kU3qzVPqVRjO0A==
X-Authority-Analysis: v=2.4 cv=be3+w+PB c=1 sm=1 tr=0 ts=6ab1edd8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=s8mzj7eOnaliLhoSWqYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfX5NZMOTxl3dGz
 9ZpDaGApzgzH/hFU5pHxqVmaYBMnou4xZtWrORGIzyRzVluIauq2txfxz8FZVRNyaP9a8+aRf9r
 pHXXXD4a7cEQqkC4Qh6WxqJA9B8mQB5KkMsoG/PWN7FgKI6lVvFv
X-Proofpoint-ORIG-GUID: kZI1-5NuS9LkpEU2M9m1WqgpB5TYCSIX
X-Proofpoint-GUID: kZI1-5NuS9LkpEU2M9m1WqgpB5TYCSIX
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=10 adultscore=0
 phishscore=0 lowpriorityscore=10 malwarescore=0 clxscore=1015 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220037

blkdev_read_iter() takes inode_lock_shared() unconditionally around
filemap_read(). Unlike blkdev_write_iter(), it does not reject
IOCB_NOWAIT for buffered I/O, so a non-blocking read, or the buffered
tail of a short IOCB_NOWAIT direct read, blocks behind set_blocksize()
holding i_rwsem across sync_blockdev().

A preadv2(RWF_NOWAIT) issued while another thread changes the block
size with a dirty page cache blocks for as long as sync_blockdev()
takes, 4 to 6 seconds on a scsi_debug device with delay=5.

Use inode_trylock_shared() for IOCB_NOWAIT and return the bytes the
direct path already read, or -EAGAIN if none, when the lock is
contended, preserving NOWAIT semantics.

Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index a51814821100..a3a709697b40 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -845,7 +845,15 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
 	 * changing i_blkbits/folio order and punching out the pagecache.
 	 */
-	inode_lock_shared(bd_inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(bd_inode)) {
+			if (!ret)
+				ret = -EAGAIN;
+			goto reexpand;
+		}
+	} else {
+		inode_lock_shared(bd_inode);
+	}
 	ret = filemap_read(iocb, to, ret);
 	inode_unlock_shared(bd_inode);
 

-- 
2.39.5


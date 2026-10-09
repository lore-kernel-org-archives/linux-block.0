Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F803B42C3
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564623; cv=none; b=Xkq1Yhlb/eBX4W57UFlWwK5DQX9+UuVvqusBm9TlL1K1Q79/Rgnn4t3MAYDOeuLbEy5S7Aow2b536TQAPcfKl4BXdb9UTq2Dp+NXxOg6eM0NreAfWuZPI5IBPPXzlsgC+aV+r5JvI3C8j4MdK37Bf3ws684Y1rgiy2s5Fq5Ox6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564623; c=relaxed/simple;
	bh=QWCjvSArrnPRtD+0j04CDKUtmIxaPixLlth1E/uEyZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8Famqv41gz0dnRQJALF/hFGR8jsTH2B2dk1e4oqjHJ385r+nsN7a+NzPEVAGEjBuAVzGurPF5VBBZRYbs++WSgtajtXHRXqu4mGoYuYRMcBAnrmL4zLJ2cch4UR7n62HtJp2U7qt7ItLJTKVtk7sRU6JzvuvVdGqYvUumhMhwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=OY9if/AI; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=4GULel6z; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="OY9if/AI";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="4GULel6z"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYFTe541451
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 12:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=l3JT
	rRt39SQipVSWvndi+FFbNSesn5q0JN18E/yrYeM=; b=OY9if/AIK6inCYoKOLPD
	UxP8kNZRCLIQfjKOH43P7bhel6CPP2ogbwArZ2HY8eoZGdjFAscN8I2fZJvEisMw
	ujJUe3L7FXpqNFbqDYRdWYk0gC9g91HgXjxtkSvXDoV+HhBVzojBa7P/KVjIgAFo
	MsnSO082PG9f/tpcsaPHQMkzqn0HxjWlH1Prue7ZXoyX8CYdgAJoQLqUgS4+Yddj
	htY7DzcRcW/1w492J/yQRJ8qiwXvvz/9TD8LHqLE3pQ8jcTgTOxnleL8v7QKA0Nk
	o7ZTaDYgFkrbuBZSx0wCVJ/ykDJS7h01v4uzWIOQYYFoXiA60k729nUJU8zkJnKj
	Cg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h6y4w363q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 12:50:20 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53522c265f1so125280001cf.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564620; x=1792169420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l3JTrRt39SQipVSWvndi+FFbNSesn5q0JN18E/yrYeM=;
        b=4GULel6zbKLdY+HeYJQjSr22UXc1Ivb3dJfZVvbOhAMR7VCiGt7lxlLtGj88AAXj/2
         IUTDvXTxOQa4wt+TD8wfNx/TRKeQnRQB0PS5kOrrzWZanyekE4GhVce212Wg1dZe5W57
         UC5I6EHC19/+aITDXb2Ab8Fe8PWR4yHjy5c9czhQnpM31yczL+/LAUD3+SwumiocgfKY
         pyDy/dLuVOm58PDDRyjpds02MKyxPwX9q184kZ4YEBhjtwZ6GBqRHklRvEQOjS01u2Xt
         oOc6E1I9yJLo0VT3gCnFNfdpSOnIbT/avVcxlK5dOLxv0iMsqcYi1FWLfRT1LIlbbIPW
         yWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564620; x=1792169420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3JTrRt39SQipVSWvndi+FFbNSesn5q0JN18E/yrYeM=;
        b=CzXNlf+HQharfMxJBaar60ylhEccYQqga4XgeWxUOYVCKHQ2FESZ3HOpGmb6eYXC6H
         rPuEC8LsD0KfH4A22RhFKuKs0kaYMgxhv36B3mL+wVa7am/F9bRfeVHkN6a6d47r+Egr
         DESMDDnMvQtIB97p3ic1SVdDLXutRYWP2GNpHIus9bwLWitF8tlTmrjNF1fO5/QxyHYU
         gRyMUR3EBS8KoEypZUUr+xCo7+NOMqm7A/6KdLencK9hSRdX1fmJR7d3D9OzJtdq0+T/
         q1BCyxoQ9+Uu8QAM/RU2ngwAqX/3es+NbK8KyUwHDWxg/y559onbS7ZkdK0S7E3+DVnY
         UcKw==
X-Forwarded-Encrypted: i=1; AKwUvBwO/nECig+4FyRLwI8EQ5jjcDS+s6xDqQzS6Lpax6WgcFYdPwSrVu3+taRDZDM9sUNww5hs+oS4HomU2w==@vger.kernel.org
X-Gm-Message-State: AFuF++mZm366oyxxQQLH0cXFn7nYyTPGKg/GHbekBl1PpAqtsc7EJe/l
	i1+GH/yhwLdgovImOmuxZIuzva2VAcVr+XwTh2Hlf7L0CVywkkyOnLpLf6yn+h5aqVyyxXQueHb
	fI8X342BTLg6RgkcwTbDhKVXJmtoUft6IWrzqdZdJAVWl8lmWnuhSKirzGq8F
X-Gm-Gg: AYBFou3v3DFUdSJJbemzpjOkVZtvGQZMVQ9m7PbMJRc1qlG++8v7St8ofxpWFLlhy/0
	76jV7Qw7jetKctDTOO8fofYb3jHaRZvPLUnKb5iKdMggL2kWZVUyRwZyMPX7SPfJnbpRpvovi/y
	OX4Tw/snCfgWRXjBFqgOAeC7P2TKjrlm3bEDI0jRVrxiYhf+NJOtXOsizIsepcto+1hylqwJMp9
	jbqiYfs9TgsKd93jR0fxcmh6xWrbVKrdV3mPTm5zzO8VdgINiFWYMppVdx8NXUzM4nuamkQg1HZ
	erBtyhz/tUypyAjF9eY7RhtfA7YKsLRCUJwV4KNQvE3dBgly/jdIM5cyGJ8ZTebkLPJe1T2gEgu
	3/0K82ULyZEo+sURW/DvKJImpzlhWJTYheefMw0oTme4135s=
X-Received: by 2002:a05:622a:4005:b0:535:1463:ec27 with SMTP id d75a77b69052e-5359fb5a42emr38189901cf.48.1791564619461;
        Fri, 09 Oct 2026 09:50:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4005:b0:535:1463:ec27 with SMTP id d75a77b69052e-5359fb5a42emr38189271cf.48.1791564618838;
        Fri, 09 Oct 2026 09:50:18 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:18 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:09 -0400
Subject: [PATCH v6 1/9] block: use iomap_dirty_folio for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-1-307939c387df@columbia.edu>
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
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=2128;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=QWCjvSArrnPRtD+0j04CDKUtmIxaPixLlth1E/uEyZQ=;
 b=qMLmvZeuSixOMS38x6EmKAp4mC0Z6ytGiXLIW869jZX/sxWmXGZmFtbD16FIcyMxeAhASjd36
 cYbRlGpBwoXDkw8TKIZpbqkBpJXceSkdRkCWwmS9nmmdt9xDp92Ohvj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=UYHE26SN c=1 sm=1 tr=0 ts=6ac91b4c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=lHyHCDWJ2e6pF_oXpYUA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: EylzY_W4Mhu6TMOSlYeZgWMwbbAWvt-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX7gZDP9mbi3ny
 hrEFoObu/0/pW76R0+V8vM7rck/y6CCH1bJyNnhdqgNlYmN+dwYIUrqecQfZVaxqCuN0vhT4g3X
 gOL4ZoAjbyrsBa49FntF/mAfEt1MG5XpEct901ovHpyCytUmblPj20WpINlwsFJfWEQUvqz4HTT
 be7yW04LTNVlWncb72r/Vc+8BrRUUZMMS+t8XFEjxVG1lMjBMnmsh6+CPNZMUI8xwxGasQFFMO4
 Opt51dfwOnREDb1k74YAqdNIEaxR802zHkNiOLSmEIsGOercFP1YSUT5RU7+sPl1GLh7EnrJDqP
 iFCPX9c0JrhtEpJ11UWL9VRS/6IqDGznpVCLdNsbMjIFTxcTlGZeXA6zzOqgsMaX6E+REFBvkkv
 DPQiP2T4rSDaH4bo7Doaxi/qv/cv3ZlDUYOOoO2u7k1/Ec/4fZ5CZzPFURctTO+mx6TKIP++j+H
 CZgpnwIMYzJaXX7915w==
X-Proofpoint-ORIG-GUID: EylzY_W4Mhu6TMOSlYeZgWMwbbAWvt-6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX6xqRBcwc6y8D
 3W4Wae4Mt6olehmjN1qTZhkHOacnWOnUoe/WT6d1KK3+JGIuP7EAa069lH6xhKwytidABflBLue
 MM8AoyduG/DsXI/xIWExcKiRw2a9JD5aWZCNwAwVd4mR3TRMaj4y
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 spamscore=0 bulkscore=10 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=10 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090067

With CONFIG_BUFFER_HEAD=n, block devices are written back through iomap,
but def_blk_aops uses filemap_dirty_folio, which only sets PG_dirty. It
does not set the per-block dirty bits in the folio's iomap_folio_state,
so iomap_writeback_folio() finds no dirty range, submits no I/O and
clears PG_dirty, resulting in data loss.

Other iomap users set .dirty_folio to iomap_dirty_folio, which marks the
folio's blocks dirty before calling filemap_dirty_folio().

This is only observable with block size < folio size. With a single
block there is no iomap_folio_state to get out of sync and
iomap_writeback_folio() marks the whole folio dirty itself. For a
page-aligned device, this may require using the BLKBSZSET ioctl to set
the block size, which requires CAP_SYS_ADMIN. A device whose size is not
page aligned already gets a sub-page block size from
set_init_blocksize(), so no ioctl and no privilege is needed.

To reproduce, on a device with a sub-page block size, write a known
pattern with O_DIRECT, mmap the same range, store to it, msync() and
fsync(), then read it back with O_DIRECT. A reproducer is available at
[1].

[1] https://gist.github.com/tzussman/18ab05cba4b3fdc79cce0a69d1fd05b4

Fixes: 925c86a19bac ("fs: add CONFIG_BUFFER_HEAD")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index b917bc0f6b44..5a559fcfadf9 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -575,7 +575,7 @@ static int blkdev_writepages(struct address_space *mapping,
 }
 
 const struct address_space_operations def_blk_aops = {
-	.dirty_folio	= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.read_folio		= blkdev_read_folio,

-- 
2.39.5


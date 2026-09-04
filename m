Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DD4F55AC
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538795; cv=none; b=rQ+8dlf1CYUwBW6RMb0QPmKMV6Za9hK6d4Pz1w+3DUBnBdMIG4ZuGqHCNlqykndjV89nDYgDwIejysD4lNdLiz0VoYWIu9peKMk8rmVL6Kp6tTaQ3HBlCdJBUuB83QoxYSu+8EHU26VwVXWyPAUh019gLLtaoBIWyxN0fW2hnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538795; c=relaxed/simple;
	bh=ObmG9tfgjwMlydiJMgZz0Uw/hklY3TtDzEUESXlWCvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyDdcoPRbeUc7qP0Cw9hWD885pb/ri/P0Kq2Qd1ue4l5xDQrbuFUkji2z9xJv/83ZR745UNSZHzKHJOAib9L3BirRIjFl/5tLOTzMpXqvmO2MQog2dJEKb/B7+V2XTDzRVBwZI+U/4Kw5x6pt1WkaB0u1ahNnVTTTlZBPp1tjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MUZ8znf0; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cBR3imX3; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MUZ8znf0";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cBR3imX3"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684G9xjR3547769
	for <linux-block@vger.kernel.org>; Fri, 4 Sep 2026 12:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CZJ1
	b+xo/XcDeEB8HUsZoAtzYxQXYY6E5mqisQMBwto=; b=MUZ8znf0F71L1M2hlNCv
	xCdJmIm7XMf/ZQwLW2vfFk52O2B0oQciKpMGkORYC8CQSVjyJAGqs98bXKdH4p0J
	NoW3cU8XjBMqTUzZF13/gB0To13e/miRP2elTJFgjIVSH63x4dQ3QAjAbgtl5zs4
	jfuTUul/5qdl5iKb6ylat+bQj1LBd7qFDlMoUwp1+szGa0w2v5oF/S+kX7BEfaFs
	jTdfUM49H1C6cKBG1dC+2e1qrVLQRQOK2rg7gJHQ+eYpLInbOb2LPWneyYHnPNg4
	Xm5cfjhewvn10YVHNHDuqDIqm8SlaOVpvFZllGQG6RXWt5FebeRX6aYiG4ZQovJQ
	SQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gg0ac8rmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 12:19:48 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e7db8d191so25369066d6.1
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788538788; x=1789143588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZJ1b+xo/XcDeEB8HUsZoAtzYxQXYY6E5mqisQMBwto=;
        b=cBR3imX3JNlUtiewTNBPQGXRDUZJ1yA6kjgt6spkMyH9o+YA8rcrJHbYXyw78U3EZS
         Ez21EkHpLMAGSkYhDo58dlqXHEGghwba+gBbq6esViGN/tj57b1E+Tg0iwAphAbE9nmP
         Ub7TAZzXTA/PfPt1Hp2aLTOVoSdMKklrj/bzJjgbvVEbxiRilC/5CUTy0zwmjmWTqUVU
         0NV2P+lTjWosLtvJJz9aYJzYQcuJ1Xj2tbCEwwVucitruck4FtsNQ8zAf0rrKWKxoRUs
         LB2nS6dK2Cune4mrYg9hdEPBBGNZ1P3gyP1FNUcDfOwvPtcDp4iWk56jxG7407xkg65y
         qcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538788; x=1789143588;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZJ1b+xo/XcDeEB8HUsZoAtzYxQXYY6E5mqisQMBwto=;
        b=XXV09VgeBQn1i6aOJ+qiAMwYYwsD/9YESeOLhiJCPDosV8uu1mh8kTaIDW3qgtwKWb
         tgjVZPtvQsFQOIVWNYT7Vyy0fqbXXn3xJoCRAcZ+3Ah0VmMrVa27un0Z2G2vujDMDrpz
         0D+SNzIyPowDSmVnTDj2mDA4dvqv2IOLY9G+m7/NFhj+tO+EbAKGtWVzu2aQcyVtrF+a
         a+27/eaD8iuBEat3kbZN9Ruej5SOyN07V3QaAao9TopdvZx6wfdDJfj+78JLEkCcJNpE
         Rq4KVGFO+88D1ja/G785jjdVvF3dlBWkTmGb5v5ZQcDpLBi2mfvTY6yg9dbmKdfCcGnK
         BXvw==
X-Gm-Message-State: AFuF++lCmx/aFB8YJLfM2mBBssQZbYLbYGhdVRW30MDAVeDCm9gjC2Jo
	45u1JWDSNR2JIDUYYh8jgSgI3aP7I/kMxBnl3nB0IHU1PCo9nAHggeaIBZPHU74oujhEKgXZj4O
	s4W/2adSL04rVnKd3ndbQ4/XQzTb+mXin4vJ62qJqc78kKtf/4CWbSiXcDdZ5bkPl6q2dYyg=
X-Gm-Gg: AYBFou1pTg2xjjvoph3BVxK0l88fOC63cojrIIwdTZImIrDw8/SM2+iUzYY0qt5Vp8m
	dM+PoFZxaiq5DAIdQDjmJV4I7jsA2uTuPcn+oikESiNqwfcMXSUE7VF9qVS8V2llIlf4LyHX7MX
	bPz4uHZfuAC0O6RLE3s61IcwyNJf7jBt15t6uBtrx64mDQYmMnLnsJfeUOcm095Lq9HBWGNKmEG
	qUI4Fi1mOnsTzIgz/aknqZN+kI0E8fbRzUj5eog9hH0aRwyA0gD6gcOduXgP47lV8UopjSwf0ID
	//XGH79N7urSk93+w7NEEM8jrRQ3q4X5Vd8nbv9Y5MyzoLYlvhu7PN4S6IXZ5NbhUEfaR/c6wgi
	IzEv2QkJK3mB0EJOdLRkOnFLl0cdFX63LxrXe/LpXId1csa3b0pkX
X-Received: by 2002:a05:6214:c6a:b0:910:3c08:fc6c with SMTP id 6a1803df08f44-9103ef89180mr79714506d6.22.1788538787693;
        Fri, 04 Sep 2026 09:19:47 -0700 (PDT)
X-Received: by 2002:a05:6214:c6a:b0:910:3c08:fc6c with SMTP id 6a1803df08f44-9103ef89180mr79713766d6.22.1788538787001;
        Fri, 04 Sep 2026 09:19:47 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-177-158.net.columbia.edu. [128.59.177.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104067b099sm24071926d6.28.2026.09.04.09.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 09:19:46 -0700 (PDT)
Message-ID: <95a68e6f-0e45-4763-8345-00f85c53b5ac@columbia.edu>
Date: Fri, 4 Sep 2026 12:19:45 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] block device fixes for large block sizes,
 IOCB_NOWAIT, and direct I/O
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: a_vEz6ERh1vv44se8BIuncQjF4qhM5C_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfXwIfqnRMlt65J
 woVqKOFAsCMHpVkIvibTjO/HQhhO42Lx+N5jo0AC1o+2pJB29qFQfK2rYjF9TU/4vkRLuGMYvHF
 zHTi1dfCwyVExrdpzwvu/3jJ9IUuwnBm6ttf2eV4V4X8P4jOmsih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfXwef4ZIOHC1Qe
 G1GF+pAJOcbzKwayb1qpzvheI2doZuFSWfet1J7YFqiz9TgpE7j7zxXP+cyAw7lkK11yYxyOCDX
 i57ZJkBYWGdSKPSljXKElB0DP2uvZKsNDiTjtN1mWD8qr4ri58Ennd+HT9lpp8HbXC1T1xRztjp
 C9BwnpNGn3zHDIPVluLeUVPhq0FrIn2qJU0M4YEdm7+ix2HmbAq0WOmi7nY4VVt9o2n5b8bZDVZ
 ED7vloINqy/AcVvgs38Kkm5VSuZ8wqiRGRowKYP8gJhLDYFZ7rcXUaVVtLgqym8Ro9DJC+b2Rmh
 KULnNAbzS5dcLhyys0aijv80VxRSqEwlvOoKD61Q0M/hLvISC/gDB1qUSiQH2XjBW8lf1E0VLQr
 Rkj7Hs4M5OcxIewlAZWuVwJr2CA3TjYjdFgve5CgaMA727tGXvCv5dRJFU6SdOat+JE05aVPn4T
 X5SklN0uz84w+3B7nRw==
X-Proofpoint-ORIG-GUID: a_vEz6ERh1vv44se8BIuncQjF4qhM5C_
X-Authority-Analysis: v=2.4 cv=a4EAM0SF c=1 sm=1 tr=0 ts=6a9aefa4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=tLges04aSNaZGVAfhBIy2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=dXbZDeGBosa9AtOZLTMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11895
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=10 lowpriorityscore=10 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040148

On 8/28/26 4:49 PM, Tal Zussman wrote:
> A set of independent fixes for the block device file operations. The
> first two were found by Sashiko while reviewing the RWF_DONTCACHE series
> [1]. The fourth and fifth were found by Sashiko's review of v1 of this
> series, and the rest came from asking an LLM to find any similar or
> related issues. Each issue has been reproduced, with the fixes resolving
> the issues.
> 
> Patch 1 fixes silently lost mmap writes with CONFIG_BUFFER_HEAD=n.
> 
> Patches 2 and 3 take i_rwsem around the direct I/O write fallback and
> the splice read path, which race set_blocksize() changing the mapping's
> minimum folio order.
> 
> Patch 4 makes the buffered read path honor IOCB_NOWAIT instead of
> blocking on i_rwsem.
> 
> Patch 5 makes IOCB_ATOMIC writes fail instead of tearing and falling
> back to buffered I/O. Block devices can reject both paths into the
> fallback before submitting any I/O, so we fail rather than issue a
> WARN() like ext4 does.
> 
> Patch 6 fixes leaked page pins in bio_iov_iter_align_down(), and patch
> 7 removes dead metadata handling in the async direct I/O path.
> 
> These issues are currently unlikely to be hit in practice due to the
> specific configurations required to trigger them.
> 
> The reproducer for patch 1 has been submitted to blktests [2].
> 

FYI the reproducer has been merged to blktests as block/048.

> [1] https://lore.kernel.org/all/20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu/
> [2] https://github.com/linux-blktests/blktests/pull/258
> 
> ---
> Changes in v2:
> - Rebase on current master.
> - 1/7: Add Christoph's Reviewed-by and submit the reproducer to
>   blktests.
> - 2/7: Skip the buffered fallback for IOCB_NOWAIT direct writes, per
>   Sashiko.
> - 2/7: Change the Fixes: commit from c0e473a0d226 to 3c20917120ce
> - 3/7 to 7/7: New patches.
> - Link to v1: https://lore.kernel.org/r/20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu
> 
> ---
> Tal Zussman (7):
>       block: use iomap_dirty_folio for block devices
>       block: take i_rwsem for the direct I/O write fallback
>       block: take i_rwsem for the splice read path
>       block: honor IOCB_NOWAIT in the block device buffered read path
>       block: fail atomic writes instead of falling back to buffered I/O
>       block: unpin all pages of a bvec in bio_iov_iter_align_down()
>       block: remove dead metadata handling from the async direct I/O path
> 
>  block/bio.c  | 18 ++++++++++++-
>  block/fops.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 84 insertions(+), 18 deletions(-)
> ---
> base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
> change-id: 20260801-blkdev-fixes-771b1c314ebb
> 
> Best regards,


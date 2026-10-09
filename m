Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125E4BD780
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562434; cv=none; b=IeXEcRoTxbtfwGdiagnhTKFUjGPgw7hjhjX3uhvt8jVAuZpqkaO4CUQE2poZGT0+nIyUHcXM0eJzdC0tpR4x//qZiPBhrIIm5nepX8rSKk3ykUuO4UBOT7im/gZSrsx38xCR53DnguGle+E4OSrlE2GBDJm/bygJ9KUe5RU7zGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562434; c=relaxed/simple;
	bh=DbRmeFKz9c5VWdWVaobKih64pVB21jZZPInaJVc30JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyxvOPV7EJBmNLomaU/Q9VdmT4XTqFSCqHqNij8ZZhr8jSIVYgazUYw5+a+FZcH530yvPsV8juN3Vhi6kdbZUx7lk9OsqNjBWOIfqU1rVJ0RzKPbmVVPgZgCp0vh5POSOTemxewkckP+LLxACz7MacGwZVokACQoVFhoU9qKiwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=rEFR7Fpk; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=q/6wo03H; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="rEFR7Fpk";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="q/6wo03H"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699EueVY067562
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 12:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=wZe9
	a2En9o6BKVSoAfcVpFv08ixIGHqSssDdI/MA20s=; b=rEFR7FpkiI2zKlQkTGRv
	l8vaftdG6plJ6RIgfVd7tUGmSCNVI0yHL2nav1LLG/4/Tp96oP1HO6hBw77krAfV
	9DqRhdUIhNDvD1z/qofcFqXckmr+tx6RcME32VmKWs1SNElnfypOn9+7U4QOcUns
	TexzZt+UnyEoLfTaN6uDiyFo8LqHgFXd0x3Wi/+SnbSDDh5iUJT7ymk/xa/sdfEy
	5UiQfohU3fbl6c9Dqw20vsiuAMKQadsuyNDKWoFGqR6t1DkbKCbbXHD8NhlNFxAo
	qAlW6QKdi9aP0+tiuoXwUnj2abu4UzdUkxyPnXbo2E73uJzYUlLX+yU3+yszUfou
	Eg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h6y3gu3um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 12:13:44 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93dd3c3badbso1282462185a.2
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791562423; x=1792167223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZe9a2En9o6BKVSoAfcVpFv08ixIGHqSssDdI/MA20s=;
        b=q/6wo03HhgBkXyLqL6Y+/pqjuIpON5wkdSNW2EnSKIEr4vgBbSQd2wqS2fJhWeUbPv
         W8dKQ9iL4wd7WnwFH9hOC/iuZw/m6wWZf7flKI6TMYG26O2cY/byhO4nLu79pqQvZ+Aj
         JeulvuzvUqKuvIMf9l05dQkEEoOveB3OpvdKNbGzmPnoxLhwYbmcoluJUsBQbdiLvSga
         pLxJWH/WHbW6vK0Gid1ygnhMl+a9uswDYPiZyi48+X7S7n/GUyb6ND9bUwzshv6JA7gb
         L3peTmKu5YAcIZlEl3s0zgrSPtXdSrwMHOslu7KcSGxM45cm9xDAKqXdG0E/8iLNZbVu
         i2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562423; x=1792167223;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZe9a2En9o6BKVSoAfcVpFv08ixIGHqSssDdI/MA20s=;
        b=QUeRaFAFo0yqFrGkR8auHbS05cUSTPGAbMv5AflT7uto7/GO7K1SIn16/ioHjoKxzy
         0tAbOTalq/LNSYoVu/62Rr6AjSiRRbml++keAK1zfzVVYcHyC4gPxLM4RGg+A600Q0aS
         Zj202JpJHwayVUc5sl/LvAhka1Fo9Q4njwVuQ5llJNMBPIRVkj5lHztroLG19GPV21Os
         xMHyTBmJkii0qtDcN7k7Qi7rS2aTuGgFXRExA84IBKdp0mVsQaByczKWZh+xueahmOzh
         L9E0Bai/phmXmCudjycA9tDFyA/RFyzP3BQ9s8FabqFx9Fg9Kihhf3EH6hOuceM2I7ih
         y3fQ==
X-Forwarded-Encrypted: i=1; AKwUvByoVfrW2cMOgZjxqdhKoQ+AUnES3PZzapsxKjfg/LXITVJJYjQ7rodCK8Mo7qV3Ta2/ipHHOukRhozduA==@vger.kernel.org
X-Gm-Message-State: AFuF++kaQoU0w5KU1v00lg0RQQ79SRpcMySOFNHPgEQ40yMAQQHu4rYx
	/Y6JF0yFQ5fsL2lJzejWtiqw8kgzkA9tGCyB2N9n70u5gk8F/E8ibJWUBzcgbH47QHHnlVgM6SA
	aJUal/bQcSEQCTlaFODuuhQm26VrDdAfeWHHxTxVQyMmgoxewsFTOGFWpDBmf
X-Gm-Gg: AYBFou1IyKW4kfWs8Rayt7oHQE+nE5BYuf4zHSQfXryoKqhyQxXc1PtrsPOwDTPb77C
	axfZPOqhWUPWa4jmp46RNPICvaK2+dv7cJJG/GlHrCvSt2tCAof7AI5rM4lTEf9d0a9K7dNm7kC
	zIQBf/GmXZKG7gT9m+sB1WrKrHMrqgySpkO02S2YjQp2vdrCKuU3Y+YRihf+iua5hWlBetGn9nP
	5FuaxGKVpAkEpzcTQzoXSUed0Fy6NDa5rjUmgpE1dHGYOkjPtXpkRQpXA3OVrtMjOEo4x4hkWNH
	r+ub7AS0hphYwaSge9ndIgQYyjrwi1HRck5Wge6npuie81jvYD37b6bEdskkmKLVL+e+WkKleTb
	C689ydekksgMzVMriVn7xxU4zcsn1XFZzloSyRk1L7V0TQ6Yg
X-Received: by 2002:a05:620a:a416:20b0:93e:c12c:9b76 with SMTP id af79cd13be357-93ec12c9f3cmr196780485a.81.1791562423659;
        Fri, 09 Oct 2026 09:13:43 -0700 (PDT)
X-Received: by 2002:a05:620a:a416:20b0:93e:c12c:9b76 with SMTP id af79cd13be357-93ec12c9f3cmr196774685a.81.1791562422959;
        Fri, 09 Oct 2026 09:13:42 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9720f24sm221712985a.3.2026.10.09.09.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 09:13:38 -0700 (PDT)
Message-ID: <69a325f6-5641-4f12-b088-5e108b48ea97@columbia.edu>
Date: Fri, 9 Oct 2026 12:13:37 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] block device fixes for large block sizes,
 IOCB_NOWAIT, and direct I/O
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
        Sashiko <sashiko-bot@kernel.org>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
 <960b1305-c5a6-4554-8bab-1cf4244fa11b@kernel.dk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <960b1305-c5a6-4554-8bab-1cf4244fa11b@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NCBTYWx0ZWRfX7Ggb0uLGnkaR
 wgjNOM8RnSfjRACSCAvlLUWJWxJzaT4HH2kg50RgMXtXLItnTsciz5NisW0YXhJGMwQrHTAaTTy
 fvE/FY5XydEXn8DaM1jdi0Nf4B50DpSrHNjefrOtsztTAEE0saPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NCBTYWx0ZWRfX2/eQDU8CIJ4f
 Rf7znTtuA5fCN5QkQmUiQ9Z7PjDhgaTpD3YXN/TdU0zwZSgXTrJhf61l2fCsYHXolggdYavaSay
 x6p6UTEtHI/n83XaMgENDpFDpQYUDO5Apv0lr5qGkouDvwc5y9gTZ/nAg20XvJvmqnqslqyihpk
 /fN2GkGdxoI9ei/TaXBKwKZ9RgqwCl0/7f0fqgE76cvY71xjcaLlzxDruoFB7xwilWOA1ycJQ1F
 R6E+O4OKI0DpBmESdn8QRIvbxtGBfjMv2q8Ezza6p5xHjsu7empXuYFuvFeaLdK4L9s5Q79hAvO
 kD5lLU6uFJWrMQPCdVBGtdv3pjcc67Qu/cCmzzcudaloSfUpDEk4cTiZmXepryLM/SBjUYD0ic3
 6T2UHnWHU+/8XjZ5t5dxHzb4/VaUP8LZxaSFhIqN6jjE4fLyA/FI2OT6IS0AgCZibWtIlcp0hhE
 Wrcis7dJM1V4dRt5dXw==
X-Proofpoint-GUID: QuP0sHzeEntHBIZjSw1Ex15flEl6SwDj
X-Proofpoint-ORIG-GUID: QuP0sHzeEntHBIZjSw1Ex15flEl6SwDj
X-Authority-Analysis: v=2.4 cv=bovZl0ai c=1 sm=1 tr=0 ts=6ac912b8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=kmbzLJUYW2F90v5fXl4A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=10 priorityscore=1501 phishscore=0
 lowpriorityscore=10 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090064

On 10/7/26 10:05 AM, Jens Axboe wrote:
> On 9/23/26 5:56 PM, Tal Zussman wrote:
>> A set of independent fixes for the block device file operations. The
>> first two were found by Sashiko while reviewing the RWF_DONTCACHE series
>> [1]. The fourth and fifth were found by Sashiko's review of v1 of this
>> series, and the rest came from asking an LLM to find any similar or
>> related issues. Each issue has been reproduced, with the fixes resolving
>> the issues.
>> 
>> Patch 1 fixes silently lost mmap writes with CONFIG_BUFFER_HEAD=n.
>> 
>> Patches 2 and 3 take i_rwsem around the direct I/O write fallback and
>> the splice read path, which race set_blocksize() changing the mapping's
>> minimum folio order.
>> 
>> Patch 4 makes the buffered read path honor IOCB_NOWAIT instead of
>> blocking on i_rwsem.
>> 
>> Patch 5 makes IOCB_ATOMIC writes fail instead of tearing, and patch 6
>> stops the buffered fallback from retrying an atomic write. Block
>> devices can reject both paths into the fallback before submitting any
>> I/O, so we fail rather than issue a WARN() like ext4 does. Patch 7
>> makes iomap_file_buffered_write() reject IOCB_ATOMIC, so no other
>> buffered fallback can complete an atomic write either.
>> 
>> Patch 8 fixes leaked page pins in bio_iov_iter_align_down(), and patch
>> 9 removes dead metadata handling in the async direct I/O path.
>> 
>> These issues are currently unlikely to be hit in practice due to the
>> specific configurations required to trigger them.
>> 
>> The reproducer for patch 1 is in blktests as block/048, and tests for
>> patches 2, 3 and 8 are posted at [2].
> 
> This is based against the 7.3 series for some reason, can you please
> resend against the 7.4 based branch, for-7.4/block.
> 

Will do that shortly. I had assumed initially this would go in as fixes
for 7.3, hence basing it on the 7.3 branch.

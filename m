Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0CD4BA1DA
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672818; cv=none; b=S/EBmv7pPWaiP3P6nmetsV4ZsVI4/WEm+/rDhnJO7PMRs3q8b+rfwtcxpmaiBF5lvO+s3v8iGaJrIAW8q3lnUTX6GRRsFb/0b6tC3m8LKiNCBBEN8+gdtWNOLDHp2+ePqnFafJ9rC0RaBL6LzGIaTDe5zz8tZ3FNUQ0k4ME+lGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672818; c=relaxed/simple;
	bh=qIkpliZGABu/1DsQ9lqxJf6xulmYU8xgQLf18jeRo/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qy9wJI1zZLqPocFN1vXRUUpndjLnpvVqJ0tf6b88/WBwA0otWm3nGlBsENApB9IFnalPrEnNFlqo5/+vKkB4PPwCRfobrnMIDwwwBpPh7lIjpYwLvv6Ik7Kst3b5VpGMmmlGZ36XBzggyPHh0yOBt6aUuBj9KfXjQOJ62qrxCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Cvw+v+7g; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CncbDnl6; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Cvw+v+7g";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CncbDnl6"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T8XcL72621543
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 04:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Nhw8
	v53Ku7yoHr9osqQh1xifI8ymi7aYlLItUVuMPgU=; b=Cvw+v+7gR9f6uZsw52F0
	MXPD0qPAq9Q+gdETTR50hu6HwIZyql1BqQ3hngAWoZ7hl1s8zJNa7ENhtX8qRMO1
	d6KwAcEU5x4qHip70NKL1Lezj+cZokgT4qnL1JdgCQ8xpGy83Ui3/sofCsgfB9oG
	dUvHuciNrM+Py803HDSfzYIvJepGceM7aogzK11x7D8ZJDUaVMOYnx7Z7/Ft8vcA
	8Pe0WcyhxnBwiMfSmRXhVk/cDdJeh9z4MMgMyjQqU0IiHBDTp3fEI5yoje1PBuQZ
	tR5V09oftFknpJBxo2xlBxs60tiJnAJ/mOoXMLygEXtEJNmkhg4KndL1MLVdhFZF
	+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gyxtrubhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 04:47:44 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936aa34873bso756603585a.3
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790671664; x=1791276464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nhw8v53Ku7yoHr9osqQh1xifI8ymi7aYlLItUVuMPgU=;
        b=CncbDnl68wrk+LwE/fGS2yfT9w5F+q5j4wX5pEJqePFRYUHqnQrC7w3oflSW9pwJP4
         lT/S2RN6v6C+rEKkSff+ZhkfhlvX6Nz2L1eN16lrLxXtU9kJWAwNEbli+3s+XknpfgnB
         kEHn+RB8pKQsQvNi6G7ybN19eh/y1n04xQKcX2zqr2nm6lNGwN7O98oL44lodjd7i4ft
         4t2T0Ts0oN9dyt5N1Y/8FEuEZRh7bn7GLzX5liXZhxxsjYt+Ryx52sbClqFaql0s9kJ3
         YAHEPUsy2IMYgD2Jivzza1L20BJzV9zdGgX+Et/l+AFJ5B5yStTSKK6OAngCYXdUCJQH
         wjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671664; x=1791276464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nhw8v53Ku7yoHr9osqQh1xifI8ymi7aYlLItUVuMPgU=;
        b=yPeDnL7Zuht8CMLDwm8LGS3RQZk6HAcBayJzZXAbooApk3dxXDU60/LUE0hdduhprN
         eR0DoIdphhMZpuuDjJE42L821phwgJROMl10E8V6Bg6fuB3V4xV8Oo/EuVw6v1UFgvBp
         dQUZCsL3EWcpYM2mNtdGY1bi7DxL5/qAWGkCcd0wz02CIWtAd6W40RSu2gSEMZxRCDZz
         R/9RRmUuZUWK6EdPbNU2j3QeuXddHmavioCVHSd+EccV8v4od29A8yJExzq5u9RS0e7T
         KdCY2MBOgq5TJf1uU8q5P9V+I/EzQiVYCdsFXW15kF3tYARHLzoTiPae0ud8Pc6GqDo7
         JpsA==
X-Forwarded-Encrypted: i=1; AKwUvBynKV2T2OR1Es/90xj3AxBU5ANR7y/IC9pKXcGCq+9KBXyC6ArGXntIfPRP3eFLL5AgGBSOw3c2HOn78g==@vger.kernel.org
X-Gm-Message-State: AFuF++nkHKWDYgq3cfFtmogGqHAnX6wTZdq4nEmEVDBU218ewZxsyl04
	kTTT3HgfItVHqBITR2GkQ+1ffqk7AvMu0o3f4y3bxi+xDZY/hWmqJXZ8Ede/r4sASQUjKIYcJIw
	FvwAeNqEJDcDGkn3PUZrx0He3sjRDMJcLDnzSEQ/kWewWjcwgkZMZoR4DOCC5
X-Gm-Gg: AYBFou2gqeGgfQ2xIKFNI9RF4S99b1Zmmlphv/DeqwPhYMJkmrdT/X4u0EIVTQxViqB
	nBLv8nSW4bFQB0l+URbjD3zmp+TyHhMEOmDj00HB72pMhR2ri3W/NjUPdXvXPUJWSDvEIFBlyX0
	kYIKQS7YLhZaFLn4swEcJLtkHZv5n5mgCGZ+c9sovg/qm1PILGtgEFeTy2+MALBwwgJ2suCXcML
	AVQgToLvEX65r0KkiyvLmXjm0hvhi1s+vbbW/aPX31A2x8wQniX5E44rfdfDzumtP+WwYF7NmdI
	Q4ELQkyS54maKHrU3mB5XjRaZOGWYaSQzAsiUtUePJ5eDW3ypMCDkYg+lbvXikHDSAQZCsMUedy
	auz0jtI5TUfs/
X-Received: by 2002:a05:620a:4446:b0:93b:6113:218 with SMTP id af79cd13be357-93c43b80eb8mr2546610185a.12.1790671664161;
        Tue, 29 Sep 2026 01:47:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4446:b0:93b:6113:218 with SMTP id af79cd13be357-93c43b80eb8mr2546608385a.12.1790671663703;
        Tue, 29 Sep 2026 01:47:43 -0700 (PDT)
Received: from [10.192.23.156] ([82.142.85.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af508cedfsm2418391f8f.30.2026.09.29.01.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 01:47:42 -0700 (PDT)
Message-ID: <bb13358b-24f2-4462-92ef-0e538ab314a2@columbia.edu>
Date: Tue, 29 Sep 2026 10:47:30 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
 <20260923-blkdev-fixes-v5-5-89e60d66eb38@columbia.edu>
 <69579dae-285d-472c-ba69-4279e5170502@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <69579dae-285d-472c-ba69-4279e5170502@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E+lYNqdl c=1 sm=1 tr=0 ts=6abb7b30 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xSnE1pX28jTrkUJPvDlzhA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=5vhaLU_8k3ht0VnDKtMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMyBTYWx0ZWRfXyFEq5QIHdQ9W
 LmBX+C1yK0kq+FHqmVPLdFcm8XXY+FYs54msVn0rFVHbicFxWUOwcWUbAOIDHcTGyt3Y7+DnzNr
 97tB+u5hz9Dg2jKgA9DjObbY0x1WoD/oRVKYQ9Z/xQ+W1THsR3bN
X-Proofpoint-ORIG-GUID: CZjkwsw7XCDUUoAfVkOMPUuzUpxFywlA
X-Proofpoint-GUID: CZjkwsw7XCDUUoAfVkOMPUuzUpxFywlA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMyBTYWx0ZWRfX5EsmY39Ik1W1
 PIuqPnCx4hrvRpkOS1ETcXhbIEzVObzOx6Y7ok9EKUntPQA3nL20S08e+BrV9FXi1us8/BRYKb3
 hWHzw/u4EaDG91xjttQKT9g5nO2KwgmX1ygMHte2oSW6TZkStOCeQB6jUQaAwWeNLQETMLMrDXE
 PPx/XTw1VBLFxn2BCIu8YwEkWuDt1oN10WEmbDZpUCM7Mk/JoNC4P4rONA7h5Ffz0zr916ZAHt+
 eXox8IepYj5PiyK6XP1ohsQd8MOsQ7qZQYMOvIbp5wiV2rY1HzUNEseNd5iRPGQ/w4JSpd5Gwdm
 3RVOvOfjjSZOetwlXWeE+QGN+KJL9IpJ84DZHfsY3Col+CLr5DTM17dgIJHsdKsAQTgqzBwy/5C
 iHpntZICgRC1trPS/USuIF56AVdsdr+UK4z1MN5xvnri/5MGX2+AB8E7YONGfq1KBd+LuzQkcG5
 oJC9fU08Lc3kXnzG4ow==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11919
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=10 lowpriorityscore=10 spamscore=0 phishscore=0
 bulkscore=10 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290033

On 9/25/26 9:37 AM, John Garry wrote:
> On 9/24/26 00:56, Tal Zussman wrote:
>> On a partial page pin, __blkdev_direct_IO_simple() and
>> __blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC set
>> and leave the rest to the buffered fallback, tearing an IOCB_ATOMIC
>> write.
>> 
>> This can be triggered deterministically. A 16K pwritev2(RWF_ATOMIC)
>> whose last page is PROT_NONE, on a scsi_debug device with atomic_wr=1,
>> completes short with only three of the four pages written, violating
>> RWF_ATOMIC semantics.
> 
> I don't mean to load more work, but a blktests case for this would be
> great. I am consider doing it if you are too busy.
> 
> Thanks!
> 

No problem, I already have a reproducer so it's easy enough. I'll send
it in the next couple of days.


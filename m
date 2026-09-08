Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF63B2AA
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826294; cv=none; b=HH/IfQ9uglgiALNpeezMLDcumfM+tU/28979okSp2lo6M4zUu8SLhqf1izBcZebLT1Kv05yvea+8DKiAQXZFvK7aapizfd4EpZ0VXIon1gyQlnlOnej2JFWCIM+iKLZq/ulI6mc5JP5byPbMD1Fm06PwrizsIyUZToNtfcodjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826294; c=relaxed/simple;
	bh=ls7R5dKuAv9pAtaI6tZbcbs0Cq6QuFIba8TTUWJGYAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIUjbtwIwvvNGClGAdSv5ag1VGEruSdsAuJHWEwx0cps3PnMVSZcM8lyGb/oHnjyzKZDXFhA63xabTyK5OoEYEB2CKf3flrRb9WDV0cZZ9zu5QMrK0/mTx/O/Gz/v92FtcQlGZmmQSpkGgFnXQbZImQ+U2wCcbMWcUeJ32JeAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=AR/5ENzL; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=FfDpgQxD; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="AR/5ENzL";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="FfDpgQxD"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687MY4lK3579012
	for <linux-block@vger.kernel.org>; Mon, 7 Sep 2026 20:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=6F9U
	PwwA5IUAoLSDzoxdxlRxl2v/TtJim6aImNVQKrk=; b=AR/5ENzL+6KsEimeNtJ7
	rXj7MjmNPF4of0uR9Y3453jKSftTEqsb1kb3Rbac5SfKI6X2Rdyl3IQyPhYga3FO
	WFdxfyqT+8d8nzCy4AhbHIO7vvrOI+TITImwFA59T8NXC78JfCHQMj5q5wQpm+ue
	IgvafaigkaybO+2wl3VUsUcQzonLqEhLyknt+Q9Wh8lUircBR8p4ZMQMOIv5qKH7
	YN90XycDLxcQF/ZK9B9bGrI8F6TJa9AbDuDl7Co0nTqCtLLcXCBxZcqb7Bf5HbYf
	jKd71lIImcFBIbiF3wN0yqTKK1Q+wWeLrxsiX+XW30pb/5YPIqMXry1vWamVl7Ea
	lQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gj4y3gqhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 20:11:31 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e62e3459fso599450385a.0
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788826291; x=1789431091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6F9UPwwA5IUAoLSDzoxdxlRxl2v/TtJim6aImNVQKrk=;
        b=FfDpgQxDS51d2UBHwMD/6f3jFEw+wem2zifg44x3LPqCEjPzSMRGfi+t7YtgH8ubfB
         DAtlzEoF/Yh1bgc0XNnZjxQJy/Ic6oELZcIUAB8qNdh8qKbE4eck7WVXyZrbv180n1Of
         vhQ9XyYB87Dep2joECqm5y8xYcQXTd3ZVYPdIn4v7DdsPWnqWLLWNNjzfSFtTFZSyh1o
         bXV+e5ac+twJbHmSTN2eXuztRxhNeUvWQQ1ARxQSifrSqQuWzfwfcJ2TBI+99ChEOJ+0
         Ar1bsAEU4cFhHXkJM8d+sD7Xt+E+Qis0IiT4UmlsWv0gNxQlwZDnGTMxkO8+amzxQJ/6
         PQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788826291; x=1789431091;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6F9UPwwA5IUAoLSDzoxdxlRxl2v/TtJim6aImNVQKrk=;
        b=dfWQQ7kcZ3Qmj9Hmon9S+nzTExF3J5BbXbsGaeFvPVfVntcnT+3SjDXF1GsSblFOFl
         FACaNNS5Lse3dOqIXycV6UFtyj3HPSoXssD+rEHiXAgq9yz4P1nuUm+IJuXLDQBh2DHN
         q/mbe9/QsEbNTCdQ1SjUB8gb/3s5BjX4ZQwuM/YUdm/VPzoE4ljq+aYqatYHBP6AqbQu
         I974zaKzJBPe/iW+7qQWf+ZRZM4Fpwmwxm+ZrbdiC68SGRVNEwng/4vnZqAJts6r3izY
         gRf1cx7R1EYcFEpZOKY+51hSNmr66IEXpB2cVdB0Q1snEgiTn9tASFONk0orHl+ldOYe
         tW8A==
X-Forwarded-Encrypted: i=1; AKwUvBwOk67enB9vuWgCyZwMP95ISBth//JpX/KBY9JUXaPL+FtD9fv5LkCXM0GxU+XpsJ7RCmu6cT/8bwtoyQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m7gTrzQ+RSEN0t8OMbuIQJJc5EvKfBWc85usvvVMviXZzSBIR/
	v8Jlsf52o/MCNE777OcWGOhpnhe+p8Wab5Bm4+zzj1tR1GaZz8i2aFbdfE+Dv5oxHRdmZSXh54O
	0qikCfofb0PaVqnbHMrDqKZQfudCZkIj5KuC4jWI9ywzqqH/4HnMLdJHSEwTi
X-Gm-Gg: AYBFou34RDm39U3mUSDBeOEtbRWSpUHEUGZq19aVtlYUwskPn4fm33k4YGptRolc+Ro
	ZhfgtA8ahW3rcVTkrt8+XdWEGBVaXGdatZQEudXiYUe4WWSjd+d9dhXEa/22uh3CxNofNIWa9+u
	YrPIU2BZ8KJt1JnI2H8lyl1QPHKPS5Wd2d42Y1cfWpEqtnv0OIp6LBF8Nkx1o4Zkgf71qxcjnDP
	SkcPWRlRkBC99JNC8nSB8xYQvoLKpRaRBajn4lJ+PUEr2M1Lirbd10uXIssUEZ13rZ1Y1N7lW9M
	azmtZapx3lTEmPEFKMouggGOhrExO6ftM/jI4Cc8ue3Tw7ZKx+KblsgSH27LmLmzk1TkjQdSJ3h
	NfovE9OvmiC/bBG8D3HQIuMHVHQhGv69xg43DIRdEuu7nWBw=
X-Received: by 2002:a05:620a:6081:b0:936:69dc:aedf with SMTP id af79cd13be357-93980370c3bmr2604430785a.16.1788826291276;
        Mon, 07 Sep 2026 17:11:31 -0700 (PDT)
X-Received: by 2002:a05:620a:6081:b0:936:69dc:aedf with SMTP id af79cd13be357-93980370c3bmr2604427185a.16.1788826290792;
        Mon, 07 Sep 2026 17:11:30 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-176-3.net.columbia.edu. [128.59.176.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb59c72sm995351485a.26.2026.09.07.17.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 17:11:30 -0700 (PDT)
Message-ID: <f51c6392-f77d-48e1-83a1-4d6d4f83aece@columbia.edu>
Date: Mon, 7 Sep 2026 20:11:29 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-6-32f3f40cebed@columbia.edu>
 <8da4a2dd-a4ef-4a61-888f-60c611d3f911@columbia.edu>
 <20260907071318.GE934@lst.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260907071318.GE934@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6jCIcb3ifutF2baZsBlKpplGZeTsLtqQ
X-Authority-Analysis: v=2.4 cv=T/68ifKQ c=1 sm=1 tr=0 ts=6a9f52b3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=92j1mJcILCjWExuphHMrQw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=IfWMoTYk9wI_L9YC-tMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDAwMCBTYWx0ZWRfX4LmoDFcVB9sw
 5yiQQFuUDj8lPaAl8CMC2ohdWHn/qIJrIV4VFLAWTGtgbPuIDyIslWQyuhxPn3y/9PUYRjn0YjA
 GwC5h+JS5mC0Gv//BklTQLUER4GcYoJ7JYJvy99TnSVCeKqrVqxg
X-Proofpoint-GUID: 6jCIcb3ifutF2baZsBlKpplGZeTsLtqQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDAwMCBTYWx0ZWRfX4tQ2/gzHWiDI
 HZ5UG40oWcucUzKCF/rzPkfYYRHv3NCfK3cjD9W6s0MWRyjc91485UpoH7MesWobbn+7lH+Z960
 9XxCGLvJfKxlmORv+790VeFC2AfNqeRN/AgkvQxN+ahN463xFjI3A1AKVvmGb7EGIYHsFhILFU4
 e/FuDVIc2XtZ7YqtICy0rYSzdIk0vbU6HqL81uixen9WGlgasUNvcXSD2cY8dhLTa9ETltZj4VA
 SKTiR8UtEMioFrsfyw5r8E5eXPDdk37+RAMe5+W6r5cwKbjpIOlDRf3DLenUKWeaO+5+DVCMbHp
 XPtp9W6B70vilU1F3560mJdLwF2o9J+hzvTa6jrpIE3OFdge06a23CDsUlEzj9lbMpg1LulRgKn
 03RTBvGWk718zLSYTbYK38IjSPm9bWCKsnAco9iZLjN+DDk0hQfSMsz8fwSpvusqKODe8isYeIQ
 kC1hl7+nchpNmiTTC6A==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11899
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=10 priorityscore=1501 adultscore=0 impostorscore=10
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=10 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080000

On 9/7/26 10:13 AM, Christoph Hellwig wrote:
> On Fri, Aug 28, 2026 at 05:36:24PM +0300, Tal Zussman wrote:
>> > Both issues occur only with a logical block size above PAGE_SIZE and a
>> > large folio backing the user buffer. On a device with a 64K logical
>> > block size, an O_DIRECT pwritev() from a hugetlb mapping that ends 16K
>> > past a block boundary leaks one huge page per call, whether the
>> > remainder is its own bvec or the tail of a larger one.
> 
> Do you have a reproducer for that?
> 

Of course :)
I can wire that up to blktests too if desired.

>> > @@ -1213,14 +1219,24 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
>> >  	bio->bi_iter.bi_size -= nbytes;
>> >  	while (nbytes >= bv->bv_len) {
>> >  		if (bio_flagged(bio, BIO_PAGE_PINNED))
>> > -			unpin_user_page(bv->bv_page);
>> > +			unpin_user_folio(bvec_folio(bv),
>> > +					 bvec_nr_pages(bv));
>> 
>> And right after sending this, I noticed bvec_unpin()...
>> 
>> I think a cleaner solution is to move bvec_unpin() up, make bvec_nr_pages()
>> handle bv_offset > PAGE_SIZE, use bvec_nr_pages() in bvec_unpin(), and then
>> use bvec_unpin() here.
> 
> Yes, that sounds better.
> 


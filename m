Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257137C901
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677481; cv=none; b=IeqwhFre1rpIkl5DEqlzFO9z/3eWDIlX3B/o/bXfAkhup5qG+1l5JiLX5SLfcAmLAJu6ezmgPcO++tDtgSj4CdcVrgUN9iPvdbQwS5xDn1q0MvauWU5UoU1HZxMf15r2WhDevIO3ILvqbWqqFkH9W2N5Nbs7wYFWmYgprdpRCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677481; c=relaxed/simple;
	bh=UKOON8VnufQeIosYs85uC5OQYu8eeg0kTOI170aPmhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUbDClixdh+OpV+UtsLAubMaKynjlDM8e0rTFwFTpoGyz4fkg/1tcXSZDeWTJ0WkabKdFIjaGLGxnmjAFY2BKBTxFU7xQN4Meg2qZYyry6182qQ5Cu2prrrMjQ2rRLMnePR9LQItGNabsgbxmanecJsUjaAHyK4YtwnmREitUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=iUwfPg//; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="iUwfPg//"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638JNBXO1556759
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 15:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cQ/T
	G8NyYW11ar8cP2zAAoS1p0Xy/yaGNX7PKSKfnNI=; b=iUwfPg//iz4QeOnNBzRS
	26n2mXDCUin867E41bkq6MbXzJHVhjIy/JEpfgrWMmzpIsMffhoxNVTijCNdayK/
	omdxmyQIaWWqjhhsoGUDrlftst5MjFj746hiLNxRoVv72HAOs+GhT20N0600pdSJ
	u5kM8hnYgRkZX6K4bIoCR7Qo/G/l5U/VGm6eJWpF8tJjbvRicduLndw2xV5BJFV6
	2MO5int4NAEXn+ocjmyXJjwWv5Zn7wusO7sw/CSCjPjDYkxyp/CFH6qM1gnEVUvO
	4Dt9o5W5NtfMdq6ljtr/V5OX8jy9ZDscvwkt3yUFXutNGJ/muM2RT9QZnmgA/w5E
	Zg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3nq73m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 15:44:39 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d84b5f73bso6990101cf.0
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 12:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677478; x=1776282278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQ/TG8NyYW11ar8cP2zAAoS1p0Xy/yaGNX7PKSKfnNI=;
        b=oC6M9ZWrnjp2Tl4cRmuT0aBsnX1ZynW5z5JqICYk330CwVB5maL3Y8aD/EeHpVgZ3f
         91bV+7uBtMXfejL0h3nUa2qtf+IiDWtVyWerf8twIEQrGTAt7n5rHBqBB1x6yTTXsj3B
         jfZFfbADOPdKJ0mF/9f5U5iI9C1V77Aux/Zzh9TtmJcg/rluMDd4UxzHT/9Yt7XIDQFw
         bO2iEc3CJ1vNpn1qNLax4AJyVT/ab+hO3pDfrD8/cY4dVJYId0hvpOWLD4qOdxgczL1T
         kKYIoL0pgvheK8IfjdgEb6Leg94PVRM9xVAV9x5PdAOQSwM/l13KQcqkAWn+a/fuWBEZ
         p1DA==
X-Forwarded-Encrypted: i=1; AJvYcCW9D1m1ZCz323Y0ZpCZJO+syo+PhBNgz97Jcw35WunuRSxRGB/i4sY2sSSxdGxIqN8tef5REW3/OpXU8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvaVb6GiZmcAwX5opyJPNTvnmLfB+HkFhtlNkd2iWbb6VH7Fal
	FIqShyVkQrpWAVFZYpaKPEQeshvXquuq5oNs6ChNkJySzITlN+kZTwdW8GQ0d8iJ2L4cqrFRmsE
	9w9WIa7Uli55VodScTBnxLRyrO/pzVN+rBh63whPW/5DzgrgEO6EXKydpKqBo
X-Gm-Gg: AeBDievg4JptHI++4I7e7SUHS1x9lxzH/7x1Z3ykZl/RLFXwoL+lR/jeihF2fNVfMKz
	G45cL0xsD5yoEJtt7UNZkBWTjzMrtnClBB+kc1DdJHv8tP/Qr1B+Qf1mMywtKf+X3KO8D/9TR8+
	cV1lMOAYXyiJFat8IKuYsdvOmZJtuS3NnECAVUZ638JhPIWUjj0RFjUqaW2ebLPd8OybGUYVu9k
	xYfeO3SeAl6nYCIKzsB6Fu2QxWT7ckmmJZhdUEeMFu0+dVlT1fJraUUZDhIm+lUSVGIXQ0l+n2o
	X+a5OsfFNHnrSlZiuh33FRiE5TF6Qt/Y3bLCKMGxT+tOnHThwdeBpuDV7FRRvcqzK8j3Z3zRmXk
	zb5iEURJ1CoVDs0ZTc+FT1Z7fxl0/ox2/+fPKS6MR
X-Received: by 2002:a05:622a:558b:b0:509:3098:819a with SMTP id d75a77b69052e-50dc22dd2a7mr10872221cf.44.1775677478535;
        Wed, 08 Apr 2026 12:44:38 -0700 (PDT)
X-Received: by 2002:a05:622a:558b:b0:509:3098:819a with SMTP id d75a77b69052e-50dc22dd2a7mr10871821cf.44.1775677478076;
        Wed, 08 Apr 2026 12:44:38 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b1a3fc7sm215560781cf.5.2026.04.08.12.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 12:44:37 -0700 (PDT)
Message-ID: <9631d652-fd3a-45ac-b8a3-b632b26f6fa5@columbia.edu>
Date: Wed, 8 Apr 2026 15:44:37 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-2-c4b56db43f64@columbia.edu>
 <acRDyJrkJhnHHMSe@casper.infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <acRDyJrkJhnHHMSe@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4NCBTYWx0ZWRfX+hM+lJaVTK9F
 /x9JxpAkngFSrOILiShQ6ca1zF7ZPAltdWbkD00Gwh0Pdl/nyOIFkUy29VWxUw0WUWA4gKYtpPn
 9u8nGuVWw1rJ4IUgGR6zHUcZIOVXAI5/t+WO6tfqaugxKqqrbU5u/pz0/xE+85hr0lyVHyESO6y
 Xi0r/OvMBhudCZatTWmfLh3obU0vsIWW4+MdH08WnfapWegalYoWhokT7Ksor+/8fCfbfrlOnow
 XYAD1NM0DmVPNaNuRScqA0SBUM2Yhld/cpE27/99ThMusjKoT5fplsCM7yC9PJkHs85qcmodaby
 bKcPFaE8r2rc/oWBm+TNOVoweAGbXEYSV9O5RhKVnFgU0W9mhsdY5jBVndZKmgbaK6pAayX3TUo
 gmzSgRZbv9Zhrtj43bgAcvxygo2Mk/1MKJHhsugZ4ILxNGS6d2mfAAcyMa3CvhcRDM9vA2t++tN
 DUCo98QR94eVtgXmIKQ==
X-Proofpoint-GUID: zPnhlDiVWJmvz3mkOwG6fA1PkvHrQngO
X-Authority-Analysis: v=2.4 cv=BeHoFLt2 c=1 sm=1 tr=0 ts=69d6b027 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=X-nALmS6JCAzqVr0gswA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: zPnhlDiVWJmvz3mkOwG6fA1PkvHrQngO
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=10 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 lowpriorityscore=10 clxscore=1015 impostorscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080184



On 3/25/26 4:21 PM, Matthew Wilcox wrote:
> On Wed, Mar 25, 2026 at 02:43:01PM -0400, Tal Zussman wrote:
>> Set BIO_COMPLETE_IN_TASK on iomap writeback bios when
>> IOMAP_IOEND_DONTCACHE is set. This ensures that bi_end_io runs in task
>> context, where folio_end_dropbehind() can safely invalidate folios.
>> 
>> With the bio layer now handling task-context deferral generically, XFS
>> no longer needs to route DONTCACHE ioends through its completion
>> workqueue for page cache invalidation. Remove the DONTCACHE check from
>> xfs_ioend_needs_wq_completion().
>> 
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  fs/iomap/ioend.c  | 2 ++
>>  fs/xfs/xfs_aops.c | 4 ----
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
>> index e4d57cb969f1..6b8375d11cc0 100644
>> --- a/fs/iomap/ioend.c
>> +++ b/fs/iomap/ioend.c
>> @@ -113,6 +113,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>>  			       GFP_NOFS, &iomap_ioend_bioset);
>>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
>>  	bio->bi_write_hint = wpc->inode->i_write_hint;
>> +	if (ioend_flags & IOMAP_IOEND_DONTCACHE)
>> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>>  	wbc_init_bio(wpc->wbc, bio);
>>  	wpc->nr_folios = 0;
>>  	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
> 
> Can't we delete IOMAP_IOEND_DONTCACHE, and just do:
> 
> 	if (folio_test_dropbehind(folio))
> 		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> 
> It'd need to move down a few lines in iomap_add_to_ioend() to after
> bio_add_folio() succeeds.
> 

Actually, looking into it more, IOMAP_IOEND_DONTCACHE is used as part of
IOMAP_IOEND_NOMERGE_FLAGS. I think deleting it while maintaining the
no-merge behavior would be uglier than leaving it in.


Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE32F4A18
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679044; cv=none; b=rD4uXSXQY+wNcQP3Z2OqXJNqGxZckQ+GryTc87lCZnZF1MjL0xWMYXwBCk8S3KtQ8X6kywL/KOk8I3hBQE8QVsHcehPaX3ZNet0RLrUP1JfhZkZoxhNxKYH/BPBQ35fFLMke7lwHJIuF9O4RIiaZc2XW4u1Ew/TP8wnMyKz8Cl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679044; c=relaxed/simple;
	bh=WMLKKNYiSxEy2xAU6WTHaAaTE+cBa07ovGOG8ufCpc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNI12oFsaepbUtuMDGzXCsDAQ1lfW6KCd0bf984mMTwz6NFv4NkoS+LpCp9DeAJ4iEh2X++su2DxzdFMr1Ktt+Afd5HdhpEawmycr7Alzlw2eT4YS8aMWEjuNN86+ZOScCs8DnSDJubfV7tbOdtmnl9/rGIjM79GThzU/UNyYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=g//499sA; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="g//499sA"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638Ju6NI2483113
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 16:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=vSff
	Q46dxsNqLEMfW9mFNMfZBuciexIdSUQp95L3zYs=; b=g//499sAUgG6l/aPNEY4
	MrWDgZlHmfuOJ2N7pJMdRvAl/ADxc31gcYWWhPadhtApYsJGBMdVuAZ84Tyf0TLd
	o7X5qy6NkDuP6cuAUkdTFD8YsGuNlKCVqHKCAnE9rBvb0CUUJkvkmpeafOlj6nFb
	KtVZjONIOH0+rMVhdndCyxP4SZmYj9cAcwKbHQBhr3E0D2JfV0q7q15HV/dekLR8
	RPvAfnvNTl8WK7OvOdrYJ5LOORWmu9FgFUIZkXM0Vzzwg+Yg6PWm5vkmCIWOp7A6
	AKzSJZs356dJIl90Rk97kyFsa3pwGkyruHvPJHy6Wv6ixy5KnZy0bZvHdbim9/DG
	Ww==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3mqm0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 16:10:41 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b31cff27fso1385431cf.3
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 13:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679041; x=1776283841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSffQ46dxsNqLEMfW9mFNMfZBuciexIdSUQp95L3zYs=;
        b=VDYWgQx7tmn0tNIj/jKCJuFZJTwyT/iYYpvG+cB5JL0rHF1zhbMXIREQfl8q7rTu2+
         1VeCHuvddp9ZbgwIBYJbP3hxT7g8l/BAZIgEJY+kbP2PYjx1v7hyBDn2iQsALtam4pyl
         YTGB6bH6mjKsrgnRXhJ9RYEEPRl+R2IjnTclb+xucsm0l8BEGI4hGXDjf+eClkpi7KUV
         G4bsHlwC3t+Els0rRkJrOBuobHiTTlnRzgBtg74pOyhs0JVJloyXNoqDruxh6zFfnoRI
         Q78ppQeBxwmATvhuYffVCxU7eMzZtXoPTBqVSgYZPOJHw2HjZsnwCTJl50KxAJ3FtNSc
         RpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP4MIuu5VxsSy9r2iHspIaEKPJqbK6pEBbAya/xzZqyT5YfsqNe0rp1J11ujwMi/E9GxMR7IZ1PZG8kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XJuplOba9YuaOmazzcziIUg79lw6oOimf39vg1eCLpvYGFrf
	JU1wmIuu1Pz+22cEvTduIYX8da9kPByP4MN3YkD/oYTzrGRzhlx2jtMf7A27lxJb25eQHRTueUA
	Qzs8vZDVIN7GhmNiFglogLj32HYHUrRBuA9l9a5YtFENAPGvrlTCaJJrK9xDV
X-Gm-Gg: AeBDievKTwi+XZ+++yIt1LseZWPlTyD3EHDlnMaKTTOnpbaYGX/l4tzQciZZnqmsz3T
	ofkNvk++dDRBxsk7rU0Hqc38cibQpIt/L+1OWwMJAGBmvt0tdYOaLSd0QNxnIcwsAErQ4faQwKI
	Dn1ctkdo7T/TH8nfJtm669btySACgpwy5pBNS+MoLz6O9S2UqO28TAsZnJeB2GdP5L0CmtZ/881
	bfC1AWUbf3J2gMKphSmMW1nj1+fzWYPjfklCCN5+7lm6rBASbPabaWWmkbwwfKsRRZvpAJ07nyh
	LBRyXJYIDs3R3j+fn3fT8cK9NRDB4WOfhIip0L3sWCSaj8TxXO5+9e90cPNr/eZMMXgNL25aVcV
	zOdPEte5PA8+9ZBC0w9+iQoagic+ZpzkB9M9kRXO4
X-Received: by 2002:ac8:5846:0:b0:50d:83d7:686c with SMTP id d75a77b69052e-50d83d76b21mr252299181cf.31.1775679041410;
        Wed, 08 Apr 2026 13:10:41 -0700 (PDT)
X-Received: by 2002:ac8:5846:0:b0:50d:83d7:686c with SMTP id d75a77b69052e-50d83d76b21mr252298531cf.31.1775679040871;
        Wed, 08 Apr 2026 13:10:40 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50db5cfd8a9sm20333591cf.12.2026.04.08.13.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 13:10:40 -0700 (PDT)
Message-ID: <62c1ec17-082d-4215-85ca-3e87048a6226@columbia.edu>
Date: Wed, 8 Apr 2026 16:10:39 -0400
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
 <9631d652-fd3a-45ac-b8a3-b632b26f6fa5@columbia.edu>
 <ada0KnRjpYnY_QYh@casper.infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <ada0KnRjpYnY_QYh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2MvNCT3_tqj990qg0yJwKUajAeyMvivt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4OCBTYWx0ZWRfX/rFJA3GpU48o
 nvFyUCKMN+5ug3qDt2/FjNnx5ou2ioiJ5tPmNzPsfAGzVGTMUukG9skFdNXQenQll5WjFc6rSF1
 YlL62p57RyCk1ao3YLaenaNQlYPNdjAWiI/bW2ZU5tgjCX9zbemDAMGxYEVIzD7FZYmsJ0S1txs
 Hx8N49GtdW/qyRwXfZqXFOlw8xjdblz/qwUjuOep5K0+0gD05vAZKj4ZtfVw5ZPuFP1bCof1HjP
 8uGNDyTdRM3mIdatSA2Rd0DNDjsllH7SHhmRfyfYvOSoK+Jz3aoMmss22ktl+XkrKs5yNMdwa0n
 r0Sa9ahhyHmDfOf64iTCfcflt4eZ5AXz3PtnD7qErJD4P8pjnH7GVvB4jXjLqmnosnHFT582ii5
 MUDziGdXslZdGeGZfAeZcVfBokxnsbnOsH02WRDLrzQ0uvPRYExVFkm+d5t41zye5kTUV3wMQ1g
 Wwz7YUHJEglKWMHzNhg==
X-Proofpoint-GUID: 2MvNCT3_tqj990qg0yJwKUajAeyMvivt
X-Authority-Analysis: v=2.4 cv=eOcjSnp1 c=1 sm=1 tr=0 ts=69d6b642 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=rfDhleDhcnsx78YaP-MA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=10 adultscore=0
 impostorscore=10 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080188

On 4/8/26 4:01 PM, Matthew Wilcox wrote:
> On Wed, Apr 08, 2026 at 03:44:37PM -0400, Tal Zussman wrote:
>> On 3/25/26 4:21 PM, Matthew Wilcox wrote:
>> > On Wed, Mar 25, 2026 at 02:43:01PM -0400, Tal Zussman wrote:
>> >> Set BIO_COMPLETE_IN_TASK on iomap writeback bios when
>> >> IOMAP_IOEND_DONTCACHE is set. This ensures that bi_end_io runs in task
>> >> context, where folio_end_dropbehind() can safely invalidate folios.
>> >> 
>> >> With the bio layer now handling task-context deferral generically, XFS
>> >> no longer needs to route DONTCACHE ioends through its completion
>> >> workqueue for page cache invalidation. Remove the DONTCACHE check from
>> >> xfs_ioend_needs_wq_completion().
>> >> 
>> >> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> >> ---
>> >>  fs/iomap/ioend.c  | 2 ++
>> >>  fs/xfs/xfs_aops.c | 4 ----
>> >>  2 files changed, 2 insertions(+), 4 deletions(-)
>> >> 
>> >> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
>> >> index e4d57cb969f1..6b8375d11cc0 100644
>> >> --- a/fs/iomap/ioend.c
>> >> +++ b/fs/iomap/ioend.c
>> >> @@ -113,6 +113,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>> >>  			       GFP_NOFS, &iomap_ioend_bioset);
>> >>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
>> >>  	bio->bi_write_hint = wpc->inode->i_write_hint;
>> >> +	if (ioend_flags & IOMAP_IOEND_DONTCACHE)
>> >> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>> >>  	wbc_init_bio(wpc->wbc, bio);
>> >>  	wpc->nr_folios = 0;
>> >>  	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
>> > 
>> > Can't we delete IOMAP_IOEND_DONTCACHE, and just do:
>> > 
>> > 	if (folio_test_dropbehind(folio))
>> > 		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
>> > 
>> > It'd need to move down a few lines in iomap_add_to_ioend() to after
>> > bio_add_folio() succeeds.
>> > 
>> 
>> Actually, looking into it more, IOMAP_IOEND_DONTCACHE is used as part of
>> IOMAP_IOEND_NOMERGE_FLAGS. I think deleting it while maintaining the
>> no-merge behavior would be uglier than leaving it in.
> 
> But why was it added to NOMERGE in the first place?  I don't think it's
> harmful to merge writeback I/Os which are COMPLETE_IN_TASK and I/Os
> which are not, as long as the final I/O is completed in a task.
> 

Looks like it was added in commit 34ecde3c5606 to ensure XFS DONTCACHE
completions were actually punted to task context... which we now ensure
elsewhere. Will delete and mention the side effect on regular I/Os in the
commit message.


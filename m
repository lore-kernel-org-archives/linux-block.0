Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DA284896
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677012; cv=none; b=GHi4NTR3VEwMZyokXN/kNirNppjD7W1VeKLGpuoRGip6oi6y2zYx2H1zZPccpZ0xJV4VI0zDQ10GGJnBmC8JrEuVTc9gyCi2paJANMHScMRKor38LKvtG97E4gPK/3pTJt5cG4tFNPeyZ785omZNJhzQjqARkry7JK20Wd3DlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677012; c=relaxed/simple;
	bh=XwPRZu5Ld+QTZqlV+HMue7Ds/fH2LaUK/cZVeqKosVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0ImC+h5P4jlsKVQgwnq+GzGzwUF+kARfsT7Jnr6oHrb9GjrZI2oQ4ayxm2lWQ/AtvnhQBAbcwOJtFUoT8ZOWNGnXssTeXrvlxMn5rWQAweY2XRpjPWCXAqDvmUOR/t9nP32QFRDpA/jcOshTu5oh5RGtmKgnBKyFTwaQQd1yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QA99faMh; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QA99faMh"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638JNXRg1682964
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 15:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=96l/
	i7uyqouj4dytN5MpYVZKfSy3eXi7wDZWJb62Zz8=; b=QA99faMhBQ2CRLNNFL8L
	qRU0KP4xnwNqn7cMfDQW5hCPv6hts7r/Xd5kZaAY3dSC43v6ijdCL1tNUW26zeG0
	i00xv5/w0hQP+E/6FmGItYboGNRG00oqthfvGcLHUjewrJYPfEU7rIUhb+rrH3ZI
	E7MY1V9FjX/Rjvqq6Buhdtpm+GujTj7zgsZPqlGlaK9OmmMVEoPJ8/8i9H/r++Ew
	xasVMLD228PIgjw2pkPCzEZbfiWSUlXyI0hlkxJ+Un5rnqSYBqPbHFeq+tEtIyhj
	R4oX1MgQkBQVvA1CNbDR1nsrNcP1286385FwkRZAdf/g5IG6aI/qI16ZN0btyleO
	5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3n7bx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 15:36:48 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b4031b86dso5129801cf.0
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 12:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677008; x=1776281808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96l/i7uyqouj4dytN5MpYVZKfSy3eXi7wDZWJb62Zz8=;
        b=Y+Np4Fs83ceT1DZ4CGJ4Xifq/UwVn9PJS223WSGn5OqA3WSjZ4L+uaO+cPHR/0/HOn
         WHpG7hFe11rLzo+u3jRDVnv8YfB8SzQD2beiShvOl8X9c8fx3pzfOwT8UMjH10Uj3xpg
         ZOZVZjCEc5a18FmHsF+hJYsq/mLMe8DGBvfPeatWjrbc45RDT/honA/Fg0n+ue3mVoFB
         m31tXX4OjJXN0dGhE/FnefbpyMsCUYaND5in9Ziw/lhTNGH2ifAxnxCtm/JiHfRnz7fo
         S8ZE4tV4S6QZjOkUfeDVsR9b25BeFaL4/YazBLAoIk3TmvCiFc0t89I614kWZ39Eh5+u
         YLtg==
X-Forwarded-Encrypted: i=1; AJvYcCWIBaKrXDXzoVKueWehYwsduRJ+l3iT1P+KeqIIjTaimR6fgskr9LULSeC+BXuORh4/WOLMcH3yVykiNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqNnRH5zF5ZsO4KD3YtA4+WNwr9xcA3xmGOP45cbEuyAKSY3a
	zx0HCqO1z14KN6VDoRaRyDHvz7rOTIpUYGK4D+rxa/xpkoSFQr+mX49drkf585NKHGZ2Z6/KyTX
	BHRcVilmQxsou3jhS3WRRJtqiC0uSq4vLWXZSt7f5wi0/cFU9XCVyAdv0lGw2
X-Gm-Gg: AeBDievnrAj37iMTtz0YVr7VMLlTNHCR+zOWeIkIyEvnihcIiEG25uJGZEO9Kj/fBhC
	3fy4Ebr09xGjXv0rVtdCbqfipYrhw8S3T9QcCZVNwTdt4DZHYciLJngVxcAmosMQJvT/EEY8KyD
	PdTuOOwK0CO9viz8fcRoSTiuK4uQL0LY7EdsK1vHmgSsLjozijmCuIrK+IqTjF78fmnUCkei4Wk
	aDXAvE6xryMkXicTm+O8HkGvsKhe1M9FpWBi4juFQdp09KBwGzIqwwG3TTeueW7AWNoVN0XXnhK
	PiceQp8G1OB60KGFnydF2C+iTpsjJ8E7JJPBNO5HM2nkFyFdxmpg0krYxVg8SU4bb3Lz7PgIYMs
	hAX6HM8mqRyf8Rmpn2kXNJ9K0Io6SHSuDnE0k4hTa
X-Received: by 2002:a05:622a:1a86:b0:50d:6b6d:bc17 with SMTP id d75a77b69052e-50dc212b2e3mr10299441cf.23.1775677007886;
        Wed, 08 Apr 2026 12:36:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1a86:b0:50d:6b6d:bc17 with SMTP id d75a77b69052e-50dc212b2e3mr10298851cf.23.1775677007355;
        Wed, 08 Apr 2026 12:36:47 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d64752857sm142454931cf.21.2026.04.08.12.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 12:36:46 -0700 (PDT)
Message-ID: <c7342d7f-5c92-4a2c-9d00-5f9cf478f4e1@columbia.edu>
Date: Wed, 8 Apr 2026 15:36:45 -0400
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MyBTYWx0ZWRfX+ikKD7kI99Fo
 h1etKW3k2zkIgj1cbOC3AUFuZSd6GuBoK//C63aJgwN/PgGgclaFwhUGr76sulcIH5Ri7EqyN/u
 5jRmgIfu9/wHo6HDJ4m0EB/hQ7ul+O1okOKoeqlXKYwzFIsKHYfrJiu+SViatZj1b0FsZuKDEDR
 LUquBssARauYPgCV61FSQvViY80ByukYMw39ouq2Wgg7yLtTkKG52yVxlW4oIxVlgGmPVsJfZAm
 4Iji8gsIHMamBHidiXiJ3IXGiuAQkMlE7CxAGMtSVxqnXCeVpX8kaqe3mF2PmPwI4pWQfSxQzFp
 n69Du6Wldns60bM+GQjXYY3ujG66r0GiI24hET3KGFWrAegFKgAxe2q7wFqenS4IGJgua72+7kT
 cmkoq+9OrZWAV9IGT4GcV4044SJ3J7Pt4QCEPlT9gFrXfb6l5eEvwEO/LrVHROmBL6U1wLv0hgW
 yfdEymjENaOrq8ILBcA==
X-Proofpoint-GUID: iEKRDcGHwAyVVbn3vB_MjqbtsHYhCfh4
X-Proofpoint-ORIG-GUID: iEKRDcGHwAyVVbn3vB_MjqbtsHYhCfh4
X-Authority-Analysis: v=2.4 cv=N9AZ0W9B c=1 sm=1 tr=0 ts=69d6ae50 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=fDzNMwFgse8Xf2NrkjQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=10 bulkscore=10 priorityscore=1501 clxscore=1015
 phishscore=0 impostorscore=10 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080183

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

Will do, thanks Matthew!


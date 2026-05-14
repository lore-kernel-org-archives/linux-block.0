Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8B26A1CF
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783460; cv=none; b=F+cN8MGhUsCLCByQI4wD2xTb7+csOn8SusO9swVmyydSb5DaouB/w6/3Fe3fMqgoPjViWyg6CnD91aEm5tKxeX6C2ygaCUb4Ek25i8kd5TRUrrUNYeo5rgTbqIhjugsXowtUYc/nwJlShNbzbxUEOUGGeV3w2rmgSkqpG1IM0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783460; c=relaxed/simple;
	bh=sBXDLpHn+FDmACYj8iVCL8mnydrKrBAMrYu3fP5qGe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKFKws7uJo8/YF56bT5O8o6BTuJ25PieyAa5yXjjxI0NpXFcicxNd0nWlJTNP2mvqrSsSIqC37qgP3s2JrhhhIQ1ACTn1eSy5epC6meddtm1+OPVAa1wELUCXIAhz68WpBw6KqnyXpyrPVSlBqFeHeBUomvkbPay8hhE2bMoDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=aEiW1vgo; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="aEiW1vgo"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EHupXm1891145
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 14:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=dqki
	LvRS0biC8wDTf7mWRqTHG4xr6lw6pw3nx+LivZU=; b=aEiW1vgogj7n5YcW6NHF
	YbDTonW54xw3FqAAekPPADUwCORx5bTzh7grpXCPPXfwnH6gVmeTcev+Dnh0bG44
	Il1GBqAswROlkVnubEUDPgMfEWWkWMpwoTuXyoaWapqNM4RLXTGrhbIRlnATX3Oz
	RhYkbCg+r8A3AD6O0954cUbQwfKwGI774KaY1uZ2jMw+pFfk2tbhcisGBL2Ez+5e
	gTCP3AyeSdrj5oaw3jxqG/tI7y1jI07auVhmJqvKafZ0nm67VdKe2Caet6gdgAyn
	DfuVt3CESQv1iyvQHkMmz1MwNC6RvKQMkvR5PeKvn323GXRBuH58ptK/j1ZnBdfC
	XA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4e5bbav053-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 14:30:51 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d812c898cso199392511cf.1
        for <linux-block@vger.kernel.org>; Thu, 14 May 2026 11:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783451; x=1779388251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqkiLvRS0biC8wDTf7mWRqTHG4xr6lw6pw3nx+LivZU=;
        b=hLKL12WaDHnoKA0F0hX394r8tK/Ws6LxVkkIXBe1BQ1YtTVGyLS0UDWiiI1B5/+vBr
         jFJLUucl1QqFoWC+5HV0zD2Abw/fsuUhDwBZO80d8HuVD6FTNr7F0Z0Uv2C/OGCDhEH9
         HCmnlItS1Yi/RyKeXw8e+Cz5AYmaWb21Cr/8oI00g66htpqleN2POgkhRsf70ty36mGc
         7hswWRDkCFK6aZ5ZiFKCK+36kjKQNb4vGBXYleiw4z97lKDOR9jUDUhNm6mP3BlUKHPw
         UaRmRwarQFOJk5AF+YeqtBqAy+FpSyjAl0N/vsjn2ibbI9Kg9Zc3ZNKKryuZlnGEAhlR
         atxw==
X-Forwarded-Encrypted: i=1; AFNElJ+2Jn3M1GCqmf5MU1s0GCNw/PVLX75ikRZhWeNlbOHmUt/ZTclK+t7xrcsFFdf360Q3kmTkDBZxT2DbkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4HXCiT+2UM5VZx/r2O3ff302ln8nm71Zo8Xi5zhBWljyGEbR5
	SOSxmOcqabg31zK5LUVxLd1oQUbW0mTOt9MOZOMMUCL7mtROv4RJohmG0+S6B6YEFdaYGmtNNGC
	+lIKbkBn6QWCNwbSma1RYmYa55cUmCoKLNnhnPZrVerCP14Rx1Y31fgVQXTAX
X-Gm-Gg: Acq92OEoFDtW1a++eUXPiZiA/V8T1AJYZVQQpjvnFo6ilu8f/rfleiLblJ/6jgWq3IB
	soi2IpTnW+/yM82qvQC3QSEDZrcJ5BxC4DAyJ9gZawIRXfGnyHSIvzpJSUI8DGXECKc1iWFLm6l
	4Nl930RvDShVmrZ8ChyxtHfmrrEz3G08e7gHwmYzykQl+Gb9ON6l18EylehxCDwuNJrHF1V4QDU
	0DpD2l499TR3rGcdtS81EDE3n4VnDPNAZOjRX1ymZ3+whPuwyKeSy3XNv8MOltUsRL6KT3UoDzt
	n4Kr2Z6C0RY7DhbgGVn43iGbfVkpZia+Wkyr/0Xv9VQ9oyGmmRiml8dJht5y49hm8LKN4mIkuSY
	Aybr5idst+0AX5kfC7xyjB4HtTJkC6sY2tTdJrndmzc35hV8=
X-Received: by 2002:a05:622a:5910:b0:50f:c26d:f309 with SMTP id d75a77b69052e-5165a007037mr6567431cf.9.1778783450603;
        Thu, 14 May 2026 11:30:50 -0700 (PDT)
X-Received: by 2002:a05:622a:5910:b0:50f:c26d:f309 with SMTP id d75a77b69052e-5165a007037mr6566801cf.9.1778783450039;
        Thu, 14 May 2026 11:30:50 -0700 (PDT)
Received: from [10.206.44.99] ([129.236.229.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm12008351cf.15.2026.05.14.11.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 11:30:49 -0700 (PDT)
Message-ID: <18dd3936-9ca7-4c34-976a-a0fa09dde238@columbia.edu>
Date: Thu, 14 May 2026 14:30:48 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] iomap: use bio_complete_in_task for buffered read
 errors
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260409160243.1008358-1-hch@lst.de>
 <20260409160243.1008358-7-hch@lst.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260409160243.1008358-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eKQZkrF7A1Auqz08NK2TmXoyjfUxU67q
X-Proofpoint-ORIG-GUID: eKQZkrF7A1Auqz08NK2TmXoyjfUxU67q
X-Authority-Analysis: v=2.4 cv=N7kZ0W9B c=1 sm=1 tr=0 ts=6a0614db cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=nkegbr1AwBRna+m8FBH0UQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=f7q37D0tNRou1Q5H7aAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE4NSBTYWx0ZWRfX2x0LyUQV+21n
 QdKhgSUvU2lr76x9ZTN0cJvFZ9HCX+RjILk/5fush+HgsChjzct5LjlkUQhOZgCKO/Z1Qk66/kH
 IQSelcdrfXkRUvZmV1qLMaX6gJRq10QwMQTanK69IzXc8H5iXKuCwyo1QZ2YE9391S3IkBGXivk
 DcYnSLMwpVdYJaPwZBlX7hA1UDX5LN09h33UUtlE+eCfn5IzVEcMlT/tzBqINDQ/hZSCpsNlqi3
 /5V9vKz1YBkXIXOy52/imogvqmnClqZQKVQ/w74pJ48csedsPHCQyEohoG9nuk6HEBwplgTEweQ
 CTFkK269jqI2EroKSDZTn9CDLKPZvJhV7BtYvG7Fzyo7eZAE3bBtPmqsD+ijcb0f2Mh6uPVFwx4
 VW94Wjy/n52GTrYAdw/QkvmtYakL/nmb9sHpr647PNkM5HQA35e3sO62YOrZbGWn+/pNbz/RNzz
 mz47g1q/QNgQqJPb7Gg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11786
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 suspectscore=0 priorityscore=1501
 lowpriorityscore=10 spamscore=0 phishscore=0 adultscore=0 bulkscore=10
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140185

On 4/9/26 12:02 PM, Christoph Hellwig wrote:
> Replace out own hand-crafted complete in task context scheme with the
> generic block code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/iomap/bio.c | 44 +-------------------------------------------
>   1 file changed, 1 insertion(+), 43 deletions(-)
> 
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 4504f4633f17..5b9b91198ec8 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -9,9 +9,6 @@
>   #include "internal.h"
>   #include "trace.h"
>   
> -static DEFINE_SPINLOCK(failed_read_lock);
> -static struct bio_list failed_read_list = BIO_EMPTY_LIST;
> -
>   static u32 __iomap_read_end_io(struct bio *bio, int error)
>   {
>   	struct folio_iter fi;
> @@ -27,49 +24,10 @@ static u32 __iomap_read_end_io(struct bio *bio, int error)
>   	return folio_count;
>   }
>   
> -static void
> -iomap_fail_reads(
> -	struct work_struct	*work)
> -{
> -	struct bio		*bio;
> -	struct bio_list		tmp = BIO_EMPTY_LIST;
> -	unsigned long		flags;
> -
> -	spin_lock_irqsave(&failed_read_lock, flags);
> -	bio_list_merge_init(&tmp, &failed_read_list);
> -	spin_unlock_irqrestore(&failed_read_lock, flags);
> -
> -	while ((bio = bio_list_pop(&tmp)) != NULL) {
> -		__iomap_read_end_io(bio, blk_status_to_errno(bio->bi_status));
> -		cond_resched();
> -	}
> -}
> -
> -static DECLARE_WORK(failed_read_work, iomap_fail_reads);
> -
> -static void iomap_fail_buffered_read(struct bio *bio)
> -{
> -	unsigned long flags;
> -
> -	/*
> -	 * Bounce I/O errors to a workqueue to avoid nested i_lock acquisitions
> -	 * in the fserror code.  The caller no longer owns the bio reference
> -	 * after the spinlock drops.
> -	 */
> -	spin_lock_irqsave(&failed_read_lock, flags);
> -	if (bio_list_empty(&failed_read_list))
> -		WARN_ON_ONCE(!schedule_work(&failed_read_work));
> -	bio_list_add(&failed_read_list, bio);
> -	spin_unlock_irqrestore(&failed_read_lock, flags);
> -}
> -
>   static void iomap_read_end_io(struct bio *bio)
>   {
> -	if (bio->bi_status) {
> -		iomap_fail_buffered_read(bio);
> +	if (bio->bi_status && bio_complete_in_task(bio))
>   		return;
> -	}
> -
>   	__iomap_read_end_io(bio, 0);

I think this should be something like:

	__iomap_read_end_io(bio, blk_status_to_errno(bio->bi_status));

Otherwise the error is never propagated when iomap_read_end_io() is later
called from task context. Maybe worth rearranging slightly to avoid the
blk_status_to_errno() call for non-error I/Os?

I was planning on carrying this and 7/8 in the next version of my series
so that the procedural version has users, but I'll send without for now.

>   }
>   
> -- 
> 2.47.3
> 


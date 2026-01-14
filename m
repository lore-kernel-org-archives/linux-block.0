Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB011D0DEE;
	Wed, 14 Jan 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394749; cv=none; b=bHiLrECTwBzOx2Xaf2OOagTcScTsy6Xp87j3vL2YbPW0iP1HePhjcOnIbuCqtdLq99d12vsGyD4nzAAlhPtjKObf53vJiHzlJRett6hL0gc6DTdAQzzyvHdtuuwK3yxGGeF6eSc8rOVpVg9y/BsGIs9a9mbpCr0n1d9ySHJGDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394749; c=relaxed/simple;
	bh=Vqo9DURxpzPQ+KJ4W44yz2L9R/yyGNIsJHVgPJnIi9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R14PjSZ7GOyYW7s3Y6PwApHQuQMHwWJKavQnzD/huo+XqpmZQHo5TLZSV4Lb3ZgzJevJnT78WUfT3UpdmRDKr7pB35qLAQlofxMfDU/kSaiBK2kvx5LKUEM3n6qIrxgBy6z6AjNmHnsGc8SQPESGQdPbQ2O/9K9/9iyTV/2cGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lB7tLl+l; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lB7tLl+l"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EBY4Hr1562086;
	Wed, 14 Jan 2026 04:45:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=/mbzjjpPpsVzlkiMoi7YIoiToKWvmhWtEUDnWSeDPQ8=; b=lB7tLl+l2I1S
	ofzL/aelsqyH+NKrxmfXvEXhmAMb1fRqdpRbFVOFzsxxylyDNsaLjc1KO1vJSZtg
	D85wfPdQK/z2Ugank7CIE5aRW70AdZEUYIMwxTHKbvPKpD6IQMzbwXEBi9n/EkQm
	ysyjc3lkZvv18QOqjLfBWYUtaxm+zPQ4TZQX1OmvM6BVl+EpVRKx5t4XR/IgkNPH
	8H/G3mPOuN+aTzDcoM155XSR4sDw+Q+eem8y+Kzn9ItBAXCydUdxfd5UrEmtuChc
	0/t363IdtEcK6MnOwcRy7jlg8OPQULvaTWN+DFKikpxoEhHYcFx2p58mGcfvJXAi
	eDp7wj3bqw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bpact8f94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 04:45:38 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 12:45:36 +0000
From: Chris Mason <clm@meta.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
        "David
 Stevens" <stevensd@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] zram: use u32 for entry ac_time tracking
Date: Wed, 14 Jan 2026 04:45:07 -0800
Message-ID: <20260114124522.1326519-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d7c0b48450c70eeb5fd8acd6ecd23593f30dbf1f.1765775954.git.senozhatsky@chromium.org>
References:
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oZjgV2DufGzTBOccm1TJGbVQnIOX0PPd
X-Authority-Analysis: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=69678ff2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=cm27Pg_UAAAA:8
 a=XjV5nGeaLPyDJ1P11u0A:9
X-Proofpoint-GUID: oZjgV2DufGzTBOccm1TJGbVQnIOX0PPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwNiBTYWx0ZWRfX4Bbro2YFOdmr
 WvZ7hQLyaHbsDQwXHz4cWEw+UB2D9Kph4AH+X9S5H2IdPfk3msQo8bgK51MR2xCWCERBunaFKeR
 IbUpS/ZV5To+zgtKg8PqhICjPK2FES/4aki85aVyqUhLKBQQJdbXvOpn/S+BoZT1ptFDpyUPrTV
 CR9r3ZR/zCqClq4GslGkAy7XMKZTjukeOLkjANqcCJMoRkOyJmNnVB5kLNt+2iIrcRwXNzh0zdP
 Mc1fQ6XBUO6ohFRj+19+IojcjtrIcihQ87t6smv6GUO22vL0Kuvjuscei5gOI7AImsKBU8EvEBT
 yKfxbSWURDRD1FkRCXqyjCU0oLkfLGt313mNq6zzg12WA2Yzihv+gtfX+rua8pWED5Z27VkpCgd
 AUXGEr8Zi6PiiCWW698Fftwrt0yuYfuWqLAY2SYFVKznDaLftH7RSSO6GbUA3EYe5mI2iO0Efmf
 HdgMUJvwnNyREGhzVVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01

On Mon, 15 Dec 2025 14:47:11 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> We can reduce sizeof(zram_table_entry) on 64-bit systems
> by converting flags and ac_time to u32.  Entry flags fit
> into u32, and for ac_time u32 gives us over a century of
> entry lifespan (approx 136 years) which is plenty (zram
> uses system boot time (seconds)).
> 
> In struct zram_table_entry we use bytes aliasing, because
> bit-wait API (for slot lock) requires a whole unsigned
> long word.

Hi everyone,

I ran mm-new through the AI patch review prompts, and this one was flagged:

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c

[ ... ]

> @@ -222,7 +221,7 @@ static void zram_accessed(struct zram *zram, u32 index)
>  	zram_clear_flag(zram, index, ZRAM_IDLE);
>  	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
>  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> -	zram->table[index].ac_time = ktime_get_boottime();
> +	zram->table[index].attr.ac_time = (u32)ktime_get_boottime_seconds();
>  #endif
>  }

This stores seconds in ac_time.

[ ... ]

> @@ -1588,7 +1588,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
>  		if (!zram_allocated(zram, index))
>  			goto next;
>
> -		ts = ktime_to_timespec64(zram->table[index].ac_time);
> +		ts = ktime_to_timespec64(zram->table[index].attr.ac_time);
>  		copied = snprintf(kbuf + written, count,
>  			"%12zd %12lld.%06lu %c%c%c%c%c%c\n",
>  			index, (s64)ts.tv_sec,
>  			ts.tv_nsec / NSEC_PER_USEC,

ktime_to_timespec64() is defined as ns_to_timespec64(), which expects
nanoseconds.  Since ac_time now stores seconds, will this produce
incorrect output?

For example, if ac_time is 3600 (representing 1 hour of uptime),
ns_to_timespec64(3600) would compute ts.tv_sec = 3600 / 1000000000 = 0
and ts.tv_nsec = 3600, resulting in "0.000003" instead of "3600.000000".



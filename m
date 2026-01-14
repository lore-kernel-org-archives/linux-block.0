Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159FA356A24;
	Wed, 14 Jan 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394241; cv=none; b=macpZ4i70+VvxYKA29cgy9FVrs4fQ7Uw50yuyXM8TwfjX5oHcrfhtOfWWHhwyNXclMOJhCBjCVdR1rembcbllRWOn3TJCMDEAt50LQgiN+9hoWg8cKA3/oKE2sUBkoNZOU+7NlIRJflvRrvuglGUMzs4sOLcXEJZZkzC2qVWzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394241; c=relaxed/simple;
	bh=I5JF8w2pHixeJKJNyd9MfZgNXL9xnAENGugUSK9zioY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhtUwJQfGboisbv5brrcHD0kOGFTtEPI4AV+lgLrPcO+BNiAB5R7XBSOSDwSSBynDc45oYjeChzzbToHXqqP5wUoeZxXFgVFOqaKKC4TCXXNdoVbtX9gQiDqMTYSQtOg7PahAlbCKgA/3YeS61JF34KNowEEYWG7mhgAgHF7FmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MCDkIVJu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MCDkIVJu"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E3oNMk970127;
	Wed, 14 Jan 2026 04:37:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=rl5dmfTpOqb6nmXRmMjziUP1h91ZxP1IGb2cOMuPhG4=; b=MCDkIVJuJ6UK
	kYOwjf0/6uew79opwH8bG6BqPmgKEx7zS2dK5bGtdRw7MApC9vXnvqNBfZk7IpGd
	GrmeIAkU4G9kOx3LPR+4rWKAmN/u2h6wnVQ4jD/R0zMF2aPwC0ENujAAM0z01bi3
	p6g88fLGbTRKbUgNdLYaR2OOoV7fS/yGbTMFnHQ2iqlTYDY/z/5/RJBcS1ALQKdv
	I/JCnufu6ubRDcmgoq5bt1MujvWqZjeSVs4gNzv7TGrmA67TIh7/RX0HTQuvD1Hj
	I8EMy4gueedpNMs7FU8yNzEdBYtgSTVx2ovG2QfcCFtVXCYTkqmWl1GV21GMcOP4
	oYJh9gI6Jw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bnuxc6t0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 04:37:11 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 12:37:10 +0000
From: Chris Mason <clm@meta.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
        "David
 Stevens" <stevensd@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] zram: rename internal slot API
Date: Wed, 14 Jan 2026 04:36:54 -0800
Message-ID: <20260114123658.1231407-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <775a0b1a0ace5caf1f05965d8bc637c1192820fa.1765775954.git.senozhatsky@chromium.org>
References:
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rf_1snwYzoHiJENk1_PLmMUp08i5UTY9
X-Proofpoint-GUID: rf_1snwYzoHiJENk1_PLmMUp08i5UTY9
X-Authority-Analysis: v=2.4 cv=ZfwQ98VA c=1 sm=1 tr=0 ts=69678df8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=cm27Pg_UAAAA:8
 a=rX5dzeJzlTyKBjE-IuUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwMiBTYWx0ZWRfX70vd2EiqxqbB
 GpdUDkV1GtatYuA/ytMlzPeqU4OcjX9h+tnu/z6cX2tavHVnQpNJ0s9V0BgVOKKoLu/g1q8D/fL
 qllvYp6f5JOSrpOt/ziXB7Jf1Zl7rPS8skPi4HFn2fv8274uCP7YputbbfXIWAmHJKRohU0VrFx
 Mza2bU/lbERaLF2YREJ/sUZGFq4D5MCtngsG9x7Ahp6C9qR7dGYvvO8Fhm4WcbR50WjBQELwr0c
 HYH8bHoXlwSrXLTtV4Cfu55yoErMYtCgk0X55VycPUwqpuMaVHHE3cjWp6xGtmr+Ed+vCrMP0l6
 Q4orfFbm0LYMgYskxID5lvHBzaQOfUJYami4EvQBooLygGxLzRyGwjl7VbavW7T30g/Rg5NdMfI
 V0dzeSV9OfP0NiuTQoIPWk04WLpDSe5bXvBTIXM8kdhL8z4EOKeBJPq/XWltHKZz1PN0D0QkhYL
 kZTkHuKI8OhW4v68Q7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01

On Mon, 15 Dec 2025 14:47:12 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> We have a somewhat confusing internal API naming.  E.g.
> the following code:
> 
> 	zram_slot_lock()
> 	if (zram_allocated())
> 		zram_set_flag()
> 	zram_slot_unlock()
> 
> may look like it does something on zram device level, but in
> fact it tests and sets slot entry flags, not the device ones.
> 
> Rename API to explicitly distinguish functions that operate on
> the slot level from functions that operate on the zram device
> level.
> 
> While at it, fixup some coding styles.

Hi everyone,

I ran mm-new through the AI patch review prompts and this one was flagged.
It uses a lot of words here to suggest a copy/paste error, but it does look
right to me:

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 65f99ff3e2e54..f00f3d22d5e32 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c

[ ... ]

> +static void mark_slot_accessed(struct zram *zram, u32 index)
> +{
> +	clear_slot_flag(zram, index, ZRAM_IDLE);
> +	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
> +#ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> +	zram->table[index].attr.ac_time = ktime_get_boottime();
                                           ^^^^^^^^^^^^^^^^^^^^

The previous commit (472f3f208d78e "zram: use u32 for entry ac_time
tracking") changed this from ktime_get_boottime() to
(u32)ktime_get_boottime_seconds() because ac_time was changed from
ktime_t to u32.

This patch appears to revert that change, storing the result of
ktime_get_boottime() (which returns a 64-bit nanosecond value) into
the u32 ac_time field. This truncates to the lower 32 bits, which
wraps every ~4.29 seconds.

The result is that mark_idle() will compare ktime_after(cutoff, ac_time)
using a truncated nanosecond value, causing pages to be incorrectly
marked as IDLE almost immediately after being accessed.

Was this change intentional, or was it accidentally reverted during
the rename refactoring?

> +#endif
> +}

[ ... ]

> -static void zram_accessed(struct zram *zram, u32 index)
> -{
> -	zram_clear_flag(zram, index, ZRAM_IDLE);
> -	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
> -#ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> -	zram->table[index].attr.ac_time = (u32)ktime_get_boottime_seconds();
> -#endif
> -}

This is the original code that was correctly using
ktime_get_boottime_seconds() with the u32 cast. The new
mark_slot_accessed() function above should preserve this behavior.


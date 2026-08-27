Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8804503FC;
	Thu, 27 Aug 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835386; cv=none; b=Y7vU/9TbkKwBrSDOabHtxLZhhdfabmImAiX6fRxPU2wmZDm17s78Yu2O8/ZXPjCvZOiDM0Pfh7MO3tM+SfarwhXeg66LBmTKjQC2gTmA+MBfpfMGWSShJhvE31CTw4AxwbtHtGimo9WMK4h1BPJRe6AgpoW6R7kL7EHr2LiCt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835386; c=relaxed/simple;
	bh=yjfAd5HzqoftbhQaKFAEymWiks9xoHxKsZAGMnolXHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4shf0TiE7wC2yxwBiwwrlXx6SUbDI4rIhBHJz6iU6+RojokbdEl27/nDZjObwpkHZi9ZG1V4/dcI/hk8Cw8ZgZGxVjcEknLiXcWSaltAQkIk2I6gMm9SQ2rxmGJxrXjHseKvbMHtqTaUsNLMLKnMqwOsZVyfSXtAgf9/IQdmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f6tlP77p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f6tlP77p"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVgnU3056614;
	Thu, 27 Aug 2026 12:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3Xd30D
	SJ7NtPUCB5YLdv6K4XXDXekQyh4v5AohRuQOg=; b=f6tlP77p8rsDqNanHBg/mR
	SFGPnMureofD0asnngvcFKDo1/sP6tQt0475avRXaPbc2QxyqbUp1AlJG20SeTMc
	sLVkKA3qCxC4LnbQsNlsKc+QI6bcGSVR77XLc7QwJguy/jkUaOtk/2lrcFU6jRYP
	NZM7RtRSjdwW2OWYm6xzCk/6bEqW4+qOnJiAohRg1XLESISnXo0XCNoanbxbTIW8
	o/lDL0ILnkYWF5nCB1MXrSHCtJxvoTmcY8UWvDma01tZ1DqxfsgisB/DDzzrTVFP
	265jNcHiVrtIYEIWlUX8isemob51/tcmfeFlDFnCJb5D6FdSMTJIkwPEnXF7AcZw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxn25s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 12:55:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RCfLlo031321;
	Thu, 27 Aug 2026 12:55:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k82uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 12:55:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RCt9m049938804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 12:55:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA13C2004F;
	Thu, 27 Aug 2026 12:55:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0B2120043;
	Thu, 27 Aug 2026 12:55:05 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.92.98])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 27 Aug 2026 12:55:05 +0000 (GMT)
Date: Thu, 27 Aug 2026 14:55:02 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ackerley Tng
 <ackerleytng@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Baolin
 Wang <baolin.wang@linux.alibaba.com>,
        Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
        Christian Brauner
 <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Christoph Lameter
 <cl@gentwo.org>,
        David Hildenbrand <david@kernel.org>, JP Kobryn
 <jp.kobryn@linux.dev>,
        Jan Kara <jack@suse.cz>, Jens Axboe
 <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>, Kairui Song
 <ryncsn@gmail.com>,
        Kiryl Shutsemau <kas@kernel.org>, Lance Yang
 <lance.yang@linux.dev>,
        Leonardo Bras <leobras.c@gmail.com>, Lorenzo
 Stoakes <ljs@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Matthew
 Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
        Minchan
 Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar
 Salvador <osalvador@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, Qi
 Zheng <qi.zheng@linux.dev>,
        Rik van Riel <riel@surriel.com>,
        Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,
        Shakeel Butt
 <shakeel.butt@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil
 Babka <vbabka@kernel.org>,
        Yang Shi <yang@os.amperecomputing.com>, Yu Zhao
 <yuzhao@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>, Zi Yan
 <ziy@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
Message-ID: <20260827145502.2fb4505b@p-imbrenda>
In-Reply-To: <2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
	<7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com>
	<20260826155722.0198d3ce@p-imbrenda>
	<2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwNCBTYWx0ZWRfX0TZApJLkdtZ1
 PtE0rU7ktQWVARMaJcd4vZ13/G8yHyRHM4u3EkB+SbNKBO7mZMEKkD16iaWBwlYzwAuGe9vvOym
 vJ2I67XiTk6YxR75ZgRBPBeAYkBQUSQ=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a9033b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1XWaLZrsAAAA:8
 a=QKwNBufzpuw2Nls-StEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Wrj_BCzufVTI3xnHE8uI4nTHpOZ09pgb
X-Proofpoint-GUID: kiq6mmh02NZYDyKGi_UG9okOaLOjTkKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwNCBTYWx0ZWRfX/GC60VEqff6H
 AD+jIFLFniVC/xqIljwSPxusJt+WASSapWED2IMDwJBC5s8SXEzQ7Lw24xM/z5E8irvqBHKEEA8
 TsW67q+rmn+Lv2a7dNWCRh2BztVeZUoe2yVSmLtzBxu4rSqHQQAV3yZwxg5jvqh6JgjK8wxQTwN
 3f2mo07mhERoXsbSGoy9prIWB/8kUt2YRvv+WDuqqOPTiMOVQvYC3s2bpCow5iwFaWuISYM30QX
 IA2ZK7TtbtOUmEorzZpatwwaRI0Ydek+gChszZuyQyDyn5QQQneZm2xxTgg8aOPFGoO1Y5kjqnF
 He3CpPU3+3/7Wld3khcvM4hXDOZAoZ60mnpZh92cwtJeFc+WqcM4HxUKlExo1CuVoR42aresGwi
 PPIFJufe7OMchwSCXeYh1nHaPgz62e4WIlmmffUFctzQbF0Lfap2jfKSgXzReFafxjYYHG69fSV
 zPDUH3nxbniYRLw4loQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270104

On Thu, 27 Aug 2026 01:49:12 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> On Wed, 26 Aug 2026, Claudio Imbrenda wrote:
> > On Mon, 24 Aug 2026 07:39:12 -0700 (PDT)
> > Hugh Dickins <hughd@google.com> wrote:
> >   
> > > s390_wiggle_split_folio() has no good reason to lru_add_drain_all(),
> > > now that the per-cpu fbatch references are gone.
> > > 
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > ---
> > >  arch/s390/kernel/uv.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > > index dc14ebc0105b..120a467026a5 100644
> > > --- a/arch/s390/kernel/uv.c
> > > +++ b/arch/s390/kernel/uv.c
> > > @@ -364,7 +364,6 @@ int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio)
> > >  
> > >  	lockdep_assert_not_held(&mm->mmap_lock);
> > >  	folio_wait_writeback(folio);
> > > -	lru_add_drain_all();
> > >  
> > >  	if (!folio_test_large(folio))
> > >  		return 0;  
> > 
> > This is black magic for me, I am not sure I fully understand all the
> > details, but what's the new purpose of lru_add_drain_all() ?
> > 
> > will we have a guarantee that no stray references to mapped folios will
> > ever remain?
> > 
> > Any unexpected reference (i.e. not due to mappings, see
> > expected_folio_refs()) will cause a protected guest to hang.  
> 
> I most certanly don't know s390 or that code well enough to guarantee
> you that no stray references to mapped folios can remain there. What I
> can guarantee is that no references, of the kind which lru_add_drain_all()
> used to be needed to remove, can exist there: so there will no longer
> be any point in s390 (or others) calling it for that reason, to help
> split_folio() to succeed.

we are not using it to help split_folio() succeed (although that's a
pleasant side effect). We need it even for small pages, to guarantee
that no extra reference from LRU is present on the page.

you just mentioned that, with this patch series, no such references
will be there, so that would be enough for me

> 
> You wonder then, what lru_add_drain_all()'s new purpose is, why it
> still exists at all? I did hope to remove it completely, but found
> two usages that I could not argue against: one is in user-forced page
> reclaim (two memcg interfaces and a sysfs interface), where it's
> still desirable to push folios on to the immediately reclaimable LRUs,
> rather than leave any on the per-cpu fbatches preceding those LRUs;
> the other is in memory hotremove, where it will be necessary to erase
> stray addresses, through which a subsequent folio_try_get() might have
> accessed a struct folio which (I imagine) might have been freed.
> 
> Yes, your split_folio() may still occasionally fail, because of
> transient references and folio_try_get()s on that folio; but that's
> so before and after the changes. And there is (in my mind anyway) an
> open question of whether "folio_try_get() blips" will be visible a
> little more than before.

yes, it's fine if there are transient fails, as long as this won't
block indefinitely (or for extended amounts of time)

> 
> Hmm, looking again at s390_wiggle_split_folio(), it seems rather
> odd that it was doing an lru_add_drain_all() at all: because any
> large (hence splittable) folios have themselves been immediately
> flushed from the per-cpu fbatches, not left queued up there. Maybe

yes, because as I mentioned above, we are not using it for
split_folio(), but to guarantee that no extra references are present.

We count how many references are present, how many we are expecting,
and if any extra are present, we do the lru drain. If after the drain
we still have extra references, then we try again, in the hope that the
extra references go away quickly (i.e. we expect the extra references
to be due to I/O)

when a page transitions from "normal" to "secure-guest owned", we must
make sure that no extra references are present.

> there was an earlier time when mm did not enforce that; and Barry
> is currently looking to relax that, so the limitation intended for
> pmd-sized folios is no longer forced on the smallest large folios.
> 
> If Barry's relaxation goes in before my drainage changes, then
> there is value in that s390 lru_add_drain_all() in the interim.

hmmm so, should it stay for now, then?

also: I'm working on completely reworking how the transition from
non-secure to secure is handled, with the explicit goal of getting rid
of that kludge we are currently using. That will also get rid of the
lru drain. But it will take some time (I hope to have something by the
end of the year)


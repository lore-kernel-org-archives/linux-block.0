Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA046A603;
	Fri, 28 Aug 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929729; cv=none; b=NaSGZCyxI0dQJggxIVE6k1er/RmIylXN/RfrIOfegN4ing8Qu0pHSocf7rmgrUXadhD02H7UNrKj6NbN4RF8ILvt6mndLRvgPVHPTFUQJmgNPD7u0Lrxt27qQgsAWcn9OiMgnBJsbJyuxi83lyEySzxKKDqpQklzCSBRBbDGrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929729; c=relaxed/simple;
	bh=VdL5Ez1TP9OEdhEYgAp4psPvS1MFoZ44aSZbnIms9RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hq2HPOiTdX/85GAOBHlnM58NUiXxykgJGuFzRNuCsLv6O5OEJXNukCDw6wJbY9HP1/9sXUJFxgliWx0NPvOhSezK24IeJVKqe78schVXCt76MmSn4lz/mfHiv+q0zG3Kuf17aHAzz+OQJDIZ8iyCRsiTSc/eApQiNpSl+hcux08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cVQ6kEee; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cVQ6kEee"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVgsu2186259;
	Fri, 28 Aug 2026 15:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R2ReIf
	cU6q09mU3umuATDMJX0HzmPeiVXkiDg/a3WZ0=; b=cVQ6kEeeIOBZIof5NJlQup
	ylyV/I1zq0HtB5g6HlEIjL3uqD0k1SbkZ2e4sqztn2MOZqxPYrDZRqlsqF+aHzIt
	k/FfJkqgrkyYNvpM6+23MBXi7QfwidYK0jynJxvuMQCv9vMMeFnJH+hYoq0b2CS/
	3HZO63xQNFrF9UiE+le8kygr//DrJGZN5QszhHZ9lu0eOwz4+MIKwgDR/cImP2g6
	FFcLF+UKgAz/DfwcqxC9jKw+pme/G3Kx03KAbHCmgS8EKBEmd9yvnGttbR45TjrF
	umlVhg6AdVlHo96/zr40P3V65wc7z65Q8113Zx5GaX8HZiAl6wPOqnQAXEJM+pOw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxvpvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 15:02:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SEuQUI021766;
	Fri, 28 Aug 2026 15:02:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qq5xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 15:02:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SF2J3G32899538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 15:02:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A081620043;
	Fri, 28 Aug 2026 15:02:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F3520040;
	Fri, 28 Aug 2026 15:02:19 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 28 Aug 2026 15:02:19 +0000 (GMT)
Date: Fri, 28 Aug 2026 17:02:17 +0200
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
Message-ID: <20260828170217.324c3445@p-imbrenda>
In-Reply-To: <cdbaa4ff-d2b3-34bf-dd41-01fdc65edebe@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
	<7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com>
	<20260826155722.0198d3ce@p-imbrenda>
	<2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com>
	<20260827145502.2fb4505b@p-imbrenda>
	<cdbaa4ff-d2b3-34bf-dd41-01fdc65edebe@google.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMCBTYWx0ZWRfXxHuti5Dj527N
 FiuJvw5RRjbYYN3JC15bUZTx+KDTxKTF+YzVq/ezrl4g++dGepSXXGaZVPkOm4cymppJdcuSX9P
 xHXurASEMTrGs5t4EgR5ewb+tDvOJx0=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a91a2ff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1XWaLZrsAAAA:8
 a=fg8ePjUzgZY9LUZ9XEsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: FQUAcCuNRcSdPaHF-8xMvR4ns_OVsTxc
X-Proofpoint-GUID: tqGOyE4oqLz6WkdSLX2ygEk1_1IVTp04
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMCBTYWx0ZWRfXxRCLSM+4Biti
 Tjs1pSPmVVcJoKO+z3p0Dt1SG8YQgEPKpDMcG/eaCrZOoFaJ9AFvVCkax+818IAsE8Uegm/xMgc
 0/cwTHHY1YoT+gHc2fQNCwnZjlqu8AMiNWqlapdmKpzZAI7HmUo9CZmuCr4hKdlqp73EVEnoMQy
 pNu+pSs1Oh5o5El/K5kbtrI3W1AkYZed0rHnRnt0tO0sNPiWOCoAByfFwGIAsvi7TeogT7IPnrz
 rEK5ADmyOmerpw33FysddOMskKC+kTa4RWJPGyi68ppeQBBFXXcl18hqGrkc6lRFa6ihlHhCE4q
 7IxqQuA/dq4h5+4ff08OmadKB3LkyhDSwC/7Tn9F+zXd6tMPaZiCnf6QPDmTqZeiYwun+8DLvlg
 fVFgNWQR+c2vPwMIpleETyofoCHhb4yzDx9NL7ik/gqTM/j2gQVlp7eELE7d2jk5a3NuP1eA1X7
 H+giiQLr8LQcrtD41UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280130

On Fri, 28 Aug 2026 01:57:25 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> On Thu, 27 Aug 2026, Claudio Imbrenda wrote:
> > On Thu, 27 Aug 2026 01:49:12 -0700 (PDT)
> > Hugh Dickins <hughd@google.com> wrote:  
> ...
> > > 
> > > I most certanly don't know s390 or that code well enough to guarantee
> > > you that no stray references to mapped folios can remain there. What I
> > > can guarantee is that no references, of the kind which lru_add_drain_all()
> > > used to be needed to remove, can exist there: so there will no longer
> > > be any point in s390 (or others) calling it for that reason, to help
> > > split_folio() to succeed.  
> > 
> > we are not using it to help split_folio() succeed (although that's a
> > pleasant side effect). We need it even for small pages, to guarantee
> > that no extra reference from LRU is present on the page.  
> 
> Ah, thanks for explaining, that all makes more sense to me now.
> I remember from when working on memfd write sealing years ago, it too

yep, we use it to make sure no I/O is happening on the page while it's
transitioning

> had to be able to account for every page reference before proceeding,
> and resorted to lru_add_drain() and lru_add_drain_all() to help -
> those now removed in 14/25 of this series.

I see, then I guess we're good (see below)

> 
> ...
> > > If Barry's relaxation goes in before my drainage changes, then
> > > there is value in that s390 lru_add_drain_all() in the interim.  
> > 
> > hmmm so, should it stay for now, then?  
> 
> The s390 lru_add_drain_all() should go whenever the rest of this
> series goes in. It's not essential for the callers to be removed
> immediately, no correctness requirement; but nicer if we can get
> rid of most of them. I'm hoping this patch can just go in along
> with the rest via the mm tree - and I'm sure you can trust David
> Hildenbrand to understand and protect s390's interests.

so if I understand correctly, with this series the LRU caches
will never hold extra references (as in refcount) on pages anymore,
therefore calling lru_add_drain_all() will never decrease the refcount
on any of the pages that are in any of the LRU caches

in that case the lru drain can indeed go

> 
> > 
> > also: I'm working on completely reworking how the transition from
> > non-secure to secure is handled, with the explicit goal of getting rid
> > of that kludge we are currently using. That will also get rid of the
> > lru drain. But it will take some time (I hope to have something by the
> > end of the year)  
> 
> Good luck!
> Hugh


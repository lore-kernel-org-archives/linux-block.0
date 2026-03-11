Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB03E868E
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.139.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253971; cv=pass; b=nF/HXmJodxjsHjIdo8LVCgUP/drtU/u9pKvX5e5NHusTOBdKmXMp1sv8G7lELfjEvx83vuFlG2YnmM0s25DhaKye3Y8pkzeSeO4MrfYDUrqcC8JLSjfQ3nN90B2Sjcvs8PCJjiTEunCQRFoITsddoNfxe2axq6690yekHf8gGF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253971; c=relaxed/simple;
	bh=Cq8+tWfGf0TNmdPtc7SAv9a2DVpNwq16jsP0bVMh1cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7jcZJavACrvK4VBtcNSUdvDPAiqFxlSBayDZJPy+YMVSwI67qqSaS0uViB7JJz4u6E07A4ysZlHbBo9e27WFWI8UNvKNsM5x/2tfZPnt4g5qqhpqsg3dNJKbMQgvQQ9jbtNqiE9+Azl8StLvSNeSnMXbkHKqI+i7XtHASwy/9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UUM+ow1l; arc=pass smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UUM+ow1l"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BIDJuS1911339
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 14:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Cq8+
	tWfGf0TNmdPtc7SAv9a2DVpNwq16jsP0bVMh1cM=; b=UUM+ow1l9Ax4aODk3kCA
	f7C6HX+J1u99B/02owTapIzmg/S3suK/So7h+9shCsOsMY31YQ+ehmWLJShBDZtJ
	XSPB3SYVeDnU5cbRSko0FZu01N7ob0aWMQCkAQxNNKfYhkrHloUojrVFq2qb+lrm
	6SwDtWiAxy8bBpNfFnmfwdfuhUVGAAvvZtsQsPKsxGPE9DClIL++hxAb18jfEGmt
	XOjrspU7yPFaEr4YHZgDT7jQr7AF4Oi1HRsZTHLlWuzw7s9+LBlcYmbUdLVRCZms
	ao5ZTen4Lmub3RDeEx9C7ttLVWXnex1T9F2275PLGcL4nuBCa3SsS9N40ALWOpX0
	YQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4cuawa1ker-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 14:21:01 -0400 (EDT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-798531a0f58so6861657b3.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 11:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773253261; cv=none;
        d=google.com; s=arc-20240605;
        b=joV375UxBM+FbiTtScEYkRemKrLSaLoAI5r72SWso4zl0tCEISDxhr5LutSnFWG2zK
         9ydHScKZ81ff17X3nYwCr6gHkYGbdlt2nuqmwrRBs2exn0xuViQ1MMjN7JqPBulo0wLR
         CTfUBhrVA0dEtD1jj+ftaxV5voFGFPermX0dK8Q5HyHxfNdigVtPPf5pjtZbbGG90Pew
         1EUmVULFikSSW3wSftY2yEFOOijAErlJ+W3jCWtfwK1ZAcbf3Bx4ns76L51q6rTy/VKL
         V5Wc0M/+gfNbFpTsNBXj6UvECYeEpm9fAPlochgMCXQP1MQfZ1XzHrYpJY81WRmzR+ag
         e4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Cq8+tWfGf0TNmdPtc7SAv9a2DVpNwq16jsP0bVMh1cM=;
        fh=NCec1UViVTiEQsA2xJzm5HnG7roC9FpxTKliag9Egus=;
        b=M8Yx6e8NTRlUZ8mC86jS/9ryi41i7lPrqzw+NOgEE8UFCzE5oMpWTF+pIlwVYHupPG
         CQoNIECn/0W4i5KzJS/Jl5d+w8jXk4Xpur/69rWgIwmvjdZbvp0j5WNMJYVfYLWLun2a
         mGzfKt2KEbj88URuYYOlFyQQnPlcpwgtEOhl3o/OK+GU5VExZWV38mv8B0EC+NY1BVRm
         TpkAT+eK3x1X1+3wWgpgVgyeORDJF3Xfnr0VJeM5MuU+p/yRdEZs7cozwNaLGs7VrzTb
         1wq8aXU9No1qLeeUi4cqEoWohKpUlbuV6pMUx/7WPoFok5fA/LPz6qeAp7nstsxl/TUS
         JgIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253261; x=1773858061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cq8+tWfGf0TNmdPtc7SAv9a2DVpNwq16jsP0bVMh1cM=;
        b=sxYgAU8NvBdhZobdxatbE8BkFPzeviMFUarOE76EZnQ1txs/avAukteQ3y1WUojp5O
         OB26ZG+noc+sipSDBlqXZwZYxAK0kNFbGQDQId/JedlO7OUYFHqfjEovVlomjF3tZlh2
         /6HFaiix0FYDxK93w1VfFdaq9KTlOzXhkoxMujMVqsbolZCK+ean0YaVbBU/Fshxp0Mm
         JnJV8vYTeHHug+Bb7dxtsxDUYUK3L5DfMcS/fT7c5Of3p8B+/1RUAqGb0VjdvC/WgOKK
         g+nHiZr1DlOglxfdevpctMMi6EF4Tvl4YYD2Vtar8bGsaxMj6yPSREb8qg7uMe6nJvU+
         QBZw==
X-Forwarded-Encrypted: i=1; AJvYcCW9rFMWSBcLWHCzepad2vGmYKIG26YGod53bHWzVm5RSnBt3y2esCna61FMBC38ypS9dPjf2f6BeFS8kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyppECF0imDyNdVSBSIhLXoZBe0G+xj/iMagORobJmcofUToo60
	yibVOlrAH0wWi/7yHUD0oWxYk1IPJ+zWciX6zLsnLBHiJoCHbkT+e7xn2Ne58tuFGiEZ14SXSYw
	aRI6NMM/HMtt7FdIhU3/Hj+ZxZRF5SsDmG42gd/OcnZjgRlOAScq/zrtE34vN1sa1MsA4gCNmmC
	nCIoZGzMvKWRdayht6UBsSyAwB4PAlulRk9eM=
X-Gm-Gg: ATEYQzy0ZdP3p7K0FALO2ErayR99y6kqe2IsmgZXIkBff2b+3o8EPmXE+WhAd5sK2bs
	ucvQTdJyPqpMAkOVCJKx7H7UqXiNpYd1ag7pdrweXSqPSmg7o3f+Z9fzLBIs2cWP2IZr0lvgJJc
	ZHmNL5WZxDs+VTpN+x0LQlm7ApQW7QeF9DIIIrrgaEHrVNJ4VGandPl0Ch1XCXReu2w/TiI9KKc
	7T+xUa9
X-Received: by 2002:a05:690c:2704:b0:798:e281:a51d with SMTP id 00721157ae682-79917f7333dmr31676327b3.32.1773253261150;
        Wed, 11 Mar 2026 11:21:01 -0700 (PDT)
X-Received: by 2002:a05:690c:2704:b0:798:e281:a51d with SMTP id
 00721157ae682-79917f7333dmr31676087b3.32.1773253260648; Wed, 11 Mar 2026
 11:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
 <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu> <wen63cjbk3k54mjzgw7zftsuze6bzxmdk5u5wdjabzdiqg645k@67666k5lrevh>
 <aaXK0_HqEnU5SK61@casper.infradead.org> <aaybsigvp33i54w244jy4jarwf53zph5mzwjy2hcfm4v7m5o5o@e5hljmjqa3kq>
In-Reply-To: <aaybsigvp33i54w244jy4jarwf53zph5mzwjy2hcfm4v7m5o5o@e5hljmjqa3kq>
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Mar 2026 14:20:49 -0400
X-Gm-Features: AaiRm52QGrwhBIHZ_poQdAn3zaJ3OJ_GcxWQiC5XIABJrq0SVTc4spz01Omwcfs
Message-ID: <CAKha_sp3nF=UbVd3tjie2qat44P3_puZLABWJRXs24SLVpG+gQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] filemap: defer dropbehind invalidation from
 IRQ context
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: YXzzPZmBH4-agXqH_tsDg2opdQMPnW5L
X-Authority-Analysis: v=2.4 cv=ev3SD4pX c=1 sm=1 tr=0 ts=69b1b28d cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=jHxIr1HyPKZ_Q5_91PL3:22 a=-5RlsJUDQDLQn6G50gQA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: YXzzPZmBH4-agXqH_tsDg2opdQMPnW5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1NSBTYWx0ZWRfX0+ByKxw7G8vd
 RBV5bpsvCddeypsz46woXRY06WsqR3ezfRxRwLcdFwO30aLVcyHzzvQEZ9hLIqhwo8YRsel2Dc1
 bBTMXCoYKp3KQw3dAhQTPaN0b91qVCLpbMOr+pCvs3y8cT1A7vPVGoHmm0JU6H2h/YswAY6Ozqd
 FNw+YQ7ljv3EsNliwsUERkvUbuIpKw9M48g2QcKPxai6zQw+BOrdneqO1Iyfi3iufLatMCliuWr
 n/Rvn5TSkCu9QfDs38RljQk/v7ouZRMtcJM/C7MtiNYwouaXeTE0UpBW2t/9Fa40HNe9fotuZ4C
 8OctDL/gJOfRdWP+w4zVS5GqvmOhCtGlGQv/8mE7yhHHkS4lyGIPAbDoxwE3qumZXoDInjYbrW6
 pUidPovwbIfFqopcrpeVWte37KXeGfOLr1hxLsBxsqjnV+dSE5rt/+lYCw6Co7oYNJM7yp+HfpQ
 jr+P5zVV4kynMk/HlWg==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11726
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 impostorscore=10 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=10 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110155

On Tue, Mar 3, 2026 at 5:39=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> On Mon 02-03-26 17:37:23, Matthew Wilcox wrote:
> > On Mon, Mar 02, 2026 at 10:11:19AM +0100, Jan Kara wrote:
> > > Folio batches are relatively small (31 folios). With 4k folios it is =
very
> > > easy to overflow the batch with a single IO completion. Large folios =
will
> > > obviously make this less likely but I'm not sure reasonable working o=
f
> > > dropbehind should be dependent on large folios... Not sure how to bes=
t
> > > address this though. We could use larger batches but that would mean =
using
> > > our own array of folios instead of folio_batch.
> >
> > That's why I think we should allow the bio to be tagged as
> > "finish the bio in workqueue context",
>
> Yeah, what you suggested there makes sense to me. The workqueue would
> probably have to be a per-cpu one for performance reasons but otherwise I
> think it's worth a try.

If the consensus is that completing tagged bios in workqueues is the right
approach, I can give that a shot based on Matthew's suggestion.

Jens, does that approach sound reasonable to you?

Thanks,
Tal

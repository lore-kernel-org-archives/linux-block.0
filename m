Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28C272803
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.139.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153100; cv=pass; b=kFmB8/5FoGSE5AMpQpsi6THKflbmNYjhNxKJdfIZLwABefppZAKllN78Z985UZ2dAvgaqKm0uUMEkMXUsshsKFfqKkXIMlVdteAfFvbIcF+zW6K9ryR+YE1Pt9bEnNd75oj42SBv9U6hXjU9uMtZg/FI5ci+vYOk5qpGbAx393w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153100; c=relaxed/simple;
	bh=O+HRxgiHT2z7n5ch0TYyL93nG95Cvo9LlcSt25e21Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo1/wE1d2c7XZnrkAZa7Uk0YMf8IVKQ2JF8g/utK3VLTCl8wbJCy2wu0BxqEQqRYGlv4t/lCJr//rgvFB/6hWyeq4brhgZrmRzdNvHv2uDT3hCpn7mvdimgspwCJs+ebwXNTMRuhpyCiswtus33zPEGYYnQ6/S1UdW6c9XMVm4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=i1OndWU+; arc=pass smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="i1OndWU+"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R0RPEB1964597
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 19:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=X7pD
	kBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=; b=i1OndWU+3hVbPOhJLPdB
	3dZ4nSkztb1ikKbvdbatjVGkVMLfV8JFZoIoELwMzvOYxfwUR6nLGakr/qfu4h1Q
	GO8wKJ8wC4UazfM1LbiYLaf16jQ5TxOebgu7QRs3IVlvCrkOwzJVdNdZd6DNe2SA
	UyzFa/gtDwTBn+WHSFtqboptIKXNMRyDXiRy1/HJUeBhpCt4ysnry1Waeo2FSSbr
	T44fjXhU7o2QxsSczc0EG487y0F+MHbUzU5UXRAbhPw2wSNZ/rXct8p9OvNCLgVx
	J8CkKDZsIksblH1voMgwtFzQHi7YdkePQnLp9goufCO+S9tQvuISr4koC2RoM7Sx
	xw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4cjsqn466k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 19:44:49 -0500 (EST)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-79801be4ca3so29440597b3.0
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772153089; cv=none;
        d=google.com; s=arc-20240605;
        b=OQBWHCAunOzf1D1V8pYHuMBuAHaAE+yt1Pq3rVTNpRqVTD3WOzL21B6DluGOqwFoUo
         /g9vDRLkdSUvS6mGSFf5dv4BiRSuMk72WmDCWUiVbcaALqoxDaSh7vZ4qhhk40TcYsbT
         8/em1In5jvb4iFpxuXjPi27/0lo4zqFaA4qjlCZ/SncsNFrk7LaO/NmhDXiW/rRkC7JL
         HKI0xM2oulzlzltuBCGmlUh99w5PeJPEbgMQLNQgAYpbm+Em/zfQtwDU3xEblsvF2PGC
         cmWfhvaGkusy3uhHpkQSr7+pcbvWykRf5KFL3o+hO2uK8WUCt4hSmVrzY93rJUZfJcez
         TKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=X7pDkBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=;
        fh=Z8pajopD3dqDWwxWfXGJHbimk2BPrTCvQB4qzQiio6o=;
        b=Q1xFOahKAUThRm1/Ujx5rQZToTdnaVrlqmNDNau2rdgUHWCuuOiXEx67P0q62cEIuz
         u/x7M8z/Udh796YsH71QBKzh5Em6QpDFnIVFQDqr3osFdDhJL3cpZpNBY1f048+Alm7v
         Sx4ZcwMkpylm4QuHGY4IoQA3e0yE5uQDoDZrXuIswWg0o6TaUz1Nt5Z8h58sDZNvYYT8
         D/WWV7r5k9ozj1eI6IUwD+jpyGZreT4ShJBMQXvuYBbNtqCJwKoqix0Ltx+0bFzVn64c
         +Dz1lWPp/iPSqD/qt6nS+8t9GywFL8QaVfumy+/t4SoHrAj4NMHX4QV9qLRC/YqcVebs
         ZUzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153089; x=1772757889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7pDkBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=;
        b=R+mJ7s1B1ae3SNEvhV6U/yFr2Oxek6B/anexS1yYR8BvzpmYw0IuVXD0QPEphUeDI6
         5Hv9XnF5uGug0EiNvA7EDWFOMrfScZMGVUJdxghR3QKr89IuaLWC+dVkesKlktcAmMVT
         OAwIV92+9VgfogkuqjiGIrZM+GrBc/OZGSgifEBqQ1ZK3rzz8iiO9074AKaDbqpHMjDC
         0zIXJTa96chmZS6f53NL8KVbhbC7JTTC2B5c4tYOSlPzCMSXn+bvIG2d6P7m+A36cQwA
         yUNktNEDtbeKWlJg1OVgzyEDihYGotbfR9uXgGMAZhoUeBE2VYrR+fyM/8UYhy4pJTDb
         C5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVjMoYedEMkZogkJZ6qEQBVmdk8rFWtYIUdIyCHWuNavTMyNNTn6RQ04s26jv3QIlGguSxI2vJznIOi+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWm0hacsBPFncGTBqxUyRI3hdUvJGZmetlV/ddvHsV3ObRblr
	leZySxgZdzUEu2e7XQBkokJoH7QKWkLjS7EA101K+1G044ZHxVXSbsPyZCkcoeDlCF3WMT+rBwf
	BQMQ9pW7IMugAwN+KN0dmU3P49xmeNA/JcKZFKHbXTJ2TKzGkt3MVzCbGSKcgCUgleWsJFHs+P/
	KybrmzW3hc95t/nfZbjpZC9VizY05Ot3JiTEY=
X-Gm-Gg: ATEYQzx/dMgIQMbb/mQkMpSPmyLMLOh2NFiw5DdDyslaA4RMdUWxti4Nz1t9vQpCR7f
	8/TdF8XrIGz+YPH5CvuIXTIegyzx/GsCu93nevJXHtQ7JCxNt/52WDmLkRsAW2HjBnClEXNkAtJ
	IDITX1NvB6Z3IK6eZQSHWOlMmDuGTonKZCQ9yNX06hG8BdAMlVR5x1uPNa5aJYiK+2sEbqJSTGq
	T4raw==
X-Received: by 2002:a05:690c:f16:b0:798:6401:fd1f with SMTP id 00721157ae682-798854a7e4emr11636147b3.14.1772153089299;
        Thu, 26 Feb 2026 16:44:49 -0800 (PST)
X-Received: by 2002:a05:690c:f16:b0:798:6401:fd1f with SMTP id
 00721157ae682-798854a7e4emr11635807b3.14.1772153088806; Thu, 26 Feb 2026
 16:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-2-70e7ac4f7108@columbia.edu> <aaDEEjVKBKrLxsht@infradead.org>
In-Reply-To: <aaDEEjVKBKrLxsht@infradead.org>
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 26 Feb 2026 19:44:38 -0500
X-Gm-Features: AaiRm52uN73WQ1q0q0Bsy0nLJ7MoTUQc88yWQcbleL3GQlPfTUc323g8dJKyM6s
Message-ID: <CAKha_sonOvAGriyromHtyRc-VY6Zyg3J3zd9UJPfBOAt1a522A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] block: enable RWF_DONTCACHE for block devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NLPYOk6g c=1 sm=1 tr=0 ts=69a0e901 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=azVShVRs0zEubeQ0wG0L:22 a=JfrnYn6hAAAA:8 a=lVyRQGvDAGr_LZokY8wA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAwNCBTYWx0ZWRfXz3efGY/Kmgda
 4chVxnPr1jaLPuoIjbsv+/6Iq87drZ/qagZkX2FpNyZ26tb3LJRl6FBBOE02VrnkU0o4i6iMWyp
 AZy7S6RFjrinacy7idCa6mPROsxMHRa5g2CCVpYIWLprEgnIHJfU6ZRkpMFV/i2At5Nkgy5jAxp
 +GPcBKfBZnEn66G5QssIxitqge030R3xXTl167jmuVoJ1Gz/nFlympsvRodC8Vto51avuoqSrbV
 RlBIXDZm633R0gJrt35VfzGTIb20HqEbmVhxnGFw/nBts3wmTZ0Cp/oG9nyr4zvLISnZTJu9V14
 Jiw5+Q1vyH20B7DxdggtMDYc4A4JDzYHC8YI4AvwttQgGyFRNTnii5kJRui/OA6xBXEiNVtSflr
 +eMBTUJ8a2mXcMKPjajcfby1MpfrK3OuSGHe0BepVC37mNLD3uNg9G2PwtKi4hotmncgliG6MDz
 LxYaAf3+wchN+xwbt+A==
X-Proofpoint-GUID: 0sg1yUAb_UZJr8UyxnXP4dHqZ4rLZfD9
X-Proofpoint-ORIG-GUID: 0sg1yUAb_UZJr8UyxnXP4dHqZ4rLZfD9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11713
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=10 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270004

On Thu, Feb 26, 2026 at 5:07=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> > --- a/fs/bfs/file.c
> > +++ b/fs/bfs/file.c
> > @@ -177,7 +177,7 @@ static int bfs_write_begin(const struct kiocb *iocb=
,
> >  {
> >   int ret;
> >
> > - ret =3D block_write_begin(mapping, pos, len, foliop, bfs_get_block);
> > + ret =3D block_write_begin(iocb, mapping, pos, len, foliop, bfs_get_bl=
ock);
>
> Please don't change the prototoype for block_write_begin and thus
> cause churn for all these legacy file systems.  Add a new
> block_write_begin_iocb, and use that in the block code and to implement
> block_write_begin.
>
> And avoid the overly long line there to keep the code readable.

Will do.

>
> Note that you also need to cover the !CONFIG_BUFFER_HEAD case.
>

I don't think there is a !CONFIG_BUFFER_HEAD case. The only user of
block_write_begin_iocb() would be blkdev_write_begin(), which is only
defined under CONFIG_BUFFER_HEAD. !CONFIG_BUFFER_HEAD paths use iomap which
doesn't use it. And buffer.c is only compiled for CONFIG_BUFFER_HEAD. Unles=
s
I'm missing something?

Thanks,
Tal

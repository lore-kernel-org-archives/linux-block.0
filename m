Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EE63CF
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313236; cv=none; b=c1sNWkcgwYofcyrA/6AETf/V71xoJastFjTcd3EtXjvPBAOl39s9jx/rrmtNKWEj+iUrMd5deZctfcGAEtsbQGLebbhOeDK10s/nnvQuXGYhOm1bV3jXorx1NdMDcHSHLkXyB4KhMrFbRmfWQNnwlQ5jm1HD1rMkJaJXLNaEaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313236; c=relaxed/simple;
	bh=8J9wxNA7crG84L16NbrsOSIHJ9ghYcToW1qbyvhcyVY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=K3ApzgbX4UpkRsgz6PusETkfkW0BIxcLwaAgv2loHBi0IsrrdODJ7vJ2piFVnIMJ+u9UNnllygRc0ap47YVrtWWMITAZMThc58IKTsZL42rMFHKWdd0J1MneGTBVE0fLeJrF7r1DtYrfUIalVaugee4Wx2h1NvezUorBeFSmbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EgKwB7ma; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EgKwB7ma"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250307020710epoutp0355a28d787ce23f4530d2f8fd781c8b21~qYyhMt5tC0342203422epoutp03Q
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 02:07:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250307020710epoutp0355a28d787ce23f4530d2f8fd781c8b21~qYyhMt5tC0342203422epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741313230;
	bh=8J9wxNA7crG84L16NbrsOSIHJ9ghYcToW1qbyvhcyVY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=EgKwB7mas9u0v/QY6QyIHME9s9NrVdS8cOcmCQQW4nI6vo2ultjDub8A1/1SfN+AQ
	 xvwPPC1N7iteevtdXvR/T/rWnvc+Imei1KPLXm85cpu5fB65RADI0GQGqfxrwIL8dI
	 lAuVs6tUYzRdQpXU8e/x0NTG34FLCjtBOzog3Tuo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250307020710epcas1p2169879cbccba3210581dd5cc2c5494f0~qYygsj-wy0300003000epcas1p2h;
	Fri,  7 Mar 2025 02:07:10 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.223]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z88ms5KFfz4x9Q2; Fri,  7 Mar
	2025 02:07:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	68.28.23253.DC45AC76; Fri,  7 Mar 2025 11:07:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250307020709epcas1p4f7dbc7989988c32674ca79d7a4cf757a~qYyf-smuY1591415914epcas1p4g;
	Fri,  7 Mar 2025 02:07:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250307020709epsmtrp1f246c0161cdecf6e660696025c4f0786~qYyf4ej2s2858928589epsmtrp1Q;
	Fri,  7 Mar 2025 02:07:09 +0000 (GMT)
X-AuditID: b6c32a33-5a18170000005ad5-2b-67ca54cd474c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.F1.18729.DC45AC76; Fri,  7 Mar 2025 11:07:09 +0900 (KST)
Received: from ssuk04 (unknown [10.253.104.229]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250307020708epsmtip109d190634692605b936976f3bbff9bb4~qYyfpNT5c0429604296epsmtip1K;
	Fri,  7 Mar 2025 02:07:08 +0000 (GMT)
From: "Sooyong Suk" <s.suk@samsung.com>
To: "'Jaewon Kim'" <jaewon31.kim@gmail.com>, "'Christoph Hellwig'"
	<hch@infradead.org>
Cc: <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>, <spssyr@gmail.com>,
	<axboe@kernel.dk>, <linux-block@vger.kernel.org>, <dhavale@google.com>,
	<surenb@google.com>
In-Reply-To: <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
Subject: RE: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for
 direct IO
Date: Fri, 7 Mar 2025 11:07:08 +0900
Message-ID: <848301db8f05$a1d79430$e586bc90$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHaiiw9LXrMK4mioaI0ilN2PEwZlQJfPoLQAkXgmoQCszXN9rMuMbSQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmru7ZkFPpBm/aNC3mrF/DZrH6bj+b
	xaH5SRanJyxisujePJPRYu8tbYvLu+awWdxb85/V4t7dBnaLyZcWsFmc/3uc1YHbY+esu+we
	CzaVemxeoeVx+Wypx6ZPk9g9Tsz4zeLxeZOcx6Ynb5kCOKKybTJSE1NSixRS85LzUzLz0m2V
	vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
	5BeX2CqlFqTkFJgV6BUn5haX5qXr5aWWWBkaGBiZAhUmZGf83/+CteCEZMXLIzINjK8luhg5
	OSQETCQurZzI1MXIxSEksINR4tS9VYwQzidGiTWHj7BAON8YJR5PvM0E03Kw7ydU1V5GiYnb
	7rFDOE8ZJW5/mAtWxSagLvH+zW0WEFtEIEJizf27YB3MAs8ZJd4eXswGkuAUCJRY+eE6WJGw
	QJBE98b5QDYHB4uAisTUuz4gYV4BS4lXnRCbeQUEJU7OfAJWziygLbFs4WtmiIsUJH4+XcYK
	sctNYveHD2wQNSISszvbmEH2Sggc4JCY2rICqsFFYv8UGFtY4tXxLewQtpTEy/42KLtY4lff
	R1aI5gZGif5jS6Aa7CVW7O9kBTmUWUBTYv0ufYhlfBLvvvaAhSUEeCU62oQgquUlfm+6wAIR
	FpXY9sYBwvSQuDbHfwKj4iwkj81C8tgsJA/MQli1gJFlFaNYakFxbnpqsmGBITyuk/NzNzGC
	k6+W8Q7Gy/P/6R1iZOJgPMQowcGsJMIruPlkuhBvSmJlVWpRfnxRaU5q8SFGU2BIT2SWEk3O
	B6b/vJJ4QxNLAxMzIxMLY0tjMyVx3gvbWtKFBNITS1KzU1MLUotg+pg4OKUamOwWT0i23cN6
	Y5r6Lr3bDyy1/znduKtcWK6jYsI9UbTUSXG33+V7k2Yv1i964h9az6QuHSsuID29ue2XZe6B
	la/D5+WwSZj5TUndVV/PEet87rC4xlUNKefwtMeKMy2dPLv4Mz4YuZbGnW82nvT3x7HdR5fq
	1XmlT7RV+HNT8Z3Irmcz+1gzm6L+d+cdXXI1QXbKUi9rt6kx3P9Md5ma5Un3nl4UtceESz5X
	4Ajn2huP5j52tUyzDM6q2pek51Wu+2lSoeLUlfapxmbdK6NO1u0Qi1rY8I1pW+eZUyIxU8y4
	emsCe3/evJby5uxL61df+TR9LGvs/tya+rXp+eY99UI//AJfT/hdaL5qqna/EktxRqKhFnNR
	cSIAApG8aUcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnO7ZkFPpBh/PsVnMWb+GzWL13X42
	i0PzkyxOT1jEZNG9eSajxd5b2haXd81hs7i35j+rxb27DewWky8tYLM4//c4qwO3x85Zd9k9
	Fmwq9di8Qsvj8tlSj02fJrF7nJjxm8Xj8yY5j01P3jIFcERx2aSk5mSWpRbp2yVwZXTMmstS
	sFWwovWVSwPjCd4uRk4OCQETiYN9Pxm7GLk4hAR2M0psP32BCSIhKvHs9zeWLkYOIFtY4vDh
	Yoiax4wSX6d1soPUsAmoS7x/c5sFxBYRiJDYu+05K0gRs8BHRomJzT/ZIDreM0r8vTcbrIpT
	IFBi5YfrYFOFBQIkGq5HgZgsAioSU+/6gFTwClhKvOq8zQRhC0qcnPkErJNZQFvi6c2ncPay
	ha+ZIe5UkPj5dBkrxA1uErs/fGCDqBGRmN3ZxjyBUXgWklGzkIyahWTULCQtCxhZVjFKphYU
	56bnFhsWGOallusVJ+YWl+al6yXn525iBMehluYOxu2rPugdYmTiYDzEKMHBrCTCK7j5ZLoQ
	b0piZVVqUX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGJgbfeUsbvxpN
	vPWOP9co5Uezwq+LVZNOfrU4VCMYoGd728s50/2b4oPeH2qfpwoqxyVnRKkdPDnj7JPlH58f
	zU2QbNZavEC22m3r3x3cldwGd6/zT2eoCu/R0WexCL/OXczaGdPAnJZ1cApjjH/SmpCCEsHj
	vT7yPVxWkQnJ2nMv8G/1FLY7yOHQuXU7z33v6NWiD7PsX0be/rKXNUj9VsC7P5NbW1d/SNv+
	q3Yij6HmIYtL+QW/44UsVS+Jbs11/SIWU6HBaXx2/qlXKZ9LOJ5re7nelX7Su6DUaOG+9HOf
	T13YqpNpU9oqs0X1nOU1+aLKhr3lpqZf8u24zlbz7jRftDBaZM1TzZ154ZpKLMUZiYZazEXF
	iQDd305XMgMAAA==
X-CMS-MailID: 20250307020709epcas1p4f7dbc7989988c32674ca79d7a4cf757a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
	<20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
	<CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>

> On Fri, Mar 7, 2025 at 12:26=E2=80=AFAM=20Christoph=20Hellwig=20<hch=40in=
fradead.org>=0D=0A>=20wrote:=0D=0A>=20>=0D=0A>=20>=20On=20Thu,=20Mar=2006,=
=202025=20at=2004:40:56PM=20+0900,=20Sooyong=20Suk=20wrote:=0D=0A>=20>=20>=
=20There=20are=20GUP=20references=20to=20pages=20that=20are=20serving=20as=
=20direct=20IO=0D=0A>=20buffers.=0D=0A>=20>=20>=20Those=20pages=20can=20be=
=20allocated=20from=20CMA=20pageblocks=20despite=20they=20can=20be=0D=0A>=
=20>=20>=20pinned=20until=20the=20DIO=20is=20completed.=0D=0A>=20>=0D=0A>=
=20>=20direct=20I/O=20is=20eactly=20the=20case=20that=20is=20not=20FOLL_LON=
GTERM=20and=20one=20of=20the=0D=0A>=20>=20reasons=20to=20even=20have=20the=
=20flag.=20=20So=20big=20fat=20no=20to=20this.=0D=0A>=20>=0D=0A>=20=0D=0A=
=0D=0AUnderstood.=0D=0A=0D=0A>=20Hello,=20thank=20you=20for=20your=20commen=
t.=0D=0A>=20We,=20Sooyong=20and=20I,=20wanted=20to=20get=20some=20opinions=
=20about=20this=20FOLL_LONGTERM=0D=0A>=20for=20direct=20I/O=20as=20CMA=20me=
mory=20got=20pinned=20pages=20which=20had=20been=20pinned=20from=0D=0A>=20d=
irect=20io.=0D=0A>=20=0D=0A>=20>=20You=20also=20completely=20failed=20to=20=
address=20the=20relevant=20mailinglist=20and=0D=0A>=20>=20maintainers.=0D=
=0A>=20=0D=0A>=20I=20added=20block=20maintainer=20Jens=20Axboe=20and=20the=
=20block=20layer=20maillinst=20here,=0D=0A>=20and=20added=20Suren=20and=20S=
andeep,=20too.=0D=0A=0D=0AThen,=20what=20do=20you=20think=20of=20using=20PF=
_MEMALLOC_PIN=20for=20this=20context=20as=20below?=0D=0AThis=20will=20only=
=20remove=20__GFP_MOVABLE=20from=20its=20allocation=20flag.=0D=0ASince=20__=
bio_iov_iter_get_pages()=20indicates=20that=20it=20will=20pin=20user=20or=
=20kernel=20pages,=0D=0Athere=20seems=20to=20be=20no=20reason=20not=20to=20=
use=20this=20process=20flag.=0D=0A=0D=0Ablock/bio.c=20=7C=203=20+++=0D=0A=
=201=20file=20changed,=203=20insertions(+)=0D=0A=0D=0Adiff=20--git=20a/bloc=
k/bio.c=20b/block/bio.c=0D=0Aindex=2065c796ecb..671e28966=20100644=0D=0A---=
=20a/block/bio.c=0D=0A+++=20b/block/bio.c=0D=0A=40=40=20-1248,6=20+1248,7=
=20=40=40=20static=20int=20__bio_iov_iter_get_pages(struct=20bio=20*bio,=20=
struct=20iov_iter=20*iter)=0D=0A=20=09unsigned=20len,=20i=20=3D=200;=0D=0A=
=20=09size_t=20offset;=0D=0A=20=09int=20ret=20=3D=200;=0D=0A+=09unsigned=20=
int=20flags;=0D=0A=20=0D=0A=20=09/*=0D=0A=20=09=20*=20Move=20page=20array=
=20up=20in=20the=20allocated=20memory=20for=20the=20bio=20vecs=20as=20far=
=20as=0D=0A=40=40=20-1267,9=20+1268,11=20=40=40=20static=20int=20__bio_iov_=
iter_get_pages(struct=20bio=20*bio,=20struct=20iov_iter=20*iter)=0D=0A=20=
=09=20*=20result=20to=20ensure=20the=20bio's=20total=20size=20is=20correct.=
=20The=20remainder=20of=0D=0A=20=09=20*=20the=20iov=20data=20will=20be=20pi=
cked=20up=20in=20the=20next=20bio=20iteration.=0D=0A=20=09=20*/=0D=0A+=09fl=
ags=20=3D=20memalloc_pin_save();=0D=0A=20=09size=20=3D=20iov_iter_extract_p=
ages(iter,=20&pages,=0D=0A=20=09=09=09=09=20=20=20=20=20=20UINT_MAX=20-=20b=
io->bi_iter.bi_size,=0D=0A=20=09=09=09=09=20=20=20=20=20=20nr_pages,=20extr=
action_flags,=20&offset);=0D=0A+=09memalloc_pin_restore(flags);=0D=0A=20=09=
if=20(unlikely(size=20<=3D=200))=0D=0A=20=09=09return=20size=20?=20size=20:=
=20-EFAULT;=0D=0A=0D=0A

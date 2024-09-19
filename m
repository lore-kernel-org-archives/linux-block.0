Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23319DF50;
	Thu, 19 Sep 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745423; cv=none; b=HcjKvoyqKdWiRWLDQVKdTkr5DNVkU35ePwwAES8VGExL0DlwI7iIX1C2h4PlojCCxog6/iVDlCLtxStNL6p3w8UG45AAi6Bt14ghYUqOdQvSl7GUwqjS5wt4xyr++4J4YQSuoSGqd0e9kovxiNRGZf5uH6cJdMoHZ2tJSvau4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745423; c=relaxed/simple;
	bh=YpzFIzTDvOtLChXPt3EJX51Bgzonbxt/P3qrKDCAGoE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HCHa4a0q4sXjVR9gFc7Ec6F9fQI5bUOHx7w4UtIWRwKfzRpaqOUf76TYF3GTizJcAy2RYFY2r5I5Qi16lrEBnQ2rfK2H9Pc8YzEpH5Rgoz6HaAZR5rYKZoo+/PQkLPTXs/0qR2eWMVt9Y3460E+0CkVs5B2hIIiXFBdnavLjBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f+gsnbtG; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f+gsnbtG"
X-UUID: 896dcffc767a11ef8b96093e013ec31c-20240919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pFtDBXloIcerwPHPWpyl2alet9mKUnrBwiIRPJMroSA=;
	b=f+gsnbtGned9LkWJWc5NbYauoXN3t+I+B8r4NjplArVdmHSzRv8ml7tuNqPBcjEleuZBvJcEc7x/DdJSmnUoKjYJHtTizVLH01mqp0w6vDQrz+gEhjtEoum6xezrvN6cpBTVZw5kPv9kNxDBR7lniBr8+8A1yQmW+Zbw2VIgqQ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d9ba1120-49be-4150-b449-93c08f27e599,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:9eee71d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 896dcffc767a11ef8b96093e013ec31c-20240919
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2027936357; Thu, 19 Sep 2024 19:30:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Sep 2024 19:30:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Sep 2024 19:30:10 +0800
From: Qun-Wei Lin <qun-wei.lin@mediatek.com>
To: Andrew Morton <akpm@linux-foundation.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ryan Roberts
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, "David
 Hildenbrand" <david@redhat.com>, Chris Li <chrisl@kernel.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
	"Dan Schatzberg" <schatzberg.dan@gmail.com>, Kairui Song
	<kasong@tencent.com>, Barry Song <baohua@kernel.org>, Jens Axboe
	<axboe@kernel.dk>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-block@vger.kernel.org>, Casper Li <casper.li@mediatek.com>, "Chinwen
 Chang" <chinwen.chang@mediatek.com>, Andrew Yang <andrew.yang@mediatek.com>,
	John Hsu <john.hsu@mediatek.com>, <wsd_upstream@mediatek.com>, Qun-Wei Lin
	<qun-wei.lin@mediatek.com>
Subject: [PATCH 0/2] Add BLK_FEAT_READ_SYNCHRONOUS and SWP_READ_SYNCHRONOUS_IO
Date: Thu, 19 Sep 2024 19:29:50 +0800
Message-ID: <20240919112952.981-1-qun-wei.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.319100-8.000000
X-TMASE-MatchedRID: y/MOm6ldwRLxEHpzyfiYCrCvlllU7Dl1u56wFPSkMVFsmSfP7d/dpYhK
	asDlRLg0PMCTxZ0FhhdYo3G+rvxrNUkjllSXrjtQFEUknJ/kEl5q8/xv2Um1avoLR4+zsDTttrr
	TuahHzlGpp01G3uBXtb0XhwlNA8MHofnMcDO+aeBJiBkhcxr75pWf1beiAmbTHliXM5eW2aacaV
	HiDzvLgZJWAqw/Km95o4s7o73brFxJmt82E/eyBQGH0CAFIQWsmb5gmylW+PbGS+seVPx64j6Qr
	n3xh/cy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.319100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	934E8F1C009F82DA8C65E157967D6F7A839701E4510113EE88E9F19DE3C52A232000:8
X-MTK: N

This patchset introduces 2 new feature flags, BLK_FEAT_READ_SYNCHRONOUS and
SWP_READ_SYNCHRONOUS_IO.

These changes are motivated by the need to better accommodate certain swap
devices that support synchronous read operations but asynchronous write
operations.

The existing BLK_FEAT_SYNCHRONOUS and SWP_SYNCHRONOUS_IO flags are not
sufficient for these devices, as they enforce synchronous behavior for both
read and write operations.

Patch 1:
- introduce BLK_FEAT_READ_SYNCHRONOUS

Patch 2:
- introduce SWP_READ_SYNCHRONOUS_IO

Qun-Wei Lin (2):
  block: add BLK_FEAT_READ_SYNCHRONOUS feature for synchronous read
  mm, swap: introduce SWP_READ_SYNCHRONOUS_IO

 include/linux/blkdev.h |  8 ++++++++
 include/linux/swap.h   | 31 ++++++++++++++++---------------
 mm/memory.c            |  3 ++-
 mm/page_io.c           |  2 +-
 mm/swapfile.c          |  3 +++
 5 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.45.2


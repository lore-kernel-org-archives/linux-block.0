Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DC12CDA5;
	Sat, 12 Oct 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717321; cv=none; b=JB+jpjxq6nDRRQHHnHA93yjT3RZgfZAPVgnY66gadS+98FLHiMm+51XqCtKV4Ms211Fqx7JFLiXffcMRMc8dk9lt+nDgNpZ3u/geDiZcHPMMay+9i1MnT5phN4lHuMw3o98nj+9Qr5e0raGiKPwyallWFS9KraTR7Woqn5IjN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717321; c=relaxed/simple;
	bh=DlGndp0ryosAmmwi+KPu6DMY2uOf8LabQmxNj896WJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0NHF2b/0PMFJe6XhlcsYJW9zEaTsjFVc/q7++EbRlNXurC6mre8PzrKlIj4ZQ8z7MIMG1FbCPdccw9EhXzjrQ5GJMwTeMqwFn1Hf9a9QgrHqNsDIhowt7hB66hAXuB30gYJehMScAKpBte3oih/fO13LfF102rqtM1czacvQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fv5HbSLW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fv5HbSLW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eKVPThxvf989v7DtzxaKQzLXa5qNtAiRX3s8s9yAlHA=; b=Fv5HbSLWfV5EjjJf5I4hXM/fl6
	9NoEikqbc6ST/MAgVg9YhMH1t+OEcTUq9hUmoraPJ4VZJAfy39UPGDedI/NJDrkQEDxknP+z+Cfiz
	Z9RZTgEma9+i4QWKjrqX/P9+m5nKTpRbLbQlQ6HvHKa4rdExB/jzzh2KQtDkpLcG8Ma0d4cOoWPIQ
	L4GcKjVBnpUa7kSTeBE9m7F4jrTLplLK0D4QJzOIfKRBSFMSZ217DGQ162R0wjc5hV2bKqklBpxGt
	B8ENowmQa/nf8VCmqY9bOnHOIfUmp292uBV88DDm6NVoyVHSQ74cXDT8LQwu/PEePmIC0XJnzTW+o
	4ySAGaNw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szWL2-0000000Cxxw-1P51;
	Sat, 12 Oct 2024 07:14:59 +0000
Date: Sat, 12 Oct 2024 08:14:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
Cc: "ying.huang@intel.com" <ying.huang@intel.com>,
	Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"baohua@kernel.org" <baohua@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"david@redhat.com" <david@redhat.com>,
	"schatzberg.dan@gmail.com" <schatzberg.dan@gmail.com>,
	Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= <chinwen.chang@mediatek.com>,
	John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kasong@tencent.com" <kasong@tencent.com>,
	Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
	"chrisl@kernel.org" <chrisl@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>
Subject: Re: [PATCH 0/2] Add BLK_FEAT_READ_SYNCHRONOUS and
 SWP_READ_SYNCHRONOUS_IO
Message-ID: <Zwoh8DrKgSD99xVQ@casper.infradead.org>
References: <20240919112952.981-1-qun-wei.lin@mediatek.com>
 <87frporxtt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <17b30f253172cce94d1e2ec86d00e82eea077bde.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17b30f253172cce94d1e2ec86d00e82eea077bde.camel@mediatek.com>

On Fri, Oct 11, 2024 at 09:08:10AM +0000, Qun-wei Lin (林群崴) wrote:
> The primary motivation for these new feature flags is to handle
> scenarios where we want read operations to be completed within the
> submit context, while write operations are handled in a different
> context.
> 
> This does not necessarily imply that the write operations are slow;
> rather, it is about optimizing the handling of read and write
> operations based on their specific characteristics and requirements.

So why wouldn't we always want to do that instead of making it a
per-bdev flag?

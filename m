Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422655;
	b=X0gT62ImbdSoO2VCpPAEZjzfAGnRQl5y8dv/NrY3oK4jhnMYg8nemV57nmD0ql+WMP1S
	 /zW4pezgZs9qc9FMj4MMUy5oPY0oqkjJaUuKyP+xD1xMan72vU5hZMjW1CE5jezeVlXGs
	 b6STv027YFpU4xYsZ6yz2tW/n56v3eUUu5FYWx6T/SJerAYXg4DuGpqTwEFbdo/hhNuL/
	 ENkuoO7WyVqPc89X8roZ4u0jd03+eiLJVXFp5bpmNQCclYHGWZxAWgLVYrJvahzsNGDxc
	 spf0FJHh3MLP87hqDKznpPzrrQyPEtb4h2+2QegCgKKVtZ54ikiLKMf1WVeUcPyvv8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422655;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=6tDd9eRJndUwaYYrTyVQpmqvbWmO76hktr/KZipnuAY=;
	b=l7snZys+o60zJo5QS6ugS67U2gTauk4/d6ygfr/ICobsKWBc6QSKC0/M/TTlSft0Dvif
	 mg14OKuTSznwk4H7esPMrUuIm9TnOZzMtfDegVobBl5gqeS8labnUMaiwSe94VEWtp+WS
	 XlEp/vUUIVTRqbUuibjEBwpf3gNnNIJy6iq1ldZut3wrtEoMAXfuP0ePy7ojAM29KBSQO
	 E4+yG6+e/k6N2QGnGYFfyAw4bWRhmWNpVybVthY7DeXdNE3uETxtoTfFP9tlefGuieq8f
	 e1UmmHJsx/PrVTw3wSKF2Pre4DhAUyB6GFoqcDNict8sax75o4MywbVPeHKe9w3lazQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A62606A31A;
	Mon, 23 Nov 2026 08:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jXzfS70p3zg1cV;
	Mon, 23 Nov 2026 16:30:40 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jXzfR3Pf6zVcB5;
	Mon, 23 Nov 2026 16:30:39 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id B48A01555;
	Mon, 23 Nov 2026 16:30:36 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 23 Nov
 2026 16:30:37 +0800
Date: Mon, 23 Nov 2026 16:30:35 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<hch@infradead.org>, <mic@digikod.net>, <axboe@kernel.dk>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <legion@kernel.org>, <aleksa@amutable.com>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <djwong@kernel.org>,
	<sandeen@redhat.com>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <wujianyong@hygon.cn>, <shijie8@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 01/11] vfs: add super_iter_inodes()
Message-ID: <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
References: <20261120031305.3561045-1-huangsj@hygon.cn>
 <20261120031305.3561045-2-huangsj@hygon.cn>
 <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Fri, Nov 20, 2026 at 03:56:23PM +0100，Andreas Gruenbacher 写道：
> > +
> > +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> > +                     ino_iter_eligible_fn eligible, void *priv, int flags);
> > +
> >  struct super_operations {
> >         struct inode *(*alloc_inode)(struct super_block *sb);
> >         void (*destroy_inode)(struct inode *inode);
> > --
> > 2.53.0
> 
> Sorry to say, but this has gone quite a bit off course. Can you try a
> construct like iomap_iter() instead?

Christian had suggested to use the following methed:
  https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner/

Thanks
Huang Shijie


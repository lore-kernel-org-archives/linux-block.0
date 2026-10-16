Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1A2F6188;
	Fri, 16 Oct 2026 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118765; cv=none; b=oZFaIrc6gO4+cFebndkQmKiggDF10Mnt8kQLdFMpyViV0NPSRK/+tDjX3ViJXlsM5vdyUwNpjSL6MvtFjowrtCEXEV5u6AI5vEJ+OLdS/uAi3OH5U5FWPAjFfdW7FPkrdVHy2j96jn/iW9Mg0hdCD8gduhlHhTyp6AhWOR4S8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118765; c=relaxed/simple;
	bh=16vuf1jsfk2TqsWcEzF1DgVBVeepkLR1eDP+Kk1TAxA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEwoh4hy/qY6IJiyVaVEqqtEWXWZu143scT2QxVYfdB6Uy1Do52Rs34Hf4NAA8CSY67A75KMbHOSLwEnyEfLmYjfYM/0qiNMQMZiXkTBNoGyOSMgpAU+8gteicFXzewK+J6AH39A9ntgJ+xtd7KNTq8/19q4PaeYg6RyiwePEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j5Tp22pWNzT1qP;
	Fri, 16 Oct 2026 10:45:46 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j5Tp224CtzT1qP;
	Fri, 16 Oct 2026 10:45:46 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 2F2A51549;
	Fri, 16 Oct 2026 10:45:46 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 16 Oct
 2026 10:45:44 +0800
Date: Fri, 16 Oct 2026 10:45:42 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
CC: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <agruenba@redhat.com>, <mic@digikod.net>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<david@kernel.org>, <sandeen@redhat.com>, <ebiggers@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, <sunjunchao@bytedance.com>
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
Message-ID: <atGP1kj1upOFi0xL@hsj-2U-Workstation>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-2-huangsj@hygon.cn>
 <CAEjxPJ7xgpYOQVRSoBMK-_w4kmrPu_v37iS+q3Oj5TvtKUvJqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7xgpYOQVRSoBMK-_w4kmrPu_v37iS+q3Oj5TvtKUvJqA@mail.gmail.com>
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Thu, Oct 15, 2026 at 11:23:07AM -0400，Stephen Smalley 写道：
> 
> Perhaps SELinux could also use this to replace its own inode walking
> logic at the tail of security/selinux/hooks.c:sb_finish_set_opts()?
The super_iter_inodes() can not be used by sb_finish_set_opts() now.

super_iter_inodes is only used to iterate the inodes in sb->s_inodes list
which is proteced by sb->s_inode_list_lock.

Thanks
Huang Shijie


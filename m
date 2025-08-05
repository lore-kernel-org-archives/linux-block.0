Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413B156237
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395264; cv=none; b=YUPsV0MUVHu+bpneldRa3tHtp89KkI9PEF8QIBZFZU48ORrGOO7jhUS327905Hx9CfwIumgHBnVuNqtxUWewRenkTR8+2d/esjg64aupC/kk/y4S2jQRE1lnOJSEyZFt1rB7Gk/UyTzfIGrM1SfDzSB4U5X212q/sKYd/XwiJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395264; c=relaxed/simple;
	bh=kFfEauye1RJdd7ksADH/nQO/TnuUnyrtM27EwfRMaF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/z7ZHCARPJcxOV0QYuanfHY5jD1l6RiG9CjbFTs3IS8jdPu27nQh6UYOukNY1UOv/AMavTO5UFG67esqgmuqM6OOkaKxoGXi76dj0DYRnX3x2SIyxoyU71LDLjA0vVyVVI1x69alMHpj41HF3qfpLVgnYH8urRIEDc9SDIsCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=X42HOCju; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="X42HOCju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754395259;
	bh=8xLf7biF5AouiZse7/4e7D5sffThqJBeE04rLUxEIb4=;
	h=From:Subject:Date:Message-ID;
	b=X42HOCjuJs9YNHbwQ9pGT87UHT6KRL4X8MbnY3XKYdZklunMRB/xQCsEyg8OZdcZH
	 kdYGkJKSrmk2RhAGg+wNf9FtK+CEYoCLY7R1tDImJe9c+Ln2o2VeVMYrAeOlNqFcv2
	 6XDWKbRM+BzSYGR4NAzqdXqVNOT6o6JHEZU1uPxE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6891F24B00003FF0; Tue, 5 Aug 2025 20:00:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9361966816215
X-SMAIL-UIID: 944879F75C2849E68EEB7C448AB9AF49-20250805-200012-1
From: Hillf Danton <hdanton@sina.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>,
	axboe@kernel.dk,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: prevent deadlock in del_gendisk()
Date: Tue,  5 Aug 2025 19:59:59 +0800
Message-ID: <20250805120001.3990-1-hdanton@sina.com>
In-Reply-To: <e312219e-aa6c-a9a6-fa01-cf38435010be@huaweicloud.com>
References: <20250803134114.2707-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 4 Aug 2025 15:51:48 +0800 Yu Kuai wrote:
> ÔÚ 2025/08/03 21:41, Ujwal Kundur Ð´µÀ:
> > A potential unsafe locking scenario presents itself when
> > mutex_lock(&disk->open_mutex) is called with reader's lock held on
> > update_nr_hwq_lock:
> >         CPU0                    CPU1
> >         ----                    ----
> > rlock(&set->update_nr_hwq_lock)
> >                                 lock(&nbd->config_lock);
> >                                 lock(&set->update_nr_hwq_lock);
> > lock(&disk->open_mutex)
> > 
> This problem is already fixed inside nbd by:
> 8b428f42f3ed ("nbd: fix lockdep deadlock warning")
> 
Deadlock still exists [1].

[1] https://lore.kernel.org/lkml/6891742c.050a0220.7f033.001a.GAE@google.com/

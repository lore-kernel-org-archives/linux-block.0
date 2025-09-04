Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D002C11D5;
	Thu,  4 Sep 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974527; cv=none; b=Aj6nw+0/2OYwCwn6ERzwiwTakFR6Ip8qdZOdX7VV1iIm5JO8YDlT6dOhO46o3xLkTZ67vR3eyOupxPx20Xb8ep9y0skK/JA8Mzu458AkAknWLB1wnXVZEpBR2DRtrt8PsPsQeKgcy5A8H/SYoeU0k+Fqi1WBqcnDGUKYYxlwYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974527; c=relaxed/simple;
	bh=0w+xnx8GDzBkVH9MReXmk6GUPZ5qZuiT3Hfka7nZ3z4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ekZ5e+esgcaLnS1kmi/NwD8/GaMRMZtlRr3fXT0hzrjMOLYwWT3fqfrZENeAjlFE/ogP28R1vdSAEVVKCwVxvWxrkw2ikJpG2FYw/3EnGXqB2xF8HrNemyu/pKUeEgprWRIMk4akxNuDJSUXJ1+8WGxBz5O8rkNpmgXpD3bjRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=wKJVi6l6; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="wKJVi6l6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756974205;
	bh=7DN0jn8EFbvGagtqyUaHOSQPeNSavR6C85ONmpAUNNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wKJVi6l6r0qe18Pz6bTFh4wbDHOODO/4dSwO6XjKeffqA7SzGJKBroiPtCE6SWn5b
	 rB6qfCMmcE3mioxNarSI1jdcDr9GekLzxIXc+Kd7mks7Dc3Rv713bI9vEmDMgJ8Pbn
	 y5/iNubqlPMxzhbU4sPxyXsBrLT8YHAjqtTK/5MI=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 5CA83E22; Thu, 04 Sep 2025 16:23:10 +0800
X-QQ-mid: xmsmtpt1756974190twdgnkbio
Message-ID: <tencent_8F4803A1271AF89895A2B3310C9F4126AB07@qq.com>
X-QQ-XMAILINFO: N3PIPzNYjboSkrggkhfqpbUAIUqVL4Uf8qbVScnYj+eSCgdeKRIY3xDGkSDrVz
	 WfmBneQ7y8tSy4PLhaovhXaXrPESvmezCZDFFJOS6IeVnyhPscu3XiWVJFbeX0lH3Ca2/NQ6QqVW
	 5ym2GZ5oequ2QPge0FZGDwWwqXOi+FIIS8aEM5aymi+47zw0zWYBQ1UTFqLMzkhUGJ3h+D9SV1sg
	 v4vPmNYS2orbiNB06E2X4JKNFjZEKTR/J55uNXQjsFy9lE5j8neetfg8N/LbVo5VAiL6bQ+dgPBH
	 F8skuHJBySManw+oTa7OSRWhS45YgxHaolXV84QuntPYyahb2N4jjQs+mZiUPzGZC523eJuI6sV5
	 ABd0ZNZK2aLBaQl81QKZXCh1SmbIGMicNV/ZpVXZ9qdrQ13AAbqMTtzauwCghqlWfcS8YJnkaXdq
	 FYJDz79RVvxqXtH6xY0G9h/d+fJHJmhRVV0/ETkMpjzZEE6M7heQJtG7Cux7AGEOmo7yiN3/6vx8
	 JjHDCUhlXJa+wFa70rnGXEe1nG0ZWlcf+vw9l+6dmmeBVHLZC4WFJp7Rc3tQ5nVEedRJvM4aWqhZ
	 BcF+rUkKRxoSn8HrIGki8DEL3YPIS3R9nEjfImxuHaGiYm0pYJH3ub2jt5thMJ172gX+NfhRERP2
	 v8GTfpnyPS1AbmoFhz+PrElQtvE48kHkgrQvjPbV4667rJw4KaAjR4mSrqVhgD8EhjeYT1i4+eyT
	 KhUMhMTIXAiG9OqrFz2wXGhxlZ+FwnmvVTzvPv8qMLOAzd6Gl+fZKapXllztK6duXkyZILhMqcDH
	 xc59Tu1aea89vzQjw09P5x9xjAvNuXpWR0m/YnRtjugZ3dKLMIEHA5TRULy7DS6gIeB7qrhE50CO
	 G3h4mPag5iASZyEpt6hSLeXYN/h82C7wUnOHeDON1ioz6xqINo4e7OA7TfvQT5zjmTe+AfUqDV35
	 YqjriDLt+AZnIWJZ9V8jHGR0lUKhSq85mtmqEEbWZkNwpfyf677IRKmiVpmhiXhdCv4DoQM/e8Hf
	 pmvlRcIRsDezYwZy9ABQOBkwN80PC2tKE+v41ugMwPnldLv6TL8/A9Y25hFMfBWLnouYLhN+4kGm
	 xvffXx
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Han Guangjiang <gj.han@foxmail.com>
To: yukuai1@huaweicloud.com
Cc: axboe@kernel.dk,
	buaajxlj@163.com,
	fanggeng@lixiang.com,
	gj.han@foxmail.com,
	hailan@yukuai.org.cn,
	hanguangjiang@lixiang.com,
	liangjie@lixiang.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangchen11@lixiang.com,
	yukuai3@huawei.com
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
Date: Thu,  4 Sep 2025 16:23:10 +0800
X-OQ-MSGID: <20250904082310.3984193-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f17231f5-61a0-8d2d-eef5-f9b838caad34@huaweicloud.com>
References: <f17231f5-61a0-8d2d-eef5-f9b838caad34@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> Yes, however, this can be fixed very similar:
> 
> Set sq->parent_sq to NULL here, and add a helper parent_sq(q, sq):
> 
> if (sq->parent_sq)
>         return sq->parent_sq;
> 
> td_sq = &q->td->service_queue;
> return sq == td_sq ? NULL : td_sq;
> 
> And sq_to_tg() need to be changed as well. So far, I'm not sure how many
> code changes are required this way. We of course want a simple fix for
> stable backport, but we definitely still want this kind of fix in future
> release.

We preliminarily tried implementing this approach. But the changes are 
scattered and backport might be complex. So we provide a simple fix first.

> Meanwhile, please remove the comment about freeze queue, turns out it
> can't protect blk_throtl_bio() becasue q_usage_coutner is not grabbed
> yet while issuing bio.

As discussed before, we also removed some outdated comments in 
blk_should_throtl().

We just submitted v2 which includes the changes.

We look forward to your feedback and suggestions on the v2 patch.

Thanks,
Han Guangjiang


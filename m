Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963373264FD
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790556812; cv=none; b=t1dS04Vbxny3RipDsMbMnWiXubz52I2nDvkWie1yZMGV1fpu32GsnGcF/4mTNd/iwVouw7aeeg5vjx4kdXSEBqbCmojgW9D+RlCZgeZfbSMHK2W4o7xjwgvILy/GN3f6U3Y192jULfrk6bTKuWkirZMyd1z0XK1+J/OCzQ83qrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790556812; c=relaxed/simple;
	bh=HO8h1KmYA4yTXRSNwVs9EHHpVuK0s9w8gUGdNTIU3X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOD14OI9M+Usj4XzUh72MEEFTJr6+9d2/xGJcFVtsg9+t2ciTb4US4/9yWSuvWfgD+HNTqylGF+ybPyLEgFxkV+RJfyuRdk67RjI/4orLMgZZuAsL0KNieoTD7qn8c7U17DeVDJRYsiuCmYvQj7WRqiWwjLMHGGPZaxH4FwLEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g40PEYi1; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g40PEYi1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HO
	8h1KmYA4yTXRSNwVs9EHHpVuK0s9w8gUGdNTIU3X4=; b=g40PEYi1Ryph3xdNle
	mvHQi5IoNW3kwV0786SZl7Cd8i0HJ20YbwvhPm8ADZp0giXOcLkPbe8bbxyJOKjM
	VJzW6JwXwjhF/rM3GaYB8NuEX5PX1XxrPax8EqsbJIcRj4Jm6zQogJyaP8/Hti3+
	pJ9re95s3H1RF0zL+YDzaA3vs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_+l8urlqsULWBA--.48987S2;
	Mon, 28 Sep 2026 08:53:16 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: shinichiro.kawasaki@wdc.com
Cc: hch@lst.de,
	linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/049: test polled dio with user PI metadata
Date: Mon, 28 Sep 2026 08:53:16 +0800
Message-Id: <20260928005316.141036-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <arZyUmncVJSolXLg@shinmob>
References: <arZyUmncVJSolXLg@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_+l8urlqsULWBA--.48987S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4DXF18XF1fXrW8Wry8Zrb_yoWfWwbE9w
	1jqr9rCw48ArWUK3yfG3W7WF47KayUu3yUXryIqrW0ga4fZFyvqrs3tFyFy34rZa1fKr9I
	kw4rGF9ag342gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREsqXJUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6RzWZ2q5unyFqQAA39

Hi Shin'ichiro,

On Thu, Sep 25, 2026 at 01:16:00PM +0000, Shin'ichiro Kawasaki wrote:
> I understand the concern. My current policy is to wait for the kernel side
> fix gets upstreamed to Linus master branch, then add the test case to blktests.
> This way we can keep blktests runs healthy with Linus master branch. It can
> cause the failure with stable kernels, but I expect it will work as the signal
> to encourage backport of the fix. So, let's wait for the kernel side fix to
> get settled on Linus master branch.

That makes sense. I will wait until the kernel fix lands in Linus' tree,
then resend the blktests patch.

> Your copyright is missing here.

Will add it in the next version.

> I recommend _have_loadable_scsi_debug instead of "_have_module scsi_debug".

Will switch to _have_loadable_scsi_debug.

Thanks for reviewing and for confirming the test behavior.

Thanks,
Yang Xiuwei


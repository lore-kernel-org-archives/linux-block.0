Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE42EFD81
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541688; cv=none; b=JSSEeMKVbHtfDzFSerWElSpwXFJuX4suRY7D9HuNSrbirzMSkKYYwIDBQIfZ82OUM2ckLoqc/jiwK9XvRwPIO65cAvDRzR5H7L9EZoADgQW6vjyFpzQFuunLbM88rmkJZ7kQr+USiCimfhEJhR159ApFPBJvQUAN1IZUQHR6HUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541688; c=relaxed/simple;
	bh=P8lm2wpk4wDU4lMhQgD87vVgo6kTpywAcBXBnu38jzU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hrFjsnnCVehHflVSY49SQSBttHGvbr2+ryek4ZiZbM829WFXSXPAgGv2YSwUvnuzWGONp/ZBar+LFI+vRE4ksaBX4/5XiPM4FCSCl5+0Kf0jmJt7wcNXaR0pFYwG82oFr6zx9UCQF+rGIZ2qrZrmSK5vBGPX/wdQ6RqV0HF+9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=i0w1ce9q; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="i0w1ce9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763541681;
	bh=K8CVcG3oGYc14oYRyGjR7Y3pbOP3rPqrnaD0t8JcaLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i0w1ce9qmUeltbPiTKaPC2NyGejTBoa79EfaRMoU/CRC3jZzYzo/tm+57AKH2DtcB
	 7g1WdPybxH5r+UHy1UtnH0h6+l4D2icYliwGWUHv2VY6SYMj8xwqMdeAr/a3OYSz/b
	 edqI6Q+Bx2fQ/y/k+zZYaNv+XpUevNjfrp+B+h6U=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id A5321AA1; Wed, 19 Nov 2025 16:41:19 +0800
X-QQ-mid: xmsmtpt1763541679ts063w993
Message-ID: <tencent_EF2ECF2226EEB0712DD7EFF3963CE1AF9107@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRsm/HvCRPm7l4cJP1nHdloABa5rQeH+bKby9gh6vcx+HcC/ehKY
	 I/3cma0IUelXKigTaDF3IByQs7MYDoW4L9BDMHALmstjiPlIiyFOY3jY7bnAKMSSfdiNbzoY1CGC
	 mqiQmQIeIEI8ADc3H6B2+Z9E0iXfnYfFF9/FZ7H9Z5oF5DxRNc0UvywjaiRtpU7XqETjxb1IHXoP
	 sWTIKCBujtFjADShByxHw1zIfwc3Ky3TzMfdMNOVM/6714+viBTtyPTBOKHfbpQ+93lmXpKmWp4M
	 Wq/iF1YvfsY+3YAl+oHUsESCTYktcwyAv6xE0ZfNfWmjQHYNq0K+MaNSDXRU/eHyPCBm0HtuEOJU
	 qyZj6u6fwb98afv+NWDyljXCofjq2zZ8dipTraRTpJc5KzlzrZDSKmycMROuSFT/2IvwjFdOLmZX
	 E9DQpfQHq6FN5N1+M5UfkyJV3jPwe5SIjhn8/cSEzcMGqv/y/siThO6w5wYblIV4TA7a6nM5IM8s
	 sXMywOVWY3/GxCkui8ScTl//hHD/gklkFKTa521jsKrFuzcGedsUb1r85K71tkJPBPXGV41HE8ri
	 9lDyfKWfbDfWBjyWOqny6gZv7TKhsc5x81PX3ytWKfQ6TXgJFidzkB/Mog1olU7lk3QlLsX9C417
	 B8CmojOHacDR/55cEHs2cRxkRQHaDTLrF0vBxu+7LPKc8r2mRyuiZbwbsbgDspGTtcCLPPrmFfyw
	 /e8olPVCh8/+pPnnXaUbwMVqZZxdVhrdYgKAFBkd7lwIEVkgFsBXPWV4jtzVn3Qvxffe1WKx7DvQ
	 i9xiO/YfmRdr5+ejrK2/GFUo9yRHWqZ/IpEEqgkyJokmeyVjcv1rOJROwS4SJW0O7e27vxhxw91n
	 At3sMLJhK5e3P5tVyrNa8wC1yJrzH5S3jXqKj+ITSTUooSV9DcUhtA9DKsjqadvMAyWUNNAg/jZ5
	 CiM7635vFyTtEHxD3Fd1arpF4WHBNuYFAOcc5oqMWJhT5wjQP4riv4IxM+Xs+ktj/hqmoRViYpfs
	 62e9ushF30WpO00u+N/EjsmZiXv7t3BLJkBJTFEW9/ltXpp0PD
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: dan.carpenter@linaro.org,
	senozhatsky@chromium.org
Cc: linux-block@vger.kernel.org,
	ywen.chen@foxmail.com
Subject: [bug report] zram: introduce writeback bio batching support
Date: Wed, 19 Nov 2025 16:41:18 +0800
X-OQ-MSGID: <20251119084118.2934760-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aR13MX98YwyyvUlH@stanley.mountain>
References: <aR13MX98YwyyvUlH@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 19 Nov 2025 10:52:17 +0300, Dan Carpenter wrote:
> Commit 01516d2d32bf ("zram: introduce writeback bio batching
> support") from Nov 13, 2025 (linux-next), leads to the following
> Smatch static checker warning:
>
> 	drivers/block/zram/zram_drv.c:1284 writeback_store()
> 	error: we previously assumed 'wb_ctl' could be null (see line 1211)

Thank you very much. It's a very obvious mistake.

regards,


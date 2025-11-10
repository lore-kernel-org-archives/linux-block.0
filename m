Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A877E28850E;
	Mon, 10 Nov 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759366; cv=none; b=N1CcIXbbzluCFZplL55i6ExzzfZffMWrYDnsCFvktYeeH15IQcedJ2RWYhAsw5JTayyNZrEMaEWqZltNYMlZk3ZFvdS2y2kLuZJ+vEAlGk12TNZrmnPyZ+2XsIw+B/fmrWb6+tfjdseAUyNF1a4g1dBpFif+rQfWdFOe8BuC1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759366; c=relaxed/simple;
	bh=rzUbkU7sKJ+q2FqqBd+imnVWKg42yj3vZy2tn1nIhdc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Z+a8/afENZIM8y6BfIZIA1vq0ClzPB7UT8pTrP3jfKHjGQjLgpFlPDdo+1M7gADGAjFSqOrh1Mp5YwnXilI5tgu+TZIKlq0FFwcE9u0XYlako10I3hy0uvt+WL2MmWyxD77qcRbZesLxTPftrIxNIiU5XA2FUZgtRkvXCZXORQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rFv9sS2r; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rFv9sS2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1762759356;
	bh=O+GcoBuG4sDAppZpZNOB0iYZLKRwCsUHdJqQLyG40Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rFv9sS2rTIjkYg7TBhnpLwYzoTvvh7vJymED6P5q5kWWDztTQk/vxzUebTF32MCsa
	 wDK19BDpgxnYV3kn5SKJ5VEAhgmDfkkcVoR5LkSniAN3oPsTZdmxgiLrt1K/hsXm+z
	 oDTAEVNrlT3sd1vSrON943Of3bAZ4oM9Asc6Qucg=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 41615009; Mon, 10 Nov 2025 15:16:22 +0800
X-QQ-mid: xmsmtpt1762758982t3wlzjwxl
Message-ID: <tencent_B2DC37E3A2AED0E7F179365FCB5D82455B08@qq.com>
X-QQ-XMAILINFO: ODP7Xsg997RQr1tAclBgOGM/U7NL7XxgpApi56eeDQMLH6mACPF9+xJzDItxEU
	 bhFds5HLQVv1zXCSY/MXQn7hoMuNRXT4+fyHKCypwmmYuqt3FvL8fsu5XDikieG0A8xTcAyuJXoZ
	 Qje7ZAX5BSg1SZCWZK3TamPLZxZ0dh82K4UFMXlEXpCG2UptW2QoJr/MvfigCNEMbe0BD1zZWBeS
	 GQBUSt7ulOjfzEPvjIrzJoZvgDSqnlnMFmqc+MlXcQe616eQP7nXBxgnwUua2oz7SS4VBwkwbOTR
	 2tWM04BFF4FU6Seeh1z/2dwvhLXQi7ZAkriuunP/lYl5ejP5UcCktNS7MbrF//1aLcfw6HQNPaLN
	 B2J/XXFndnX432B/YgslOtnk+IQFeNccGX48qvXS+VtuibB5uz+NNjE3gtArwgryv1MznNAvxHhj
	 14HJld/DHRtzKmQupCI2e5ecJMGqf8+FAO4ZZobM5kmI7YbCyaVJv4XGxiJWF0z8U5DB0NP+Wkse
	 jKWSquF/n21Fb0X3RmKOEDsMCgoVbXcC/yoBifa2vlEMdNkUNbQgQechQz1derzE7lKVkgLQzsKU
	 xtWbgzbLmilhVasyBDLeTFx8XqcHiMW2uL6E6LLoWzQcGouSqZ3IykqFX9pPeI7EKa/Mu4DX/dx1
	 nUwIdG738w1JNWCsWMvXT4fD7BcH+u1k6JO6WZiK18YjoqZL3ULPxsNhuOeiglmdxQ355CduQsrX
	 bwDN621x29Wf2W4l7rUpAC3pa02RANpshNY/ILPdfbpfj7bz8CPrNTXi52SBvePSbnLjQfWxOvSx
	 yvgR0Q/MJWOjWrnJo/+aBzXvjSVbgRAR0qUFngqLa94anzWI4YsnC7JHxlh7A9NmW8U5EXyg0O9W
	 SIaq5W1WDS/qLFO/yDgH/MFAljC823hPWGU3aiHEInOQhwRp4dFu6EXPmGUEFRmf+yM3T+HqT/jM
	 QGSHiJad5XLfRo+/3vP2f7Bh0rO/Z2GIG6Shb+7x9a+A3aCPeWNdFyLKRFJR4E2fjw9XUB8nIaAO
	 8iB8AhmL7i6+7u8X/SCjvxIjYnqBgqeAwPqqlUloKC3gr/sW92
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liumartin@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Date: Mon, 10 Nov 2025 15:16:21 +0800
X-OQ-MSGID: <20251110071621.2943297-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yv2ktkwwu3hadzkw6wb4inqzihndfpwb42svuu25ngmn6eb7c4@hclvcrnsmvvk>
References: <yv2ktkwwu3hadzkw6wb4inqzihndfpwb42svuu25ngmn6eb7c4@hclvcrnsmvvk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10 Nov 2025 13:49:26 +0900, Sergey Senozhatsky wrote:
> As a side note:
> You almost never do sequential writes to the backing device. The
> thing is, e.g. when zram is used as swap, page faults happen randomly
> and free up (slot-free) random page-size chunks (so random bits in
> zram->bitmap become clear), which then get overwritten (zram simply
> picks the first available bit from zram->bitmap) during next writeback.
> There is nothing sequential about that, in systems with sufficiently
> large uptime and sufficiently frequent writeback/readback events
> writeback bitmap becomes sparse, which results in random IO, so your
> test tests an ideal case that almost never happens in practice.

Thank you very much for your reply.
As you mentioned, the current test data was measured under the condition
that all writes were sequential writes. In a normal user environment,
there are a large number of random writes. However, the multiple
concurrent submissions implemented in this submission still have performance
advantages for storage devices. I artificially created the worst - case
scenario (all writes are random writes) with the following code:

for (int i = 0; i < nr_pages; i++)
    alloc_block_bdev(zram);

for (int i = 0; i < nr_pages; i += 2)
    free_block_bdev(zram, i);

On the physical machine, the measured data is as follows:
before modification:
real	0m0.624s
user	0m0.000s
sys	0m0.347s

real	0m0.663s
user	0m0.001s
sys	0m0.354s

real	0m0.635s
user	0m0.000s
sys	0m0.335s

after modification:
real	0m0.340s
user	0m0.000s
sys	0m0.239s

real	0m0.326s
user	0m0.000s
sys	0m0.230s

real	0m0.313s
user	0m0.000s
sys	0m0.223s

The test script is as follows:
# mknod /dev/loop45 b 7 45
# losetup /dev/loop45 ./zram_writeback.img
# echo "/dev/loop45" > /sys/block/zram0/backing_dev
# echo "1024000000" > /sys/block/zram0/disksize
# dd if=/dev/random of=/dev/zram0
# time echo "page_indexes=1-100000" > /sys/block/zram0/writeback

Thank you again for your reply.


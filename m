Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC781724;
	Thu,  6 Nov 2025 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396430; cv=none; b=glt33eDQ5lB+1NE6fgtqyGgk59yKDdtydJFgmuegTAQlPJ2R0dhv4TeYlAVKKMpVENb5SihsBiCW/TaIJ485EAnJLVq4JWARK6JpMwzX2wiuiCdMkf1LqDc9JIA78YFm6yV1o8W+7xjbvCbX6MGxmaDpweGId3JFfVJnKv6frbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396430; c=relaxed/simple;
	bh=+NQXZBSYOQISbrzspNQhqIW6vWYSbWXcNEH2AXfRTeg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cV8qQyXml9DcrE1JT44dpy2mHXxb3obq0nBBD4nLkch3rJkHH7EJY5qK/oMbCKItGwCjKISdGnIglDUs8LV0RzxQlaasiLFcs2dyf4F0K9lPxiNJf8J834rhfnNT4cEzZkZT6iVoddDvAJCS7xak4JpXMqk6ZRvYiz66UaZHCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=iBXxYJTc; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="iBXxYJTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1762396116;
	bh=+sn4rWDbaRXab2FydeaqMlsDRUX96FTNA0Hi4iwrBR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBXxYJTceLo1Wf9glKNPyOy1MgUSOw+Z2ZiwKFD3ZmFLhviwAeJcQ99kA7FfOMruu
	 31z+uqAT8CRJm45JmKQICG7ehnYlwx0oxk5bWDD51nIbzdiDj5T3UGQzhT89rN/BRv
	 bLEqSxKsquWDuKFcUmIiY0c1dLFdHIjgFlbQ6EcQ=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 7219A68A; Thu, 06 Nov 2025 10:28:33 +0800
X-QQ-mid: xmsmtpt1762396113t601gxnym
Message-ID: <tencent_4045D6DC43E374AEA3E78479385F205D4008@qq.com>
X-QQ-XMAILINFO: NWMjIPXM0fdCT1+I/1CYrF6DG9jOllEpOv+iqMAJ7eN6IE0/BEhrtRt3kc0vhK
	 ssrMwg3CLFRtkFZkvvA6QZm8xDXaBayrN4UnYO8X85dYcN+hMocRQU7dWYZy2QhHbn4LDr3vtCUA
	 Uw+Jy33swxco7versuKpRglNKowIHxlifhiXk/fbyCgUevkv0P74qMBNw9mpjX7KQTmxY0xAYlzO
	 hu78GWvOnebdxyfbmebTc6wWWuw0GkHyYPpyy91vsEIXHmqp/9VUOF8J90jQV73wAj+gzVk97fN8
	 7maOCd6qAvtdDcRDEhRx2f05qjRGF3LIT/gcTyamxqgH5kdiZHhcuHUDRz3rsRjvP2z4eZp6RILg
	 KpsbPFBANHRh0F+dldwdPBSlMdw/s9et3FnxVA5yGd+rdiZDHZZRiHvoH+LPxXMtay7A9RkUFAzN
	 8W/bz7wK+RF9tUwf2MbvdMG00+BcYTEoO+crtg2SdNaIQ2YJjleJQSHKob30P1djM9lk+eWI4EK4
	 tHnd5oqhZTfp6Ujji/Qt6LLM1WpiHEOJb7lG0hh04pAmrSP7e16ouF+8qnCmkoo+eS46rN7P78SJ
	 vdXannnBYQflhk6Ue7rf9HY0KPCwFfhuXMuewjONpI1Bn5AogeN/LDhtA7trjU5ClD6Z+tKt+epV
	 YDSDVusL2Iou9IB+a7peBn0iPqz4cJZHHjNHg9I92LdYOuopEh6RvU7IDy+wr7LZ6tAAazN99n7m
	 a+CCtqj6pkDeXs+iOOc7c3QEN+ilxmh/TuPRWN5FvlLb5uB41eEh4/UgKijftESOHixpyeR58sFT
	 ShcjvWc02SVJoVSB5gSS+WCP+hnTGWnmszsOb4y5nhvbtk42ZoINEEF0pFlI50Xm/kyxbmVztkxN
	 eotcRqh1reHi9QYrvH+zOEN80evHNeSDWI9tIPqAnLEOmFuftMqfoyvIMyP6tjV48UVm/D6NfVAF
	 bFpff7AB3KSWWfwajtp5pXj1cbFgp3a4bghKel6muUMd1G5RQ8eEtCrUFd4KkPE4dp3hTykU6MB0
	 C2sCURcLT0g4rLnG5hB3u9JY8ShWl1mPoSBb0GE+O++prCzVlypBBXTUylxnqXG8cFVdVbcJ67kX
	 TpwWPcAki7ZQWs5+I1+IEscMmgqn1Gb3RmVx1OI+8HB/yYJDvPD8YKvb+Wd+q38k2A8XSAamI7MW
	 n2ycxWHXSOaQKw+1WNVNIx+EoQR0Sbsil1ulo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: axboe@kernel.dk
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liumartin@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	senozhatsky@chromium.org,
	ywen.chen@foxmail.com
Subject: Re: [PATCH v3] zram: Implement multi-page write-back
Date: Thu,  6 Nov 2025 10:28:33 +0800
X-OQ-MSGID: <20251106022833.2729849-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/5/25 08:25 AM, Jens Axboe wrote:
> Please either finish the patch before sending it out, or take your
> time before posting again. Sending 3 versions in one day will just
> make people ignore you.

> This commit message is in dire need of some actual performance
> results. This is a change for better performance, no? If so, you
> should have some clear numbers in there describing where it's
> better, and where it's worse (if appropriate).

Thank you very much for your reply. The description of the patch has
been revised. This time, performance test data has been added,
showing an approximate increase of 1000%. Please help review
version v4. Thank you again!

The QEMU parameters used for this test data are as follows:
sudo qemu-system-x86_64 \
        -M pc \
        -smp 8 \
        -m 2G \
        -kernel /boot/vmlinuz-`uname -r` \
        -hda system.img \
        -hdb zram_writeback.img \
        -append "root=/dev/sda rw init=/linuxrc console=ttyAMA0 console=ttyS0" \
        -virtfs local,path=`pwd`/../,mount_tag=hostshare,security_model=passthrough \
        -nographic

The approximate configuration of the host is as follows:
Kernel: x86_64 Linux 6.8.0-50-generic
CPU   : 12th Gen Intel Core i7-12700K @ 20x 4.9GHz
MEM   : 64G
DISK  : PC801 NVMe SK hynix 1TB

